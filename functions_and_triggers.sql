-- TASK 9 FUNCTIONS --

-- по ФИО клиента выводит количество его заказов, чтобы мб потом
-- присваивать им какие-то карты лояльности, как постоянным покупателям

create or replace function number_of_orders_by_name(name text, surname text)
returns integer as $$
    declare
        result int := 0;
    begin
        execute format('select count(*)
                        from restaurants."Client" c
                        inner join restaurants."Order" o
                        on c.client_id = o.client_id
                        where c.first_nm = $1 and c.last_nm = $2')
        into result
        using name, surname;
    return result;
    end;
$$ language plpgsql;

select number_of_orders_by_name('Danila', 'Borisov');
select number_of_orders_by_name('Alexander', 'Rusin');

-- аналогично, но с общей суммой, которую оставили в ресторане
-- заинсертим больше заказов, чтобы убедиться, что все правильно работает

create or replace function sum_of_orders_by_name(name text, surname text)
returns integer as $$
    declare
        sum int := 0;
    begin
        execute format('select sum(price_amt)
                        from restaurants."Client" c
                        inner join restaurants."Bank_Check" b
                        on c.client_id = b.client_id
                        where c.first_nm = $1 and c.last_nm = $2
                        group by c.client_id ')
        into sum
        using name, surname;
    return sum;
    end;
$$ language plpgsql;

select sum_of_orders_by_name('Danila', 'Borisov');
select sum_of_orders_by_name('Liza', 'Neledova');

-- по ФИО сотрудника выводит текущее место работы

create or replace function current_work_by_name(name text, surname text)
returns text as $$
    declare
        curr_work text;
    begin
        execute format('select r.address
                        from restaurants."Worker" w
                        inner join restaurants."Restaurant" r
                        on w.restaurant_id = r.restaurant_id
                        where w.first_nm = $1 and w.last_nm = $2')
        into curr_work
        using name, surname;
    return curr_work;
    end;
$$ language plpgsql;

select current_work_by_name('Katya', 'Blintsova');

-- TASK 10 TRIGGERS --

-- при update или delete места работы сотрудника, он автоматически добавляется в history
-- со старым местом работы

create or replace function trigger_on_upd_del_worker()
returns trigger as $$
    begin
        if tg_op = 'UPDATE' and (NEW is distinct from OLD) then
            insert into restaurants."History_Table" (worker_id, restaurant_id, history_dttm)
            values (old.worker_id, old.restaurant_id, current_date);
        elseif tg_op = 'DELETE' then
            insert into restaurants."History_Table" (worker_id, restaurant_id, history_dttm)
            values (old.worker_id, old.restaurant_id, current_date);
        end if;
    return new;
    end;
$$ language plpgsql;

drop function trigger_on_upd_del_worker();

create trigger trigger_on_update_worker
    after update or delete
    on restaurants."Worker"
    for each row
    execute procedure trigger_on_upd_del_worker();


drop trigger trigger_on_update_worker on restaurants."Worker";

update restaurants."Worker"
    set restaurant_id = (select "Restaurant".restaurant_id
                        from restaurants."Restaurant"
                        where address = 'Golubeva, 9')
    where first_nm = 'Nikita' and last_nm = 'Vasilenko';


-- При удалении какого-либо поставщика, его записи автоматически удалятся в
-- табличке PERV_X_REST, так как больше он не будет поставлять ни в один ресторан

create or replace function trigger_on_del_perveyor()
returns trigger as $$
    begin
        if tg_op = 'DELETE' then
            delete
                from restaurants."Perveyor_X_Restaurant"
                where perveyor_id = OLD.perveyor_id;
        end if;
    return OLD;
    end;
$$ language plpgsql;

drop function trigger_on_del_perveyor();

create trigger trigger_on_del_perveyor
    before delete
    on restaurants."Perveyor"
    for each row
    execute procedure trigger_on_del_perveyor();

drop trigger trigger_on_del_perveyor on restaurants."Perveyor";

delete
    from restaurants."Perveyor"
    where product = 'Fruits';
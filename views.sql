--- TASK 8 ---

--- Вывод имени, фамилии и места работы с замазанной зарплатой
--- чтобы, если табличку скидывать работнику или другим людям, они не знали зарплату
--- других работников

create or replace view drop_salary as
    select w.first_nm, w.last_nm, overlay(text(salary_amt) placing '*****' from 1 for 5) as salary_nm, r.address
    from restaurants."Worker" w
    inner join restaurants."Restaurant" r
    on w.restaurant_id = r.restaurant_id;

select * from drop_salary;

--- Пусть аналогично будем скрывать фамилию клиента и дату транзакции,
--- чтобы данные были персональными и сокрытыми

create or replace view drop_personal_data as
    select c.first_nm,
           b.price_amt,
           overlay(c.last_nm placing '*****' from 1 for 200) as last_nm,
           overlay(text(o.transaction_dttm) placing '*****' from 1 for 200) as date,
           r.address
    from restaurants."Client" c
    inner join restaurants."Bank_Check"  b
        on c.client_id = b.client_id
    inner join restaurants."Order" o
        on c.client_id = o.client_id and b.order_id = o.order_id
    inner join restaurants."Restaurant" r
        on o.restaurant_id = r.restaurant_id;

drop view if exists drop_personal_data;

select * from drop_personal_data;

--- Рестораны и их поставщики

create or replace view restaurants_and_perveyors as
    select r.address, p.telephone as perveyor_telephone, p.product
    from restaurants."Restaurant" r
    left join restaurants."Perveyor_X_Restaurant" pr
        on r.restaurant_id = pr.restaurant_id
    left join restaurants."Perveyor" p
        on pr.perveyor_id = p.perveyor_id
    order by address;

select * from restaurants_and_perveyors;

drop view if exists restaurants_and_perveyors;

--- Блюда и ингредиенты в них

create or replace view dish_and_ingredients as
    select dish_nm, ingredient_nm
    from restaurants."Dish" d
    left join restaurants."Dish_X_Ingredient" di
        on d.dish_id = di.dish_id
    left join restaurants."Ingredient" i
        on di.ingredient_id = i.ingredient_id
    order by dish_nm;

select * from dish_and_ingredients;

--- Клиенту сопоставляются его блюда в его заказе

create or replace view client_order_dish as
    select c.first_nm,
           c.last_nm,
           o.transaction_dttm as transaction_date,
           d.dish_nm as dish_name
    from restaurants."Client" c
    inner join restaurants."Order" o
        on c.client_id = o.client_id
    inner join restaurants."Order_X_Dish" od
        on o.order_id = od.order_id
    inner join restaurants."Dish" d
        on od.dish_id = d.dish_id;

select * from client_order_dish;

--- Сводная таблица с историей, кто в каком ресторане работал

create or replace view history as
    select w.first_nm,
           w.last_nm,
           h.history_dttm as date_of_transfer,
           r.address
    from restaurants."History_Table" h
    inner join restaurants."Worker" w
        on h.worker_id = w.worker_id
    inner join restaurants."Restaurant" r
        on h.restaurant_id = r.restaurant_id;

select * from history;
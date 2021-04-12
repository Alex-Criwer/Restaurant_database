
--- TASK 5 UPDATE, INSERT, SELECT, DELETE ---

insert
    into restaurants."Order"(RESTAURANT_ID, WORKER_ID, CLIENT_ID, TRANSACTION_DTTM, QUANTITY_OF_DISHES_AMT)
    values ((select distinct restaurant_id
                 from restaurants."Restaurant"
                 where address = 'Golubeva, 9'),
            (select distinct worker_id
                 from restaurants."Worker"
                 where first_nm = 'Roman' and last_nm = 'Ivanov'and middle_nm = 'Danilovich'),
            (select distinct client_id
                 from restaurants."Client"
                 where first_nm = 'Liza' and last_nm = 'Neledova' and middle_nm = 'Dmitrovna'),
            current_date, 1
           );

delete
    from restaurants."Order"
    where (RESTAURANT_ID = (select distinct restaurant_id
                 from restaurants."Restaurant"
                 where address = 'Golubeva, 9') and
          WORKER_ID = (select distinct worker_id
                 from restaurants."Worker"
                 where first_nm = 'Roman' and last_nm = 'Ivanov'and middle_nm = 'Danilovich') and
          CLIENT_ID = (select distinct client_id
                 from restaurants."Client"
                 where first_nm = 'Liza' and last_nm = 'Neledova' and middle_nm = 'Dmitrovna'));

insert
    into restaurants."Order"(RESTAURANT_ID, WORKER_ID, CLIENT_ID, TRANSACTION_DTTM, QUANTITY_OF_DISHES_AMT)
    values ((select distinct restaurant_id
                 from restaurants."Restaurant"
                 where address = 'Golubeva, 9'),
            (select distinct worker_id
                 from restaurants."Worker"
                 where first_nm = 'Roman' and last_nm = 'Ivanov'and middle_nm = 'Danilovich'),
            (select distinct client_id
                 from restaurants."Client"
                 where first_nm = 'Liza' and last_nm = 'Neledova' and middle_nm = 'Dmitrovna'),
            current_date, 1
           );

select dish_nm
    from restaurants."Dish"
    where dish_price_amt > 300;

update restaurants."Client"
    set BIRTH_DT = '19-09-1999'
    where first_nm = 'Roman' and last_nm = 'Berdashkevich';


insert
    into restaurants."Order_X_Dish"(ORDER_ID, DISH_ID)
    values ((select order_id
                 from restaurants."Order"
                 where client_id =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Liza' and last_nm = 'Neledova')),
            (select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Chicken cutlets with mashed potatoes')
            );

select order_id, dish_nm
    from (select ordish.order_id, dish_id
         from restaurants."Order"
             inner join
         restaurants."Order_X_Dish" as ordish
         on restaurants."Order".order_id = ordish.order_id) as dish_order
        inner join restaurants."Dish" as dish
        on dish.dish_id = dish_order.dish_id;


update restaurants."Order_X_Dish"
    set dish_id = (select dish_id
                       from restaurants."Dish"
                       where dish_nm = 'Alfredo pasta with chicken')
    where order_id = (select order_id
                          from restaurants."Order"
                          where client_id = (select client_id
                                                from restaurants."Client"
                                                where first_nm = 'Liza' and last_nm = 'Neledova') and
                                worker_id = (select worker_id
                                                from restaurants."Worker"
                                                where first_nm = 'Roman' and last_nm = 'Ivanov'));

insert
    into restaurants."Worker"(RESTAURANT_ID, FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT, SALARY_AMT)
    values ((select RESTAURANT_ID
                 from restaurants."Restaurant"
                 where address = 'Pervomayskaya, 32'),
            'Nikita', 'Vasilenko', 'Nikolaevich',
            '01-08-1987', 37000
);

insert
    into restaurants."History_Table"(WORKER_ID, RESTAURANT_ID, HISTORY_DTTM)
    values ((select worker_id
                from restaurants."Worker"
                where first_nm = 'Nikita' and last_nm = 'Vasilenko'),
            (select "Worker".restaurant_id
                from restaurants."Worker"
                where first_nm = 'Nikita' and last_nm = 'Vasilenko'),
            current_date);

update restaurants."Worker"
    set restaurant_id = ((select RESTAURANT_ID
                              from restaurants."Restaurant"
                              where address = 'Tverskaya, 16'))
    where first_nm = 'Nikita' and last_nm = 'Vasilenko';

insert
    into restaurants."Bank_Check"(CLIENT_ID, ORDER_ID, PRICE_AMT)
    values ((select client_id
                 from restaurants."Client"
                 where first_nm = 'Liza' and last_nm = 'Neledova'),
            (select order_id
                 from restaurants."Order"
                 where (client_id =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Liza' and last_nm = 'Neledova'))),
            350
           );

--- crud запросы - четыре базовые функции, используемые при работе с базами данных:
--- создание, чтение, модификация, удаление
---  нашем случае - это insert, select, update, delete

--- TASK 6 ---

--- Хочу узнать рестораны, чей средний чек больше 300 рублей

select address, avg(price_amt)
    from restaurants."Restaurant" r
    inner join restaurants."Order" o
    on r.restaurant_id = o.restaurant_id
    inner join restaurants."Bank_Check" bc
    on o.order_id = bc.order_id
    group by address
    having avg(price_amt) >= 300;

--- Вывожу ФИО персонала по убыванию зарплаты

select first_nm, last_nm, middle_nm, salary_amt
    from restaurants."Worker"
    order by salary_amt DESC;

--- Вывожу ФИО покупателей по возрастанию чека, который они оставили в ресторане

select first_nm, last_nm, middle_nm, price_amt
    from restaurants."Client" c
    inner join
    restaurants."Bank_Check" bc
    on c.client_id = bc.client_id
    order by price_amt ASC;

--- Количество работников в каждом ресторане

select distinct address, count(*) over (partition by address) as number_of_workers
    from restaurants."Restaurant" r
    inner join restaurants."Worker" w
    on r.restaurant_id = w.restaurant_id;

--- Список клиентов по убыванию даты рождения

select row_number() over (order by с.birth_dt, с.first_nm, с.last_nm, с.middle_nm)
    as id, birth_dt, first_nm, last_nm, middle_nm
    from restaurants."Client" с;

--- По каждому ресторану вывести работников по возрастанию зарплаты и дате рождения

select distinct row_number() over (partition by address order by salary_amt, birth_dt)
    as id, address, first_nm, last_nm, middle_nm, salary_amt, birth_dt
    from restaurants."Restaurant" r
    inner join restaurants."Worker" w
    on r.restaurant_id = w.restaurant_id;
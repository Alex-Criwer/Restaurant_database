
--- INSERTS INGREDIENT ---

select * from restaurants."Ingredient";

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Chicken');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Carrot');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Potato');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Milk');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Rice');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Egg');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Salad');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Buns');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Mushroom');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Dough');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Pasta');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Tomato');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Bacon');

insert
    into restaurants."Ingredient"(ingredient_nm)
    values ('Beef');

--- INSERTS DISH ---

select * from restaurants."Dish";

insert
    into restaurants."Dish"(DISH_NM, DISH_PRICE_AMT)
    values ('Chicken cutlets with mashed potatoes', 400);

insert
    into restaurants."Dish"(DISH_NM, DISH_PRICE_AMT)
    values ('Bavarian burger with bacon', 300);

insert
    into restaurants."Dish"(DISH_NM, DISH_PRICE_AMT)
    values ('Dumplings', 300);

insert
    into restaurants."Dish"(DISH_NM, DISH_PRICE_AMT)
    values ('Alfredo pasta with chicken', 350);

insert
    into restaurants."Dish"(DISH_NM, DISH_PRICE_AMT)
    values ('Creamy Mushroom Cream Soup', 200);


--- INSERTS RESTAURANT -----

insert
    into restaurants."Restaurant"(ADDRESS, TELEPHONE)
    values ('Pervomayskaya, 32', '7-916-215-87-96');

insert
    into restaurants."Restaurant"(ADDRESS, TELEPHONE)
    values ('Golubeva, 9', '7-916-852-46-12');

insert
    into restaurants."Restaurant"(ADDRESS, TELEPHONE)
    values ('Tverskaya, 16', '7-916-756-19-04');

--- INSERTS PERVEYOR ---

insert
    into restaurants."Perveyor"(TELEPHONE, PRODUCT)
    values ('7-916-873-94-18', 'Meat');

insert
    into restaurants."Perveyor"(TELEPHONE, PRODUCT)
    values ('7-916-164-95-07', 'Dairy');

insert
    into restaurants."Perveyor"(TELEPHONE, PRODUCT)
    values ('7-916-296-15-76', 'Vegetables');

insert
    into restaurants."Perveyor"(TELEPHONE, PRODUCT)
    values ('7-916-562-63-64', 'Fruits');

--- INSERTS CLIENT ---

insert
    into restaurants."Client"(FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT)
    values ('Danila', 'Borisov', 'Nikolaevich', '25-08-2001');

insert
    into restaurants."Client"(FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT)
    values ('Liza', 'Neledova', 'Dmitrovna', '21-04-1999');


insert
    into restaurants."Client"(FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT)
    values ('Alexander', 'Rusin', 'Igorevich', '17-04-2001');

insert
    into restaurants."Client"(FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT)
    values ('Roman', 'Berdashkevich', 'Sergeevich', '09-09-1995');


--- INSERTS DISH_X_INGR ---

select dish_id
    from restaurants."Dish"
    where dish_nm = 'Dumplings';

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Dumplings'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Dough')
            );


insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Dumplings'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Beef')
            );


insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Creamy Mushroom Cream Soup'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Potato')
            );


insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Creamy Mushroom Cream Soup'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Milk')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Creamy Mushroom Cream Soup'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Mushroom')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Bavarian burger with bacon'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Salad')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Bavarian burger with bacon'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Buns')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Bavarian burger with bacon'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Beef')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Bavarian burger with bacon'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Tomato')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Chicken cutlets with mashed potatoes'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Chicken')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Chicken cutlets with mashed potatoes'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Potato')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Alfredo pasta with chicken'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Pasta')
            );

insert
    into restaurants."Dish_X_Ingredient"(DISH_ID, INGREDIENT_ID)
    values ((select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Alfredo pasta with chicken'),
            (select ingredient_id
                 from restaurants."Ingredient"
                 where ingredient_nm = 'Chicken')
            );

--- INSERTS WORKER ---

insert
    into restaurants."Worker"(RESTAURANT_ID, FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT, SALARY_AMT)
    values ((select RESTAURANT_ID
                 from restaurants."Restaurant"
                 where telephone = '7-916-215-87-96'),
            'Katya', 'Blintsova', 'Vladimirovna',
            '08-06-1992', 40000
            );

insert
    into restaurants."Worker"(RESTAURANT_ID, FIRST_NM, LAST_NM, MIDDLE_NM, BIRTH_DT, SALARY_AMT)
    values ((select RESTAURANT_ID
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            'Roman', 'Ivanov', 'Danilovich',
            '13-02-1989', 35000
            );


--- INSERTS PERV_X_REST ---

insert
    into restaurants."Perveyor_X_Restaurant"(RESTAURANT_ID, PERVEYOR_ID)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            (select perveyor_id
                 from restaurants."Perveyor"
                 where telephone = '7-916-873-94-18')
            );

insert
    into restaurants."Perveyor_X_Restaurant"(RESTAURANT_ID, PERVEYOR_ID)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            (select perveyor_id
                 from restaurants."Perveyor"
                 where telephone = '7-916-296-15-76')
            );

insert
    into restaurants."Perveyor_X_Restaurant"(RESTAURANT_ID, PERVEYOR_ID)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-852-46-12'),
            (select perveyor_id
                 from restaurants."Perveyor"
                 where telephone = '7-916-164-95-07')
            );

insert
    into restaurants."Perveyor_X_Restaurant"(RESTAURANT_ID, PERVEYOR_ID)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            (select perveyor_id
                 from restaurants."Perveyor"
                 where telephone = '7-916-164-95-07')
            );

insert
    into restaurants."Perveyor_X_Restaurant"(RESTAURANT_ID, PERVEYOR_ID)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            (select perveyor_id
                 from restaurants."Perveyor"
                 where telephone = '7-916-562-63-64')
            );

--- INSERTS ORDER ---

insert
    into restaurants."Order"(RESTAURANT_ID, WORKER_ID, CLIENT_ID, TRANSACTION_DTTM, QUANTITY_OF_DISHES_AMT)
    values ((select restaurant_id
                 from restaurants."Restaurant"
                 where telephone = '7-916-756-19-04'),
            (select worker_id
                 from restaurants."Worker"
                 where first_nm = 'Katya' and last_nm = 'Blintsova'and middle_nm = 'Vladimirovna'),
            (select client_id
                 from restaurants."Client"
                 where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich'),
            current_date, 3
           );

--- INSERTS ORDER_X_DISH ---

insert
    into restaurants."Order_X_Dish"(ORDER_ID, DISH_ID)
    values ((select order_id
                 from restaurants."Order"
                 where ((select client_id
                            from restaurants."Order") =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich')) ),
            (select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Creamy Mushroom Cream Soup')
            );

insert
    into restaurants."Order_X_Dish"(ORDER_ID, DISH_ID)
    values ((select order_id
                 from restaurants."Order"
                 where ((select client_id
                            from restaurants."Order") =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich')) ),
            (select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Bavarian burger with bacon')
            );

insert
    into restaurants."Order_X_Dish"(ORDER_ID, DISH_ID)
    values ((select order_id
                 from restaurants."Order"
                 where ((select client_id
                            from restaurants."Order") =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich')) ),
            (select dish_id
                 from restaurants."Dish"
                 where dish_nm = 'Chicken cutlets with mashed potatoes')
            );
--- INSERTS BANK_CHECK ---

insert
    into restaurants."Bank_Check"(CLIENT_ID, ORDER_ID, PRICE_AMT)
    values ((select client_id
                 from restaurants."Client"
                 where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich'),
            (select order_id
                 from restaurants."Order"
                 where ((select client_id
                            from restaurants."Order") =
                        (select client_id
                             from restaurants."Client"
                             where first_nm = 'Danila' and last_nm = 'Borisov' and middle_nm = 'Nikolaevich'))),
            900
           );
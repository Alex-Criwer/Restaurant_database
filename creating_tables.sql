create schema restaurants;

--- RESTAURANTS TABLE ---

create table restaurants."Restaurant"
(
	RESTAURANT_ID serial,
	ADDRESS text not null,
	TELEPHONE varchar(20) not null
);

create unique index restaurant_address_uindex
	on restaurants."Restaurant" (ADDRESS);

create unique index restaurant_telephone_uindex
	on restaurants."Restaurant" (TELEPHONE);

alter table restaurants."Restaurant"
	add constraint restaurant_pk
		primary key (RESTAURANT_ID);

--- WORKER TABLE ---

create table restaurants."Worker"
(
	WORKER_ID serial,
	RESTAURANT_ID int not null
		constraint RESTAURANT_ID
			references restaurants."Restaurant",
	FIRST_NM text not null,
	LAST_NM text not null,
	MIDDLE_NM text default NULL,
	BIRTH_DT date not null,
	SALARY_AMT int not null
);

alter table restaurants."Worker"
	add constraint worker_pk
		primary key (WORKER_ID);


--- HISTORY TABLE ---

create table restaurants."History_Table"
(
	TRANSFER_ID serial,
	WORKER_ID int not null
		constraint WORKER_ID
			references restaurants."Worker",
	RESTAURANT_ID int not null
		constraint RESTAURANT_ID
			references restaurants."Restaurant",
	HISTORY_DTTM date not null
);

alter table restaurants."History_Table"
	add constraint history_table_pk
		primary key (TRANSFER_ID);

--- PERVEYOR TABLE ---

create table restaurants."Perveyor"
(
	PERVEYOR_ID serial,
	TELEPHONE varchar(20) not null,
	PRODUCT text not null
);

create unique index perveyor_telephone_uindex
	on restaurants."Perveyor" (TELEPHONE);

alter table restaurants."Perveyor"
	add constraint perveyor_pk
		primary key (PERVEYOR_ID);


--- PERVEYOR_X_RESTAURANT TABLE ---

create table restaurants."Perveyor_X_Restaurant"
(
	RESTAURANT_ID int not null
		constraint RESTAURANT_ID
			references restaurants."Restaurant",
	PERVEYOR_ID int not null
		constraint PERVEYOR_ID
			references restaurants."Perveyor"
);

alter table restaurants."Perveyor_X_Restaurant"
	add constraint perveyor_x_restaurant_pk
		primary key (PERVEYOR_ID, RESTAURANT_ID);

--- CLIENT TABLE ---

create table restaurants."Client"
(
	CLIENT_ID serial,
	FIRST_NM text not null,
	LAST_NM text not null,
	MIDDLE_NM text default NULL,
	BIRTH_DT date not null
);

alter table restaurants."Client"
	add constraint client_pk
		primary key (CLIENT_ID);


--- ORDER TABLE ---

create table restaurants."Order"
(
	ORDER_ID serial,
	RESTAURANT_ID int not null
		constraint RESTAURANT_ID
			references restaurants."Restaurant",
	WORKER_ID int not null
		constraint WORKER_ID
			references restaurants."Worker",
	CLIENT_ID int not null
		constraint CLIENT_ID
			references restaurants."Client",
	TRANSACTION_DTTM date not null,
	QUANTITY_OF_DISHES_AMT int default 0 not null
);

alter table restaurants."Order"
	add constraint order_pk
		primary key (ORDER_ID);

--- BANK_CHECK TABLE ---

create table restaurants."Bank_Check"
(
	BANK_CHECK_ID serial,
	CLIENT_ID int not null
		constraint CLIENT_ID
			references restaurants."Client",
	ORDER_ID int not null
		constraint ORDER_ID
			references restaurants."Order" (ORDER_ID),
	PRICE_AMT int not null
);

alter table restaurants."Bank_Check"
	add constraint bank_check_pk
		primary key (BANK_CHECK_ID);

--- DISH TABLE ---

create table restaurants."Dish"
(
	DISH_ID serial,
	DISH_NM text not null,
	DISH_PRICE_AMT int not null
);

create unique index dish_dish_nm_uindex
	on restaurants."Dish" (DISH_NM);

alter table restaurants."Dish"
	add constraint dish_pk
		primary key (DISH_ID);

--- ORDER_X_DISH TABLE ---

create table restaurants."Order_X_Dish"
(
	ORDER_ID int not null
		constraint ORDER_ID
			references restaurants."Order",
	DISH_ID int not null
		constraint DISH_ID
			references restaurants."Dish"
);

alter table restaurants."Order_X_Dish"
	add constraint order_x_dish_pk
		primary key (ORDER_ID, DISH_ID);

--- INGREDIENTS TABLE ---

create table restaurants."Ingredient"
(
	INGREDIENT_ID serial,
	INGREDIENT_NM text not null
);

create unique index ingredient_ingredient_nm_uindex
	on restaurants."Ingredient" (INGREDIENT_NM);

alter table restaurants."Ingredient"
	add constraint ingredient_pk
		primary key (INGREDIENT_ID);


--- DISH_X_INGREDIENT TABLE ---

create table restaurants."Dish_X_Ingredient"
(
	DISH_ID int not null
		constraint DISH_ID
			references restaurants."Dish",
	INGREDIENT_ID int not null
		constraint INGREDIENT_ID
			references restaurants."Ingredient"
);

alter table restaurants."Dish_X_Ingredient"
	add constraint dish_x_ingredient_pk
		primary key (DISH_ID, INGREDIENT_ID);
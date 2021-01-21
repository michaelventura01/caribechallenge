create DATABASE caribechallenge;                                                                                            
CREATE TABLE COUNTRIES(
	id varchar(4) primary key,
	name varchar(40) not null,
    nationality varchar(40) not null,
    code varchar(5) not null
);
CREATE TABLE CITIES(
	id varchar(6) primary key,
	name varchar(40) not null,
	country varchar(4) not null
);
CREATE TABLE STORES(
	id serial  primary key,
	name varchar(40) not null,
	description text not null,
	address text not null,
	zipcode varchar(6) not null,
	phone varchar(10) not null,
	website text not null,
	city varchar(6) not null,
	logo text not null
);
CREATE TABLE DAYS(
	id serial primary key,
	name varchar(20) not null
);
CREATE TABLE STORESCHEDULES(
	id serial primary key,
	day int not null,
	openhour varchar(6) not null,
	closehour varchar(6) not null,
    store bigint not null	
);

CREATE TABLE LANGUAJES(
	id varchar(3) primary key,
	name varchar(20) not null
);
CREATE TABLE STORELANGUAJES(
	id serial primary key,
	store bigint not null,
	languaje varchar(3) not null
);
CREATE TABLE PAYMENTMETHODS(
	id serial primary key,
	name varchar(20) not null
);
CREATE TABLE STOREPAYMENTMETHODS(
	id serial primary key,
	store bigint not null,
	paymentmethod int not null
);
CREATE TABLE STORETAGS(
	id serial primary key,
	store bigint not null,
	tag varchar(60) not null 
);
CREATE TABLE STORECATEGORIES(
	id serial primary key,
	store bigint not null,
	category varchar(60) not null,
	points int not null 
);
CREATE TABLE USERS(
	id serial primary key,
	firstname varchar(60) not null,
	lastname varchar(60) not null,
	email varchar(60) not null,
	password varchar(60) not null,
	phone varchar(11) not null,
    address text not null,
	city varchar(6) not null,
    nationality varchar(4) not null 
);

-- ----------------------------------

INSERT INTO COUNTRIES(id, name, nationality, code) values ('DR', 'DOMINICAN REPUBLIC', 'DOMINICAN', '+1');

INSERT INTO DAYS (name) values ('SUNDAY');
INSERT INTO DAYS (name) values ('MONDAY');
INSERT INTO DAYS (name) values ('TUESDAY');
INSERT INTO DAYS (name) values ('WEDNESDAY');
INSERT INTO DAYS (name) values ('THURSDAY');
INSERT INTO DAYS (name) values ('FRIDAY');
INSERT INTO DAYS (name) values ('SATURDAY');

INSERT INTO LANGUAJES (id, name) VALUES ('ES', 'SPANISH');
INSERT INTO LANGUAJES (id, name) VALUES ('EN', 'ENGLISH');

INSERT INTO PAYMENTMETHODS (name) values ('Visa');
INSERT INTO PAYMENTMETHODS (name) values ('Mastercard');
INSERT INTO PAYMENTMETHODS (name) values ('American Express');

INSERT INTO CITIES(id, name, country) values ('SD', 'SANTO DOMINGO', 'DR');
INSERT INTO CITIES(id, name, country) values ('STG', 'SANTIAGO', 'DR');

INSERT INTO STORES (name, description, address, zipcode, phone, website, city, logo) 
VALUES (
	'Consolidated Moving & Storage SRL', 
	'39 Years of Professional Moving Services Packing Moving Storage Local & Long Distance Fully Licensed & Insured WSIB Certified Guaranteed Competitive Quotations',
	'542 Mount Pleasant Santo Domingo',
	'10123',
    '8096540983',
    'https://www.consolidatedmoving.com.do',
    'SD',
    'https://picsum.photos/200/300'
);

INSERT INTO STORETAGS(store,tag) values (1,'services');
INSERT INTO STORETAGS(store,tag) values (1,'storage');
INSERT INTO STORETAGS(store,tag) values (1,'movements');

insert into STORECATEGORIES(store, category, points) values (1, 'Movements', 2);

insert into STOREPAYMENTMETHODS(store, paymentmethod) values (1,1);
insert into STOREPAYMENTMETHODS(store, paymentmethod) values (1,2);

insert into STORESCHEDULES(day, openhour, closehour, store) values (2,'7:00','18:00', 1);
insert into STORESCHEDULES(day, openhour, closehour, store) values (3,'7:00','18:00', 1);
insert into STORESCHEDULES(day, openhour, closehour, store) values (4,'7:00','18:00', 1);
insert into STORESCHEDULES(day, openhour, closehour, store) values (5,'7:00','18:00', 1);
insert into STORESCHEDULES(day, openhour, closehour, store) values (6,'7:00','18:00', 1);

insert into STORELANGUAJES(store, languaje) values (1,'ES');

INSERT INTO USERS(firstname, lastname, email, password, phone, address, city, nationality)
VALUES('michael', 'ventura','michaelmail.com', 'MTIzNDU2', '8299677530', 'c/ rogelio rosselle #9', 'SD', 'DR');

-- ----------------------------------

ALTER TABLE CITIES 
ADD CONSTRAINT countryfk
FOREIGN KEY(country) 
REFERENCES COUNTRIES(id);

ALTER TABLE STORES 
ADD CONSTRAINT cityfk
FOREIGN KEY(city) 
REFERENCES CITY(id);

ALTER TABLE STORESCHEDULES
ADD CONSTRAINT dayfk
FOREIGN KEY (day)
REFERENCES DAYS(id);

alter table STORESCHEDULES
add constraint storeschedulefk
foreign key(store)
references stores(id);

ALTER TABLE STORELANGUAJES
ADD CONSTRAINT storelanguajefk
FOREIGN KEY (store)
REFERENCES STORES(id);

ALTER TABLE STORELANGUAJES
ADD CONSTRAINT languajestorefk
FOREIGN KEY (languaje)
REFERENCES LANGUAJES(id);

ALTER TABLE STOREPAYMENTMETHODS
ADD CONSTRAINT storepaymenthodfk
FOREIGN KEY(store)
REFERENCES STORES(id);

ALTER TABLE STOREPAYMENTMETHODS
ADD CONSTRAINT paymenthodstorefk
FOREIGN KEY(paymentmethod)
REFERENCES paymentmethods(id);

ALTER TABLE STORETAGS
ADD CONSTRAINT storetagfk
FOREIGN KEY(store)
REFERENCES STORES(id);

ALTER TABLE STORECATEGORIES
ADD CONSTRAINT storecategoryfk
FOREIGN KEY(store)
REFERENCES STORES(id);

ALTER TABLE USERS
ADD CONSTRAINT cityuserfk
FOREIGN KEY(city)
REFERENCES CITIES(id);

ALTER TABLE USERS
ADD CONSTRAINT nationalityuserfk
FOREIGN KEY(nationality)
REFERENCES COUNTRIES(id);

-- views
create view seeusersvw as
select 
	usr.id,
	usr.firstname,
	usr.lastname,
	usr.email,
	usr.password,
	usr.phone,
	usr.address,
	city.id as cityid,
	city.name as cityname,
	country.id as countryid,
	country.name as countryname,
	nationality.nationality as nationality
from users as usr
inner join cities as city on usr.city = city.id
inner join countries as country on city.country = country.id
inner join countries as nationality on usr.nationality = nationality.id;

create view seestoretagsvw as 
select 
	storetag.id,
	store.name as storename,
	store.id as storeid,
	storetag.tag as tag
from storetags as storetag
inner join stores as store on storetag.store = store.id;

create view seestorecategoriesvw as
select 
	storecategory.id as id,
	storecategory.category as category,
	storecategory.points as points,
	store.name as storename,
	store.id as storeid
from storecategories as storecategory
inner join stores as store on storecategory.store = store.id;

create view seestorepaymentmethodsvw as
select 
	STOREPAYMENTMETHOD.id,
	store.id as storeid,
	store.name as storename,
	paymentmethod.id as paymentmethodid,
	paymentmethod.name as paymentmethodname
from STOREPAYMENTMETHODS as STOREPAYMENTMETHOD
inner join stores as store on STOREPAYMENTMETHOD.store = store.id
inner join paymentmethods as paymentmethod on STOREPAYMENTMETHOD.paymentmethod = paymentmethod.id;

create view seecountriesvw as 
SELECT id, name, nationality, code FROM COUNTRIES;

create view seecitiesvw as
SELECT city.id, city.name, country.name as country FROM CITIES as city
inner join COUNTRIES as country on city.country = country.id;

create view seestoresvw as
SELECT 
	store.id,
	store.name, 
	store.description, 
	store.address, 
	store.zipcode, 
	country.code as code,
	store.phone, 
	store.website, 
	city.name as city,
	city.id as cityid,
	country.name as country, 
	country.id as countryid,
	store.logo 
from STORES AS store
inner join CITIES as city on store.city = city.id
inner join COUNTRIES as country on city.country = country.id;


create view seedaysvw as
select 
	day.id, 
	day.name 
from days as day;

create view seestoreschedulesvw as
select 
	storeschedule.id,
	store.id as storeid,
	store.name as storeName, 
	day.name as dayname, 
	day.id as codeday,
	storeschedule.openhour, 
	storeschedule.closehour
from STORESCHEDULES as storeschedule
inner join days as day on storeschedule.day = day.id
inner join stores as store on storeschedule.store = store.id;

create view seelanguajesvw as
select 
	languaje.id, 
	languaje.name 
from languajes as languaje;

create view seestorelanguajesvw as
select 
	storelanguaje.id,
	store.id as storeid,
	store.name as storename,
	languaje.id as languajecode,
	languaje.name as languajename
from STORELANGUAJES as storelanguaje
inner join stores as store on storelanguaje.store = store.id
inner join languajes as languaje on storelanguaje.languaje = languaje.id;

create view seepaymentmethodsvw as
select 
	paymentmethod.id,
	paymentmethod.name
from PAYMENTMETHODS as paymentmethod;


-- PROCEDURES

CREATE PROCEDURE ADDUSERSP (username varchar(60), userlastname varchar(60), email varchar(60), password varchar(60), phone varchar(11), address text, city varchar(6), nationality varchar(4)) 
LANGUAGE SQL
AS $$
	INSERT INTO USERS(firstname, lastname, email, password, phone, address, city, nationality)
	VALUES(username, userlastname,email, password, phone, address, city, nationality)
$$;

CREATE PROCEDURE ADDSTORESP (NAME VARCHAR(40), DESCRIPTION TEXT, ADDRESS TEXT, ZIPCODE VARCHAR(6), PHONE VARCHAR(10), WEBSITE TEXT, CITY VARCHAR(6), LOGO TEXT)
LANGUAGE SQL
AS $$
	INSERT INTO STORES (name, description, address, zipcode, phone, website, city, logo) 
	VALUES (
		NAME, 
		DESCRIPTION,
		ADDRESS,
		ZIPCODE,
		PHONE,
		WEBSITE, 
		CITY, 
		LOGO
	)
$$;

CREATE PROCEDURE ADDSTORETAGSP (STORE BIGINT, TAG VARCHAR(60)) 
LANGUAGE SQL
AS $$
	INSERT INTO STORETAGS(store,tag) values (STORE, TAG)
$$;

CREATE PROCEDURE ADDSTORECATEGORYSP (STORE BIGINT, CATEGORY VARCHAR(60), POINTS INT) 
LANGUAGE SQL
AS $$
	insert into STORECATEGORIES(store, category, points) values (STORE, CATEGORY, POINTS)
$$;

CREATE PROCEDURE ADDSTOREPAYMENTMETHODSP (STORE BIGINT, PAYMENTMETHOD INT)
LANGUAGE SQL
AS $$
	insert into STOREPAYMENTMETHODS(store, paymentmethod) values (STORE,PAYMENTMETHOD)
$$;

CREATE PROCEDURE ADDSTORESCHEDULESP (DAY INT, OPENHOUR VARCHAR(6), CLOSEHOUR VARCHAR(6), STORE BIGINT) 
LANGUAGE SQL
AS $$
	insert into STORESCHEDULES(day, openhour, closehour, store) values (DAY, OPENHOUR, CLOSEHOUR, STORE)
$$;

CREATE PROCEDURE ADDSTORELANGUAJESP (STORE BIGINT, LANGUAJE VARCHAR(3)) 
LANGUAGE SQL
AS $$
	insert into STORELANGUAJES(store, languaje) values (STORE, LANGUAJE)
$$;

create PROCEDURE GETUSERBYEMAILsp (EMAIL varchar(60)) 
LANGUAGE SQL
as $$ 
	SELECT * FROM seeusersvw where email = email
$$; 

create procedure gettagsbystoresp (storeid bigint)
LANGUAGE SQL
as $$
	SELECT * FROM seestoretagsvw where storeid = storeid
$$;

CREATE PROCEDURE GETSTORECATEGORYBYID( STOREID BIGINT )
LANGUAGE SQL
AS $$	
	SELECT * FROM seestorecategoriesvw WHERE STOREID = STOREID
$$;

CREATE PROCEDURE GETSTOREPAYMENTMETHODSBYID( STOREID BIGINT)
LANGUAGE SQL
AS $$	
	SELECT * FROM seestorepaymentmethodsvw WHERE STOREID = STOREID
$$;

CREATE PROCEDURE GETSTORELANGUAJESBYID( STOREID BIGINT )
LANGUAGE SQL
AS $$	
	SELECT * FROM seestorelanguajesvw WHERE STOREID = STOREID
$$;

CREATE PROCEDURE GETSTORESCHEDULEBYID(  STOREID BIGINT) 
LANGUAGE SQL
AS $$	
	SELECT * FROM seestoreschedulesvw  WHERE STOREID = STOREID
$$;

CREATE PROCEDURE getstoreatSP( countryid VARCHAR(4), cityid VARCHAR(6)) 
LANGUAGE SQL
as $$	
	SELECT * FROM seestoresvw where cityid = cityid and countryid = countryid
$$;

CREATE PROCEDURE getstoreBYZIPSP( ZIP VARCHAR(6) )
LANGUAGE SQL
as $$	
	SELECT * FROM seestoresvw where ZIPCODE = ZIP
$$;

CREATE PROCEDURE getstoreBYNAMESP( NAME VARCHAR(40) )
LANGUAGE SQL
as $$	
	SELECT * FROM seestoresvw where NAME LIKE CONCAT( '%',NAME,'%')
$$;
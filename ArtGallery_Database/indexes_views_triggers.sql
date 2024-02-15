--Примери с ограничения


ALTER TABLE Client ADD CONSTRAINT FK_FAV_ARTIST_ID FOREIGN KEY(favourite_id) REFERENCES Artist(artist_id);

ALTER TABLE Exhibition ADD CONSTRAINT FK_EX_GALLERY_ID FOREIGN KEY(gallery_id) REFERENCES Gallery(gallery_id);

ALTER TABLE ArtWork ADD CONSTRAINT FK_AW_GALLERY_ID FOREIGN KEY(gallery_id) REFERENCES Gallery(gallery_id);
ALTER TABLE ArtWork ADD CONSTRAINT FK_EXHIBITION_ID FOREIGN KEY(exhibition_id) REFERENCES Exhibition(exhibition_id);
ALTER TABLE ArtWork ADD CONSTRAINT FK_ARTIST_ID FOREIGN KEY(artist_id) REFERENCES Artist(artist_id);
ALTER TABLE ArtWork ADD CONSTRAINT FK_CLIENT_ID FOREIGN KEY(client_id) REFERENCES Client(client_id);



--Примери с изгледи и индекси


--Индекс за името на артиста от неговото име и фамилия
CREATE INDEX artist_name
ON Artist (f_name, l_name);



--Индекс за името на клиента от неговото име и фамилия
CREATE INDEX client_name
ON Client (f_name, l_name);



--Индекс за локация на дадения клиент
CREATE INDEX client_location
ON Client (address, country);



--Изглед за артистите от САЩ
CREATE VIEW [USA Artists] AS
SELECT f_name, l_name
FROM Artist
WHERE birth_place = 'USA';



--Изглед за потекло на артистите от 20ти век
CREATE VIEW [20th century artists origin] AS
SELECT a.birth_place
FROM Artist a, ArtWork aw 
WHERE aw.year_of_creation>1899
AND aw.artist_id = a.artist_id
GROUP BY aw.type_of_art;



--Изглед за клиентите от Катар
CREATE VIEW [Qatar Clients] AS
SELECT f_name, l_name
FROM Client 
WHERE country = 'Qatar';



--Изглед за мобилни телефони на фенове на Поп Арт
CREATE VIEW [Pop Art Fans' mobile numbers] AS
SELECT mobile_number
FROM Client 
WHERE favourite_style = 'Pop Art';



--Изглед за изложби от 2014
CREATE VIEW [Exhibitions in 2014] AS
SELECT *
FROM Exhibition
WHERE start_date>2013-12-31
AND end_date<2015-1-1;



--Изглед за живописи създадени преди първата световна война
CREATE VIEW [Paintings before World War I] AS
SELECT title
FROM ArtWork
WHERE type_of_art = 'painting'
AND year_of_creation<1914;


--Тригери


--Tригер за таблицата ArtWork, 
--който да се задейства при вмъкване на художествено произведение в таблицата и да увеличава с единица броя на произведенията за таблицата Gallery, 
--както и броя на произведенията към съответната изложба.


ALTER TABLE Gallery ADD num_artwork_g int check(num_galleries >= 0);
ALTER TABLE Exhibition ADD num_artwork_e int check(num_exhibitions >= 0);

-- drop trigger if exists in master
USE master
GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'art_work_increase_values')
	drop trigger art_work_increase_values;
GO




-- create trigger "art_work_increase_values"
create trigger art_work_increase_values on ArtWork
for insert 
as
update Gallery
   set num_artwork_g = isnull(num_artwork_g,0) + (select count(1) from inserted where gallery_id = gallery_id)
 where gallery_id in (select gallery_id from inserted)
update Exhibition
   set num_artwork_e = isnull(num_artwork_e,0) + (select count(1) from inserted where exhibition_id = exhibition_id)
 where exhibition_id in (select exhibition_id from inserted);
 

 
 -- several scripts to check the trigger
-- firstly, delete records if they exist in the ArtWork table
delete from ArtWork where art_id in ('AW23', 'AW2', 'AW13');



-- set to null the num_artwork_g values for gallery_id G333 and G111
update Gallery
   set num_artwork_g = null
 where gallery_id in ('G333', 'G111');



-- set to null the num_artwork_e  values for exhibition_id EX3 and EX14
update Exhibition
   set num_artwork_e = null
 where exhibition_id in ('EX3', 'EX14');
 


 -- insert some artWork records
INSERT INTO ArtWork
VALUES('ART13','AW13','Eight Elvises',1963,'silkscreen painting',99000000.00,'G222','EX3','CL16'),
		 ('ART3','AW2','Le Bassin aux Nymphéas',1919,'painting',102000000.00,'G111','EX14','CL15'),
       	   ('ART4','AW23','EVERYDAYS: THE FIRST 5000 DAYS',2020,'digital art',70000000.00,'G222','EX14','CL17');



-- see if anything happened to the gallery table
select g.*
  from Gallery g
 where g.gallery_id in ('G333', 'G111');



-- see if anything happened to the Exhibition table
select e.*
  from Exhibition e
 where e.exhibition_id in ('EX3', 'EX14');



 
--Tригер, който регистрира записи за таблицата ArtWork, за всяка промяна направена в съществуващи записи

-- creating an audit table (copying only table structure, no data)
select * into ArtWork_audit from ArtWork where 1=2;



-- adding additional columns for change date and user that
-- made the change
alter table ArtWork_audit add udated_by varchar(60), updated_on datetime default getdate(), operation_type varchar(20);



-- drop trigger if exists
USE master
GO
if exists (select 1
			 from sys.objects
			where type = 'TR'
			  and name = 'trigger_artWork_audit')
	drop trigger trigger_artWork_audit;
GO



CREATE TRIGGER trigger_artWork_audit ON ArtWork
AFTER update, delete
AS
DECLARE @event_type varchar(42)
IF EXISTS(SELECT * FROM inserted)
	AND EXISTS(SELECT * FROM deleted)
    SELECT @event_type = 'update'
ELSE
	SELECT @event_type = 'delete'



insert into ArtWork_audit
	  (artist_id,
       art_id,
       title,
       year_of_creation,
       type_of_art,
       price,
       gallery_id,
       exhibition_id,
       client_id,
	   udated_by,
	   operation_type)
select artist_id,
       art_id,
       title,
       year_of_creation,
       type_of_art,
       price,
       gallery_id,
       exhibition_id,
       client_id,
	   SUSER_SNAME(),
	   @event_type
  from deleted;



-- check trigger
select * from ArtWork
 where art_id in ('AW23', 'AW3');

update ArtWork
   set price = 274000000.00
 where art_id = 'AW23';

delete from ArtWork where art_id = 'AW3';

select *
  from ArtWork_audit;

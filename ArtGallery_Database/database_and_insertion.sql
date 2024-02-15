--Създаване на схемите и релациите

USE master
GO
if exists (select * from sysdatabases where name='ArtGallery')
	DROP DATABASE ArtGallery
GO



CREATE DATABASE ArtGallery
GO
USE ArtGallery
GO




CREATE TABLE Artist(
  	artist_id varchar(50) PRIMARY KEY, 
	f_name varchar(50),
  	l_name varchar(50),
  	birth_place varchar(50),
  	style varchar(50),
);



CREATE table Client(
  client_id varchar(50) PRIMARY key,
  f_name varchar(50),
  l_name varchar(50),
  address varchar(50),
  country varchar(50),
  mobile_number varchar(50),
  check(mobile_number like '+%'), --check this
  favourite_id varchar(50) FOREIGN key REFERENCES Artist(artist_id),
  favourite_artist varchar(50),
  favourite_style varchar(50),
);




CREATE table Gallery (
  gallery_id varchar(50) PRIMARY key,
  name varchar(50) not NULL,
  location VARCHAR(50),
  unique(name, location)
);




CREATE table Exhibition (
  exhibition_id varchar(50) PRIMARY key,
  start_date date DEFAULT GETDATE(),
  end_date date,
  gallery_id varchAR(50) FOREIGN key REFERENCES Gallery(gallery_id),
  CHECK(end_date >= start_date)
);




CREATE TABLE ArtWork(
  artist_id varchar(50) FOREIGN key references Artist(artist_id),
  art_id varchar(50) PRIMARY key,
  title varchar(50),
  year_of_creation int,
  type_of_art varchar(50),
  price decimal(13,2) not NULL,
  gallery_id varchar(50) FOREIGN key REFERENCES Gallery(gallery_id),
  exhibition_id varchar(50) FOREIGN key REFERENCES Exhibition(exhibition_id),
  client_id varchar(50) FOREIGN key REFERENCES Client(client_id),
  CHECK(year_of_creation > 1800)
);




--Добавяне на съдържание


INSERT INTO Artist (artist_id, f_name, l_name, birth_place, style) VALUES
    ('ART1','Jacques-Louis','David','France','Neoclassicism'),
    ('ART2','Jean','Broc','France','Neoclassicism'),
    ('ART3','Claude','Monet','France','Impressionism'),
    ('ART4','Francisco','de Goya','Spain','Romanticism'),
    ('ART5','Théodore','Géricault','France','Romanticism'),
    ('ART6','Eugene','Delacroix','France','Romanticism'),
    ('ART7','Gustave','Courbet','France','Realism'),
    ('ART8','Jean-Francois ','Millet','France','Realism'),
    ('ART9','Thomas','Eakins','USA','Realism'),
    ('ART10','Berthe','Morison','France','Impressionism'),
    ('ART11','Edgar','Degas','France','Impressionism'),
    ('ART12','Vincent','Van Gogh','Netherlands','Post-Impressionism'),
    ('ART13','Andy','Warhol','USA','Pop Art'),
    ('ART14','Wassily','Kandinsky','Russia','Expressionism'),
    ('ART15','Edvard','Munch','Norway','Expressionism'),
    ('ART16','Franz','Marc','Germany','Expressionism'),
    ('ART17','Ernst','Barlach','Germany','Expressionism'),
    ('ART18','Pablo','Picasso','Spain','Cubism'),
    ('ART19','Umberto','Boccioni ','Italy','Futurism'),
    ('ART20','Gerardo','Dottori','Italy','Futurism'),
    ('ART21','Salvador','Dali','Spain','Surrealism'),
    ('ART22','Jackson','Pollock','USA','Abstract Expressionism'),
    ('ART23','Willem','de Kooning','Netherlands','Abstract Expressionism'),
    ('ART24','Mark','Rothko','Latvia','Abstract Expressionism'),
    ('ART25','Roy','Lichtenstein','USA','Pop Art'),
    ('ART26','Gustav','Klimt','Austria','Symbolism'),
    ('ART27','Kazimir','Malevich','Ukraine','Geometric Abstraction'),
    ('ART28','Sacha ','Jafri','United Kingdom','Contemporary'),
    ('ART29','Peter','Lik','Australia','Landscape'),
    ('ART30','Andreas','Gursky','Germany','Landscape'),
    ('ART31','Richard','Prince','USA','Full-body Portrait'),
    ('ART32','Cindy','Sherman','USA ','Self-Portait'),
    ('ART33','Jeff','Koons','USA','Contemporary'),
    ('ART34','Gerhard','Richter','Germany','Contemporary'),
    ('ART35','Mike','Winkelmann','USA','Contemporary');




INSERT INTO Client (client_id, f_name, l_name, address, country, mobile_number, favourite_id, favourite_artist, favourite_style) VALUES
    ('CL1','Marlene','Singleton','1197 Burnside Court, Phoenix','USA','+1 480 871 4296','ART1','Jacques-Louis David','Neoclassicism'),
    ('CL2','Susan','Caldwell','1762 Robertson Ave, Thabazimbi','South Africa','+27 822 818 303','ART2','Jean Broc','Neoclassicism'),
    ('CL3','Darcie-Mae','Davidson','783 Akasia St, Merrivale','South Africa','+27 844 799 348','ART3','Claude Monet','Impressionism'),
    ('CL4','Kenny','Morris','Rue des Ecoles 2119, Vise','Belgium','+32 484 92 27248','ART4','Francisco de Goya','Romanticism'),
    ('CL5','Zakariah','Riddle','Rue Haute 391, Steendorp','Belgium','+32 496 74 33295','ART5','Théodore Géricault','Romanticism'),
    ('CL6','Jacque','Hardy','Rue du Bourgmestre Dandoy 375, Antwerp','Belgium','+32 496 22 38085','ART6','Eugene Delacroix','Romanticism'),
    ('CL7','Dion','Franco','Heinrich Heine Platz 48, Leinefelde','Germany','+49 3605 61 75722','ART7','Gustave Courbet','Realism'),
    ('CL8','Celyn','Baker','Brandenburgische Str. 48, Bad Wimpfen','Germany','+49 7063 54 70462','ART8','Jean-Francois Millet','Realism'),
    ('CL9','Drew','Butt','Karl-Liebknecht-Strasse 84, Bassum','Germany','+49 4241 46 20808','ART9','Thomas Eakins','Realism'),
    ('CL10','Casper','Charles','123 rue Lenotre, Rennes','France','+33 286 882 8561','ART10','Berthe Morison','Impressionism'),
    ('CL11','Omari','Arroyo','84 Chemin Du Lavarin Sud, Caen','France','+33 289 985 5453','ART11','Edgar Degas','Impressionism'),
    ('CL12','Mohammad ','Ratcliffe','Alunsjøveien 1023, Oslo','Norway','+47 925 43 142','ART12','Vincent Van Gogh','Post-Impressionism'),
    ('CL13','Annabel','Robbins','Erlenweg 48, Bern','Switzerland','+41 315 514 8258','ART13','Andy Warhol','Pop Art'),
    ('CL14','Devonte','Mcgee','Erlenweg 48, Bern','Switzerland','+41 316 385 9297','ART14','Wassily Kandinsky','Expressionism'),
    ('CL15','Saanvi','Johnston','Alunsjøveien 1023, Oslo','Norway','+47 428 91 556','ART15','Edvard Munch','Expressionism'),
    ('CL16','Rubie','Melendez','23.Blok N 220, Gimat, Ankara','Turkey','+90 312 397 1167','ART16','Franz Marc','Expressionism'),
    ('CL17','Lorelai','Hinton','St 17, Gate 113 - A, Indl Area','Qatar','+974 44 423 378','ART17','Ernst Barlach','Expressionism'),
    ('CL18','Ollie','Callahan','Al Sadd St, Doha','Qatar','+974 44 329 993','ART18','Pablo Picasso','Cubism'),
    ('CL19','Ava-Grace','Woodcock','Street 14 Gate 65 Industrial Area Salwa Road, Doha','Qatar','+974 44 503 316','ART19','Umberto Boccioni','Futurism'),
    ('CL20','Gabrielle','Joyner','Al Gharafa, P.O.Box 128128, Doha','Qatar','+974 44 861 887','ART20','Gerardo Dottori','Futurism');



INSERT INTO Gallery (gallery_id, name, location) VALUES
    ('G111','DOWNTOWN GALLERY','New York City'),
    ('G222','UPTOWN GALLERY','New York City'),
    ('G333','SOHO GALLERY','New York City'),
    ('G444','MANHATTAN GALLERY','New York City');



INSERT INTO Exhibition (exhibition_id, start_date, end_date, gallery_id) VALUES
    ('EX1','2010-07-19','2010-09-11','G222'),
    ('EX2','2011-02-14','2011-04-16','G444'),
    ('EX3','2012-03-05','2012-04-28','G444'),
    ('EX4','2012-11-19','2013-02-09','G222'),
    ('EX5','2013-10-28','2014-11-15','G111'),
    ('EX6','2015-06-22','2015-07-11','G222'),
    ('EX7','2016-02-22','2016-06-04','G111'),
    ('EX8','2016-02-29','2016-11-05','G444'),
    ('EX9','2016-11-21','2017-02-25','G222'),
    ('EX10','2017-04-03','2017-11-04','G111'),
    ('EX11','2018-08-20','2018-12-01','G111'),
    ('EX12','2018-10-15','2019-02-02','G333'),
    ('EX13','2018-11-05','2019-04-27','G111'),
    ('EX14','2019-02-04','2019-07-06','G222'),
    ('EX15','2019-04-15','2019-11-23','G111'),
    ('EX16','2020-06-29','2020-08-29','G333'),
    ('EX17','2020-08-17','2020-10-10','G444'),
    ('EX18','2021-07-19','2021-11-27','G333'),
    ('EX19','2021-09-20','2021-12-25','G222'),
    ('EX20','2021-10-18','2022-05-28','G111');




INSERT INTO ArtWork (artist_id, art_id, title, year_of_creation, type_of_art, price, gallery_id, exhibition_id, client_id) VALUES
    ('ART1','AW1','Napoleon Crossing the Alps',1805,'painting',10000000.00,'G222','EX1','CL10'),
    ('ART10','AW10','The Gross Clinic',1875,'painting',89000000.00,'G111','EX10','CL6'),
    ('ART11','AW11','The Bridge at Argenteuil',1874,'painting',75100000.00,'G222','EX14','CL16'),
    ('ART12','AW12','The Cradle',1872,'painting',100000000.00,'G111','EX13','CL3'),
    ('ART12','AW13','The Ballet Class',1874,'painting',6000000.00,'G333','EX12','CL10'),
    ('ART12','AW14','A Wheat Field with Cypresses',1889,'painting',107000000.00,'G222','EX4','CL8'),
    ('ART13','AW15','The Starry Night',1889,'painting',9250000.00,'G111','EX15','CL4'),
    ('ART13','AW16','Eight Elvises',1963,'silkscreen painting',99000000.00,'G444','EX2','CL16'),
    ('ART14','AW17','Mountain Landscape with Church',1910,'painting',130000000.00,'G111','EX7','CL1'),
    ('ART15','AW18','The Scream',1893,'painting',141000000.00,'G222','EX14','CL11'),
    ('ART16','AW19','Fighting Forms',1914,'painting',146300000.00,'G111','EX13','CL7'),
    ('ART17','AW2','The Death of Hyacinthos',1801,'painting',5000000.00,'G222','EX6','CL4'),
    ('ART18','AW20','The Avenger',1914,'sculpture',30000000.00,'G111','EX5','CL10'),
    ('ART18','AW21','Les Demoiselles d''Avignon',1907,'painting',36000000.00,'G444','EX3','CL14'),
    ('ART18','AW22','Guernica',1937,'painting',72400000.00,'G111','EX10','CL12'),
    ('ART19','AW23','Head of a Woman',1910,'sculpture',56000000.00,'G333','EX16','CL17'),
    ('ART2','AW24','Unique Forms of Continuity in Space',1913,'sculpture',14000000.00,'G111','EX11','CL15'),
    ('ART20','AW25','Primavera Umbria',1923,'painting',120300000.00,'G222','EX1','CL19'),
    ('ART21','AW26','The Persistence of Memory',1931,'painting',135000000.00,'G111','EX11','CL12'),
    ('ART22','AW27','Number 17A',1948,'painting',229000000.00,'G444','EX2','CL6'),
    ('ART22','AW28','Woman III',1953,'painting',185000000.00,'G444','EX2','CL13'),
    ('ART23','AW29','No. 6 (Violet, Green and Red)',1951,'painting',213000000.00,'G444','EX8','CL2'),
    ('ART24','AW3','Poppies',1873,'painting',1500000.00,'G222','EX9','CL8'),
    ('ART25','AW30','Shot Sage Blue Marilyn',1964,'graphic',195000000.00,'G111','EX20','CL8'),
    ('ART25','AW31','No. 5, 1948',1948,'painting',182000000.00,'G111','EX7','CL14'),
    ('ART26','AW32','Masterpiece',1962,'painting',182000000.00,'G222','EX6','CL8'),
    ('ART26','AW33','Nurse',1964,'painting',109000000.00,'G222','EX14','CL2'),
    ('ART27','AW34','L’Allée des Alyscamps',1888,'painting',76000000.00,'G111','EX15','CL18'),
    ('ART28','AW35','Portrait of Adele Bloch-Bauer II',1912,'painting',170000000.00,'G111','EX10','CL7'),
    ('ART29','AW36','Portrait of Adele Bloch-Bauer I',1907,'painting',182000000.00,'G111','EX15','CL2'),
    ('ART3','AW37','Meules',1890,'painting',117000000.00,'G111','EX15','CL6'),
    ('ART3','AW38','Le Bassin aux Nymphéas',1919,'painting',102000000.00,'G111','EX13','CL15'),
    ('ART3','AW39','Suprematist Composition',1916,'painting',93000000.00,'G111','EX10','CL15'),
    ('ART3','AW4','Third of May 1808',1814,'painting',123000000.00,'G111','EX15','CL5'),
    ('ART30','AW40','The Journey of Humanity',2020,'painting',62000000.00,'G222','EX1','CL17'),
    ('ART31','AW41','Phantom',2014,'photograph',6500000.00,'G222','EX6','CL5'),
    ('ART32','AW42','Rhein II',1999,'photograph',4500000.00,'G111','EX5','CL4'),
    ('ART33','AW43','Spiritual America',1983,'print',4000000.00,'G333','EX12','CL1'),
    ('ART33','AW44','Untitled #96',1981,'photograph',4000000.00,'G444','EX2','CL13'),
    ('ART33','AW45','Hanging Heart (Magenta/Gold)',2006,'installation',24000000.00,'G333','EX12','CL10'),
    ('ART34','AW46','Abstraktes Bild(809-4)',1994,'painting',34000000.00,'G111','EX20','CL17'),
    ('ART34','AW47','Domplatz, Mailand',1968,'photo-painting',37000000.00,'G111','EX15','CL12'),
    ('ART35','AW48','Balloon Dog (Orange)',1955,'sculpture',58500000.00,'G222','EX1','CL14'),
    ('ART4','AW49','EVERYDAYS: THE FIRST 5000 DAYS',2020,'digital art',70000000.00,'G222','EX14','CL17'),
    ('ART5','AW5','The Raft of Medusa',1819,'painting',119000000.00,'G222','EX19','CL6'),
    ('ART6','AW50','Rabbit',1986,'sculpture',91500000.00,'G222','EX4','CL11'),
    ('ART7','AW6','Liberty Leading the People',1830,'painting',98500000.00,'G111','EX5','CL12'),
    ('ART7','AW7','A Burial at Ornans',1849,'painting',69300000.00,'G111','EX15','CL6'),
    ('ART8','AW8','The Gleaners',1857,'painting',149200000.00,'G333','EX18','CL3'),
    ('ART9','AW9','The Stone Breakers',1850,'painting',23000000.00,'G111','EX15','CL9');

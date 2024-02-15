--Примерни прости заявки


-- 1. Заявка, която извежда адреса на галерията ‘DOWNTOWN GALLERY’
select g.location
from Gallery g
where g.NAME = 'DOWNTOWN GALLERY';



-- 2. Заявка, която извежда стила на артиста Gustave Courbet	
select a.style
from Artist a
where a.f_name = 'Gustave' and a.l_name = 'Courbet';



-- 3. Заявка, която извежда годината кога е направено изкуственото произведение чийто art id е AW13, в чието заглавие има думата 'woman'.
select a.year_of_creation
from ArtWork a
where a.art_id = 'AW13'
or upper(a.title) like upper('%woman%');



-- 4. Заявка, която извежда началната и крайната дата на изложбата EX12
select ex.start_date, ex.end_date
from exhibition ex
where ex.exhibition_id = 'EX12';



-- 5. Заявка, която извежда името на клиентите кои са от Норвегия и тяхните омилени артисти.
select c.f_name, c.l_name, c.favourite_artist
from client c
where c.country = 'Norway';



--Примерни заявки върху две и повече релации


-- 1. Заявка, която извежда рожденото место на артиста, който прави дигитални изкуствени произведения.
select a.birth_place
from Artist a, 
	ArtWork aw
where a.artist_id = aw.artist_id
	and aw.type_of_art = 'digital art';



-- 2. Заявка, която извежда държавата на клиента, чието любимo изкуствено произведение е направено в 1805год.
select c.country
from client c, ArtWork aw
where c.client_id = aw.client_id
	and aw.year_of_creation = 1805;



-- 3. Заявка, която извежда името и локацията на галерията където е изложбата с ид EX12.
select g.name, g.location
from Gallery g, Exhibition ex
where g.gallery_id = ex.gallery_id
	and ex.exhibition_id = 'EX12';



-- 4. Заявка, която извежда имената на артистите, чийто стил е романтизам и изложбите са им в една галерия.
select a.f_name, a.l_name
from Artist a,
	 ArtWork aw,
	 Gallery g
where a.artist_id = aw.artist_id
   and aw.gallery_id = g.gallery_id
   and a.style = 'Romanticism';



-- 5. Заявка, която извежда наслова и годината на изкуствените произведения, чиято цена е по-голяма от 50000 и ид на галерията е G111.
select aw.title, aw.year_of_creation
from ArtWork aw,
	Exhibition ex
where aw.price > 50000
	and ex.gallery_id = 'G111'
	and aw.exhibition_id = ex.exhibition_id;



-- Подзаявки


-- 1. Заявка, която извежда имената на всички изкуствени произведения с година на производство, по-голяма от годината на производство на произведението ‘Eight Elvises’.
select title
from ArtWork 
where year_of_creation > (select year_of_creation 
						  from ArtWork 
						  where title = 'Eight Elvises');



-- 2. Заявка, която извежда името на артиста и името на изкуственото произведение, което има най-висока цена от всички изкуствени произведения.
select a.f_name, a.l_name, aw.title
from Artist a,
	(select aw.artist_id , aw.title 
	 from ArtWork aw 
	 where aw.price >=ALL (select price 
						   from ArtWork)) aw
where a.artist_id = aw.artist_id;



-- 3. Заявка, която извежда имената и типа на всички изкуствени произведения които са били изложeни на 20.09.2021, подредени по наименованието им. 
select a.title, a.type_of_art 
from ArtWork a
where a.gallery_id in (select e.gallery_id 
					   from Exhibition e 
					   where e.start_date = '2021-09-20') 
order by 1;



-- 4. Заявка, която извежда имената, омилен артист и стил на всички клиенти които имат същ омилен артист и стил като клиентът с име 'Saanvi'. 
select distinct c.f_name, c.l_name, c.favourite_artist, c.favourite_style
from client c
where c.favourite_style in (select s.favourite_style 
							from Client s 
							where s.f_name = 'Saanvi')



-- 5. Заявка, която извежда всички изкуствени произведения които не са били част от егзибиция която се е случвала в галерията UPTOWN GALLERY, подредени по именованията им.
select aw.title
from ArtWork aw, 
	 Gallery g
where aw.exhibition_id not in (select e.exhibition_id 
							   from Exhibition e 
							   where e.gallery_id = g.gallery_id)
and g.name = 'UPTOWN GALLERY'
order by title;



--Примери със съединения


-- 1. Заявка, която извежда имената на артистите, наслова на арта и цената на изкуствените произведения, чиято цена е по-голяма от 90000000.
select a.f_name, a.l_name, aw.title, aw.price
from ArtWork aw
join Artist a on a.artist_id = aw.artist_id
where aw.price > 90000000;



-- 2. Заявка, която извежда имената на артистите, чийто са направили изкуствените произведения си след 1928 год. и са изложени в галерия G111.
select distinct a.f_name, a.l_name
from Artist a
join ArtWork aw on a.artist_id = aw.artist_id
join Gallery g on g.gallery_id = aw.gallery_id
where aw.year_of_creation > 1928 
   and g.gallery_id = 'G111';



-- 3. Заявка, която извежда exhibition id, началната дата на изложбата и крайната дата на изложбата, къде са изложени дела с цена над 10000000.00 в галерияата SOHO GALLERY.
select ex.exhibition_id, ex.start_date, ex.end_date
from Exhibition ex
join Gallery g on g.gallery_id = ex.gallery_id
join ArtWork aw on ex.exhibition_id = aw.exhibition_id
where g.name = 'SOHO GALLERY'
  and aw.price > 10000000.00;



-- 4. Заявка, която извежда client id, името на клиентите кои са от Южна Африка и неговия омилен артист, чийто изкуствени произведения са с цена над 50000000.
select distinct c.client_id, c.f_name, c.l_name, c.favourite_artist
from client c
join ArtWork aw on aw.client_id = c.client_id
join Artist a on a.artist_id = aw.artist_id
where  aw.price > 50000000
   and c.country = 'South Africa';



-- 5. Заявка, която извежда името на артиста и неговото рожденно место, чийто стил е футуризам и вида на изкуственото произведение е скулптура.
select a.f_name, a.l_name, a.birth_place
from Artist a
left join ArtWork aw on aw.artist_id = a.artist_id
where a.style = 'Futurism'
  and aw.type_of_art = 'sculpture';



-- Примери с групиране и аграгация

-- 1. Заявка, която извежда средната цена на изкуствените изображения изработени от 'Vincent Van Gogh'.
select AVG(aw.price) avgPrice, a.f_name, a.l_name
from ArtWork aw
join Artist a on a.artist_id = aw.artist_id
where a.f_name = 'Vincent'
  and a.l_name = 'Van Gogh'
group by a.f_name, a.l_name;



-- 2. Заявка, която извежда артистите, които са произвели поне 2 различни изкуствени изображения, подредени в нисходящ ред според броя на изработени изображения.
select a.f_name, a.l_name, count(aw.art_id) numOfArts
from ArtWork aw 
join Artist a on a.artist_id = aw.artist_id
group by a.f_name, a.l_name
having count(aw.art_id) >= 2
order by count(aw.art_id) DESC;



-- 3. Заявка, която извежда артист/ите с най-висока цена на изкуствено изображение.
select a.f_name, a.l_name, aw.title, aw.price maxPrice
from ArtWork aw 
join Artist a on a.artist_id = aw.artist_id
where aw.price = (select max(price) 
				  from ArtWork);



-- 4. Заявка, която извежда средната цена на изкуствените изображения, които са изработени от 'Claude Monet', след 1900г.
select  a.f_name, a.l_name, AVG(aw.price) avgPrice
from ArtWork aw
join Artist a on a.artist_id = aw.artist_id
where a.f_name = 'Claude'
  and a.l_name = 'Monet'
  and aw.year_of_creation > 1900
group by a.f_name, a.l_name;



-- 5. Заявка, която извежда за всяка галерия най-старто и най-новото изкуствено изображение което е било на съответна егзибиция, подредени по най-старо изображение. 
select g.name, min(aw.year_of_creation) oldestArt, max(aw.year_of_creation) newestArt
from ArtWork aw
join Exhibition e on e.gallery_id = aw.gallery_id
join Gallery g on g.gallery_id = e.gallery_id
group by g.name
order by oldestArt;



-- 6. Заявка, която извежда за всяка галерия броя на изкуствени дела във възходящ ред.
select g.name, count(aw.art_id) numOfArts
from ArtWork aw 
join Gallery g on g.gallery_id = aw.gallery_id
group by g.name
order by count(aw.art_id);



-- 7. Заявка, която извежда броя на изкуствени изображения, доколкото е имало поне едно, на егзибицията която се е случила на 19.07.2010 в галерията 'UPTOWN GALLERY'.
select g.name, count(aw.art_id) numOfArts
from ArtWork aw 
join Gallery g on g.gallery_id = aw.gallery_id
join Exhibition e on e.gallery_id = g.gallery_id
where g.name = 'UPTOWN GALLERY'
and e.start_date = '2010-07-19'
group by g.name
having count(aw.art_id) >= 1;



-- 8. Заявка, която извежда имената на клиентите и броя на купени изкуствени изображения, за тези клиенти които са купили по-вече от 1 изображение, подредени в разходящ ред според техните имена.
select c.f_name, c.l_name, count(aw.art_id) numOfBoughtArts
from ArtWork aw
join Artist a on a.artist_id = aw.artist_id
join Client c on c.favourite_id = a.artist_id
group by c.f_name, c.l_name
having count(aw.art_id) > 1
order by c.f_name;



-- 9. Заявка, която извежда сумата от всички закупени изкуствени изображения на клиентът с име 'Darcie-Mae Davidson'.
select c.f_name, c.l_name, sum(aw.price) sumOfBoughtArts
from ArtWork aw
join Artist a on a.artist_id = aw.artist_id
join Client c on c.favourite_id = a.artist_id
where c.f_name = 'Darcie-Mae'
  and c.l_name = 'Davidson'
group by c.f_name, c.l_name;



-- 10. Заявка, която извежда броят на екзибиции за всяка галерия. 
select g.name, count(e.exhibition_id) numOfExhibitions
from Exhibition e
join Gallery g on g.gallery_id = e.gallery_id
group by g.name;

























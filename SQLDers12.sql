use EczaneTakip

select * from tblDoktor

select * from tblDoktor
where AdSoyad like 'a%'

------------------JOÝN KULLANIMI---------------------

--FARKLI KOLONLARI BÝRLEÞTÝREREK GETÝRME ÝÞLEMÝNÝ YAPAR
select u.UnvanAd,d.AdSoyad,d.TelCep
from tblDoktor d
join tblUnvan u on d.ID=u.ID

select u.UnvanAd,b.BirimAd,d.AdSoyad,d.TelCep
from tblDoktor d
join tblBirimler b on d.ID=b.ID
join tblUnvan u on  d.ID=u.ID



--Ýlaç Katogori adý ,eczanedeposu adý ve ilaç adýný 
--birlestiren sql sorgusunu yazýnýnz
select e.DepoAd,k.KategoriAd,i.Ad
from tblilac i
join tblEczaneDeposu e on i.ID=e.ID
join tblilacKategori k on k.ID=i.ÝlacKategoriID


--Satýþ tablosundaki satýlan ürünlerin tarihe göre tersten müþterinin adýný,  
--fiyatý ve kaç adet satýldýðýný gösteren sql sorgusunu yazýnýz 
select s.Tarih,m.AdSoyad,i.Ad,s.Fiyat,s.Adet
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID 
join tblilac i on s.ilacID=i.ID
order by Tarih desc


--yukardaki sorguyu tarih gün.ay.yýl olacak 
--þekilde formatlayarak gösteriniz.
select CONVERT(varchar,s.Tarih,104) as [Satýþ Tarih],m.AdSoyad, i.Ad, s.Fiyat, s.Adet 	
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID
join tblilac i on s.ilacID=i.ID
order by Tarih desc


--yukarýdaki sorguya ilaveten ilacýn hangi eczadeposuna ait
--ve hangi kategorideki ilac olduðunu da belirtiniz.
select CONVERT(varchar,s.Tarih,104) as [Satýþ Tarih],ik.KategoriAd, e.DepoAd, m.AdSoyad, i.Ad, s.Fiyat, s.Adet
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID
join tblilac i on s.ilacID=i.ID
join tblEczaneDeposu e on i.EczaDepoID = e.ID
join tblilacKategori ik on i.ilacKategoriID = ik.ID
order by Tarih desc


--EczaDeposunda adýna göre gruplayarak Satýlan ilaçlarýn 
--adet ve fiyat toplamlarýný bulduran sql sorgusunu yazýnýz
select e.DepoAd,SUM(Fiyat) as[Toplam Satýþ],SUM(Adet) as Adet
from tblSatis s
join tblilac i on s.ilacID=i.ID 
join tblEczaneDeposu e on i.EczaDepoID = e.ID
group by e.DepoAd


--Hangi eczane deposundan ortalama ne kadar ilaç satýlmýþ
--ayrýyeten bir kerede en çok ve en az ilaç satýþ adetler
--kaçar tane olmuþ
select e.DepoAd[Satýþ Yapýlan Depo Adý],
       AVG(s.Adet) as [Ortalama Satýþ Adeti],
	   MAX(s.Adet)[Bir Kerede en çok Satýþ],
	   MIN(s.Adet)[Bir Kerede en az Satýþ]
from tblSatis s
join tblilac i on s.ilacID=i.ID
join tblEczaneDeposu e on i.EczaDepoID=e.ID
group by e.DepoAd

 


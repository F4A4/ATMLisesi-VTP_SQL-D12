use EczaneTakip

select * from tblDoktor

select * from tblDoktor
where AdSoyad like 'a%'

------------------JO�N KULLANIMI---------------------

--FARKLI KOLONLARI B�RLE�T�REREK GET�RME ��LEM�N� YAPAR
select u.UnvanAd,d.AdSoyad,d.TelCep
from tblDoktor d
join tblUnvan u on d.ID=u.ID

select u.UnvanAd,b.BirimAd,d.AdSoyad,d.TelCep
from tblDoktor d
join tblBirimler b on d.ID=b.ID
join tblUnvan u on  d.ID=u.ID



--�la� Katogori ad� ,eczanedeposu ad� ve ila� ad�n� 
--birlestiren sql sorgusunu yaz�n�nz
select e.DepoAd,k.KategoriAd,i.Ad
from tblilac i
join tblEczaneDeposu e on i.ID=e.ID
join tblilacKategori k on k.ID=i.�lacKategoriID


--Sat�� tablosundaki sat�lan �r�nlerin tarihe g�re tersten m��terinin ad�n�,  
--fiyat� ve ka� adet sat�ld���n� g�steren sql sorgusunu yaz�n�z 
select s.Tarih,m.AdSoyad,i.Ad,s.Fiyat,s.Adet
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID 
join tblilac i on s.ilacID=i.ID
order by Tarih desc


--yukardaki sorguyu tarih g�n.ay.y�l olacak 
--�ekilde formatlayarak g�steriniz.
select CONVERT(varchar,s.Tarih,104) as [Sat�� Tarih],m.AdSoyad, i.Ad, s.Fiyat, s.Adet 	
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID
join tblilac i on s.ilacID=i.ID
order by Tarih desc


--yukar�daki sorguya ilaveten ilac�n hangi eczadeposuna ait
--ve hangi kategorideki ilac oldu�unu da belirtiniz.
select CONVERT(varchar,s.Tarih,104) as [Sat�� Tarih],ik.KategoriAd, e.DepoAd, m.AdSoyad, i.Ad, s.Fiyat, s.Adet
from tblSatis s
join tblMusteri m on s.MusteriID=m.ID
join tblilac i on s.ilacID=i.ID
join tblEczaneDeposu e on i.EczaDepoID = e.ID
join tblilacKategori ik on i.ilacKategoriID = ik.ID
order by Tarih desc


--EczaDeposunda ad�na g�re gruplayarak Sat�lan ila�lar�n 
--adet ve fiyat toplamlar�n� bulduran sql sorgusunu yaz�n�z
select e.DepoAd,SUM(Fiyat) as[Toplam Sat��],SUM(Adet) as Adet
from tblSatis s
join tblilac i on s.ilacID=i.ID 
join tblEczaneDeposu e on i.EczaDepoID = e.ID
group by e.DepoAd


--Hangi eczane deposundan ortalama ne kadar ila� sat�lm��
--ayr�yeten bir kerede en �ok ve en az ila� sat�� adetler
--ka�ar tane olmu�
select e.DepoAd[Sat�� Yap�lan Depo Ad�],
       AVG(s.Adet) as [Ortalama Sat�� Adeti],
	   MAX(s.Adet)[Bir Kerede en �ok Sat��],
	   MIN(s.Adet)[Bir Kerede en az Sat��]
from tblSatis s
join tblilac i on s.ilacID=i.ID
join tblEczaneDeposu e on i.EczaDepoID=e.ID
group by e.DepoAd

 


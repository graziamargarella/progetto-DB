#VISUALIZZARE IL LETTORE CHE NON HA PRESO IN PRESTITO ALCUN LIBRO
select tessera, nome from prestito p right join lettore l on l.tessera = p.lettore where p.lettore is null;

#VISUALIZZARE I LETTORI CHE HANNO PRESO IN PRESTITO 'DELITTO E CASTIGO' E NON 'DIVINA COMMEDIA' (TESSERA, NOME)
select l.tessera, l.nome from lettore l, prestito p, copia c, libro lib 
where p.lettore = l.tessera and p.copia = c.codice and c.libro = lib.isbn and lib.titolo = "Delitto e Castigo" 
and (l.tessera) not in (select l1.tessera from lettore l1, prestito p1, copia c1, libro lib1
where p1.lettore = l1.tessera and p1.copia = c1.codice and c1.libro = lib1.isbn and lib1.titolo = "Divina Commedia");

#VISUALIZZA I LETTORI CHE HANNO PRESO IN PRESTITO PIU' DI 5 LIBRI (TESSERA, PRESTITI)
select nome, count(*) as prestiti 
from prestito join lettore on prestito.lettore = lettore.tessera 
group by lettore 
having prestiti > 5
order by prestiti desc;

#VISUALIZZARE LIBRI CON IL NUMERO DI COPIE PIU' ALTO (ISBN, TITOLO, COPIE)
DROP VIEW CopieXLibro;
CREATE VIEW CopieXLibro AS 
select isbn, titolo, count(*) as copie 
from libro join copia on copia.libro = libro.isbn
GROUP BY isbn;

SELECT *
FROM CopieXLibro
WHERE copie = (SELECT max(copie) FROM CopieXLibro);

#VISUALIZZARE I LETTORI CHE HANNO PRESO IN PRESTITO TUTTI I LIBRI (TESSERA, NOME)
SELECT tessera, nome
FROM Lettore l
WHERE NOT EXISTS (SELECT * 
		FROM Copia c
		WHERE NOT EXISTS(SELECT * 
			FROM Prestito p 
            WHERE p.libro = c.libro 
            AND p.lettore = l.tessera
            GROUP BY p.copia, p.libro));

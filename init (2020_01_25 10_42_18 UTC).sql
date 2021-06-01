drop database if exists biblio;
create database biblio;

use biblio;

create table Lettore (
	tessera int not null auto_increment primary key,
    nome varchar(50) not null,
    via varchar(40) not null,
    civico int not null,
    citta varchar(30) not null
);

create table Autore (
	id int not null,
	nome varchar(30) not null,
    cognome varchar(30) not null,
    primary key(id)
);

create table Libro (
	isbn numeric not null,
    titolo varchar(100),
    primary key (isbn)
);

create table Scrittura (
	libro numeric not null,
    autore int not null,
    primary key (libro, autore),
    foreign key(libro) references Libro(isbn) on delete cascade on update cascade,
    foreign key(autore) references Autore(id) on delete cascade on update cascade
);

create table Copia (
	codice varchar(6) not null, #il codice della copia = lettera scaffale + numero nello scaffale
    libro numeric not null,
	primary key(codice,libro),
    foreign key(libro) references Libro(isbn) on delete cascade on update cascade
);

create table Prestito(
	copia varchar(6) not null,
    libro numeric not null,
    lettore int not null,
    inizio date not null,
	primary key (copia, libro, lettore, inizio),
    foreign key(copia) references Copia(codice) on delete cascade on update cascade,
    foreign key(libro) references Copia(libro) on delete cascade on update cascade,
    foreign key(lettore) references Lettore(tessera) on delete cascade on update cascade
);

insert into Lettore (nome, via, civico, citta) values
("Alice Rossi", "Vicolo Corto", 5, "Roma"),
("Leonardo Ferrari", "Parco della Vittoria", 7, "Roma"),
("Francesco Russo", "Corso Impero", 14, "Roma"),
("Alessandro Romano", "Viale Costantino", 24, "Milano"),
("Lorenzo Bianchi", "Via Accademia", 112, "Milano"),
("Giulia Verdi", "Bastioni Gran Sasso", 10, "Milano"),
("Ginevra Fontana", "Via Marco Polo", 12, "Venezia"),
("Aurora Esposito", "Piazza Giulio Cesare", 11, "Venezia");

insert into Autore values
(001, "Dante", "Alighieri"),
(002, "Italo", "Calvino"),
(003, "Franz", "Kafka"),
(004, "Charles", "Dickens"),
(005, "Fedor", "Dostoevskij");

insert into Libro values
(10793, "Memorie dal Sottosuolo"),
(21908, "Delitto e Castigo"),
(48690, "Il processo"),
(63731, "La metamorfosi"),
(40641, "Divina Commedia"),
(11718, "Vita nuova"),
(11462, "Il barone dimezzato"),
(24325, "Raccolta classici");

insert into Scrittura (libro, autore) values 
(10793, 005),
(21908, 005),
(48690, 003),
(63731, 003),
(40641, 001),
(11718, 001),
(11462, 002),
(24325, 004),
(24325, 005);

insert into Copia (libro, codice) values 
(10793, "A1"),
(21908, "A2"),
(48690, "B4"),
(63731, "B5"),
(40641, "B6"),
(11718, "C12"),
(11462, "C11"),
(24325, "A21"),
(24325, "B12"),
(11718, "A13"),
(21908, "A23"),
(63731, "B43"),
(63731, "B53"),
(11718, "B63"),
(11718, "C25"),
(48690, "C14"),
(48690, "A31"),
(48690, "B32");

insert into Prestito (lettore, copia, libro, inizio) values 
(2, "C12", 11718, 20200120),
(3, "C12", 11718, 20200323),
(3, "A1", 10793, 20191201),
(1, "B4", 48690, 20191123),
(2, "B5", 63731, 20200426),
(5, "B12", 24325, 20200923),
(6, "A2", 21908, 20191209),
(6, "B6", 40641, 20191209),
(3, "B12", 24325, 20200120),
(2, "A2", 21908, 20191109),
(8, "A2", 21908, 20200202),
(4, "A1", 10793, 20191010),
(4, "A2", 21908, 20191010),
(4, "B4", 48690, 20191010),
(4, "B5", 63731, 20191010),
(4, "B6", 40641, 20191010),
(4, "C11", 11462, 20191010),
(4, "A21", 24325, 20191010),
(4, "A13", 11718, 20190216),
(3, "B6", 40641, 20191019),
(2, "B4", 48690, 20190915),
(2, "A21", 24325, 20200120),
(3, "A31", 48690, 20200323),
(3, "C25", 11718, 20191201),
(1, "B43", 63731, 20191123),
(2, "B53", 63731, 20200426),
(6, "A13", 11718, 20191209),
(6, "C25", 11718, 20191209),
(2, "A31", 48690, 20191109),
(8, "B43", 63731, 20200202),
(3, "C25", 11718, 20191019),
(2, "B6", 40641, 20190915);
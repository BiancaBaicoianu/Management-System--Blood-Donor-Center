
--CREARE TABELE
create table DONATORI
(
    DONATOR_ID NUMBER(8)    not null
        primary key,
    NUME       VARCHAR2(15) not null,
    PRENUME    VARCHAR2(15) not null,
    VARSTA     NUMBER(3),
    SEX        VARCHAR2(20),
    ADRESA     VARCHAR2(250),
    TELEFON    VARCHAR2(15) not null
)
/

create table DEPARTAMENTE
(
    DENUMIRE        VARCHAR2(50) not null
        primary key,
    POSTURI_OCUPATE NUMBER(8) default 0,
    POSTURI_TOTAL   NUMBER(8) default 0,
    ZILE_CONCEDIU   NUMBER(8) default 0,
    constraint CK_POSTURI
        check (posturi_ocupate <= posturi_total)
)
/

create table DOCTORI
(
    DOCTOR_ID     NUMBER(8)    not null
        primary key,
    NUME          VARCHAR2(15) not null,
    PRENUME       VARCHAR2(15) not null,
    ADRESA        VARCHAR2(250),
    TELEFON       VARCHAR2(15) not null,
    SPECIALIZARE  VARCHAR2(30) not null
        constraint FK_SPECIALIZ
            references DEPARTAMENTE
                on delete cascade,
    SALARIU       NUMBER(8)    not null
        constraint CK_SAL
            check (salariu >= 2400),
    DATA_ANGAJARE DATE,
    TIP_DOCTOR    VARCHAR2(30)
)
/

create table REZULTATE_ANALIZE
(
    ANALIZE_ID     NUMBER(8) not null
        primary key,
    OBSERVATII     VARCHAR2(400),
    DATA_RECOLTARE DATE      not null
)
/

create table CAMERE
(
    CAMERA_ID         NUMBER(8)     not null
        primary key,
    TIP               VARCHAR2(100) not null,
    CAPACITATE        NUMBER(8) default 0,
    ETAJ              NUMBER(2)     not null,
    OBSERVATII_CAMERA VARCHAR2(400)
)
/

create table APARATE_MEDICALE
(
    APARAT_ID      NUMBER(8)     not null
        primary key,
    CAMERA_ID      NUMBER(8)     not null
        constraint FK_CAM_ID
            references CAMERE
                on delete cascade,
    DENUMIRE       VARCHAR2(150) not null,
    BRAND          VARCHAR2(50),
    NR_SERVICE     VARCHAR2(15)  not null,
    DATA_PRIMIRE   DATE,
    PRET_CUMPARARE NUMBER(8) default 0
)
/

create table ISTORIC_DOCTORI
(
    DOCTOR_ID    NUMBER(8)    not null
        constraint FK_DCT_ID
            references DOCTORI
                on delete cascade,
    SPECIALIZARE VARCHAR2(30) not null
        constraint FK_SPECIALIZARE
            references DEPARTAMENTE
                on delete cascade,
    DATA_INCEPUT DATE         not null,
    DATA_SFARSIT DATE         not null,
    TIP_DOCTOR   VARCHAR2(30) not null,
    primary key (DOCTOR_ID, DATA_INCEPUT)
)
/

create index IDX_DATA_ANG_DOCT
    on ISTORIC_DOCTORI (DATA_INCEPUT)
/

create table PERSONAL
(
    PERSONAL_ID   NUMBER(8)    not null
        primary key,
    NUME          VARCHAR2(15) not null,
    PRENUME       VARCHAR2(15) not null,
    DEPARTAMENT   VARCHAR2(50) not null
        constraint FK_DEP
            references DEPARTAMENTE
                on delete cascade,
    DATA_ANGAJARE DATE,
    SALARIU       NUMBER(8)    not null
        check (salariu > 2400),
    TELEFON       VARCHAR2(15) not null
)
/

create table PROGRAMARI
(
    DONATOR_ID       NUMBER(8) not null
        constraint FK_DONATOR_ID
            references DONATORI
                on delete cascade,
    DATA_PROGRAMARII DATE      not null
        primary key
)
/

create table ASISTENTI
(
    ASISTENT_ID    NUMBER(8)    not null
        primary key,
    NUME           VARCHAR2(15) not null,
    PRENUME        VARCHAR2(15) not null,
    ADRESA         VARCHAR2(15),
    TELEFON        VARCHAR2(15) not null,
    SALARIU        NUMBER(8)    not null
        constraint CK_SAL_ASIS
            check (salariu >= 2400),
    DATA_ANGAJARII DATE
)
/

create table RECOLTARI
(
    DONATOR_ID  NUMBER(8) not null
        constraint FK_PAC3_ID
            references DONATORI
                on delete cascade,
    ASISTENT_ID NUMBER(8) not null
        constraint FK_ASISID1
            references ASISTENTI
                on delete cascade,
    DATA_DONARE DATE      not null,
    primary key (DONATOR_ID, DATA_DONARE)
)
/

create table CONSULTATII
(
    DOCTOR_ID        NUMBER(8)     not null
        constraint FK_DOC22_ID
            references DOCTORI
                on delete cascade,
    DONATOR_ID       NUMBER(8)     not null
        constraint FK_DONATOR11_ID
            references DONATORI
                on delete cascade,
    DATA_CONSULTATIE DATE          not null,
    DIAGNOSTIC       VARCHAR2(200) not null,
    primary key (DOCTOR_ID, DONATOR_ID)
)
/

create table ISTORIC_DONATORI
(
    DONATOR_ID        NUMBER(8)    not null
        primary key,
    GRUPA_SANGE       VARCHAR2(5)  not null,
    RH                VARCHAR2(10) not null,
    DATA_ULTIM_DONARI DATE
)
/

--INSERARE ÎN TABELE
--1.donatori
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (1, 'Dobre', 'Rares', 19, 'masculin','Str. Noua, Iasi', '0572911192');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (2, 'Robu', 'Florina', 25, 'feminin','Str. Florilor, Ploiesti', '0768401233');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (3, 'Enescu', 'David', 43, 'masculin', 'Str. Atelierului, Constanta', '0796940277');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (4, 'Alexandrescu', 'Oana', 51, 'feminin', null, '0757391822');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (5, 'Ionescu', 'Mirela', 21,'feminin', null, '0799098954');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (6, 'Olaru', 'Ioan', 34, 'masculin', 'Strada Garii, Craiova', '0747264016');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (7, 'Mateescu', 'Ioana', 34, 'feminin', 'Strada Schelelor, Bucuresti', '0711164016');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (8, 'Campeanu', 'Ana', 31, 'feminin', 'Strada Primaverii, Sinaia ', '0747267263');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (9, 'Stefan', 'Andrei', 27, 'masculin', 'Strada Castanilor, Bucuresti', '0747109216');
INSERT INTO donatori(DONATOR_ID, NUME, PRENUME, VARSTA, SEX, ADRESA, TELEFON) VALUES (55, 'Matei', 'Mihai', 23, 'masculin', 'Strada Florilor, Constanta', '0710299016');

--8.departamente
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('receptie', 2, 5, 20);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('generala', 4, 10, 25);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('diabetologie', 2, 8, 25);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('curatenie', 2, 5, 30);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('oncologie', 3, 7, 30);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('epidemiologie', 2, 6, 18);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('medicina de laborator', 3, 4, 15);
INSERT INTO departamente(DENUMIRE, POSTURI_OCUPATE, POSTURI_TOTAL, ZILE_CONCEDIU) VALUES ('contabilitate', 1, 10, 15);

--2.doctori
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (100, 'Ionescu', 'George', 'Strada Lalelelor,  Bucuresti', '0786649201', 'diabetologie', 2600, TO_DATE('2020-06-12', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (101, 'Popescu', 'Ioana', 'Strada Libertatii, Bucuresti', '0765619573', 'oncologie', 3500, TO_DATE('2021-08-07', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (102, 'Ion', 'Ramona', null, '0747759274', 'epidemiologie', 5000, TO_DATE('2015-03-17', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (103, 'Dinu', 'Flavius', null, '0747417503', 'oncologie', 3900, TO_DATE('2018-09-18', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (104, 'Enache', 'Diana', 'Strada Morii, Bucuresti', '0738106720', 'medicina de laborator', 4840, TO_DATE('2017-08-14', 'YYYY-MM-DD'), 'interpretare rezultate');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (105, 'Badea', 'Rares', 'Strada Caragiale, Bucuresti', '0759372849', 'generala', 5400, TO_DATE('2022-03-12', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (106, 'Simionescu', 'Robert', null, '0759306710', 'oncologie', 4300, TO_DATE('2020-09-26', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (107, 'Tache', 'Ionut', 'Strada Campulung, Bucuresti', '0783983029', 'diabetologie', 3900, TO_DATE('2017-06-24', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (108, 'Iliescu', 'Jasmine', null, '0789362295', 'epidemiologie', 4500, TO_DATE('2017-06-24', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (109, 'Anghel', 'Elena', 'Strada Mare, Ploiesti', '0756894639', 'generala', 5300, TO_DATE('2017-10-12', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (110, 'Neagu', 'Denisa', 'Strada Castanilor, Ploiesti', '0767491000', 'medicina de laborator', 6776, TO_DATE('2014-09-16', 'YYYY-MM-DD'), 'interpretare rezultate');
INSERT INTO doctori (DOCTOR_ID, NUME, PRENUME, ADRESA, TELEFON, SPECIALIZARE, SALARIU, DATA_ANGAJARE, TIP_DOCTOR) VALUES (111, 'Andreescu', 'Denis', 'Strada Cailor, Ploiesti', '0767495003', 'oncologie', 5200, TO_DATE('2015-09-02', 'YYYY-MM-DD'), 'consultatii');

--3.rezultate_analize
--cerinta 13-- sequence
CREATE SEQUENCE pk_analize_id
INCREMENT BY 1  --default 1
START WITH 1
ORDER; -- default 1

INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'HIV pozitiv', TO_DATE('2021-03-10', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-02-16', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-04-21', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-04-05', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-07-08', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-07-17', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'hepatita B', TO_DATE('2021-09-11', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-12-29', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-12-31', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-01-26', 'YYYY-MM-DD'));
INSERT INTO rezultate_analize(ANALIZE_ID, OBSERVATII, DATA_RECOLTARE) VALUES (pk_analize_id.NEXTVAL, 'sanatos', TO_DATE('2021-10-19', 'YYYY-MM-DD'));

--4.camere
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (1, 'asteptare', 5, 1, null);
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (2, 'recoltari', 10, 2, 'Recoltare probe biologice. Risc epidemiologic.');
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (3, 'asteptare', null, 4, null);
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (4, 'prelucrare probe', 12, 3, 'Prelucrare probe recoltate. Rosc epidemiologic');
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (5, 'cabinet consultatie', 6, 2, null);
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (6, 'operatii', null, 1, 'Fara grup sanitar.');
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (7, 'recoltari', 4, 0, 'Recoltare probe biologice. Risc epidemiologic.');
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (8, 'cabinet consultatie', 3, 0, null);
INSERT INTO camere(CAMERA_ID, TIP, CAPACITATE, ETAJ, OBSERVATII_CAMERA) VALUES (9, 'asteptare', 5, 0, null);

--5.aparate_medicale
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (1, 1, 'scaun recoltare', 'BestMedicals', '0759201183', null, 0);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (2, 4, 'aparat prelucrare sange', 'JiveX', '0749104922', TO_DATE('2015-09-06', 'YYYY-MM-DD'), 5000);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (3, 2, 'pungi recoltare', 'JiveX', '0749104922', TO_DATE('2012-09-06', 'YYYY-MM-DD'), 100);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (4, 6, 'Sigilant microbian', 'Medica', '0789573900', null, 0);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (5, 8, 'stetoscop', 'Medica', '0789573900', null, 0);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (6, 7, 'aparat plasmaferaza', 'MedX', '0789854431', TO_DATE('2019-05-05', 'YYYY-MM-DD'), 200);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (7, 9, 'scaun recoltare', 'SuperMedical', '0789336822', null, 700);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (8, 6, 'scaun recoltare', 'MedX', '0789684933', null, 3000);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (9, 5, 'monitor functii vitale PRO', 'MedX', '0789684933', TO_DATE('2020-09-03', 'YYYY-MM-DD'), 5000);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (10, 1, 'aparat prelucrare sange', 'SuperMedical', '0789336822', null, 0);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (11, 2, 'ace recoltare sange', 'MedX', '0789184933', TO_DATE('2020-09-05', 'YYYY-MM-DD'), 200);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (12, 1, 'scaun recoltare', 'JiveX', '0749104922', null, 0);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (13, 3, 'aparat prelucrare sange', 'Medica', '0789184933', null, 4000);
INSERT INTO aparate_medicale (APARAT_ID, CAMERA_ID, DENUMIRE, BRAND, NR_SERVICE, DATA_PRIMIRE, PRET_CUMPARARE) VALUES (14, 3, 'pungi recoltare', 'Medica', '0749114922', null, 0);

--6.istoric-doctori
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (110, 'medicina de laborator', TO_DATE('2010-08-30', 'YYYY-MM-DD'), TO_DATE('2013-11-15', 'YYYY-MM-DD'), 'interpretare rezultate');
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (104, 'oncologie', TO_DATE('2016-09-12', 'YYYY-MM-DD'), TO_DATE('2017-08-13', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (104, 'diabetologie', TO_DATE('2013-01-10', 'YYYY-MM-DD'), TO_DATE('2015-12-18', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (109, 'medicina de laborator', TO_DATE('2014-08-13', 'YYYY-MM-DD'), TO_DATE('2016-08-10', 'YYYY-MM-DD'), 'interpretare rezultate');
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (107, 'diabetologie', TO_DATE('2007-03-19', 'YYYY-MM-DD'), TO_DATE('2016-04-28', 'YYYY-MM-DD'), 'consultatii');
INSERT INTO istoric_doctori (DOCTOR_ID, SPECIALIZARE, DATA_INCEPUT, DATA_SFARSIT, TIP_DOCTOR) VALUES (111, 'oncologie', TO_DATE('2007-04-19', 'YYYY-MM-DD'), TO_DATE('2013-02-07', 'YYYY-MM-DD'), 'consultatii');

--7.personal
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (10, 'Grigorescu', 'Ion', 'receptie', TO_DATE('2016-06-12', 'YYYY-MM-DD'), 2600, '0578573422');
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (11, 'Ilode', 'Georgiana', 'curatenie', TO_DATE('2020-11-09', 'YYYY-MM-DD'), 2500, '0767937193');
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (12, 'Florea', 'Ana', 'curatenie', TO_DATE('2021-10-11', 'YYYY-MM-DD'), 2800, '0759593018');
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (13, 'Popescu', 'Florentina', 'receptie', TO_DATE('2017-03-30', 'YYYY-MM-DD'), 2600, '0679491977');
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (14, 'Ionescu', 'Claudia', 'contabilitate', TO_DATE('2018-05-13', 'YYYY-MM-DD'), 2700, '0797591711');
INSERT INTO personal (PERSONAL_ID, NUME, PRENUME, DEPARTAMENT, DATA_ANGAJARE, SALARIU, TELEFON) VALUES (15, 'Florescu', 'Alexandru', 'receptie', TO_DATE('2020-11-17', 'YYYY-MM-DD'), 2500, '0797006955');

--9.programari
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (1, TO_DATE('2021-03-10 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (4, TO_DATE('2020-09-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (5, TO_DATE('2019-08-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (2, TO_DATE('2014-03-17 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (4, TO_DATE('2016-01-10 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (2, TO_DATE('2015-08-18 10:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (6, TO_DATE('2019-04-09 08:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (3, TO_DATE('2012-12-26 09:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (1, TO_DATE('2018-10-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (6, TO_DATE('2014-11-25 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO programari (DONATOR_ID, DATA_PROGRAMARII) VALUES (1, TO_DATE('2018-06-23 12:30:00', 'YYYY-MM-DD HH24:MI:SS'));

--13.asistenti
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1001, 'Popescu', 'Ioan', null, '0578123422', 2600, null);
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1006, 'Iliescu', 'Marcel', null, '0712137193', 2500, TO_DATE('2020-11-09', 'YYYY-MM-DD'));
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1002, 'Florea', 'Ancuta', null, '0751425018', 2800, TO_DATE('2021-10-11', 'YYYY-MM-DD'));
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1003, 'Irimescu', 'Florentina', null, '0670101017', 2600, TO_DATE('2017-03-30', 'YYYY-MM-DD'));
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1004, 'Diaconescu', 'Cristina', null, '0796514231', 2700, TO_DATE('2018-05-13', 'YYYY-MM-DD'));
INSERT INTO asistenti (ASISTENT_ID, NUME, PRENUME, ADRESA, TELEFON, SALARIU, DATA_ANGAJARII) VALUES (1005, 'Florescu', 'Tudor', null, '0723146955', 2500, TO_DATE('2020-11-17', 'YYYY-MM-DD'));

--10.recoltari
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (4, 1001, TO_DATE('2020-09-16', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (5, 1005, TO_DATE('2019-08-03', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (2, 1002, TO_DATE('2014-03-18', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (6, 1002, TO_DATE('2019-04-10', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (1, 1003, TO_DATE('2019-04-15', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (8, 1004, TO_DATE('2019-11-25', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (6, 1003, TO_DATE('2018-12-18', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (7, 1006, TO_DATE('2019-04-15', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (5, 1004, TO_DATE('2022-01-12', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (4, 1005, TO_DATE('2021-10-09', 'YYYY-MM-DD'));
INSERT INTO recoltari (DONATOR_ID, ASISTENT_ID, DATA_DONARE) VALUES (9, 1004, TO_DATE('2021-10-09', 'YYYY-MM-DD'));

--11.consultatii
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (102, 3, TO_DATE('2022-05-02', 'YYYY-MM-DD'), 'sida depistata');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (101, 2, TO_DATE('2021-08-30', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (105, 4, TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (103, 2, TO_DATE('2020-08-18', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (106, 1, TO_DATE('2018-10-19', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (105, 5, TO_DATE('2022-01-12', 'YYYY-MM-DD'), 'boala autoimuna depistata');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (103, 4, TO_DATE('2016-01-10', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (101, 6, TO_DATE('2014-11-25', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (108, 5, TO_DATE('2021-10-09', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (103, 1, TO_DATE('2014-03-17', 'YYYY-MM-DD'), 'clinic sanatos');
INSERT INTO consultatii (DOCTOR_ID, DONATOR_ID, DATA_CONSULTATIE, DIAGNOSTIC) VALUES (108, 2, TO_DATE('2018-06-23', 'YYYY-MM-DD'), 'clinic sanatos');

--12.istoric-donatori
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (1, 'A', '+', TO_DATE('2018-12-18', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (8, 'B', '+', TO_DATE('2019-11-25', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (2, 'A', '-', TO_DATE('2021-08-30', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (5, 'AB', '+', TO_DATE('2022-01-12', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (3, 'AB', '+', TO_DATE('2022-05-02', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (9, 'B', '-', TO_DATE('2021-10-09', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (4, '0', '-', TO_DATE('2022-10-09', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (6, 'A', '+', TO_DATE('2020-11-19', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (7, '0', '-', TO_DATE('2022-06-09', 'YYYY-MM-DD'));
INSERT INTO istoric_donatori (DONATOR_ID, GRUPA_SANGE, RH, DATA_ULTIM_DONARI) VALUES (55, '0', '-', TO_DATE('2019-06-06', 'YYYY-MM-DD'));




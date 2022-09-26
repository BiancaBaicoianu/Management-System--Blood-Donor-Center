--11. Formulați în limbaj natural și implementați 5 cereri SQL complexe ce vor utiliza, în 
--ansamblul lor, următoarele elemente: 
--• operație join pe cel puțin 4 tabele
--• filtrare la nivel de linii
--• subcereri sincronizate în care intervin cel puțin 3 tabele
--• subcereri nesincronizate în care intervin cel puțin 3 tabele
--• grupări de date, funcții grup, filtrare la nivel de grupuri
--• ordonări
--• utilizarea a cel puțin 2 funcții pe șiruri de caractere, 2 funcții pe date calendaristice, a 
--funcțiilor NVL și DECODE, a cel puțin unei expresii CASE
--• utilizarea a cel puțin 1 bloc de cerere (clauza WITH)
--_________________________________________________________________
	--1.Sa se afiseze toti donatori universali(grupa 0 și rh negativ),ordonati alfabetic, 
--și daca acestia sunt apti de recoltari la data curenta( sa fi trecut 3 luni de la ultima donare).

select d.donator_id, d.nume, d.prenume, 
        DECODE(floor(months_between(sysdate,ist.data_ultim_donari)),0, 'Inapt donare',
                                                                    1, 'Inapt donare',
                                                                    2, 'Inapt donare',
                                                                    3, 'Inapt donare',
                                                                    'Apt donare') "APT/INAPT"
from donatori d
join ISTORIC_DONATORI ist on (ist.donator_id=d.donator_id)
where d.donator_id in (
                        select DONATOR_ID
                        from ISTORIC_DONATORI
                        where rh='-' and grupa_sange='0'
    )
order by d.nume;

--În cererea anterioară am utilizat din elementele menționate: 
--DECODE, JOIN, WHERE(filtrare la nivel de linii), MONTHS_BETWEEN(funcție pe dată calendaristică), ORDER BY
--_________________________________________________________________________
	--2.Pentru doctorii care au facut consultatii in 2022, sa se afiseze numele, adresa si specializarea doctorului 
-- avand cea mai mare vechime
-- iar daca sunt mai multi doctori, sa se ordoneze descrescator dupa specializare

SELECT dr.nume, dr.prenume, NVL(dr.adresa,'Adresa indisponibila'), dr.specializare
FROM doctori dr
JOIN departamente d ON dr.specializare = d.denumire
JOIN consultatii c ON dr.doctor_id = c.doctor_id
WHERE to_char(c.data_consultatie,'YYYY') = '2022' and dr.data_angajare in (
                    SELECT distinct
                        MIN(data_angajare)
                    FROM doctori
                    WHERE specializare = dr.specializare
                 )
ORDER BY d.denumire DESC;

--În cererea anterioară am utilizat din elementele menționate: 
--NVL, JOIN, MIN, WHERE, subcerere necorelata și ORDER BY(funcție grup)
--__________________________________________________________________________
	--3.Să se afișeze informații( id, nume, sex, telefon, grupa de sange, rh) despre donatorii care au donat
--în ultimul an și au sub 30 ani.

select d.donator_id, d.nume, d.prenume, d.sex, d.telefon, ist.grupa_sange, ist.rh
from donatori d
join istoric_donatori ist on (d.donator_id = ist.donator_id)
where d.varsta < 30 and d.donator_id in (select donator_id
                                        from recoltari
                                        where months_between(sysdate, data_donare) <= 12)
order by d.varsta;

--În cererea anterioară am utilizat din elementele menționate: 
--JOIN, WHERE(filtrare la nivel de linii), MONTHS_BETWEEN(functie pe dată calendaristică), ORDER BY(funcție grup)
--___________________________________________________________________________
	--4. Sa se afiseze informatii (denumire, salariul maxim si ultima data de angajare) pentru fiecare departament
--care a facut ultima angajare de personal(exceptand doctorii si asistentii) acum cel putin 3 ani

with informatii as ( select dep.denumire, max(pers.salariu) sal_max , to_char(max(pers.data_angajare), 'dd-mm-yyyy') data_angajare_max
                          from personal pers
				  join departamente dep on (dep.denumire=pers.departament)
                          group by dep.denumire)
select *
from informatii
where add_months(data_angajare_max,36)<sysdate;

--În cererea anterioară am utilizat din elementele menționate: 
--WITH(bloc cerere), MAX(funcții grup), JOIN, GROUP BY(funcție grup), ADD_MONTHS(funcție pe date calendaristice)
--__________________________________________________________________________
	--5. Sa se calculeze cati donatori care au adresa introdusa sunt din Bucuresti si cati din Ploiesti.

select sum(Bucuresti) "Donatori din Bucuresti", sum(Ploiesti) "Donatori din Ploiesti"
from
(select d.donator_id, case instr(lower(d.adresa), 'bucuresti')  when 0 then 0 else 1 end Bucuresti,
                      case instr(lower(d.adresa), 'ploiesti')  when 0 then 0 else 1 end Ploiesti
from donatori d 
where d.adresa is not null);

--În cererea anterioară am utilizat din elementele menționate: 
--SUM(funcție grup), subcerere, CASE, INSTR(funcție pe șiruri de caractere), LOWER(funcție pe șiruri de caractere)
_________________________________________________________________________________________________________________________________________







--12. Implementarea a 3 operații de actualizare sau suprimare a datelor utilizând subcereri.

	--1.Sa se creasca salariul cu 10% doctorilor care se afla intr-un departament cu numar minim de zile de concediu
update doctori
set salariu=salariu*110/100
where specializare in (select denumire 
                        from departamente
                        where zile_concediu=(select min(zile_concediu) 
                                            from departamente));

	--2.Sa se adauge pentru fiecare camera  mesajul "Contine insuficiente aparate medicale" in observatii_camera daca ea contine mai putin de 2 aparate medicale 
update camere c 
set observatii_camera= concat(observatii_camera, ' Contine insuficiente aparate medicale.')
where (select count(*) 
        from aparate_medicale a 
        where a.camera_id= c.camera_id) <2; 

	--3.Sa se stearga donatorii care nu și-au facut nicio programare pentru donat
delete from donatori
where donator_id not in (select donator_id 
                        from programari);
--_________________________________________________________________________________________________________________________________________





--13. Crearea unei secvențe ce va fi utilizată în inserarea înregistrărilor în tabele (punctul 10).

CREATE SEQUENCE pk_analize_id
INCREMENT BY 1  --default 1
START WITH 1
ORDER; -- default 1


--__________________________________________________________________________________________________________________________________________


--14. Crearea unei vizualizări compuse. Dați un exemplu de operație LMD permisă pe 
vizualizarea respectivă și un exemplu de operație LMD nepermisă.

	--vizualizare care contine date(id, id-ul camerei, denumire aparat, telefon service, etaj) despre aparatele medicale care se afla la etajul 1 sau 2

create or replace view viz_aparate_etaj
as
select ap.aparat_id, ap.camera_id, ap.denumire, ap.nr_service telefon_service, cam.etaj
from aparate_medicale ap 
join camere cam on (ap.camera_id=cam.camera_id)
where cam.etaj = 1 or cam.etaj = 2;

--vizualizare compusa = definita pe mai multe tabele
--operatiile LMD folosite sunt UPDATE și DELETE, iar aparate_medicale este tabel protejat prin cheie(key preserved table)<=>are proprietatea că 
--fiecare valoare a cheii sale primare sau a unei coloane având constrângerea de unicitate, este unică şi în vizualizare


--EXEMPLU NEPERMIS: Sa se actualizeze etajul camerei in care se afla aparatul cu id-ul 4 in etajul 2
update viz_aparate_etaj 
set etaj = 2 
where aparat_id = 4; 
-- apare etajul care nu face parte din 'key preserved table'
         
--EXEMPLU PERMIS: Sa se stearga prin intermediul vizualizarii linia aparatului cu id-ul 10             
delete from viz_aparate_etaj 
where aparat_id = 10; 
--se face stergerea unei linii din tabelul 'aparate_medicale'( se modifică doar în tabelul de bază, nu și în alt tabel, ca de exemplu "camere")
--___________________________________________________________________________________________________________________________






--15. Crearea unui index care să optimizeze o cerere de tip căutare cu 2 criterii. Specificați 
cererea.

create index i_data_angajare on doctori(data_angajare);

	--Sa se afiseze id-ul, numele, prenumele si  data angajarii pentru doctorii care interpretează 
	--rezultatele analizelor efectuate ulterior donării si sunt angajati inainte de 1 ianuarie 2022

select doctor_id, data_angajare
from doctori
where data_angajare < to_date('01-01-2022', 'dd-mm-yyyy') and tip_doctor = 'interpretare rezultate';
--______________________________________________________________________________________________________________________________


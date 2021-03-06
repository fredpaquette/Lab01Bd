DROP TABLE ENTREPRISES CASCADE CONSTRAINT;
DROP TABLE ETUDIANTS CASCADE CONSTRAINT;
DROP TABLE STAGES CASCADE CONSTRAINT;
DROP TABLE POSTULER CASCADE CONSTRAINT;
--1

CREATE
  TABLE Entreprises
  (
    NumEnt     CHAR (6) NOT NULL ,
    NomEnt     VARCHAR2 (40) ,
    AdresseEnt VARCHAR2 (50) ,
    TelEnt     VARCHAR2 (15)
  ) ;
ALTER TABLE Entreprises ADD CONSTRAINT Entreprises_PK PRIMARY KEY ( NumEnt ) ;

CREATE
  TABLE Etudiants
  (
    Numad  NUMBER NOT NULL ,
    Nom    VARCHAR2 (30) ,
    Prenom VARCHAR2 (30)
  ) ;
ALTER TABLE Etudiants ADD CONSTRAINT Etudiants_PK PRIMARY KEY ( Numad ) ;

CREATE
  TABLE Postuler
  (
    Numad    NUMBER NOT NULL ,
    NumStage NUMBER NOT NULL ,
    Priorite NUMBER (2)
  ) ;
ALTER TABLE Postuler ADD CONSTRAINT Postuler_PK PRIMARY KEY ( Numad, NumStage )
;

CREATE
  TABLE Stages
  (
    NumStage    NUMBER NOT NULL ,
    Description VARCHAR2 (100) NOT NULL ,
    typeStg     CHAR (3)
  ) ;
ALTER TABLE Stages ADD CONSTRAINT Stages_PK PRIMARY KEY ( NumStage ) ;

ALTER TABLE Postuler ADD CONSTRAINT Postuler_Etudiants_FK FOREIGN KEY ( Numad )
REFERENCES Etudiants ( Numad ) ;

ALTER TABLE Postuler ADD CONSTRAINT Postuler_Stages_FK FOREIGN KEY ( NumStage )
REFERENCES Stages ( NumStage ) ;

--2
INSERT INTO ETUDIANTS VALUES(12,'PROULX','WILLIAM');
INSERT INTO ETUDIANTS VALUES(13,'MARTIN','JONATHAN');
INSERT INTO ETUDIANTS VALUES(14,'VALENTE','OLIVIER');
INSERT INTO ETUDIANTS VALUES(15,'LEROY','MATHIEU');
INSERT INTO ETUDIANTS VALUES(20,'BEAULIEU','MARTIN');

INSERT INTO STAGES VALUES(100,'gestion dune ecole hoteliere','ges');
INSERT INTO STAGES VALUES(101,'mise a jour du site web de la bibliotheque','ges');
INSERT INTO STAGES VALUES(200,'automatisation dune serre','ind');
INSERT INTO STAGES VALUES(102,'application android pour faire les courses','ges');
INSERT INTO STAGES VALUES(103,'application android pour clavardage','ges');

INSERT INTO ENTREPRISES VALUES('Xper','Xperdoc Inc','24 rue de lespoir,Laval','(450)345-5678');
INSERT INTO ENTREPRISES VALUES('Zens','zensol automation','420 rue de la paix Montreal','(514)230-4523');
INSERT INTO ENTREPRISES VALUES('comac','comacoptimisation','410 grand allee boisbriand','(450)530-1223');
INSERT INTO ENTREPRISES VALUES('exa','System Exa','222 cote vertue Montreal','(514)111-1223');

INSERT INTO POSTULER VALUES(20,102,3);
INSERT INTO POSTULER VALUES(12,100,1);
INSERT INTO POSTULER VALUES(12,103,2);
INSERT INTO POSTULER VALUES(14,103,1);
INSERT INTO POSTULER VALUES(14,100,3);
INSERT INTO POSTULER VALUES(14,101,2);
INSERT INTO POSTULER VALUES(14,102,4);
INSERT INTO POSTULER VALUES(20,101,2);
INSERT INTO POSTULER VALUES(20,100,1);
commit;
--------------------------------------------------------------------------------------------------------------------

--3
ALTER TABLE ETUDIANTS
ADD  TELEPHONE VARCHAR2 (14);
--4
UPDATE ETUDIANTS
SET TELEPHONE = '(514)345-7689)'
WHERE NUMAD = 12;

UPDATE ETUDIANTS
SET TELEPHONE = '(514)365-7439)'
WHERE NUMAD = 13;

UPDATE ETUDIANTS
SET TELEPHONE = '(514)222-4683)'
WHERE NUMAD = 14;

UPDATE ETUDIANTS
SET TELEPHONE = '(514)132-5623)'
WHERE NUMAD = 15;

UPDATE ETUDIANTS
SET TELEPHONE = '(514)212-9323)'
WHERE NUMAD = 20;

--5
SELECT * 
FROM ETUDIANTS
ORDER BY NOM,PRENOM;

--6
ALTER TABLE STAGES
ADD NUMENT CHAR (6);

--7
ALTER TABLE STAGES ADD CONSTRAINT FK_NUMENT FOREIGN KEY (NUMENT)
REFERENCES ENTREPRISES (NUMENT);

--8

UPDATE STAGES
SET NUMENT = 'comac'
WHERE  numstage = 102;

UPDATE STAGES
SET NUMENT = 'comac'
WHERE  numstage = 103;

UPDATE STAGES
SET NUMENT = 'exa'
WHERE  numstage = 101;

UPDATE STAGES
SET NUMENT = 'Zens'
WHERE numstage = 200;

--9
SELECT * 
FROM ENTREPRISES
WHERE  AdresseEnt  like '%Montreal%'
ORDER BY NOMENT;

--10
select * 
from stages
inner join entreprises
on entreprises.nument = stages.nument
where noment = 'zensol automation';

--11
select numstage,description,entreprises.noment
from stages
inner join entreprises
on entreprises.nument = stages.nument;

--12
select numstage,description,entreprises.noment
from stages
right join entreprises
on entreprises.nument = stages.nument;

--13
select etudiants.nom,etudiants.prenom,stages.description , priorite
from postuler
inner join stages 
on stages.numstage = postuler.numstage
inner join etudiants
on postuler.numad = etudiants.numad
order by priorite;

--14
select nom,prenom
from etudiants
inner join postuler
on postuler.numad = etudiants.numad
inner join stages
on stages.numstage = postuler.numstage
where stages.description = 'application android pour clavardage';

--15
select count(nument) as nombrestages,nument
from stages
group by nument;

--16
select count(postuler.numstage) as nombredepostulant, stages.description
from postuler
inner join stages 
on stages.numstage = postuler.numstage
group by postuler.numstage,stages.description;

--17
select count(numad) 
from POSTULER p  
inner join STAGES s on p.NUMSTAGE = s.NUMSTAGE
where s.DESCRIPTION = 'application android pour clavardage';

--18

select nom, prenom from ETUDIANTS 
where NUMAD in (
select e.NUMAD from ETUDIANTS e
minus 
select p.NUMAD from postuler p 
)
;

---19
select nom, prenom 
from ETUDIANTS E
INNER JOIN POSTULER P ON E.NUMAD = P.NUMAD
where e.NOM != 'VALENTE' AND P.NUMSTAGE in 
(
select NUMSTAGE 
from POSTULER p
inner join ETUDIANTS e on e.NUMAD = p.NUMAD
where e.NOM = 'VALENTE'
)
GROUP BY E.NOM, E.PRENOM
;

--20
DROP TABLE ETUDIANTS CASCADE CONSTRAINT;

--21
SELECT COUNT(p.NUMSTAGE) AS NonbreDeStageDeOlivierValente
from postuler p
inner join ETUDIANTS e on e.NUMAD=p.NUMAD
where e.NOM = 'VALENTE' AND e.PRENOM = 'OLIVIER'
;



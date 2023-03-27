-- SQL for Normalized Relational Model for Theater Group

-- drop old tables from initial model, if necessary
drop table Member_Production;
drop table Ticket;
drop table Donation;
drop table DuesPayment;
drop table TicketSale;
drop table Performance;
drop table Production;
drop table Play;
drop table Subscriber;
drop table Sponsor;
drop table Member;

-- Partt 1: Create the new tables & Insert Preliminary data---

CREATE TABLE Zips( 
zip 		CHAR(5), 
city 		VARCHAR2(15), 
state 		CHAR(2),
CONSTRAINT Zips_zip_pk PRIMARY KEY (zip));

CREATE TABLE Member(
memId		number(6),
dateJoined	date, 
firstname 	VARCHAR2(15),
lastName 	VARCHAR2(20), 
street		VARCHAR2(50),
zip		char(5),
areaCode 	CHAR(3), 
phoneNumber 	CHAR(7), 
currentOfficeHeld  VARCHAR2(20),
CONSTRAINT Member_memId_pk PRIMARY KEY(memid),
CONSTRAINT Member_zip_fk FOREIGN KEY(zip) REFERENCES Zips(zip));

CREATE TABLE Sponsor(
sponID		number(6), 
name		varchar2(20), 
street		VARCHAR2(50),
zip		char(5),
areaCode 	CHAR(3), 
phoneNumber 	CHAR(7),
CONSTRAINT Sponsor_sponId_pk PRIMARY KEY(sponID),
CONSTRAINT Sponsor_zip_fk FOREIGN KEY(zip) REFERENCES Zips(zip)); 

CREATE TABLE Subscriber(
subID		number(6), 
firstname 	VARCHAR2(15),
lastName 	VARCHAR2(20), 
street		VARCHAR2(50),
zip		char(5),
areaCode 	CHAR(3), 
phoneNumber 	CHAR(7),
CONSTRAINT Subscriber_subId_pk PRIMARY KEY(subID),
CONSTRAINT Subscriber_zip_fk FOREIGN KEY(zip) REFERENCES Zips(zip));

CREATE TABLE Play(
title		varchar2(100), 
author		varchar2(35), 
numberOfActs	number(1), 
setChanges	number(2),
CONSTRAINT Play_title_pk PRIMARY KEY(title));

CREATE TABLE Production(
year		number(4), 
seasonStartDate	varchar2(7), 
seasonEndDate	varchar2(7), 
title		varchar2(100),
CONSTRAINT Prod_year_seasStDate_pk primary key(year, seasonStartDate),
CONSTRAINT Prod_title_fk FOREIGN KEY(title) REFERENCES Play(title));

CREATE TABLE Performance(
datePerf	varchar2(7), 
timePerf	varchar2(10), 
year		number(4), 
seasonStartDate	varchar2(7),
CONSTRAINT Performance_date_pk PRIMARY KEY(datePerf,year),
CONSTRAINT Performance_yr_seasStart_fk FOREIGN KEY(year,seasonStartDate) REFERENCES Production(year, seasonStartDate)); 

CREATE TABLE TicketSale(
saleID		number(6), 
saleDate	date, 
totalAmount	number(6,2), 
perfDate	varchar2(7),
perfYear	number(4),
subId		number(6),	
CONSTRAINT TicketSale_ID_PK PRIMARY KEY(saleId),
CONSTRAINT TicketSale_perfDate_fk FOREIGN KEY(perfDate,perfYear) REFERENCES Performance(datePerf,year),
CONSTRAINT TicketSale_subId_fk FOREIGN KEY(subId) REFERENCES Subscriber(subId));

CREATE TABLE DuesPayment(
memId 		number(6), 
duesYear	number(4), 
amount		number(5,2), 
datePaid	date,
CONSTRAINT DuesPayment_memId_year_pk PRIMARY KEY(memid, duesyear),
CONSTRAINT DuesPayment_memId_fk FOREIGN KEY(memid) REFERENCES Member(memid));

CREATE TABLE Donation(
sponId	number(6),
donationDate	date,
donationType	varchar2(20), 
donationValue	number(8,2), 
year		number(4), 
seasonStartDate	varchar2(7),
CONSTRAINT Donation_sponId_date_pk PRIMARY KEY(sponId, donationDate),
CONSTRAINT Donation_sponId_fk FOREIGN KEY(sponId) REFERENCES Sponsor(sponId),
CONSTRAINT Donation_year_seasStartDate_fk FOREIGN KEY(year,seasonStartDate) REFERENCES Production(year, seasonStartDate));

CREATE TABLE Ticket(
saleId		number(6), 
seatLocation	varchar2(3), 
price		number(5,2), 
seattype	varchar2(15),
CONSTRAINT Ticket_saleid_pk PRIMARY KEY(saleId, seatLocation),
CONSTRAINT Ticket_saleid_fk FOREIGN KEY(saleid) REFERENCES TicketSale(saleId));

CREATE TABLE Member_Production(
memId	number(6), 
year		number(4), 
seasonStartDate	varchar2(7),
role		varchar2(25), 
task		varchar2(25),
CONSTRAINT Mem_Prod_Id_year_seas_pk PRIMARY KEY(memId, year, seasonStartDate),
CONSTRAINT Mem_Prod_memId_FK FOREIGN KEY (memid) REFERENCES Member(memId),
CONSTRAINT Mem_Prod_yr_seasStartDate_fk FOREIGN KEY(year,seasonStartDate) REFERENCES Production(year,seasonStartDate));

--insert some records

INSERT INTO Zips values('10801','New Rochelle','NY');
INSERT INTO Zips values('10101','New York','NY');
INSERT INTO Zips values('92101', 'San Diego', 'CA');
INSERT INTO Zips values('33010', 'Miami', 'FL');
INSERT INTO Zips values('60601', 'Chicago', 'IL');

INSERT INTO Member values(11111,'01-Feb-2013', 'Frances','Hughes','10 Hudson Avenue','10801','914','3216789','President');
INSERT INTO Member values(22222,'01-Mar-2011', 'Irene','Jacobs','1 Windswept Place','10101','212','3216789','Vice-President');
INSERT INTO Member values(33333,'01-May-2012', 'Winston', 'Lee','22 Amazon Street', '10101','212','3336789',null);
INSERT INTO Member values(44444,'01-Feb-2013', 'Ryan','Hughes','10 Hudson Avenue','10801','914','5556789','Secretary');
INSERT INTO Member values(55555,'01-Feb-2011', 'Samantha', 'Babson','22 Hudson Avenue','10801','914','6666789','Treasurer');
INSERT INTO Member values(66666,'01-Feb-2014', 'Robert', 'Babson','22 Hudson Avenue','10801','914','6666789',null);

INSERT INTO Sponsor values(1234, 'Zap Electrics', '125 Main Street', '10101', '212','3334444');
INSERT INTO Sponsor values(1235, 'Elegant Interiors', '333 Main Street', '10101', '212','3334446');
INSERT INTO Sponsor values(1236, 'Deli Delights', '111 South Street', '10801', '914','2224446');

INSERT INTO Subscriber values(123456, 'John','Smith','10 Sapphire Row', '10801', '914','1234567');
INSERT INTO Subscriber values(987654, 'Terrence','DeSimone','10 Emerald Lane', '10101','914','7676767');

INSERT INTO Play values('Macbeth','Wm. Shakespeare', 3,6);
INSERT INTO Play values('Our Town','T. Wilder', 3,4);
INSERT INTO Play values('Death of a Salesman','A. Miller', 3,5);

INSERT INTO Production values(2015,'05-May', '14-May', 'Our Town');
INSERT INTO Production values(2014,'14-Oct','23-Oct','Macbeth');


INSERT INTO Performance values('05-May','8pm',2015,'05-May');
INSERT INTO Performance values('06-May','8pm',2015,'05-May');
INSERT INTO Performance values('07-May','3pm',2015,'05-May');
INSERT INTO Performance values('12-May','8pm',2015,'05-May');
INSERT INTO Performance values('13-May','8pm',2015,'05-May');
INSERT INTO Performance values('14-May','3pm',2015,'05-May');
INSERT INTO Performance values('14-Oct','8pm',2014,'14-Oct');
INSERT INTO Performance values('15-Oct','8pm',2014,'14-Oct');
INSERT INTO Performance values('16-Oct','3pm',2014,'14-Oct');
INSERT INTO Performance values('21-Oct','8pm',2014,'14-Oct');
INSERT INTO Performance values('22-Oct','8pm',2014,'14-Oct');
INSERT INTO Performance values('23-Oct','3pm',2014,'14-Oct');

INSERT INTO TicketSale values(123456,'01-May-2015',40.00,'05-May',2015,123456);
INSERT INTO Ticket values(123456, 'A1',20.00,'orch front');
INSERT INTO Ticket values(123456, 'A2',20.00,'orch front');

INSERT INTO TicketSale values(123457,'02-May-2015',80.00,'05-May',2015,987654);
INSERT INTO Ticket values(123457, 'A3',20.00,'orch front');
INSERT INTO Ticket values(123457, 'A4',20.00,'orch front');
INSERT INTO Ticket values(123457, 'A5',20.00,'orch front');
INSERT INTO Ticket values(123457, 'A6',20.00,'orch front');

INSERT INTO TicketSale values(000001,'01-Oct-2014',40.00,'14-Oct',2014, 987654);
INSERT INTO Ticket values(000001, 'A1',20.00,'orch front');
INSERT INTO Ticket values(000001, 'A2',20.00,'orch front');

INSERT INTO TicketSale values(000002,'9-Oct-2014',60.00,'14-Oct',2014,123456);
INSERT INTO Ticket values(000002, 'A1',20.00,'orch front');
INSERT INTO Ticket values(000002, 'A2',20.00,'orch front');
INSERT INTO Ticket values(000002, 'A3',20.00,'orch front');

INSERT INTO DuesPayment values(11111, 2015, 50.00, '01-Jan-2015');
INSERT INTO DuesPayment values(22222, 2015, 50.00, '15-Jan-2015');
INSERT INTO DuesPayment values(33333, 2015, 50.00, '01-Feb-2015');
INSERT INTO DuesPayment values(44444, 2015, 50.00, '30-Jan-2015');
INSERT INTO DuesPayment values(55555, 2015, 50.00, '28-Jan-2015');

INSERT INTO Donation values(1234, '01-Mar-2015','sound board',1250.00,2015,'05-May');
INSERT INTO Donation values(1235, '15-Apr-2015','cash', 500.00,2015,'05-May');
INSERT INTO Donation values(1236, '05-May-2015','food',500.00,2015,'05-May');
INSERT INTO Donation values(1236, '06-May-2015','beverges',200.00,2015,'05-May');
INSERT INTO Donation values(1236, '07-May-2015','snacks',100.00,2015,'05-May');

INSERT INTO Member_Production values(11111,2015,'05-May','Emily','sets');
INSERT INTO Member_Production values(22222,2015,'05-May','Mrs. Webb','costumes');

commit;



 select Count(*) From TicketSale;
 
----Part 2:
Select Count(*) From table_name;
Donation= 5 records, DuesPayment= 5 records, Memebr = 6 records, Member_Production = 2 records, Performance = 12 records, Play = 3 records
Production = 2 records, Sponsor = 3 records, Subscriber = 2 records, Ticket = 11 records, TicketSale = 4 records. 


----Part 3a---
Select s.FirstName, s.LastName, s.Street, s.Zip, z.City, z.State
    From Subscriber s, TicketSale ts, Zips z
    where s.SUBID=ts.SUBID
        and s.ZIP=z.ZIP
        and (ts.SALEID = 123456 or ts.SALEID = 123457);
    
    
----Part 3b---
select NAME, SUM(DONATIONVALUE) 
    from donation d, sponsor s
    where d.SPONID=s.SPONID
     and NAME = 'Deli Delights'
     Group by NAME;
----- Deli Delights SUM (donation value) = 800----

----Part 3c-------
 SELECT RTRIM(m.lastname) || '' || RTRIM(m.firstname) as members_names
        FROM MEMBER m
        WHERE 
        MEMID NOT IN (SELECT MEMID FROM DUESPAYMENT WHERE DUESYEAR = 2015);

----Babson Robert has not paid thier dues----



----Part 3d---
select Count(*), SUM (TOTALAMOUNT) AS Total_value_of_tickets_sold_of_production_from_10_14_2014
    from TICKETSALE
    where PERFDATE >= '14-Oct'
    and PERFYEAR >= 2014;

----Total value of Tickets sold = 100----


----Part 3e---
SELECT t.SEATLOCATION, s.lastname || '' || s.firstname as subscriber_name
     FROM TICKET t, TICKETSALE ts, PERFORMANCE p, SUBSCRIBER s
     WHERE t.SALEID=ts.SALEID
     AND p.DATEPERF=ts.PERFDATE
     AND p.YEAR=ts.PERFYEAR
     AND (t.SEATLOCATION = 'A6' or t.SEATLOCATION = 'A7')
     AND ts.PERFDATE='05-May'
     AND ts.PERFYEAR=2015;
     
----Apparently A6 is no more available, but A7 still available for booking---
    
    
---- 3e: "name of the person who bought the ticket(s) on May 2, 2015"---
SELECT ts.SALEDATE, s.lastname || '' || s.firstname as subscriber_name
    FROM TICKETSALE ts, SUBSCRIBER s
    WHERE ts.SUBID=S.SUBID
    AND ts.SALEDATE='02-May-15';
    
----Desimone Terrence bought Seat A6 on 2/May/2015----
    
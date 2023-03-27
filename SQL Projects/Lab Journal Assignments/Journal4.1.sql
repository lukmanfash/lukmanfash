

INSERT INTO BARN (bId, bName) VALUES (2, 'TNFarms');
INSERT INTO BARN (bId, bName) VALUES (3, 'Saddle Creek Stables');
INSERT INTO BARN (bId, bName) VALUES (4, 'The Green Barn');
INSERT INTO BARN (bId, bName) VALUES (5, 'Bacon family Farms');
INSERT INTO BARN (bId, bName) VALUES (6, 'Stars Sporthorses');
INSERT INTO BARN (bId, bName) VALUES (7, 'ThorSport Farm');





INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P21','Brad Cox', 2085651997,'87 Harbor Ter, Johnson City, TN, 36001');
INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P31', 'John Sadler', 5718587676,	'9242 Dorchester Johnson City, TN, 36001');
INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P41', 'Charles Appleby', '4133186747', '4235 Gerdine Sq Johnson City, TN, 36001');
INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P51', 'Richard Baltas', 5593752110, '3614 Upper Fjord Johnson City, TN, 36001');
INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P61', 'Jamie Ness', '3092791944', '2831 Gallup Vw Johnson City, TN, 36001');
INSERT INTO PERSON (pId, pName, pPhone, pAddress) VALUES ('P71', 'Christophe Clement', 5736482982, '5088 Eagles Ave Johnson City, TN, 36001');





INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R20', 'Lucky', 'Stalli', 'Appaloosa', '1-Feb-03', 'three 000',	'P21', 2);
INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R30', 'Coomer', 'Geldin', 'American Quat', '23-Apr-99', 'five 000', 'P31', 3);
INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R40', 'Cupertino', 'Colt', 'American Pait', '15-Dec-00', 'four 000', 'P41',	4);
INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R50', 'Dekabrist', 'Colt', 'AmericanSadle', '21-Nov-98', 'eight 000', 'P51', 5);
INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R60', 'Defondo', 'Colt', 'AmericnWarmbd', '4-Jun-06', 'six 000', 'P61', 6);
INSERT INTO RACEHORSE (regNum, hName, gender, type, purchaseDate, purchasePrice, trainedBy, stabledAt) VALUES ('R70', 'Frammento', 'Stalli', 'Thoroubreds', '28-Aug-02', 'two 000', 'P71', 7);




INSERT INTO OFFSPRING (regNum, parent) VALUES ('R20', 'R20');
INSERT INTO OFFSPRING (regNum, parent) VALUES ('R30', 'R30');
INSERT INTO OFFSPRING (regNum, parent) VALUES ('R40', 'R40');
INSERT INTO OFFSPRING (regNum, parent) VALUES ('R50', 'R50');
INSERT INTO OFFSPRING (regNum, parent) VALUES ('R60', 'R60');
INSERT INTO OFFSPRING (regNum, parent) VALUES ('R70', 'R70');





INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R20', 'P21', 100);
INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R30', 'P31',	80);
INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R40', 'P41', 70);
INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R50', 'P51',	85);
INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R60', 'P61', 95);
INSERT INTO OWNEDBY (regNum, pId, percentage) VALUES ('R70', 'P71', 98);




INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B11', '2015', '01', '1');
INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B12', '2016', '02', '12');
INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B13', '2017', '03', '22');
INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B14',	'2018', '04', '13');
INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B15', '2019', '03', '5');
INSERT INTO RACESCHEDULE (sId, year, month, day) VALUES ('B16', '2020', '04', '27');




INSERT INTO RACE (sId, rNumber, purse) VALUES ('B11', 101, 280192);
INSERT INTO RACE (sId, rNumber, purse) VALUES ('B12', 102, 300002);
INSERT INTO RACE (sId, rNumber, purse) VALUES ('B13', 103, 400000);
INSERT INTO RACE (sId, rNumber, purse) VALUES ('B14', 104, 500000);
INSERT INTO RACE (sId, rNumber, purse) VALUES ('B15', 105, 450000);
INSERT INTO RACE (sId, rNumber, purse) VALUES ('B16', 106, 420000);




INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B11', 101, 25, 1, 'P21', 'R20');
INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B12', 102, 26, 2, 'P31', 'R30');
INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B13', 103, 27, 3, 'P41', 'R40');
INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B14', 104, 28, 4, 'P51', 'R50');
INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B15', 105, 29, 5, 'P61', 'R60');
INSERT INTO ENTRY (sId, rNumber, gate, finalPos, jockey, horse) VALUES ('B16', 106, 30, 6, 'P71', 'R70');
COMMIT;



--- QUESTION 2bi: Query for who trained lucky and trainer's phone number----
 SELECT pName, pPhone
     from Person
    where pId = 'P21';
-----output = Brad Cox	2085651997----
    
    
    
---- Also on Question 2bi: Query for who horse's trained (Lucky)who trained it and trainer's phone number----   
 SELECT hName, pName, pPhone
    from Person p, Racehorse rh
    where p.pId=rh.trainedBy
    and pId = 'P21';
----Output= Lucky	Brad Cox	2085651997----
    
    
----QUESTION 2bii Query for Lucky and its final position ----
 SELECT hName, finalPos
    from ENTRY e, RACEHORSE rh
    where e.horse=rh.regNum
    and horse = 'R20';
----Output= Lucky	1----
    
----QUESTION 2biii Query for who rode the winning horse in a particular race, his/her name and address----
 SELECT e.jockey, pAddress
     from Person p, Entry e
     where p.pId=e.jockey
     and e.finalpos=1;
----Output = P21	87 Harbor Ter, Johnson City, TN, 36001  -----
      
      
----Part 3: Uodate and Delete Statement---- 
----Deleting data referenced by other tables----
 Delete from entry where  rNumber = 101;
 
 Delete from Race where  rNumber = 101;
 
 Delete from Person where pId = 'P21';
 
 Delete from Ownedby where regNum = 'R20';
 
 Delete from Offspring where regNum = 'R20';

 Delete from Barn where bId = 2;
 
 Delete from RaceHorse where regNum = 'R20';
 
 
 Commit;
 
 
 ----Updating Entry Table----
 
 Update Entry set finalPos = 1 where rNumber = 102;
 
 Update Entry set finalPos = 2 where rNumber = 103;
 
 Update Entry set finalPos = 3 where rNumber = 104;
 
 Update Entry set finalPos = 4 where rNumber = 105;
  
 Update Entry set finalPos = 5 where rNumber = 106;
 
 Commit;
set serveroutput on;

--DELETE FROM TRANSACTION CASCADE;
DELETE FROM COMPONENT CASCADE;
DELETE FROM CUSTOMER CASCADE;
DELETE FROM EMPLOYEE CASCADE;
DELETE FROM STORE CASCADE;
DELETE FROM ADDRESS CASCADE;
DELETE FROM BICYCLE CASCADE;
DELETE FROM PART CASCADE;
DELETE FROM Paint CASCADE;
DELETE FROM Model CASCADE;
DELETE FROM Purchase CASCADE;


PURGE RECYCLEBIN;

INSERT INTO Paint
SELECT PAINTID,
  COLORNAME,
  COLORSTYLE,
  COLORLIST,
  DATEINTRODUCED,
  DATEDISCONTINUED
FROM BIKE_SHOP.PAINT;
/
INSERT INTO Model
SELECT ROWNUM,
       MODELTYPE
  FROM BIKE_SHOP.MODELTYPE
 ORDER BY 1;
/
-- INSERT BICYCLES
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE number_tab IS TABLE OF NUMBER;

  c_bikenumber int_tab;
  c_serialnumber char_tab;
  c_modelid int_tab;
  c_paintid int_tab;
  c_framesize number_tab;

  CURSOR cBicycle IS
    SELECT DISTINCT row_number() OVER (ORDER BY b.SERIALNUMBER),
             b.SerialNumber,
             m.MODELID,
             b.PAINTID,
             b.FRAMESIZE
      FROM BIKE_SHOP.BICYCLE b
      INNER JOIN Model m ON b.MODELTYPE = m.MODELName;
BEGIN
  OPEN cBicycle;
  FETCH cBicycle BULK COLLECT INTO c_bikenumber, c_serialnumber, c_modelid, c_paintid, c_framesize;
  CLOSE cBicycle;

  -- bulk insert
  FORALL indx IN c_bikenumber.first..c_bikenumber.last
  INSERT INTO Bicycle VALUES
    ( c_serialnumber(indx), c_modelid(indx), c_paintid(indx), c_framesize(indx));
END;
/
COMMIT;
/

-- INSERT PARTS
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE number_tab IS TABLE OF NUMBER;

  c_rownum int_tab;
  c_componentid char_tab;
  c_componentname char_tab;
  c_manufacturername char_tab;
  c_description char_tab;
  c_listprice number_tab;
  c_cost number_tab;

  CURSOR cPart IS
    SELECT DISTINCT row_number() OVER (ORDER BY cmp.COMPONENTID),
                    cmp.COMPONENTID,
                    cmpname.COMPONENTNAME,
                    mfr.MANUFACTURERNAME,
                    cmpname.DESCRIPTION,
                    cmp.LISTPRICE,
                    cmp.ESTIMATEDCOST
      FROM BIKE_SHOP.COMPONENT cmp
      INNER JOIN BIKE_SHOP.COMPONENTNAME cmpname ON cmp.CATEGORY = cmpname.COMPONENTNAME
      INNER JOIN BIKE_SHOP.MANUFACTURER mfr ON cmp.MANUFACTURERID = mfr.MANUFACTURERID;

BEGIN
  OPEN cPart;
  FETCH cPart BULK COLLECT INTO  c_rownum, c_componentid, c_componentname, c_manufacturername, c_description, c_listprice, c_cost;
  CLOSE cPart;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Part VALUES
    ( c_componentid(indx), c_componentname(indx), c_manufacturername(indx), c_description(indx), c_listprice(indx), c_cost(indx));
END;
/
COMMIT;
/
--INSERT ADDRESSES
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);

  c_rownum int_tab;
  c_address char_tab;
  c_city char_tab;
  c_state char_tab;
  c_zip char_tab;
  c_country char_tab;

  CURSOR cAddress IS
      SELECT DISTINCT
             ROW_NUMBER() OVER (ORDER BY state, city, address) addressid,
             InitCap(Address),
             City,
             State,
             Zip,
             Country
        FROM (SELECT DISTINCT
                   TRIM(e.ADDRESS) address,
                   TRIM(c.CITY) city,
                   TRIM(c.STATE) state,
                   TRIM(c.ZIPCODE) zip,
                   TRIM(c.COUNTRY) country
              FROM BIKE_SHOP.EMPLOYEE e
             LEFT JOIN BIKE_SHOP.CITY c ON e.CITYID = c.CITYID
             UNION
            SELECT DISTINCT
                   TRIM(s.ADDRESS) Address,
                   TRIM(c.CITY) City,
                   TRIM(c.STATE) State,
                   TRIM(c.ZIPCODE) Zip,
                   TRIM(c.COUNTRY) Country
              FROM BIKE_SHOP.RETAILSTORE s
             LEFT JOIN BIKE_SHOP.CITY c ON s.CITYID = c.CITYID
            UNION
            SELECT DISTINCT
                   TRIM(cmr.ADDRESS) address,
                   TRIM(c.CITY) city,
                   TRIM(c.STATE) state,
                   TRIM(c.ZIPCODE) zip,
                   TRIM(c.COUNTRY) country
              FROM BIKE_SHOP.CUSTOMER cmr
             LEFT JOIN BIKE_SHOP.CITY c ON cmr.CITYID = c.CITYID
       );
BEGIN
  OPEN cAddress;
  FETCH cAddress BULK COLLECT INTO c_rownum, c_address, c_city, c_state, c_zip, c_country;
  CLOSE cAddress;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Address VALUES
    ( c_rownum(indx), c_address(indx), c_city(indx), c_state(indx), c_zip(indx), c_country(indx));
END;
/
COMMIT;
/
--INSERT Employees
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE date_tab IS TABLE OF DATE;

  c_rownum int_tab;
  c_EMPLOYEEID int_tab;
  c_Name char_tab;
  c_HomePhone char_tab;
  c_AddressID int_tab;
  c_DateHired date_tab;
  c_DateReleased date_tab;

  CURSOR cEmp IS
      SELECT DISTINCT
             row_number() over (order by e.employeeid),
             e.EMPLOYEEID EmployeeID,
             e.LASTNAME || ', ' || e.FIRSTNAME Name,
             e.HOMEPHONE HomePhone,
             a.AddressID AddressID,
             e.DATEHIRED DateHired,
             e.DATERELEASED DateReleased
        FROM BIKE_SHOP.EMPLOYEE e
        LEFT OUTER JOIN BIKE_SHOP.City c ON e.CITYID = c.CITYID
        LEFT OUTER JOIN Address a ON UPPER(NVL(e.Address,'ZZ')) = UPPER(NVL(a.address,'ZZ'))
                                 AND UPPER(NVL(c.City,'ZZ')) = UPPER(NVL(a.City,'ZZ'))
                                 AND NVL(c.State,'ZZ') = NVL(a.State,'ZZ');
BEGIN
  OPEN cEmp;
  FETCH cEmp BULK COLLECT INTO c_rownum, c_EmployeeId, c_Name, c_HomePhone, c_AddressID, c_DateHired, c_DateReleased;
  CLOSE cEmp;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Employee VALUES
    ( c_EmployeeId(indx), c_Name(indx), c_HomePhone(indx), c_AddressID(indx), c_DateHired(indx), c_DateReleased(indx));
END;
/
COMMIT;
/
--INSERT Stores
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE date_tab IS TABLE OF DATE;

  c_rownum int_tab;
  c_StoreID int_tab;
  c_Name char_tab;
  c_Phone char_tab;
  c_AddressID int_tab;

  CURSOR cStore IS
      SELECT ROW_NUMBER() OVER (ORDER BY StoreID),
             rs.StoreID,
             rs.StoreName,
             rs.Phone,
             a.AddressID
        FROM BIKE_SHOP.RETAILSTORE rs
        LEFT JOIN BIKE_SHOP.City c ON rs.CityID = c.CityID
        LEFT OUTER JOIN Address a ON UPPER(NVL(rs.Address,'ZZ')) = UPPER(NVL(a.address,'ZZ'))
                                 AND UPPER(NVL(c.City,'ZZ')) = UPPER(NVL(a.City,'ZZ'))
                                 AND NVL(c.State,'ZZ') = NVL(a.State,'ZZ');
BEGIN
  OPEN cStore;
  FETCH cStore BULK COLLECT INTO c_rownum, c_StoreID, c_Name, c_Phone, c_AddressID;
  CLOSE cStore;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Store VALUES
    ( c_StoreID(indx), c_Name(indx), c_Phone(indx), c_AddressID(indx));
END;
/
COMMIT;
/
--INSERT Customers
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE date_tab IS TABLE OF DATE;

  c_rownum int_tab;
  c_CustomerID int_tab;
  c_Name char_tab;
  c_Phone char_tab;
  c_AddressID int_tab;

  CURSOR cCustomer IS
      SELECT Row_Number() OVER (ORDER BY CUSTOMERID) rown,
             CUSTOMERID,
             lastname || ', ' || firstname CUSTOMERNAME,
             PHONE,
             a.AddressID
        FROM BIKE_SHOP.CUSTOMER c
        LEFT JOIN BIKE_SHOP.City ci ON c.CityID = ci.CityID
        LEFT OUTER JOIN Address a ON UPPER(NVL(c.Address,'ZZ')) = UPPER(NVL(a.address,'ZZ'))
                                 AND UPPER(NVL(ci.City,'ZZ')) = UPPER(NVL(a.City,'ZZ'))
                                 AND NVL(ci.State,'ZZ') = NVL(a.State,'ZZ');
BEGIN
  OPEN cCustomer;
  FETCH cCustomer BULK COLLECT INTO c_rownum, c_CustomerID, c_Name, c_Phone, c_AddressID;
  CLOSE cCustomer;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Customer VALUES
    ( c_CustomerID(indx), c_Name(indx), c_Phone(indx), c_AddressID(indx));
END;
/
COMMIT;
/
--INSERT Components
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE number_tab IS TABLE OF NUMBER;
  TYPE date_tab IS TABLE OF DATE;

  c_rownum int_tab;
  c_serialnumber int_tab;
  c_employeeid int_tab;
  c_componentid char_tab;
  c_quantity int_tab;
  c_cost number_tab;
  c_date date_tab;

  CURSOR cComponents IS
      SELECT DISTINCT row_number() OVER (ORDER BY cmp.SERIALNUMBER, cmp.EMPLOYEEID,cmp.COMPONENTID),
                      cmp.SERIALNUMBER,
                      cmp.EMPLOYEEID,
                      cmp.COMPONENTID,
                      cmp.QUANTITY,
                      c.estimatedcost,
                      cmp.DATEINSTALLED
        FROM BIKE_SHOP.BIKEPARTS cmp
        INNER JOIN PART c ON c.PARTID = cmp.COMPONENTID
        ORDER BY cmp.SERIALNUMBER, cmp.EMPLOYEEID,cmp.COMPONENTID;
BEGIN
  OPEN cComponents;
  FETCH cComponents BULK COLLECT INTO c_rownum, c_serialnumber, c_employeeid, c_componentid, c_quantity, c_cost, c_date;
  CLOSE cComponents;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Component VALUES
    ( c_rownum(indx), c_serialnumber(indx), c_employeeid(indx), c_componentid(indx), c_quantity(indx), c_cost(indx), c_date(indx));
END;
/
commit;
/
--INSERT Purchases
DECLARE

  TYPE int_tab IS TABLE OF INT;
  TYPE char_tab IS TABLE OF VARCHAR2(2000);
  TYPE number_tab IS TABLE OF NUMBER;
  TYPE date_tab IS TABLE OF DATE;

  c_rownum int_tab;
  c_serialnumber int_tab;
  c_customerid int_tab;
  c_storeid int_tab;
  c_employeeid int_tab;
  c_list number_tab;
  c_sale number_tab;
  c_tax number_tab;
  c_ship number_tab;
  c_orderdate date_tab;
  c_startdate date_tab;
  c_shipdate date_tab;

  CURSOR cPurchases IS
            SELECT ROW_NUMBER() OVER (ORDER BY b.CUSTOMERID, b.SERIALNUMBER),
              b.SERIALNUMBER,
              b.CUSTOMERID,
              b.StoreID,
              b.EmployeeID,
              b.ListPrice,
              b.saleprice,
              b.salestax,
              b.shipprice,
              b.orderdate,
              b.startdate,
              b.shipdate
        FROM BIKE_SHOP.BICYCLE b;
BEGIN
  OPEN cPurchases;
  FETCH cPurchases BULK COLLECT INTO c_rownum, c_serialnumber, c_customerid, c_storeid,
                    c_employeeid, c_list, c_sale, c_tax, c_ship, c_orderdate,
                    c_startdate, c_shipdate;
  CLOSE cPurchases;

  -- bulk insert
  FORALL indx IN c_rownum.first..c_rownum.last
  INSERT INTO Purchase VALUES
    ( c_rownum(indx), c_serialnumber(indx), c_customerid(indx), c_storeid(indx),
                    c_employeeid(indx), c_list(indx), c_sale(indx), c_tax(indx),
                    c_ship(indx), c_orderdate(indx),
                    c_startdate(indx), c_shipdate(indx));
END;
/
commit;
/

DECLARE
  val NUMBER;
BEGIN
  FOR I IN (SELECT TABLE_NAME FROM USER_TABLES order by table_name) LOOP
    EXECUTE IMMEDIATE 'SELECT count(*) FROM ' || i.table_name INTO val;
    DBMS_OUTPUT.PUT_LINE(i.table_name || ' ==> ' || val );
  END LOOP;
END;
/

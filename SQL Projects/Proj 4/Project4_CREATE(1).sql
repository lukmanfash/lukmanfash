-----
DROP TABLE ADDRESS CASCADE CONSTRAINTS;                                                                                                                         
DROP TABLE BICYCLE CASCADE CONSTRAINTS;                                                                                                                         
DROP TABLE COMPONENT CASCADE CONSTRAINTS;                                                                                                                       
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;                                                                                                                        
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;                                                                                                                        
DROP TABLE MODEL CASCADE CONSTRAINTS;                                                                                                                           
DROP TABLE PAINT CASCADE CONSTRAINTS;                                                                                                                           
DROP TABLE PART CASCADE CONSTRAINTS;                                                                                                                            
DROP TABLE PURCHASE CASCADE CONSTRAINTS;                                                                                                                        
DROP TABLE STORE CASCADE CONSTRAINTS;                                                                                                                           

CREATE TABLE Model(
  ModelID NUMBER NOT NULL,
  ModelName VARCHAR2(50) NOT NULL,
  
  CONSTRAINT Model_PK PRIMARY KEY (ModelID)
);

CREATE TABLE Paint(
  PaintID NUMBER NOT NULL,
  ColorName VARCHAR2(50),
  ColorStyle VARCHAR2(50),
  ColorList VARCHAR2(50),
  DateIntroduced DATE,
  DateDiscontinued DATE,
  
  CONSTRAINT Paint_PK PRIMARY KEY (PaintID)
);

CREATE TABLE Address(
  AddressID NUMBER NOT NULL,
  Address VARCHAR2(50),
  City VARCHAR2(50),
  State VARCHAR2(50),
  ZIP VARCHAR2(50),
  Country VARCHAR2(50),
  
  CONSTRAINT Address_PK PRIMARY KEY (AddressID)
);

CREATE TABLE Bicycle(
  SerialNumber NUMBER NOT NULL,
  ModelID NUMBER,
  PaintID NUMBER,
  FrameSize NUMBER,
  
  CONSTRAINT Bicycle_PK PRIMARY KEY (SerialNumber),
  CONSTRAINT Bicycle_Model_FK FOREIGN KEY (ModelID)
   REFERENCES Model(ModelID),
  CONSTRAINT Bicycle_Paint_FK FOREIGN KEY (PaintID)
   REFERENCES Paint(PaintID)
);

CREATE TABLE Customer(
  CustomerID NUMBER NOT NULL,
  CustomerName VARCHAR2(101),
  Phone VARCHAR2(50),
  AddressID NUMBER,
  
  CONSTRAINT Customers_PK PRIMARY KEY (CustomerID),
  CONSTRAINT Customer_Address_FK FOREIGN KEY (AddressID)
   REFERENCES Address(AddressID)
);

CREATE TABLE Store(
  StoreID NUMBER NOT NULL,
  StoreName VARCHAR2(50),
  Phone VARCHAR2(50),
  AddressID NUMBER,
  
  CONSTRAINT Store_PK PRIMARY KEY (StoreID),
  CONSTRAINT Store_Address_FK FOREIGN KEY (AddressID)
   REFERENCES Address(AddressID)
);

CREATE TABLE Part(
  PartID NUMBER NOT NULL,
  PartName VARCHAR2(50),
  ManufacturerName VARCHAR2(50),
  Description VARCHAR2(100),
  ListPrice NUMBER(38,4),
  EstimatedCost NUMBER(38,4),
  
  CONSTRAINT Park_PK PRIMARY KEY (PartID)
);

CREATE TABLE Employee(
  EmployeeID NUMBER NOT NULL,
  EmployeeName VARCHAR2(101),
  HomePhone VARCHAR2(50),
  AddressID NUMBER,
  HireDate DATE,
  ReleaseDate DATE,
  
  CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
  CONSTRAINT Employee_Address_FK FOREIGN KEY (AddressID)
   REFERENCES Address(AddressID)
);


CREATE TABLE Component(
  ComponentID NUMBER NOT NULL,
  BicycleSerialNumber NUMBER,
  EmployeeID NUMBER,
  PartID NUMBER,
  Quantity NUMBER,
  Cost NUMBER(*,4),
  DateInstalled DATE,
  
  CONSTRAINT Component_FK PRIMARY KEY (ComponentID),
  CONSTRAINT Comp_Bicycle_FK FOREIGN KEY (BicycleSerialNumber)
   REFERENCES Bicycle(SerialNumber),
  CONSTRAINT Comp_Employee_FK FOREIGN KEY (EmployeeID)
   REFERENCES Employee(EmployeeID),
  CONSTRAINT Comp_Part_FK FOREIGN KEY (PartID)
   REFERENCES Part(PartID)
);

CREATE TABLE Purchase(
  PurchaseID NUMBER NOT NULL,
  BicycleSerialNumber NUMBER,
  CustomerID NUMBER,
  StoreID NUMBER,
  EmployeeID NUMBER,
  ListPrice NUMBER(*,4),
  SalePrice NUMBER(*,4),
  SalesTax NUMBER(*,4),
  ShipPrice NUMBER(*,4),
  OrderDate DATE,
  StartDate DATE,
  ShipDate DATE,
  
  CONSTRAINT Purchase_PK PRIMARY KEY (PurchaseID),
  CONSTRAINT Purch_Bicycle_FK FOREIGN KEY (BicycleSerialNumber)
   REFERENCES Bicycle(SerialNumber),
  CONSTRAINT Purch_Customer_FK FOREIGN KEY (CustomerID)
   REFERENCES Customer(CustomerID),
  CONSTRAINT Purch_Store_FK FOREIGN KEY (StoreID)
   REFERENCES Store(StoreID),
  CONSTRAINT Purch_Employee_FK FOREIGN KEY (EmployeeID)
   REFERENCES Employee(EmployeeID)
);
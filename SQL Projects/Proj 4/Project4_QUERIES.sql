
----Project Preparation: Verifying tables-----
select count(*) from table_name;
Address= 24680 records, Bicycle= 22610 records, Component = 412242 records, Customer= 18511 records, Employee = 20 records, Model=7 records
Paint = 15  records, Part = 533 records, Purchase = 22610 records, Store = 6246 records. 

----Part 2, Question 1: The average purchase list price and sale price by state-----

 Select ad.state, avg(pur.listprice), avg(pur.saleprice)from purchase pur 
    inner join store st
    on pur.storeid = st.storeid
    inner join address ad
    on st.addressid = ad.addressid
    group by rollup (ad.state)
    order by 1 Asc, 2 desc, 3 desc;


----Part 2, Question 2: The average purchase list price and sale price by store----   
Select st.storename, ad.state, avg(pur.listprice), avg(pur.saleprice) from purchase pur
    inner join store st
    on pur.storeid = st.storeid
    inner join address ad
    on st.addressid = ad.addressid
    group by rollup (ad.state, st.storename);



------Drill-down on store for number of store in each state----
Select ad.state, count(st.storename) from purchase pur
    inner join store st
    on pur.storeid = st.storeid
    inner join address ad
    on st.addressid = ad.addressid
    group by rollup (ad.state, st.storename);
    
    
    
    
----Part 2, Question 3: the most popular paint color-------
select colorname, count(colorname) as ByBicyclesPaintColor from paint 
    natural join bicycle
    group by colorname
    order by 2 Asc;
----- OUTPUT: Most Popular paint color= Arctic White.------
    
------store that sells the most of each paint color-----
select st.storename, bc.paintid, count(bc.paintid) as ByVolofPaintSale from purchase pur
    inner join store st
    on st.storeid = pur.storeid
    inner join bicycle bc
    on bc.serialnumber = pur.bicycleserialnumber 
    group by cube(bc.paintid), st.storename
    order by count(bc.paintid)desc;   
    
    
    

----Part 2, Question 4: Part Manufacturers that is most popular by store--------
select pt.manufacturername, count(pt.manufacturername) from part pt
    inner join component com
    on pt.partid = com.partid
    inner join bicycle bc
    on com.bicycleserialnumber = bc.serialnumber
    inner join purchase pur
    on bc.serialnumber = pur.bicycleserialnumber
    inner join store st
    on pur.storeid = st.storeid
    group by pt.manufacturername
    order by 2 Asc;
------OUTPUT: Part Manufacturers that is most popular by store= Shimano (USA)-----
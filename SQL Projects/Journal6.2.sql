
----Part 2a: ROLLUP Queries----
---2ai: $Total Price = (Quantity*SalePrice)+SalesTax$)-----
select sum((quantity * saleprice)+salestax) as TotalSalePriceinUSD from sales;

-----OUTPUT: total amount of animal sales by sale price= 44897.64 USD-----


-----2aii: category of animal with the most sales by sale price----
select  to_char(saleprice), to_char(category), sum((quantity * saleprice)+salestax) as TotalSalePriceinUSD from sales 
    natural join animal
    group by rollup(to_char(category), to_char(saleprice))
    order by 2 Asc;
    
-----OUTPUT= Dog	  17941.83 USD-----



-----2aiii: by the Dog category, the State that had the most sales of an animal =?, total price for Dog = ?----
select to_char(saleprice), to_char(category),  sum((quantity * saleprice)+salestax) as TotalSalePriceinUSD, sup.State from sales sa
    natural join animal an
    inner join supplier sup
    on sa.employeeid = sup.supplierid
    where to_char(category) = 'Dog'
    group by rollup( state, to_char(category), to_char(saleprice))
    order by to_char(state);

-----by the Dog category, the State that had the most sales =  KY, total price for Dog in KY = 6650.61 USD----




select count (*) from(select to_char(saleprice), to_char(category), sum((quantity * saleprice)+salestax) as TotalSalePriceinUSD, sup.State from sales sa
    natural join animal an
    inner join supplier sup
    on sa.employeeid = sup.supplierid
    where to_char(category) = 'Dog'
    group by rollup( state, to_char(category), to_char(saleprice))
    order by to_char(state))
    where state = 'KY';
    
------OIUTPUT: The total number of Dog sold in KY= 38------
    
    
    
----Part 2b. CUBE Queries---- 
---2bi: month with the highest number of orders, the month's total number of orders, and the month's total cost-----
select  orderid, to_char(orderdate), to_char(month), sum(quantity*cost) as TotalOrderByCost from orders
    natural join datelookup
    group by rollup(to_char(month),to_char(orderdate), orderid)
    order by 4 desc;

---- OUTPUT: Month with the highest numnber of orders= March, and total cost= 1359922.96


----total number of orders in March----
select count (*) from (select  to_char(orderdate), to_char(month), orderid, sum(quantity*cost) as TotalOrderByCost from orders
    natural join datelookup
    where to_char(month) = 'MAR'
    group by rollup(to_char(month),to_char(orderdate), orderid)
    order by 4 desc);

----OUTPUT: total number of orders in March= 344----



---2bii:Supplier that provided the most merchandise in March, the total number of orders, and the total cost-----
select (count(merchandiseid)) as MerchandiseVolume, sup.name, (sum(quantity*cost)) as TotalOrderByCost from orders ord
    natural join datelookup d8lk
    inner join supplier sup
    on ord.supplierid = sup.supplierid
    where month = 'MAR' and ord.merchandiseid is not null
    group by cube (sup.name)
    order by 1 desc;

----OUTPUT: Suppliers with the most merchandise in March= Love and Hughes, Total Cost for Love=  163384.54, and Total cost for Hughes = 264585.42, Total number of orders from each = 440----






----2biii: Supplier that incurred the highest average shipping cost and the average shipping cost-----
select name, supplierid, avg(shippingcost) as AveragShippingCost from orders
    natural join supplier 
    group by supplierid, name
    order by AveragShippingCost Asc;
    
-----OUTPUT: Supplier with the highest average shipping cost= Dillard, Dillard's average shipping cost= 55.54894736842105263157894736842105263158-------




----2biv: State (supplier's location) with the highest average shipping cost and the average shipping cost of the particular state-----
select state,  avg(shippingcost) as AveragShippingCost from orders
    natural join supplier
    group by state
    order by AveragShippingCost Asc;

------OUTPUT: State (supplier's location) with the highest average shipping cost= SC, and the avg shipping cost of SC = 55.54894736842105263157894736842105263158------




-----2bv: The month with the highest average shipping cost in SC, and the average shipping cost for that month in SC-------
select state, to_char(month), avg(shippingcost) as AveragShippingCost from orders ord
    natural join supplier sup
    inner join datelookup d8lk
    on ord.orderdate = d8lk.dateid
    where state = 'SC'
    group by state, cube (to_char(month))
    order by AveragShippingCost Asc;

-------OUTPUT: The month with the highest average shipping cost in SC = March, and the average shipping cost for March in SC = 58.186----

    
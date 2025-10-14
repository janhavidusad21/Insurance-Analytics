use invoice;

-- kpi1
select AE,count(invoice_number),income_class
from invoice1
group by income_class,AE
order by count(invoice_number) desc;


SELECT 
  DISTINCT AE,
SUM(CASE WHEN income_class = 'Cross Sell' THEN 1 ELSE 0 END) AS Cross_Sell,
SUM(CASE WHEN income_class = 'New' THEN 1 ELSE 0 END) AS New_Business,
SUM(CASE WHEN income_class = 'Renewal' THEN 1 ELSE 0 END) AS Renewal,
SUM(CASE WHEN income_class IS NULL OR income_class = '' THEN 1 ELSE 0 END) AS Blank_Class
FROM invoice1
GROUP BY AE
ORDER BY renewal desc;

-- no of meeting by account executive
select AE,count("ID")
from meeting
group by AE;


-- top 4 oppty by revenue
select opportunity_name,sum(revenue_amount)
from opportunity
group by opportunity_name
order by sum(revenue_amount) desc
limit 4;

-- oppty distribution by oppty 
select product_group,count(opportunity_name)
from opportunity
group by product_group
order by count(opportunity_name) desc ;

-- top open oppty
select opportunity_name,sum(revenue_amount) as total_amount
from opportunity
group by opportunity_name
order by total_amount desc
limit 4;

-- stage funnel
select stage,sum(revenue_amount) AS amount
from opportunity
group by stage
order by amount desc;


-- kpi 3
# cross sell target,achieved and new
select sum(cbudget) AS Crosssell_Target,sum(budget) as new_target ,sum(rbudget)  as renewal_target from bud ;


SELECT
    SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS achieved_crosssell,
    Sum(case when income_class="New" then amount else 0 end)as achieved_New,
    sum(case when income_class="Renewal" then amount else 0 end) as achieved_Renewal
FROM fees ;

SELECT 
    SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS brokerage_cross_sell,
    Sum(case when income_class="New" then amount else 0 end)as brokerage_New,
    sum(case when income_class="Renewal" then amount else 0 end) as brokerage_Renewal
FROM Brokerage ;

select case when a.income_class="crosssell" then a.amount else 0 end +case when b.income_class="crosssell" then a. amount else 0 end as cs_achieved,
a.income_class="new"+b.income_class="new" as new_achieved,
a.income_class="renewal"+b.income_class="renewal" as renewal_achieved from fees a 
inner join brokerage b on a.AE =b.exe ;

select  a.income_class,a.amount from fees a left join brokerage b on a.income_class=b.income_class union 
select a.income_class,a.amount from fees a right join brokerage b on a.income_class=b.income_class;

select a.income_class,a.amount from fees a left join brokerage b on a.income_class=b.income_class union 
select a.income_class,a.amount from fees a right join brokerage b on a.income_class=b.income_class;


select *,(select distinct a.exe,a.income_class, sum(a.amount) as total_amount from brokerage as a left join fees as b on a.exe=b.AE) from a group by 1,2;
select distinct AE as empname,income_class,sum(amount) as total_amount from fees group by 1,2 order by 1;

select a.AE, SUM(CASE WHEN a.income_class = 'Cross Sell'+ b.income_class="crosssell" THEN a.Amount ELSE 0 END) AS crosssell_ac,
SUM(CASE WHEN a.income_class = 'new'+ b.income_class="new" THEN a.Amount ELSE 0 END) AS new_ac,
SUM(CASE WHEN a.income_class = 'renewal'+ b.income_class="renewal" THEN a.Amount ELSE 0 END) AS renewal_ac
from fees a right join brokerage b on a.ae=b.exe group by 1;

######### fees + brokerage 
select (select SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS achieved_fees from fees) +
(select SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS brokerage_cross_sell from brokerage )
as total_csell_Achieved,

(select SUM(case when income_class="New" then amount else 0 end)as Total_New from fees)+ 
(select Sum(case when income_class="New" then amount else 0 end)as Total_New from brokerage)
as total_New_Achieved,

(select SUM(case when income_class="Renewal" then amount else 0 end)as Total_New from fees)+ 
(select Sum(case when income_class="Renewal" then amount else 0 end)as Total_New from brokerage)
as total_Renewal_Achieved;

select f.income_class,sum(b.amount)+sum(f.amount) from fees f inner join brokerage b on f.income_class =b.income_class group by 1;

select Emp_Name,SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS achieved_cross_sell,
    Sum(case when income_class="New" then amount else 0 end)as achieved_New,
    sum(case when income_class="Renewal" then amount else 0 end) as a_Renewal from( select exe as emp_name,income_class,amount from brokerage union all select
ae as emp_name,income_class,amount from fees) as combineddata group by emp_name,income_class order by emp_name;
 
select exe,income_class,sum(amount) from brokerage group by 1,2;

select AE, income_class,sum(amount) from fees group by 1,2 order by 1;

###########invoice cross sell,new, renewal
SELECT
    SUM(CASE WHEN income_class = 'Cross Sell' THEN Amount ELSE 0 END) AS invoice_cross_sell,
    Sum(case when income_class="New" then amount else 0 end)as invoice_New,
    sum(case when income_class="Renewal" then amount else 0 end) as invoice_Renewal 
FROM invoice1; 

-- yearly meeting count

SELECT 
    YEAR(meeting_date) AS Year,
    COUNT(*) AS TotalMeetings
FROM 
    meetinG
GROUP BY 
    YEAR(meeting_date)
ORDER BY 
    Year;
    
    
    

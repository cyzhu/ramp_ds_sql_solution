--Author: Chongyang Zhu
--Date: 09/25/2023

with T1 as (
    -- First group by the date and sum the transaction amount by day
	select date_format(transaction_time, '%Y-%m-%d') as transaction_date
  	    ,sum(transaction_amount) as transaction_amount
  	from transactions
  	group by date_format(transaction_time, '%Y-%m-%d')
)
,T2 as (
    -- Then get the moving 3 days average for each day
	select transaction_date
		,avg(transaction_amount) over (order by transaction_date rows between 2 preceding and current row) as moving_average
	from T1
)
-- Finally select the amount for Jan 31st
select *
from T2
where month(transaction_date) = 1
	and day(transaction_date) = 31

---- Result
-- transaction_date	moving_average
-- 2021-01-31	682.1499996185303
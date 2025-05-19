

select category, avg(user_count) avg_customer_count, avg(avg_trans) avg_transaction_count
from
(select period, sum(owner_id) user_count, 
case when trans_count >=10 then 'High Frequency'
when trans_count between 3 and 9 then 'Medium Frequency'
else 'Low Frequency' end category, avg(trans_count) avg_trans
from (
select DATE_FORMAT(transaction_date, '%M-%Y') period, owner_id, count(*)trans_count
from savings_savingsaccount
group by DATE_FORMAT(transaction_date, '%M-%Y'),owner_id)a
group by period, case when trans_count >=10 then 'High Frequency'
when trans_count between 3 and 9 then 'Medium Frequency'
else 'Low Frequency' end) d
group by category;
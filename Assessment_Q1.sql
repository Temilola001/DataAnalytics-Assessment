

select a.id owner_id, a.first_name, a.last_name,
b.cn savings_count, c.cn investment_count, b.amount+c.amount total_deposits 
from users_customuser a
inner join (select owner_id , count(id) cn, sum(amount) amount
 from plans_plan where amount>0 group by owner_id) b
 on a.id =b.owner_id
 inner join (select owner_id, count(*) cn, sum(confirmed_amount) amount  
 from savings_savingsaccount 
 where transaction_status ='success'
 group by owner_id) c
 on a.id=c.owner_id;
 

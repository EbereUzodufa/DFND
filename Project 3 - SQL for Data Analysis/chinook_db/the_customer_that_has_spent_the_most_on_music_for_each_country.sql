/*New TAble sub*/
with sub as(select (c.FirstName ||' '||c.LastName) customers, c.Country country,  sum(i.total) amt_spent
from Invoice i
join Customer c
	on c.CustomerId = i.CustomerId
group by customers
order by amt_spent desc)

select sub.country country, sub.customers customers, sub.amt_spent amt_spent
from sub
join(
	select sub.country country, max(sub.amt_spent) amt_spent
	from sub
	group by 1) w1
	on w1.amt_spent = sub.amt_spent and w1.country = sub.country
order by country
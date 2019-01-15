with sub as (
select c.Country country, g.Name genre_Name, sum (iL.Quantity) quantity
from InvoiceLine iL
join Invoice i
	on i.InvoiceId = iL.InvoiceId
join Customer c
	on c.CustomerId = i.CustomerId
join Track t
	on t.TrackId = iL.TrackId
join Genre g
	on g.GenreId = t.GenreId
group by 1,2
order by 1, 3 desc
)

select sub.country, sub.quantity, sub.genre_name
from sub
join (select country, max(quantity) quantity
from sub
group by sub.country) jj
on jj.quantity = sub.quantity and jj.country = sub.country

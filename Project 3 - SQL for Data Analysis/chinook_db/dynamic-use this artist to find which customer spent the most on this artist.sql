with tt as (
	select a.ArtistId ID, a.Name artist_name, count(iL.Quantity) qty_sold, (count(iL.Quantity) * iL.UnitPrice) total_amt
from InvoiceLine iL
join Track t
	on t.TrackId = iL.TrackId
join Album ab
	on ab.AlbumId = t.AlbumId
join Artist a
	on a.ArtistId = ab.ArtistId
group by a.ArtistId
order by qty_sold  desc
limit 1
)

select a.Name artist_name, c.FirstName customer_name, count(iL.Quantity) qty_bought, (count(iL.Quantity) * iL.UnitPrice) total_amt
from InvoiceLine iL
join Invoice i
	on i.InvoiceId = iL.InvoiceId
join Customer c
	on c.CustomerId = i.CustomerId
join Track t
	on t.TrackId = iL.TrackId
join Album ab
	on ab.AlbumId = t.AlbumId
join Artist a
	on a.ArtistId = ab.ArtistId
join tt
	on tt.artist_name = a.Name
group by c.CustomerId
order by qty_bought  desc
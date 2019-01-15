select a.Name artist_name, c.FirstName customers, count(iL.Quantity) qty_bought, (count(iL.Quantity) * iL.UnitPrice) total_amt
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
where a.ArtistId = 90
group by c.CustomerId
order by qty_bought  desc
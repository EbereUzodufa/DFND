select a.Title album_name, sum(iL.Quantity)qty_sold
from Track t
join InvoiceLine iL
	on iL.TrackId = t.TrackId
join Album a
	on a.AlbumId = t.AlbumId
group by album_name
order by qty_sold desc
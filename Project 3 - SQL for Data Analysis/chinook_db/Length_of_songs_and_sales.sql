select t.TrackId track_Id, t.Name track_Name,a.Title album_name, t.Milliseconds track_length, sum(iL.Quantity)qty_sold
from Track t
join InvoiceLine iL
	on iL.TrackId = t.TrackId
join Album a
	on a.AlbumId = t.AlbumId
group by track_Id
order by album_name desc
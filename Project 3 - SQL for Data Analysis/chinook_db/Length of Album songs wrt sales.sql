select a.Title album_name, count(t.AlbumId) song_no, sum(t.Milliseconds) album_length, sum(iL.Quantity) amt_sold, sum(iL.UnitPrice * iL.Quantity) amt_gen
from Album a
join Track t
	on t.AlbumId = a.AlbumId
join InvoiceLine iL
	on iL.TrackId = t.TrackId
group by a.AlbumId
order by amt_gen desc
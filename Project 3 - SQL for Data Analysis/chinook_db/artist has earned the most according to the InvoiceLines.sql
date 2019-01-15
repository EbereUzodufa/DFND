/*Percentage of earning of the top 25 of artist based on track sold*/
with artist_earning as (select a.ArtistId ID, a.Name artist_name, count(iL.Quantity) qty_sold, (count(iL.Quantity) * iL.UnitPrice) total_amt
from InvoiceLine iL
join Track t
	on t.TrackId = iL.TrackId
join Album ab
	on ab.AlbumId = t.AlbumId
join Artist a
	on a.ArtistId = ab.ArtistId
group by a.ArtistId
order by qty_sold  desc)

select artist_name "Artist Name", total_amt "Total Sales", round((total_amt/(select sum(total_amt) from artist_earning)*100),3) "Percentage of Total Sales"
from artist_earning
Limit 25
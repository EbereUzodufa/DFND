
/*Question 1: Most sold media type based on quantity of Tracks sold*/
select m.Name "Media Type", sum(iL.Quantity) "Quantity Sold"
from MediaType m
join Track t
	on t.MediaTypeId = m.MediaTypeId
join InvoiceLine iL
	on iL.TrackId = t.TrackId
group by t.MediaTypeId
order by "Quantity Sold" desc /*Idon't like using 2 or Numeric*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------


/*Question 2: top 10 Most sold Album based on quantity of Tracks sold*/
select a.Title "Album Name", sum(iL.Quantity) "Quantity of Tracks sold",art.Name "Artist Name"
from Track t
join InvoiceLine iL
	on iL.TrackId = t.TrackId
join Album a
	on a.AlbumId = t.AlbumId
join Artist art
	on art.ArtistId = a.ArtistId
group by "Album Name" /*don't want 1 to reps field*/
order by "Quantity of Tracks sold" desc
Limit 10

>>>>Percentage<<<<
with album_sold as(select a.Title album_name, sum(iL.Quantity)qty_sold
from Track t
join InvoiceLine iL
	on iL.TrackId = t.TrackId
join Album a
	on a.AlbumId = t.AlbumId
group by album_name
order by qty_sold desc)

select sub.total_qty_sold, sub.sum_top_ten, round(((cast(sub.sum_top_ten as float)/cast(sub.total_qty_sold as float))*100),2)
from(select sum(qty_sold) as total_qty_sold,
	(select sum(top10.qty_sold)
		from (select qty_sold from album_sold limit 10)top10) sum_top_ten
from album_sold)sub
---------------------------------------------------------------------------------------------------------------------------------------------------------------


/*Question 3: Percentage of earning of the top 25 of artist based on track sold*/
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

>>>>>Summing their percentages<<<<<<<<<<<<<<<<

select sum(sub.percentage)
from (with artist_earning as (select a.ArtistId ID, a.Name artist_name, count(iL.Quantity) qty_sold, (count(iL.Quantity) * iL.UnitPrice) total_amt
from InvoiceLine iL
join Track t
	on t.TrackId = iL.TrackId
join Album ab
	on ab.AlbumId = t.AlbumId
join Artist a
	on a.ArtistId = ab.ArtistId
group by a.ArtistId
order by qty_sold  desc)

select artist_name, round((total_amt/(select sum(total_amt) from artist_earning)*100),3) percentage
from artist_earning
Limit 25)sub
---------------------------------------------------------------------------------------------------------------------------------------------------------------


/*Question 4: influence of selling of tracks based on length*/
with trackMinLength as(select t.Name track_Name,round((cast(t.Milliseconds as float)/(60 * 1000)),2) track_len_min, sum(iL.Quantity)qty_sold
from Track t
join InvoiceLine iL
	on iL.TrackId = t.TrackId
join Album a
	on a.AlbumId = t.AlbumId
group by t.TrackId
order by track_len_min desc)

select length_category "Minute Length Category", sum(qty_sold) "Quantity Sold"
from (select track_Name, track_len_min, qty_sold,
		case when track_len_min < 1 then "below 1"
			 when (track_len_min>1) and (track_len_min<3) then "1-3"
			 when (track_len_min>3) and (track_len_min<6) then "3-6"
			 when (track_len_min>6) and (track_len_min<10) then "6-10"
			 when (track_len_min>10) and (track_len_min<20) then "10-20"
			 when (track_len_min>20) and (track_len_min<30) then "20-30"
			 when (track_len_min>30) and (track_len_min<40) then "30-40"
			 when (track_len_min>40) and (track_len_min<50) then "40-50"
			 when (track_len_min>50) and (track_len_min<60) then "50-60"
			 when (track_len_min>60) and (track_len_min<70) then "60-70"
			 when (track_len_min>70) and (track_len_min<80) then "70-80"
			 when (track_len_min>80) and (track_len_min<90) then "80-90"
			 when (track_len_min>90) and (track_len_min<100) then "90-100"
			 else "above 100" end length_category
	from trackMinLength)sub
group by 1
order by 2 desc

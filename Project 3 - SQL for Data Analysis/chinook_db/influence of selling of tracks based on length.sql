/*influence of selling of tracks based on length*/
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
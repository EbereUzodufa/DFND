/*Most sold media type based on quantity of Tracks sold*/
select m.Name "Media Type", sum(iL.Quantity) "Quantity Sold"
from MediaType m
join Track t
	on t.MediaTypeId = m.MediaTypeId
join InvoiceLine iL
	on iL.TrackId = t.TrackId
group by t.MediaTypeId
order by "Quantity Sold" desc /*Idon't like using 2 or Numeric*/
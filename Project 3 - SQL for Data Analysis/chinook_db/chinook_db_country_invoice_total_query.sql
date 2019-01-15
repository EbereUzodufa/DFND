select iL.TrackId tracks, iL.UnitPrice UnitPrice, count(iL.Quantity) Quantity
from InvoiceLine iL
join Track t
	on t.TrackId = iL.TrackId
Group by tracks
order by tracks asc
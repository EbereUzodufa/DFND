select m.Name, Count(t.TrackId) amt
from MediaType m
join Track t
	on t.MediaTypeId = m.MediaTypeId
group by t.MediaTypeId
order by amt desc
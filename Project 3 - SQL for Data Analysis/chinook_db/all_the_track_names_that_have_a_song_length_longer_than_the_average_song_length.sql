select Name, milliseconds
from Track
where milliseconds > (
	select avg(milliseconds)
	from Track
)
order by milliseconds desc
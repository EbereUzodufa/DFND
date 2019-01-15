select a.Title album_id, count(t.AlbumId) song_no, sum(t.Milliseconds) album_length
from Album a
join Track t
	on t.AlbumId = a.AlbumId
group by a.AlbumId
order by album_length desc
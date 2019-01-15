select p.Name Playlist_Name, Count(pT.TrackId)
from Playlist p
join PlaylistTrack pT
	on pT.PlaylistId = p.PlaylistId
group by Playlist_Name
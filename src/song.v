module main

import strconv

struct Song {
	path         string
	title        string
	release_date string
	author       []Author
	album        Album
	cover        Cover
	tag          []Tag
}

fn Song.new(mut app App, song_id int) !&Song {
	song_row := app.db.exec_one('SELECT * FROM song WHERE OID = ${song_id}')!
	// authors := app.db.exec('SELECT * FROM song_author WHERE song_id = ${song_id}')!
	// tags := app.db.exec('SELECT * FROM song_tag WHERE song_id = ${song_id}')!

	album_id := strconv.atoi(song_row.vals[3])!
	album := Album.new(mut app, album_id)!

	cover_id := strconv.atoi(song_row.vals[4])!
	cover := Cover.new(mut app, cover_id)!

	return &Song{
		path: song_row.vals[0]
		title: song_row.vals[1]
		release_date: song_row.vals[2]
		album: album
		cover: cover
	}
}

fn (mut app App) get_song(song_id int) !&Song {
	return Song.new(mut app, song_id)
}

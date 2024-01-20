module main

import strconv

struct Song {
	path         string
	title        string
	release_date string
	authors      []Author
	album        Album
	cover        Cover
	tags         []Tag
}

fn Song.new(mut app App, song_id int) !&Song {
	song_row := app.db.exec_one('SELECT * FROM song WHERE OID = ${song_id}')!

	author_rows := app.db.exec('SELECT * FROM song_author WHERE song_id = ${song_id}')!
	mut authors := []Author{cap: author_rows.len}
	for author_row in author_rows {
		author_id := strconv.atoi(author_row.vals[1])!
		authors << Author.new(mut app, author_id)!
	}

	tag_rows := app.db.exec('SELECT * FROM song_tag WHERE song_id = ${song_id}')!
	mut tags := []Tag{cap: tag_rows.len}
	for tag_row in tag_rows {
		tag_id := strconv.atoi(tag_row.vals[1])!
		tags << Tag.new(mut app, tag_id)!
	}

	album_id := strconv.atoi(song_row.vals[3])!
	album := Album.new(mut app, album_id)!

	cover_id := strconv.atoi(song_row.vals[4])!
	cover := Cover.new(mut app, cover_id)!

	return &Song{
		path: song_row.vals[0]
		title: song_row.vals[1]
		release_date: song_row.vals[2]
		authors: authors
		album: album
		cover: cover
		tags: tags
	}
}

fn (mut app App) get_song(song_id int) !&Song {
	return Song.new(mut app, song_id)
}

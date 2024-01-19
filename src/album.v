module main

struct Album {
	title        string
	release_date string
}

fn Album.new(mut app App, album_id int) !&Album {
	album_row := app.db.exec_one('SELECT * FROM album WHERE OID = ${album_id}')!

	return &Album{
		title: album_row.vals[0]
		release_date: album_row.vals[1]
	}
}

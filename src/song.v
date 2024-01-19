module main

struct Song {
	file_path string
	song_name string
	album     string = 'none'
	author    string = 'unkown'
}

fn (mut app App) get_song(i int) !&Song {
	row := app.db.exec_one('select * from songs where oid = ${i}')!
	song := &Song {
		file_path: row.vals[0]
		song_name: row.vals[1]
		album: row.vals[2]
		author: row.vals[3]
	}

	return song
}

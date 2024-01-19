module main

struct Cover {
	path string
}

fn Cover.new(mut app App, cover_id int) !&Cover {
	cover_row := app.db.exec_one('SELECT * FROM cover WHERE OID = ${cover_id}')!

	return &Cover{
		path: cover_row.vals[0]
	}
}

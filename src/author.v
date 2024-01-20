module main

struct Author {
	name string
}

fn Author.new(mut app App, author_id int) !&Author {
	author_row := app.db.exec_one('SELECT * FROM author WHERE OID = ${author_id}')!

	return &Author{
		name: author_row.vals[0]
	}
}

module main

struct Tag {
	name string
}

fn Tag.new(mut app App, tag_id int) !&Tag {
	tag_row := app.db.exec_one('SELECT * FROM tag WHERE OID = ${tag_id}')!

	return &Tag{
		name: tag_row.vals[0]
	}
}

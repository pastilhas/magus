module main

import vweb
import os
import db.sqlite

const (
	page_title = 'Magus'
)

struct App {
	vweb.Context
mut:
	db sqlite.DB
}

fn run() {
	vweb.run(new_app(), 8081)
}

fn new_app() &App {
	mut db := sqlite.connect('database.db') or { panic(err) }
	mut app := &App{
		db: db
	}
	app.handle_static('assets', true)
	app.mount_static_folder_at(os.resource_abs_path('.'), '/')
	return app
}

@['/']
pub fn (mut app App) home() vweb.Result {
	return $vweb.html()
}

@['/play/:i']
pub fn (mut app App) play(i int) vweb.Result {
	row := app.get_song(i) or { return app.not_found() }

	sound_name := row[0]
	sound_src := row[1]

	return $vweb.html()
}

fn (mut app App) get_song(i int) ![]string {
	row := app.db.exec_one('select * from songs where oid = ${i}')!
	return row.vals
}

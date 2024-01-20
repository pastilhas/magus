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
pub fn (mut app App) player(i int) vweb.Result {
	song := app.get_song(i) or { return app.not_found() }
	return $vweb.html()
}

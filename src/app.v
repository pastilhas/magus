module main

import vweb
import os
import db.sqlite

const (
	base_page_title = 'Magus'
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

	static_path := '${os.resource_abs_path('.')}/src/static'

	app.handle_static('${static_path}', true)
	app.mount_static_folder_at('${static_path}', '/')
	return app
}

@['/']
pub fn (mut app App) home() vweb.Result {
	page_title := base_page_title
	return $vweb.html()
}

@['/play/:i']
pub fn (mut app App) player(i int) vweb.Result {
	song := app.get_song(i) or { return app.not_found() }
	page_title := '${song.title}'
	return $vweb.html()
}

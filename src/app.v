module main

import vweb
import os

const (
	music_dict := './src/assets/dictionary.txt'
	page_title = 'Magus'
)

struct App {
	vweb.Context
}

fn run() {
	vweb.run_at(new_app(), vweb.RunParams{
		port: 8081
	}) or { panic(err) }
}

fn new_app() &App {
	mut app := &App{}
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
	dictionary := os.read_lines(music_dict) or { return app.not_found() }

	if dictionary.len <= i {
		return app.not_found()
	}

	sound_src := dictionary[i]

	return $vweb.html()
}

module main

import vweb
import os

const page_title = 'Magus'

struct App {
	vweb.Context
}

struct Object {
	title       string
	description string
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
	page_title := 'V is the new V'
	v_url := 'https://github.com/vlang/v'

	list_of_object := [
		Object{
			title: 'One good title'
			description: 'this is the first'
		},
		Object{
			title: 'Other good title'
			description: 'more one'
		},
	]

	return $vweb.html()
}

@['/play/:i']
pub fn (mut app App) play(i int) vweb.Result {
	path := './src/assets/dictionary.txt'
	dictionary := os.read_lines(path) or { return app.not_found() }

	if dictionary.len <= i {
		return app.not_found()
	}

	sound_src := dictionary[i]

	return $vweb.html()
}

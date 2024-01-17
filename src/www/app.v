module www

import vweb
import os

struct App {
	vweb.Context
}

struct Object {
pub:
	title       string
	description string
}

pub fn run() {
	vweb.run_at(new_app(), vweb.RunParams{
		port: 8081
	}) or { panic(err) }
}

fn new_app() &App {
	mut app := &App{}
	app.mount_static_folder_at(os.resource_abs_path('.'), '/')
	return app
}

@['/']
pub fn (mut app App) pages_home() vweb.Result {
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

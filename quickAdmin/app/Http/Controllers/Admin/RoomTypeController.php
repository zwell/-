<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

class RoomTypeController extends Controller {

	/**
	 * Index page
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index()
    {
		return view('admin.roomtype.index');
	}

}
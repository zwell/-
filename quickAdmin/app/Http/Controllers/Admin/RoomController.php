<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use App\Room;
use App\RoomType;
use App\Http\Requests\CreateRoomRequest;
use App\Http\Requests\UpdateRoomRequest;
use Illuminate\Http\Request;



class RoomController extends Controller {

	public $status = array('1' => '空闲', 2 => '内部预订', 3 => '已入住', -1 => '维修中');

	/**
	 * Display a listing of room
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index(Request $request)
    {
        $room = Room::with("roomType")->get();
        foreach ($room as $key => &$value) {
        	$value['status'] = isset($this->status[$value['status']]) ? $this->status[$value['status']] : "未知";
        }

		return view('admin.room.index', compact('room'));
	}

	/**
	 * Show the form for creating a new room
	 *
     * @return \Illuminate\View\View
	 */
	public function create()
	{
	    $roomTypes = RoomType::pluck("name", "id")->prepend('选择客房类型', null);
	    
	    return view('admin.room.create', compact("roomTypes"));
	}

	/**
	 * Store a newly created room in storage.
	 *
     * @param CreateRoomRequest|Request $request
	 */
	public function store(CreateRoomRequest $request)
	{
	    
		Room::create($request->all());

		return redirect()->route(config('quickadmin.route').'.room.index');
	}

	/**
	 * Show the form for editing the specified room.
	 *
	 * @param  int  $id
     * @return \Illuminate\View\View
	 */
	public function edit($id)
	{
		$room = Room::find($id);
	    $roomTypes = RoomType::pluck("name", "id")->prepend('选择客房类型', null);
	    $status = array_merge(['0' => '选择状态'], $this->status);
	    
		return view('admin.room.edit', compact('room', 'roomTypes', 'status'));
	}

	/**
	 * Update the specified room in storage.
     * @param UpdateRoomRequest|Request $request
     *
	 * @param  int  $id
	 */
	public function update($id, UpdateRoomRequest $request)
	{
		$room = Room::findOrFail($id);

        

		$room->update($request->all());

		return redirect()->route(config('quickadmin.route').'.room.index');
	}

	/**
	 * Remove the specified room from storage.
	 *
	 * @param  int  $id
	 */
	public function destroy($id)
	{
		Room::destroy($id);

		return redirect()->route(config('quickadmin.route').'.room.index');
	}

    /**
     * Mass delete function from index page
     * @param Request $request
     *
     * @return mixed
     */
    public function massDelete(Request $request)
    {
        if ($request->get('toDelete') != 'mass') {
            $toDelete = json_decode($request->get('toDelete'));
            Room::destroy($toDelete);
        } else {
            Room::whereNotNull('id')->delete();
        }

        return redirect()->route(config('quickadmin.route').'.room.index');
    }

}

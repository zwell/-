<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use DB;
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
        $room = Room::with("roomType")->orderBy('type_id')->get();
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

		DB::table('room_type')
            ->where('id', $request->get('type_id'))
            ->increment('number_of_room', 1);

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

    public function createDateCheckIn()
    {

    }

    public function getAvaiableRooms(Request $request)
    {
        $roomTypeId = $request->get('room_type_id');
        $checkInDate = $request->get('check_in_date');
        $checkInDays = $request->get('check_in_days');
        if (!$roomTypeId || !$checkInDate || !$checkInDays) {
            return ['code' => 0, 'msg' => "缺少参数"];
        }
        $checkInDates = array();
        for ($i = 0; $i < $checkInDays; $i++) {
            $checkInDates[] = date("Y-m-d", strtotime("+ ".$i." days", strtotime($checkInDate)));
        }

        // 不可用的房间
        $checkedRooms = DB::table('room_date_check_in')
            ->select('room_id')
            ->whereIn('date', $checkInDates)
            ->get()
            ->toarray();
        $checkedRoomIds = array_column($checkedRooms, 'room_id');
        
        // 可用房间
        $allRooms = DB::table('room')
            ->join('room_type', 'room_type.id', '=', 'room.type_id')
            ->select('room.type_id', 'room_type.name as type_name', 'room_type.fee', 'room.id', 'room.name')
            ->where('room.type_id', $roomTypeId)
            ->whereNotIn('room.id', $checkedRoomIds)
            ->get();

        return ['code' => 1, 'msg' => "成功", 'data' => $allRooms];;
    }
}

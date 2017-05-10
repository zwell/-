<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use DB;
use App\RoomType;
use App\Http\Requests\CreateRoomTypeRequest;
use App\Http\Requests\UpdateRoomTypeRequest;
use Illuminate\Http\Request;



class RoomTypeController extends Controller {

	/**
	 * Display a listing of roomtype
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index(Request $request)
    {
        $roomtype = RoomType::all();

		return view('admin.roomtype.index', compact('roomtype'));
	}

	/**
	 * Show the form for creating a new roomtype
	 *
     * @return \Illuminate\View\View
	 */
	public function create()
	{
	    
	    return view('admin.roomtype.create');
	}

	/**
	 * Store a newly created roomtype in storage.
	 *
     * @param CreateRoomTypeRequest|Request $request
	 */
	public function store(CreateRoomTypeRequest $request)
	{    
		RoomType::create($request->all());

		return redirect()->route(config('quickadmin.route').'.roomtype.index');
	}

	/**
	 * Show the form for editing the specified roomtype.
	 *
	 * @param  int  $id
     * @return \Illuminate\View\View
	 */
	public function edit($id)
	{
		$roomtype = RoomType::find($id);
	    
	    
		return view('admin.roomtype.edit', compact('roomtype'));
	}

	/**
	 * Update the specified roomtype in storage.
     * @param UpdateRoomTypeRequest|Request $request
     *
	 * @param  int  $id
	 */
	public function update($id, UpdateRoomTypeRequest $request)
	{
		$roomtype = RoomType::findOrFail($id);

        

		$roomtype->update($request->all());

		return redirect()->route(config('quickadmin.route').'.roomtype.index');
	}

	/**
	 * Remove the specified roomtype from storage.
	 *
	 * @param  int  $id
	 */
	public function destroy($id)
	{
		RoomType::destroy($id);

		return redirect()->route(config('quickadmin.route').'.roomtype.index');
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
            RoomType::destroy($toDelete);
        } else {
            RoomType::whereNotNull('id')->delete();
        }

        return redirect()->route(config('quickadmin.route').'.roomtype.index');
    }

    /**
     * 
     * @param Request $request
     *
     * @return mixed
     */
    public function getAvaiableRoomTypes(Request $request)
    {
    	$checkInDate = $request->get('check_in_date');
        $checkInDays = $request->get('check_in_days');
    	$amount = $request->get('amount');
    	if (!$checkInDate || !$checkInDays || !$amount) {
    		return ['code' => 0, 'msg' => "缺少参数"];
    	}
    	$checkInDates = array();
    	for ($i = 0; $i < $checkInDays; $i++) {
    		$checkInDates[] = date("Y-m-d", strtotime("+ ".$i." days", strtotime($checkInDate)));
    	}

        $this->params['checkInDates'] = $checkInDates;

        // 可用房间
        $allRooms = DB::table('room_type')
                ->leftJoin('room_type_date_check_in as r', function ($join) {
                    $join->on('r.room_type_id', '=', 'room_type.id')
                    ->whereIn('r.date', $this->params['checkInDates']);
                })
                ->select('room_type.id', 'room_type.name', 'room_type.fee', 'room_type.number_of_room', 'r.number_of_check_in_room')
                ->get();
        $allTypes = array();
        $unAvaiableIds = array();
        foreach ($allRooms as $key => $value) {
            if (in_array($value->id, $unAvaiableIds)) {
                continue;
            }
            $leftRoom = $value->number_of_room - $value->number_of_check_in_room;
            if ($leftRoom < $amount) {
                $unAvaiableIds[] = $value->id;
                unset($allTypes[$value->id]);
                continue;
            }
            if (isset($allTypes[$value->id])) {
                $allTypes[$value->id]['rooms'] = min($allTypes[$value->id]['rooms'], $leftRoom);
            } else {
                $allTypes[$value->id] = array(
                    'id' => $value->id,
                    'name' => $value->name,
                    'fee' => $value->fee,
                    'rooms' => $leftRoom,
                );
            }
        }

        return ['code' => 1, 'msg' => "成功", 'data' => $allTypes];
    }

}

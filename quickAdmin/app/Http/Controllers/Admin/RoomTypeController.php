<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
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
    	if (!$checkInDate || !$checkInDays) {
    		return "缺少参数";
    	}
    	$checkInDates = array();
    	for ($i = 0; $i < $checkInDays; $i++) {
    		$checkInDates[] = date("Y-m-d", strtotime("+ ".$i." days", strtotime($checkInDate)));
    	}

    	// 不可用的房间
        $sql = "SELECT cr.room_id FROM room_date_check_in cr
        	WHERE cr.date IN ('".implode("','", $checkInDates)."') AND cr.status = 1
        ";
        echo $sql;exit;

        return redirect()->route(config('quickadmin.route').'.roomtype.index');
    }

}

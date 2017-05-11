<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use DB;
use App\CheckIn;
use App\Booking;
use App\Http\Requests\CreateCheckInRequest;
use App\Http\Requests\UpdateCheckInRequest;
use Illuminate\Http\Request;



class CheckInController extends Controller {

	public $status = [1 => "入住中", 2 => '已退房'];

	/**
	 * Display a listing of checkin
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index(Request $request)
    {
        $checkin = CheckIn::all();
        foreach ($checkin as $key => &$value) {
        	$value['status'] = isset($this->status[$value['status']]) ? $this->status[$value['status']] : "未知";
        }

		return view('admin.checkin.index', compact('checkin'));
	}

	/**
	 * Show the form for creating a new checkin
	 *
     * @return \Illuminate\View\View
	 */
	public function create(Request $request)
	{
	    $booking = Booking::with("roomType")->find($request->get('booking_id'));
        if ($booking) {
            $booking->check_out_datetime = date("Y-m-d 12:00", strtotime("+ ".$booking->check_in_days." days", strtotime($booking->check_in_date)));
        } else {
        	$booking = (object)[];
        	$booking->id = "";
        	$booking->check_in_date = "";
        	$booking->check_in_days = "";
        	$booking->room_type_id = "";
        	$booking->customer_name = "";
        	$booking->customer_phone = "";
        	$booking->check_in_fee = "";
        	$booking->prepaid = "";
        	$booking->check_out_datetime = "";
        	$booking->amount = 1;
        }
	    
	    return view('admin.checkin.create', compact('booking'));
	}

	/**
	 * Store a newly created checkin in storage.
	 *
     * @param CreateCheckInRequest|Request $request
	 */
	public function store(CreateCheckInRequest $request)
	{
		$input = $request->all();

		$checkInDate = $datetime = date("Y-m-d");
	    $checkInDays = $input['check_in_days'];

		if ($input['booking_id']) {
			DB::table('booking')
            ->where('id', $input['booking_id'])
            ->update(['status' => 2]);
		} else {
			// 更新剩余房间类型
	        $amount = $input['amount'];        
	        $i = 0;
	        $datetime = date("Y-m-d H:i:s");
	        do {
	            $date = date("Y-m-d", strtotime("+$i days", strtotime($checkInDate)));

	            $result = DB::table('room_type_date_check_in')
	                ->where('room_type_id', $input['room_type_id'])
	                ->where('date', $date)
	                ->get()
	                ->first();
	            if ($result) {
	                DB::table('room_type_date_check_in')
	                ->where('room_type_id', $input['room_type_id'])
	                ->where('date', $date)
	                ->update(['number_of_check_in_room' => $result->number_of_check_in_room + $amount, 'updated_at' => $datetime]);
	            } else {
	                $dateCheckIn = [
	                    'room_type_id' => $input['room_type_id'],
	                    'date' => $date,
	                    'number_of_check_in_room' => $amount,
	                    'created_at' => $datetime,
	                    'updated_at' => $datetime,
	                ];
	                DB::table('room_type_date_check_in')->insert($dateCheckIn);
	            }
	            $i++;
	        } while ($i < $checkInDays);
		}
		// 更新房间入住信息
		$dateCheckIns = array();
		$i = 0;
		do {
            $date = date("Y-m-d", strtotime("+$i days", strtotime($checkInDate)));

            $dateCheckIn[] = [
                'room_id' => $input['room_id'],
                'date' => $date,
                'status' => 2,
                'created_at' => $datetime,
                'updated_at' => $datetime,
            ];
            $i++;
        } while ($i < $checkInDays);
        DB::table('room_date_check_in')->insert($dateCheckIn);

        DB::table('room')
            ->where('id', $input['room_id'])
            ->update(['status' => 3]);

		CheckIn::create($request->all());

		return redirect()->route(config('quickadmin.route').'.checkin.index');
	}

	/**
	 * Show the form for editing the specified checkin.
	 *
	 * @param  int  $id
     * @return \Illuminate\View\View
	 */
	public function edit($id)
	{
		$checkin = CheckIn::find($id);
	    
	    
		return view('admin.checkin.edit', compact('checkin'));
	}

	/**
	 * Update the specified checkin in storage.
     * @param UpdateCheckInRequest|Request $request
     *
	 * @param  int  $id
	 */
	public function update($id, UpdateCheckInRequest $request)
	{
		$checkin = CheckIn::findOrFail($id);

        

		$checkin->update($request->all());

		return redirect()->route(config('quickadmin.route').'.checkin.index');
	}

	/**
	 * Remove the specified checkin from storage.
	 *
	 * @param  int  $id
	 */
	public function destroy($id)
	{
		CheckIn::destroy($id);

		return redirect()->route(config('quickadmin.route').'.checkin.index');
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
            CheckIn::destroy($toDelete);
        } else {
            CheckIn::whereNotNull('id')->delete();
        }

        return redirect()->route(config('quickadmin.route').'.checkin.index');
    }

    // 退房
	public function checkout(Request $request)
	{
	    $checkin = CheckIn::find($request->get('checkin_id'));
	    if (!$checkin) {
	    	return false;
	    }
        
	    return view('admin.checkin.checkout', compact('checkin'));
	}

	/**
	 * Store a newly created checkin in storage.
	 *
     * @param CreateCheckInRequest|Request $request
	 */
	public function checkoutStore(Request $request)
	{
		$input = $request->all();

		$checkin = CheckIn::find($input['checkin_id']);
	    if (!$checkin) {
	    	return false;
	    }

	    $datetime = date("Y-m-d");
		$checkInDate = substr($checkin->created_at, 0, 10);
	    $checkInDays = $checkin->check_in_days;

		// 更新剩余房间类型，房间入住信息
        $checkInDates = array();
        for ($i = 0; $i < $checkInDays; $i++) {
            $checkInDates[] = date("Y-m-d", strtotime("+ ".$i." days", strtotime($checkInDate)));
        }
        DB::table('room_type_date_check_in')
            ->where('room_type_id', $checkin->room_type_id)
            ->whereIn('date', $checkInDates)
            ->decrement('number_of_check_in_room', 1);

        DB::table('room_date_check_in')
            ->where('room_id', $checkin->id)
            ->whereIn('date', $checkInDates)
            ->update(['status' => 1]);

        DB::table('room')
            ->where('id', $checkin->room_id)
            ->update(['status' => 1]);

        DB::table('check_in')
            ->where('id', $checkin->id)
            ->update(['status' => 2]);

        $checkout = [
        	'check_in_id' => $checkin->id,
        	'check_out_fee' => $input['check_out_fee'],
        	'created_at' => $datetime,
        	'updated_at' => $datetime,
        ];
        DB::table('check_out')
            ->insert($checkout);

		return redirect()->route(config('quickadmin.route').'.checkin.index');
	}
}

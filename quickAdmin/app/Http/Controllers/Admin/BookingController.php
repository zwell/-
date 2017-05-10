<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use DB;
use App\Booking;
use App\Http\Requests\CreateBookingRequest;
use App\Http\Requests\UpdateBookingRequest;
use Illuminate\Http\Request;



class BookingController extends Controller {

	/**
	 * Display a listing of booking
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index(Request $request)
    {
        $booking = Booking::with("roomType")
            ->where(['status' => 1])
            ->orderBy('created_at', 'desc')
            ->get();

		return view('admin.booking.index', compact('booking'));
	}

	/**
	 * Show the form for creating a new booking
	 *
     * @return \Illuminate\View\View
	 */
	public function create()
	{
	    
	    return view('admin.booking.create');
	}

	/**
	 * Store a newly created booking in storage.
	 *
     * @param CreateBookingRequest|Request $request
	 */
	public function store(CreateBookingRequest $request)
	{
        // 后期需要先验证是否有空余房间

        // 更新剩余房间类型
        $input = $request->all();
        $checkInDate = $input['check_in_date'];
        $checkInDays = $input['check_in_days'];
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
                DB::table('room_type_date_check_in')
                ->insert($dateCheckIn);
            }
            $i++;
        } while ($i < $checkInDays);

        Booking::create($request->all());

		return redirect()->route(config('quickadmin.route').'.booking.index');
	}

	/**
	 * Show the form for editing the specified booking.
	 *
	 * @param  int  $id
     * @return \Illuminate\View\View
	 */
	public function edit($id)
	{
		$booking = Booking::find($id);
	    
	    
		return view('admin.booking.edit', compact('booking'));
	}

	/**
	 * Update the specified booking in storage.
     * @param UpdateBookingRequest|Request $request
     *
	 * @param  int  $id
	 */
	public function update($id, UpdateBookingRequest $request)
	{
		$booking = Booking::findOrFail($id);

        

		$booking->update($request->all());

		return redirect()->route(config('quickadmin.route').'.booking.index');
	}

    /**
     * cancel.
     *
     * @param  int  $id
     */
    public function cancel(Request $request)
    {
        $id = $request->all('id');
        $booking = Booking::find($id)->first();
        $booking->status = -2;
        $booking->save();

        // 更新剩余房间类型
        $checkInDates = array();
        for ($i = 0; $i < $booking->check_in_days; $i++) {
            $checkInDates[] = date("Y-m-d", strtotime("+ ".$i." days", strtotime($booking->check_in_date)));
        }
        DB::table('room_type_date_check_in')
            ->where('room_type_id', $booking->room_type_id)
            ->whereIn('date', $checkInDates)
            ->decrement('number_of_check_in_room', $booking->amount);

        return redirect()->route(config('quickadmin.route').'.booking.index');
    }
	/**
	 * Remove the specified booking from storage.
	 *
	 * @param  int  $id
	 */
	public function destroy($id)
	{
		Booking::destroy($id);

		return redirect()->route(config('quickadmin.route').'.booking.index');
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
            Booking::destroy($toDelete);
        } else {
            Booking::whereNotNull('id')->delete();
        }

        return redirect()->route(config('quickadmin.route').'.booking.index');
    }

}

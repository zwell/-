<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use App\CheckIn;
use App\Booking;
use App\Http\Requests\CreateCheckInRequest;
use App\Http\Requests\UpdateCheckInRequest;
use Illuminate\Http\Request;



class CheckInController extends Controller {

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

		return view('admin.checkin.index', compact('checkin'));
	}

	/**
	 * Show the form for creating a new checkin
	 *
     * @return \Illuminate\View\View
	 */
	public function create(Request $request)
	{
	    $booking = Booking::find($request->get('booking_id'));
        if ($booking) {
            $booking->check_out_datetime = date("Y-m-d 12:00", strtotime("+ ".$booking->check_in_days." days", strtotime($booking->check_in_date)));
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

}

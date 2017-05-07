<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
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
        $booking = Booking::all();

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

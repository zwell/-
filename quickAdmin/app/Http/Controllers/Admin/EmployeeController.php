<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Redirect;
use Schema;
use App\Employee;
use App\Http\Requests\CreateEmployeeRequest;
use App\Http\Requests\UpdateEmployeeRequest;
use Illuminate\Http\Request;



class EmployeeController extends Controller {

	public $types = ["" => "","负责人" => "负责人","接待员" => "接待员","前台员工" => "前台员工","收银员" => "收银员"];
	public $status = [1 => "正常", 2 => '休假中', 3 => '已离职'];

	/**
	 * Display a listing of employee
	 *
     * @param Request $request
     *
     * @return \Illuminate\View\View
	 */
	public function index(Request $request)
    {
        $employee = Employee::all();

		return view('admin.employee.index', compact('employee'));
	}

	/**
	 * Show the form for creating a new employee
	 *
     * @return \Illuminate\View\View
	 */
	public function create()
	{
	    $types = $this->types;
	    
	    return view('admin.employee.create', compact('types'));
	}

	/**
	 * Store a newly created employee in storage.
	 *
     * @param CreateEmployeeRequest|Request $request
	 */
	public function store(CreateEmployeeRequest $request)
	{
	    
		Employee::create($request->all());

		return redirect()->route(config('quickadmin.route').'.employee.index');
	}

	/**
	 * Show the form for editing the specified employee.
	 *
	 * @param  int  $id
     * @return \Illuminate\View\View
	 */
	public function edit($id)
	{
		$employee = Employee::find($id);
	    
	    
		return view('admin.employee.edit', compact('employee'));
	}

	/**
	 * Update the specified employee in storage.
     * @param UpdateEmployeeRequest|Request $request
     *
	 * @param  int  $id
	 */
	public function update($id, UpdateEmployeeRequest $request)
	{
		$employee = Employee::findOrFail($id);

        

		$employee->update($request->all());

		return redirect()->route(config('quickadmin.route').'.employee.index');
	}

	/**
	 * Remove the specified employee from storage.
	 *
	 * @param  int  $id
	 */
	public function destroy($id)
	{
		Employee::destroy($id);

		return redirect()->route(config('quickadmin.route').'.employee.index');
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
            Employee::destroy($toDelete);
        } else {
            Employee::whereNotNull('id')->delete();
        }

        return redirect()->route(config('quickadmin.route').'.employee.index');
    }

}

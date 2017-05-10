<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreateCheckInRequest extends FormRequest {

	/**
	 * Determine if the user is authorized to make this request.
	 *
	 * @return bool
	 */
	public function authorize()
	{
		return true;
	}

	/**
	 * Get the validation rules that apply to the request.
	 *
	 * @return array
	 */
	public function rules()
	{
		return [
            'room_id' => 'required',
            'check_in_days' => 'required',
            'check_in_fee' => 'required',
            'pay_fee' => 'required',
            'check_out_datetime' => 'required',
		];
	}
}

<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class CheckIn extends Model {

    

    

    protected $table    = 'check_in';
    
    protected $fillable = ['booking_id','customer_id','room_id','check_in_days','check_in_fee','pay_fee','desopsit','check_out_datetime','status'];
    

    public static function boot()
    {
        parent::boot();

        CheckIn::observe(new UserActionsObserver);
    }
    
    
    
    
}
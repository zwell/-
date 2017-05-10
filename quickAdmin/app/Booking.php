<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class Booking extends Model {

    

    

    protected $table    = 'booking';
    
    protected $fillable = ['customer_id','room_type_id','customer_name','customer_phone','check_in_date','check_in_days','amount','check_in_fee','prepaid','keep_datetime','status'];
    

    public static function boot()
    {
        parent::boot();

        Booking::observe(new UserActionsObserver);
    }
    
    /**
     * Get the phone record associated with the user.
     */
    public function roomType()
    {
        return $this->hasOne('App\roomType', 'id', 'room_type_id');
    }
    
    
}
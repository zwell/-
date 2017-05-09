<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class Test extends Model {

    

    

    protected $table    = 'test';
    
    protected $fillable = [
          'aaaa',
          'bbbb',
          'booking_id'
    ];
    

    public static function boot()
    {
        parent::boot();

        Test::observe(new UserActionsObserver);
    }
    
    public function booking()
    {
        return $this->hasOne('App\Booking', 'id', 'booking_id');
    }


    
    
    
}
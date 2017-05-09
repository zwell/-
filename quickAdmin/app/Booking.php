<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class Booking extends Model {

    

    

    protected $table    = 'booking';
    
    protected $fillable = ['11'];
    

    public static function boot()
    {
        parent::boot();

        Booking::observe(new UserActionsObserver);
    }
    
    
    
    
}
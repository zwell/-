<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;


use Illuminate\Database\Eloquent\SoftDeletes;

class Booking extends Model {

    use SoftDeletes;

    /**
    * The attributes that should be mutated to dates.
    *
    * @var array
    */
    protected $dates = ['deleted_at'];

    protected $table    = 'booking';
    
    protected $fillable = ['customer_name'];
    

    public static function boot()
    {
        parent::boot();

        Booking::observe(new UserActionsObserver);
    }
    
    
    
    
}
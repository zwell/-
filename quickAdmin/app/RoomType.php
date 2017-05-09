<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;

class RoomType extends Model {

    /**
    * The attributes that should be mutated to dates.
    *
    * @var array
    */
    protected $dates = [];

    protected $table    = 'room_type';
    
    protected $fillable = ['name','fee','area','number_of_bed','number_of_room','number_of_left_room',];
    

    public static function boot()
    {
        parent::boot();

        RoomType::observe(new UserActionsObserver);
    }
    
    
    
    
}
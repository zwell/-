<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class Room extends Model {

    

    

    protected $table    = 'room';
    
    protected $fillable = ['name','type_id','phone','status'];
    

    public static function boot()
    {
        parent::boot();

        Room::observe(new UserActionsObserver);
    }
    
    /**
     * Get the phone record associated with the user.
     */
    public function roomType()
    {
        return $this->hasOne('App\roomType', 'id', 'type_id');
    }
    
    
}
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;




class Employee extends Model {

    

    

    protected $table    = 'employee';
    
    protected $fillable = ['type','name','phone','join_date','date_of_birth','salary','status'];
    

    public static function boot()
    {
        parent::boot();

        Employee::observe(new UserActionsObserver);
    }
    
    
    
    
}
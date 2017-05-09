<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Laraveldaily\Quickadmin\Observers\UserActionsObserver;

use Carbon\Carbon; 



class Test extends Model {

    

    

    protected $table    = 'test';
    
    protected $fillable = [
          'aa',
          'bbbbbbb',
          'cccccccc',
          'dddddddddd',
          'eeeee',
          'fffffffff'
    ];
    
    public static $eeeee = ["1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5"];


    public static function boot()
    {
        parent::boot();

        Test::observe(new UserActionsObserver);
    }
    
    
    /**
     * Set attribute to date format
     * @param $input
     */
    public function setBbbbbbbAttribute($input)
    {
        if($input != '') {
            $this->attributes['bbbbbbb'] = Carbon::createFromFormat(config('quickadmin.date_format'), $input)->format('Y-m-d');
        }else{
            $this->attributes['bbbbbbb'] = '';
        }
    }

    /**
     * Get attribute from date format
     * @param $input
     *
     * @return string
     */
    public function getBbbbbbbAttribute($input)
    {
        if($input != '0000-00-00') {
            return Carbon::createFromFormat('Y-m-d', $input)->format(config('quickadmin.date_format'));
        }else{
            return '';
        }
    }


    /**
     * Set attribute to datetime format
     * @param $input
     */
    public function setCcccccccAttribute($input)
    {
        if($input != '') {
            $this->attributes['cccccccc'] = Carbon::createFromFormat(config('quickadmin.date_format') . ' ' . config('quickadmin.time_format'), $input)->format('Y-m-d H:i:s');
        }else{
            $this->attributes['cccccccc'] = '';
        }
    }

    /**
     * Get attribute from datetime format
     * @param $input
     *
     * @return string
     */
    public function getCcccccccAttribute($input)
    {
        if($input != '0000-00-00') {
            return Carbon::createFromFormat('Y-m-d H:i:s', $input)->format(config('quickadmin.date_format') . ' ' .config('quickadmin.time_format'));
        }else{
            return '';
        }
    }


}
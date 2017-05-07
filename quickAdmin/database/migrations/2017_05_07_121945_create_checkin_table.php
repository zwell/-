<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Eloquent\Model;

class CreateCheckInTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Model::unguard();
        Schema::create('checkin',function(Blueprint $table){
            $table->increments("id");
            $table->string("customer_id")->nullable();
            $table->string("room_type_id");
            $table->string("customer_name")->nullable();
            $table->string("customer_phone")->nullable();
            $table->date("check_in_date")->nullable();
            $table->dateTime("keep_datetime")->nullable();
            $table->string("status")->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('checkin');
    }

}
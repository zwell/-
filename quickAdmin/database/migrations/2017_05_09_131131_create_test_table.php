<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Eloquent\Model;

class CreateTestTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Model::unguard();
        Schema::create('test',function(Blueprint $table){
            $table->increments("id");
            $table->tinyInteger("aa")->default(0)->nullable();
            $table->date("bbbbbbb")->nullable();
            $table->dateTime("cccccccc")->nullable();
            $table->string("dddddddddd")->nullable();
            $table->enum("eeeee", ["1", "2", "3", "4", "5""5"])->nullable();
            $table->text("fffffffff")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('test');
    }

}
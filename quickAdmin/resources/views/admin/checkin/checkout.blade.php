@extends('admin.layouts.master')

@section('content')

<div class="row">
    <div class="col-sm-10 col-sm-offset-2">
        <h1>退房</h1>

        @if ($errors->any())
        	<div class="alert alert-danger">
        	    <ul>
                    {!! implode('', $errors->all('<li class="error">:message</li>')) !!}
                </ul>
        	</div>
        @endif
    </div>
</div>

{!! Form::open(array('route' => config('quickadmin.route').'.checkin.checkoutStore', 'id' => 'form-with-validation', 'class' => 'form-horizontal')) !!}

<div class="form-group">
    {!! Form::label('check_in_fee', '房费*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_fee', old('check_in_fee', 300), array('id' => 'check_in_days', 'class'=>'form-control', 'readonly')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_out_fee', '其他消费*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_out_fee', old('check_out_fee', 0), array('id' => 'check_in_days', 'class'=>'form-control')) !!}
        
    </div>
</div>

<input type="hidden" id="checkin_id" name="checkin_id" value="<?php echo $checkin->id; ?>">
<div class="form-group">
    <div class="col-sm-10 col-sm-offset-2">
      {!! Form::submit( '退房' , array('class' => 'btn btn-primary')) !!}
    </div>
</div>

{!! Form::close() !!}

@endsection
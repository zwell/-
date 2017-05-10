@extends('admin.layouts.master')

@section('content')

<div class="row">
    <div class="col-sm-10 col-sm-offset-2">
        <h1>{{ trans('quickadmin::templates.templates-view_create-add_new') }}</h1>

        @if ($errors->any())
        	<div class="alert alert-danger">
        	    <ul>
                    {!! implode('', $errors->all('<li class="error">:message</li>')) !!}
                </ul>
        	</div>
        @endif
    </div>
</div>

{!! Form::open(array('route' => config('quickadmin.route').'.checkin.store', 'id' => 'form-with-validation', 'class' => 'form-horizontal')) !!}

<div class="form-group">
    {!! Form::label('check_in_date', '入住日期*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_date', old('check_in_date', $booking->check_in_date), array('id' => 'check_in_date', 'class'=>'form-control datepicker')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_in_days', '入住天数*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_days', old('check_in_days', $booking->check_in_days), array('id' => 'check_in_days', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    <div class="col-sm-10 col-sm-offset-2">
      {!! Form::button( "获取可选客房" , array('id' => 'getRoomType', 'class' => 'btn btn-primary')) !!}
    </div>
</div>
<div class="form-group" id='room'>
</div>
<div class="form-group">
    {!! Form::label('customer_name', '客户姓名*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('customer_name', old('customer_name', $booking->customer_name), array('id' => 'customer_name', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('customer_phone', '客户联系方式*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('customer_phone', old('customer_phone', $booking->customer_phone), array('id' => 'customer_phone', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_in_fee', '入住房费', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_fee', old('check_in_fee', $booking->check_in_fee), array('id' => 'check_in_fee', 'class'=>'form-control', 'readonly')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('pay_fee', '已缴房费', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('pay_fee', old('pay_fee', $booking->prepaid), array('id' => 'pay_fee', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('desopsit', '押金', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('desopsit', old('desopsit'), array('id' => 'desopsit', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_out_datetime', '预计退房时间', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_out_datetime', old('check_out_datetime', $booking->check_out_datetime), array('id' => 'check_out_datetime', 'class'=>'form-control')) !!}
        
    </div>
</div>
<input type="hidden" id="amount" name="amount" value="<?php echo $booking ? $booking->amount : 1; ?>">
<div class="form-group">
    <div class="col-sm-10 col-sm-offset-2">
      {!! Form::submit( trans('quickadmin::templates.templates-view_create-create') , array('class' => 'btn btn-primary')) !!}
    </div>
</div>

{!! Form::close() !!}

@endsection

@section('javascript')
    <script>
        $(document).ready(function () {
            $('#getRoomType').click(function () {
                var check_in_date = $("#check_in_date").val();
                if (check_in_date == "") {
                    alert("请输入入住日期");
                    return false;
                }
                var check_in_days = $("#check_in_days").val();
                if (check_in_days == "") {
                    alert("请输入入住天数");
                    return false;
                }
                var amount = $("#amount").val();
                if (amount == "") {
                    alert("请输入预订数量");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    url: "/admin/room/getAvaiableRooms",
                    headers: {
                        'X-CSRF-TOKEN': $('input[name="_token"]').val()
                    },
                    data: {check_in_date:check_in_date,check_in_days:check_in_days,amount:amount},
                    success: function(result) {
                        if (result.code == 0) {
                            alert(result.msg);
                            return false;
                        }
                        var html = '<label for="room_id" class="col-sm-2 control-label">客房*</label><div class="col-sm-10">';
                        $.each(result.data, function( index, value ) {
                            //html = html + '<option value="'+value.id+'" data-fee="'+value.fee+'">'+value.name+'</option>'
                            html = html + '<input type="checkbox" name="room_id" value="'+value.id+'">'+value.name+'&nbsp;&nbsp;&nbsp;';
                        });
                        html = html + '</div>';
                        $("#room").html(html);
                    },
                    dataType: "json"
                });
            });
        });

    </script>
@stop
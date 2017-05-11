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

{!! Form::open(array('route' => config('quickadmin.route').'.booking.store', 'id' => 'form-with-validation', 'class' => 'form-horizontal')) !!}

<div class="form-group">
    {!! Form::label('check_in_date', '入住日期*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_date', old('check_in_date'), array('id' => 'check_in_date', 'class'=>'form-control datepicker')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_in_days', '入住天数*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_days', old('check_in_days'), array('id' => 'check_in_days', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('amount', '预订数量*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('amount', old('amount', 1), array('id' => 'amount', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    <div class="col-sm-10 col-sm-offset-2">
      {!! Form::button( "获取可选房型" , array('id' => 'getRoomType', 'class' => 'btn btn-primary')) !!}
    </div>
</div>
<div class="form-group" id='roomType'>
</div>
<div class="form-group">
    {!! Form::label('customer_name', '客户姓名*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('customer_name', old('customer_name'), array('id' => 'customer_name', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('customer_phone', '客户联系方式*', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('customer_phone', old('customer_phone'), array('id' => 'customer_phone', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_in_fee', '入住房费', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_fee', old('check_in_fee'), array('id' => 'check_in_fee', 'class'=>'form-control', 'readonly')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('prepaid', '预付金额', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('prepaid', old('prepaid', 0), array('id' => 'prepaid', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('keep_datetime', '最晚保留时间', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('keep_datetime', old('keep_datetime'), array('id' => 'keep_datetime', 'class'=>'form-control datetimepicker')) !!}
        
    </div>
</div>

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
                    url: "/admin/roomtype/getAvaiableRoomTypes",
                    headers: {
                        'X-CSRF-TOKEN': $('input[name="_token"]').val()
                    },
                    data: {check_in_date:check_in_date,check_in_days:check_in_days,amount:amount},
                    success: function(result) {
                        if (result.code == 0) {
                            alert(result.msg);
                            return false;
                        }
                        var html = '<label for="room_type_id" class="col-sm-2 control-label">客房类型*</label><div class="col-sm-10"><select class="form-control" id="room_type_id" name="room_type_id"><option value="">选择客房类型</option>';
                        $.each(result.data, function( index, value ) {
                            html = html + '<option value="'+value.id+'" data-fee="'+value.fee+'">'+value.name+'（费用：'+value.fee+'，剩余客房：'+value.rooms+'间）</option>'
                        });
                        html = html + '</select></div>';
                        $("#roomType").html(html);
                    },
                    dataType: "json"
                });
            });
            $('body').on('change','select[name="room_type_id"]',function() {
                var selected = $(this).children('option:selected');
                if (selected.val() == '') {
                    $("input[name='check_in_fee']").val("");
                    $("input[name='keep_datetime']").val("");
                    return false;
                }
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
                // 计算房费
                var fee = check_in_days * amount * selected.data('fee');
                $("input[name='check_in_fee']").val(fee);
                // 最晚保留时间
                d = new Date(check_in_date);
                var ad = d.getTime() + check_in_days * 24 * 60 * 60 * 1000;
                var keep_datetime = UnixToDate(ad);
                $("input[name='keep_datetime']").val(keep_datetime);
            });
        });

    </script>
@stop
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
    {!! Form::label('check_in_date', '入住日期', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_date', old('check_in_date'), array('id' => 'check_in_date', 'class'=>'form-control datepicker')) !!}
        
    </div>
</div>
<div class="form-group">
    {!! Form::label('check_in_days', '入住天数', array('class'=>'col-sm-2 control-label')) !!}
    <div class="col-sm-10">
        {!! Form::text('check_in_days', old('check_in_days'), array('id' => 'check_in_days', 'class'=>'form-control')) !!}
        
    </div>
</div>
<div class="form-group">
    <div class="col-sm-10 col-sm-offset-2">
      {!! Form::button( "获取可选房型" , array('id' => 'getRoomType', 'class' => 'btn btn-primary')) !!}
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
                $.ajax({
                    type: "POST",
                    url: "/admin/roomtype/getAvaiableRoomTypes",
                    headers: {
                        'X-CSRF-TOKEN': $('input[name="_token"]').val()
                    },
                    data: {check_in_date:check_in_date,check_in_days:check_in_days},
                    success: function(result) {
                        alert(result);
                    },
                    dataType: "json"
                });
            });
        });
    </script>
@stop
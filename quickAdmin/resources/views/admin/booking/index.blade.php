@extends('admin.layouts.master')

@section('content')

<p>{!! link_to_route(config('quickadmin.route').'.booking.create', trans('quickadmin::templates.templates-view_index-add_new') , null, array('class' => 'btn btn-success')) !!}</p>

@if ($booking->count())
    <div class="portlet box green">
        <div class="portlet-title">
            <div class="caption">{{ trans('quickadmin::templates.templates-view_index-list') }}</div>
        </div>
        <div class="portlet-body">
            <table class="table table-striped table-hover table-responsive datatable" id="datatable">
                <thead>
                    <tr>
                        <th>
                            {!! Form::checkbox('delete_all',1,false,['class' => 'mass']) !!}
                        </th>
                        <th>客户姓名</th>
                        <th>客户联系方式</th>
                        <th>客房类型</th>
                        <th>入住日期</th>
                        <th>入住天数</th>
                        <th>预订数量</th>
                        <th>入住房费</th>
                        <!--<th>预付金额</th>
                        <th>最晚保留时间</th>-->
                        <th>预订时间</th>

                        <th>&nbsp;</th>
                    </tr>
                </thead>

                <tbody>
                    @foreach ($booking as $row)
                        <tr date-prepaid="{{ $row->prepaid }}" data-keep_datetime="{{ $row->keep_datetime }}">
                            <td>
                                {!! Form::checkbox('del-'.$row->id,1,false,['class' => 'single','data-id'=> $row->id]) !!}
                            </td>
                            <td>{{ $row->customer_name }}</td>
                            <td>{{ $row->customer_phone }}</td>
                            <td>{{ $row->roomType->name }}</td>
                            <td>{{ $row->check_in_date }}</td>
                            <td>{{ $row->check_in_days }}</td>
                            <td>{{ $row->amount }}</td>
                            <td>{{ $row->check_in_fee }}</td>
                            <!--<td>{{ $row->prepaid }}</td>
                            <td>{{ $row->keep_datetime }}</td>-->
                            <td>{{ $row->created_at }}</td>

                            <td>
                                <!--{!! link_to_route(config('quickadmin.route').'.booking.edit', trans('quickadmin::templates.templates-view_index-edit'), array($row->id), array('class' => 'btn btn-xs btn-info')) !!}-->
                                {!! link_to_route(config('quickadmin.route').'.checkin.create', "入住", array('booking_id' => $row->id), array('class' => 'btn btn-xs btn-info')) !!}
                                {!! Form::open(array('style' => 'display: inline-block;', 'method' => 'POST', 'onsubmit' => "return confirm('".trans("quickadmin::templates.templates-view_index-are_you_sure")."');",  'route' => array(config('quickadmin.route').'.booking.cancel', 'id'=>$row->id))) !!}
                                {!! Form::submit(trans('quickadmin::templates.templates-view_index-cancel'), array('class' => 'btn btn-xs btn-danger')) !!}
                                {!! Form::close() !!}
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
	</div>
@else
    {{ trans('quickadmin::templates.templates-view_index-no_entries_found') }}
@endif

@endsection

@section('javascript')
    <script>
        $(document).ready(function () {
            $('#delete').click(function () {
                if (window.confirm('{{ trans('quickadmin::templates.templates-view_index-are_you_sure') }}')) {
                    var send = $('#send');
                    var mass = $('.mass').is(":checked");
                    if (mass == true) {
                        send.val('mass');
                    } else {
                        var toDelete = [];
                        $('.single').each(function () {
                            if ($(this).is(":checked")) {
                                toDelete.push($(this).data('id'));
                            }
                        });
                        send.val(JSON.stringify(toDelete));
                    }
                    $('#massDelete').submit();
                }
            });
        });
    </script>
@stop
@extends('admin.layouts.master')

@section('content')

<p>{!! link_to_route(config('quickadmin.route').'.checkin.create', trans('quickadmin::templates.templates-view_index-add_new') , null, array('class' => 'btn btn-success')) !!}</p>

@if ($checkin->count())
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
                        <th>客房名称</th>
                        <th>入住天数</th>
                        <th>入住房费</th>
                        <th>预计退房时间</th>
                        <th>状态</th>
                        <th>入时间</th>

                        <th>&nbsp;</th>
                    </tr>
                </thead>

                <tbody>
                    @foreach ($checkin as $row)
                        <tr>
                            <td>
                                {!! Form::checkbox('del-'.$row->id,1,false,['class' => 'single','data-id'=> $row->id]) !!}
                            </td>
                            <td>{{ $row->customer_name }}</td>
                            <td>{{ $row->customer_phone }}</td>
                            <td>{{ $row->room->name }}</td>
                            <td>{{ $row->check_in_days }}</td>
                            <td>{{ $row->check_in_fee }}</td>
                            <td>{{ $row->check_out_datetime }}</td>
                            <td>{{ $row->status }}</td>
                            <td>{{ $row->created_at }}</td>

                            <td>
                                {!! link_to_route(config('quickadmin.route').'.checkin.checkout', '退房', array('checkin_id' => $row->id), array('class' => 'btn btn-xs btn-info')) !!}
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
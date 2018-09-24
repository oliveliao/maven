<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8"/>
    <link rel="stylesheet" href="plug/x-admin/css/font.css">
    <link rel="stylesheet" href="plug/x-admin/css/xadmin.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/common.js"></script>
    <script src="plug/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script src="plug/x-admin/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="js/html5.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="x-body">
    <xblock id="toolbar">
        <button class="layui-btn" onclick="x_admin_show('新增','page?viewName=user/edit&actionType=1')"><i
                class="layui-icon">&#xe654;</i>新增
        </button>
        <button class="layui-btn layui-btn-normal" onclick="openDialog('编辑','page?viewName=user/edit&actionType=2')"><i
                class="layui-icon">&#xe642;</i>编辑
        </button>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>删除</button>
        <span style="line-height:40px;float: right">
        <form class="layui-form layui-col-md12 x-so">
            <input type="text" name="username" placeholder="请输入用户名" autocomplete="off" class="layui-input">
            <button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
        </span>
    </xblock>
    <table id="tb"></table>
</div>

<script>
    $(function () {
        Ajax({
            api: "page/getColumns?pageid=1",
            callback_success: function (res) {
                var clos = [];
                clos.push({
                    checkbox: true,
                    fixed: true
                });
                $.each(res, function (i, item) {
                    var clo = {
                        field: item.code,
                        title: item.displayName
                    };
                    if (item.hasOwnProperty("width")) clo.width = item.width;
                    if (item.hasOwnProperty("sort")) clo.sort = item.sort;
                    if (item.hasOwnProperty("fixed")) clo.fixed = item.fixed;
                    if (item.hasOwnProperty("templet")) {
                        //clo.templet = item.templet;
                        var fun = "window.fun=" + item.templet;
                        clo.templet = eval(fun);
                    }
                    clos.push(clo);
                });
                layui.use('table', function () {
                    var table = layui.table;
                    table.render({
                        elem: '#tb',
                        url: 'page/getList',
                        page: true,
                        cols: [clos]
                    });
                });
            }
        });
    });

    function openDialog(title, url, w, h) {
        var checkStatus = layui.table.checkStatus('tb');
        var length = checkStatus.data.length;
        if (length != 1) {
            layer.alert("请选择一条记录");
            return false;
        }
        url += "&itemId=" + checkStatus.data[0]["id"];
        x_admin_show(title, url, w, h);
    }

    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {

            if ($(obj).attr('title') == '启用') {

                //发异步把用户状态进行更改
                $(obj).attr('title', '停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!', {icon: 5, time: 1000});

            } else {
                $(obj).attr('title', '启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!', {icon: 5, time: 1000});
            }

        });
    }

    /*用户-删除*/
    function member_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $(obj).parents("tr").remove();
            layer.msg('已删除!', {icon: 1, time: 1000});
        });
    }


    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data, function (index) {
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
</body>

</html>

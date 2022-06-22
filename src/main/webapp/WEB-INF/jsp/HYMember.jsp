
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin"))
</script>
<html>
<head>
    <title>会员列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>
	<script src="${pageContext.request.contextPath}/static//bootstrap/js/tableExport.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <script>
        $(function () {
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                $(e).each(function () {
                    $('#ktype').append('<option value='+this.typeId+' >'+this.typeName+'</option>');
                })
            });
            $('#srdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#upsrdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/menber/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'memberId',title:'会员编号',sortable: true},
                    { field:'memberName',title:'名称',sortable: true},
                    { field:'memberPhone',title:'电话',sortable: true},
                    { field:'memberSex',title:'性别',
                        formatter:function (value,row,index) {
                            if(row.memberSex==0){
                                return "女";
                            }else{
                                return "男";
                            }
                        }
                    },
                    { field:'memberAge',title:'年龄',sortable: true},
                    { field:'email',title:'邮箱',sortable: true},
                    { field:'birthday',title:'生日',sortable: true},
                    { field:'membertypes.typeName',title:'卡类型'},
                    { field:'nenberDate',title:'录入日期'},
                    { field:'xxx',title:'会员状态',
                        formatter:function (value,row,index) {
                            if(row.memberStatic==1){
                                return "正常"
                            }else{
                                return "<p style='color:red'>请续卡</p>"
                            }
                        }
                    },
                    { field:'xxx',title:'会员余额',
                        formatter:function (value,row,index) {
                            if(row.memberbalance==0){
                                return "<p style='color:red'>请充值</p>"
                            }else if(row.memberbalance<10){
                                return "<p style='color:red'>不足10元</p>";
                            }else{
                                return row.memberbalance;
                            }
                        }
                    },
                    { field:'memberxufei',title:'到期日期'},
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='删除' href='javascript:del("
                                + row.memberId + ")'><span class='glyphicon glyphicon-trash'></span></a> | <a> <span class='glyphicon glyphicon-pencil'></span></a>";
                        }

                    }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[10,15,20],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',
                onDblClickRow:function(row,$element,field) {
                    $('#updateeModal').modal('show');
                   /* $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                        var e=releset;
                        var tt ="";
                        var tttt="";
                        var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                        $(e).each(function () {
                            tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                            tttt=ttt+tt;
                            $('#upoptype').html(tttt);
                        })
                    }),*/
                    $('#upname').val(row.memberName);
                    $('#upphone').val(row.memberPhone);
                    $('#upsex').val(row.memberSex);
                    $('#upsrdata').val(row.birthday);
                    $('#upemail').val(row.email);
                    $('#updata').val(row.nenberDate);
                    $('#upage').val(row.memberAge);
                    $('#upid').val(row.memberId);
                    $('#upoptype').val(row.membertypes.typeId);


                    }
            })
        });

        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#hyid').val(),
                "ktype":$('#ktype').val()

            };
            return i;
        }
        function search(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var hyid=$('#hyid').val().trim();
            var ktype=$('#ktype').val().trim();


            $.post("${pageContext.request.contextPath}/menber/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":hyid,"ktype":ktype},function (releset) {
                $("#dg").bootstrapTable('load',releset) ;
            })
        }
        //先添加再分页查询
        function insert() {
            $('#exampleModal').modal('show');
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e).each(function () {
                    tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                    tttt=ttt+tt;
                    $('#optype').html(tttt);
                })


            })
            var mydate = new Date();
            var str = "" + mydate.getFullYear() + "-";
            str += (mydate.getMonth()+1) + "-";
            str += mydate.getDate();

            $('#data').val(str)
        }
        function del(memid) {
            swal({
                    title: "确定删除吗？",
                    text: "您将无法恢复！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定删除！",
                    cancelButtonText: "取消删除！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm){
            if (isConfirm) {
            $.post("${pageContext.request.contextPath}/menber/delete",{"memid":memid},function (releset) {
                    $("#dg").bootstrapTable('load',releset) ;
                    swal(
                        {
                            title:"删除成功",
                            type:"success",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
            })
                }else{
                    swal(
                        {
                            title:"删除失败",
                            type:"warning",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }
            });
        }

        function tianjia() {
            debugger;
            if(!validateAdd()){
                return;
            }
            debugger;
            var name=$('#name').val();
            var phone =$('#phone').val();
            var sex=$('#sex').val();
            var srdata=$('#srdata').val();
            var optype=$('#optype').val();
            var data=$('#data').val();
            var age=$('#age').val();
            var  email=$('#email').val();
            var jine=$('#xzmoney').val();
            var ssmoney=$('#ssmoney').val();
            var zhaoqian=$('#zhaoqian').val();
            if (parseInt(zhaoqian)<0){
                swal(
                    {
                        title: "金额不足！！！",
                        type: "warning",
                        timer: 1500,
                        showConfirmButton: false
                    }
                )

            }else if (true){
            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;
                var price=releset.typemoney;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.post("${pageContext.request.contextPath}/menber/add",{"memberName":name,"memberPhone":phone,"memberSex":sex,"birthday":srdata,"Membertypes.typeId":optype,"nenberDate":data,"memberAge":age,"Memberxufei":rq,"email":email,"ssmoney":ssmoney,"zlmoney":zhaoqian },function (releset) {
                    if(releset != null){
                        $("#dg").bootstrapTable('load',releset) ;
                        $('#name').val("");
                        $('#phone').val("");
                        $('#sex').val("");
                        $('#srdata').val("");
                        $('#optype').val("");
                        $('#data').val("");
                        $('#age').val("");
                        $('#email').val("");
                        $('#exampleModal').modal('hide');
                        swal(
                            {
                                title:"添加成功",
                                type:"success",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                          //页面刷新
                        $("#dg").bootstrapTable('refresh');

                    }else{
                        swal(
                            {
                                title:"添加失败",
                                type:"warning",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                    }
                })
            })
            }
        }
        function upd() {
            if(!validateUpd()){
                return;
            }
            var id=$('#upid').val();
            var name=$('#upname').val();
            var phone =$('#upphone').val();
            var sex=$('#upsex').val();
            var srdata=$('#upsrdata').val();
            var email=$('#upemail').val();
            var data=$('#updata').val();
            var age=$('#upage').val();
            var optype=$('#upoptype').val();
            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.post("${pageContext.request.contextPath}/menber/update",{"memberId":id,"memberName":name,"memberPhone":phone,"memberSex":sex,"email":email,"birthday":srdata,"membertypes.typeId":optype,"nenberDate":data,"memberAge":age,"Memberxufei":rq},function (releset) {
                            $("#dg").bootstrapTable('load',releset) ;
                            if(releset != null){
                                $("#dg").bootstrapTable('load',releset) ;
                                $('#updateeModal').modal('hide');
                                swal(
                                    {
                                        title:"修改成功",
                                        type:"success",
                                        timer: 1500,
                                        showConfirmButton: false
                                    }
                                )
                    }else{
                        swal(
                            {
                                title:"修改失败",
                                type:"warning",
                                timer: 1500,
                                showConfirmButton: false
                            }
                        )
                    }
                })
            })
        }
        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#phone").parent().find("span").remove();
            $("#age").parent().find("span").remove();
            $("#srdata").parent().find("span").remove();
            $("#optype").parent().find("span").remove();
            $("#email").parent().find("span").remove();
            $("#optype").parent().find("span").remove();
            $("#ssmoney").parent().find("span").remove();

            var optype = $("#optype").val().trim();
            if(optype==-1){
                $("#optype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }

            var ssmoney = $("#ssmoney").val().trim();
            if(ssmoney == null || ssmoney == ""){
                $("#ssmoney").parent().append("<span style='color:red'>请填写实收金额</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(ssmoney))){
                $("#ssmoney").parent().append("<span style='color:red'>实收金额只能为正整数</span>");
                return false;
            }
            var  email= $("#email").val().trim();
            if(email == null ||email == ""){
                $("#email").parent().append("<span style='color:red'>请填写邮箱</span>");
                return false;
            }

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var phone = $("#phone").val().trim();
            if(phone == null || phone == ""){
                $("#phone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $("#phone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var age = $("#age").val().trim();
            if(age == null || age == ""){
                $("#age").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(age))){
                $("#age").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var srdata = $("#srdata").val().trim();
            if(srdata == null || srdata == ""){
                $("#srdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var optype = $("#optype").val().trim();
            if(optype==-1){
                $("#optype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }
            return true;
        }
        function validateUpd() {
            $("#upname").parent().find("span").remove();
            $("#upphone").parent().find("span").remove();
            $("#upage").parent().find("span").remove();
            $("#upsrdata").parent().find("span").remove();
            $("#upemail").parent().find("span").remove();
            $("#upoptype").parent().find("span").remove();
            var upname = $("#upname").val().trim();
            if(upname == null || upname == ""){
                $("#upname").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var upphone = $("#upphone").val().trim();
            if(upphone == null || upphone == ""){
                $("#upphone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(upphone))){
                $("#upphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var upage = $("#upage").val().trim();
            if(upage == null || upage == ""){
                $("#upage").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(upage))){
                $("#upage").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var upsrdata = $("#upsrdata").val().trim();
            if(upsrdata == null || upsrdata == ""){
                $("#upsrdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var upemail = $("#upemail").val().trim();
            if(upemail==-1){
                $("#upemail").parent().append("<span style='color:red'>请选择邮箱</span>");
                return false;
            }
            var upoptype = $("#upoptype").val().trim();
            if(upoptype==-1){
                $("#upoptype").parent().append("<span style='color:red'>请选择卡型</span>");
                return false;
            }
            return true;
        }
        function sss() {
            var optype=$('#optype').val();
            if(optype!=0){
                $.post("${pageContext.request.contextPath}/ktype/query2",{xztype:optype},function (releset) {
                    $('#xzmoney').val(releset.typemoney);
                });
            }
        }
        function zql() {
            if ($('#ssmoney').val()==""){
                $('#zhaoqian').val("");
            }else{
                var jine=$('#xzmoney').val();
                var ssjine=$('#ssmoney').val();
                var zhao=ssjine-jine;
                $('#zhaoqian').val(zhao);
                if ($('#ssmoney').val()==""){
                    $('#zhaoqian').val("");
                }

            }
        }

    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default" style="background-image: url(${pageContext.request.contextPath}/static/HTmoban/images/6.jpg) ">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="hyid" class="control-label">姓名:</label>
                <input id="hyid" type="text" class="form-control">
            </div>
            <div  class="input-group input-daterange">
                <label for="ktype" class="control-label">卡型:</label>
                <select class="form-control" id="ktype">
                    <option value="0">请选择</option>
                </select>
            </div>

            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" onclick="insert()"><span class="glyphicon glyphicon-plus"></span>添加会员</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#dg').tableExport({ type: 'excel', escape: 'false',fileName:'会员信息表' })">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
<%--添加--%>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">会员添加</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="name"  class="form-inline">姓名: </label>
                            <input type="text" class="form-control" id="name">

                        </div>
                        <div class="form-group">
                            <label for="phone" class="control-label">电话:</label>
                            <input type="text" class="form-control" id="phone">
                        </div>
                      <div class="form-group">
                            <label for="sex" class="control-label">性别:</label>
                            <select class="form-control" id="sex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="age" class="control-label">年龄:</label>
                            <input type="text" class="form-control" id="age">
                        </div>
                        <div class="form-group">
                            <label for="srdata" class="control-label">生日:</label>
                            <input type="text" class="form-control" id="srdata">
                        </div>
                        <div class="form-group">
                            <label for="optype" class="control-label">卡型:</label>
                            <select class="form-control" id="optype"  oninput="sss()">
                            </select>
                        </div>
                            <div>
                                <label for="xzmoney" class="control-label">金额:</label>
                                <input class="form-control" type="text" id="xzmoney" readonly="readonly" >
                            </div>
                            <div>
                                <label for="ssmoney" class="control-label">实收金额:</label>
                                <input class="form-control" type="text" id="ssmoney" oninput="zql()">
                            </div>
                            <div>
                                <label for="zhaoqian" class="control-label">找钱:</label>
                                <input class="form-control" type="text" id="zhaoqian" readonly="readonly">
                            </div>
                            <input type="hidden" id="ycy">
                        <div class="form-group">
                            <label for="email" class="control-label">邮箱:</label>
                            <input type="text" class="form-control" id="email">
                        </div>
                        <div class="form-group">
                            <label for="data" class="control-label" style="display: none" >时间:</label>
                            <input type="text" class="form-control" id="data" style="display: none">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="tianjia()">添加</button>
                </div>
            </div>
        </div>
    </div>

<%--修改--%>
    <div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="updateModalLabel">会员修改</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" id="upid">
                        <div class="form-group">
                            <label for="name" class="control-label">姓名:</label>
                            <input type="text" class="form-control" id="upname" >
                        </div>
                        <div class="form-group">
                            <label for="phone" class="control-label">电话:</label>
                            <input type="text" class="form-control" id="upphone">
                        </div>
                        <div class="form-group">
                            <label for="sex" class="control-label">性别:</label>
                            <select class="form-control" id="upsex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="age" class="control-label">年龄:</label>
                            <input type="text" class="form-control" id="upage">
                        </div>
                        <div class="form-group">
                            <label for="srdata" class="control-label">生日:</label>
                            <input type="text" class="form-control" id="upsrdata">
                        </div>
                        <div class="form-group">
                            <label for="upemail" class="control-label">邮箱：</label>
                            <input type="text" class="form-control" id="upemail">
                        </div>
                        <div class="form-group" style="display: none">
                            <label for="upoptype" class="control-label">会员卡类型：</label>
                            <input type="text" class="form-control" id="upoptype" readonly>
                        </div>
                        <div class="form-group">
                            <label for="data" class="control-label">时间:</label>
                            <input type="text" class="form-control" id="updata" disabled="disabled">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="upd()">修改</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin"))
</script>
<html>
<head>
    <title>续卡续费记录</title>
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
            $('#xdate').datetimepicker({
                //viewMode: 'day',
                format: 'YYYY-MM-DD',
                useCurrent: false
            });
            $('#ddate').datetimepicker({
                format: 'YYYY-MM-DD',
                useCurrent: false //Important! See issue #1075
            });
            $("#xdate").on("dp.change", function (e) {
                $('#secondDate').data("DateTimePicker").minDate(e.date);
            });
            $("#ddate").on("dp.change", function (e) {
                $('#firstDate').data("DateTimePicker").maxDate(e.date);
            });
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/cz/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'member.memberId',title:'会员编号'},
                    { field:'member.memberName',title:'名称'},
                    { field:'xxx',title:'充值类型',
                        formatter:function (index,row,value) {
                            if(row.czStatic==2){
                                return "续卡"
                            }else if(row.czStatic==1){
                                return "充值"
                            }
                        }
                    },
                    { field:'membertype.typeName',title:'名称'},
                    { field:'money',title:'金额'},
                    { field:'ssmoney',title:'实收金额'},
                    { field:'zlmoney',title:'找零'},
                    { field:'date',title:'日期'},
                    
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:500,
                pageList:[10,20,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',
            })
        });
        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "xdate":$('#xdate').val(),
                "ddate":$('#ddate').val(),
            };
            return i;
        }
        //根据日期查询
        function searchone(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var xdate=$('#xdate').val();
            var ddate=$('#ddate').val();
            var date3 = new Date(xdate);
            var date4 = new Date(ddate);
            if (xdate==""&&ddate==""){
                $.post("${pageContext.request.contextPath}/cz/query2",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber},function (data) {
                    $("#dg").bootstrapTable('load',data) ;
                })
            } else if (date3.getTime()>=date4.getTime()){
                swal(
                    {
                        title: "请检查时间段是否正确",
                        type: "warning",
                        timer: 600,
                        showConfirmButton: false
                    }
                )
            }else{
                $.post("${pageContext.request.contextPath}/cz/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"xdate":xdate,"ddate":ddate},function (releset) {
                    $("#dg").bootstrapTable('load',releset) ;
                })
            }




        }
        function searchtwo(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var name=$('#hyname').val();
           if (name==""){
               $.post("${pageContext.request.contextPath}/cz/query2",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber},function (data) {
                   $("#dg").bootstrapTable('load',data) ;
               })
               }else{
          $.post('${pageContext.request.contextPath}/menber/cha2',{'name':name},function(data){
                   $("#table").bootstrapTable("load",data) ;
                 $.post("${pageContext.request.contextPath}/cz/query3",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"id":data.memberId},function (releset) {
                  $("#dg").bootstrapTable('load',releset) ;
              })

                })

                 }

        }
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/4.jpg">
<div class="panel panel-default" style="background-image: url(${pageContext.request.contextPath}/static/HTmoban/images/6.jpg) ">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="xdate" class="control-label">日期从:</label>
                <input id="xdate" type="text" class="form-control">
            </div>
            <div  class="input-group input-daterange">
                <label for="ddate" class="control-label">到:</label>
                <input id="ddate" type="text" class="form-control">
            </div>
            <button onclick="searchone()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <div  class="input-group input-daterange">
               会员名:<input id="hyname" type="text" class="form-control">
            </div>
            <button onclick="searchtwo()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#dg').tableExport({ type: 'excel', escape: 'false' ,fileName:'充值续卡记录'})">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
</body>
</html>

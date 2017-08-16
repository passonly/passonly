<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>
<script type="text/javascript">

//定义列 
var columns=[[
       
{
	field : 'id',
	title : '采购单编号',
	width : 80
},{
	field : 'mc',
	title : '采购单名称',
	width : 150
},{
	field : 'cjsj',
	title : '建单时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			//通过js日期格式化
			var date = new Date(value);
			var y = date.getFullYear();//获取年
			var m = date.getMonth()+1;//获取月
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'xgsj',
	title : '修改时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'tjsj',
	title : '提交时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'shsj',
	title : '审核时间',
	width : 80,
	formatter: function(value,row,index){
		if(value){
			try{
			var date = new Date(value);
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+"-"+m+"-"+d;
			}catch(e){
				alert(e);
			}
		}
		
	}
},{
	field : 'zt',
	title : '采购单<br>状态', 
	width : 60,
	formatter:function(value,row,index){
		return row.sysDictInfoByzt.info;
	}
},{
	field : 'opt3',
	title : '修改',
	width : 60,
	formatter:function(value, row, index){
		return '<a href=javascript:yycgdedit("'+row.id+'")>修改</a>';
	}
}

       ]];
 var toolbar=[
  
           ];
//预加载方法加载datagrid
$(function(){
	$('#yycgdlist').datagrid({
		title : '采购单列表',
		striped : true,
		url : '${baseurl}/cgd/list_result.action',//返回json
		idField : 'id',//rows中每一行唯一标识的字段
		columns : columns,
		pagination : true,
		rownumbers : true,
		toolbar : toolbar,
		loadMsg : "",
		pageList : [ 15, 30, 50, 100 ],//每页显示下拉框值
		onClickRow : function(index, field, value) {
			$('#sysuserlist').datagrid('unselectRow', index);
		}
	});
	
	
});

//查询
function yycgdquery(){
	//alert(0);
	var formdata = $("#yycgdqueryForm").serializeJson();
	$('#yycgdlist').datagrid('load',formdata);
}
//修改
function yycgdedit(id){
	
	var sendUrl = "${baseurl}/cgd/edit.action?yycgdCustom.id="+id;
	//parent就是tabs中iframe的parent
	parent.opentabwindow(id+'采购单修改',sendUrl);//打开一个新标签
}

</script>
<title>维护采购单</title>
</head>
<body>
<!-- 查询条件 -->
<form id="yycgdqueryForm" name="yycgdqueryForm" method="post" action="">
			<TABLE class="table_search">
				<TBODY>
					<TR>
						<TD class="left">采购单号</td>
						<td><INPUT type="text" name="yycgdQueryCustom.yycgdbm" /></TD>
						<TD class="left"></TD>
						<td></TD>

						<TD class="left">采购单状态：</TD>
						<td>
							<select name="yycgdQueryCustom.sysDictInfoByzt.id">
								<option value="">请选择</option>
								<!--groupList就是模型对象中的属性 -->
								<c:forEach items="${yycgdZtList}" var="dictinfo">
								  <option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
								
							</select>
						</TD>
						<td >
						<a id="btn" href="#" onclick="yycgdquery()"
							class="easyui-linkbutton" iconCls='icon-search'>查询</a>
							</td>
					</TR>


				</TBODY>
			</TABLE>
			
		</form>
<!-- datagrid -->
<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
						<table id="yycgdlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
</body>
</html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
<head>
<title>系统用户信息查询</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>
<script type="text/javascript">

//定义columns
var columns =[[
{
	field : 'usercode',
	title : '账号',
	width : 180
} ,
{
	field : 'username',
	title : '用户名称',
	width : 180
},
{
	field : 'groupid',//datagrid不支持dictinfoByGroupid.info定义方式
	title : '用户类型',
	width : 180,
	formatter:function(value,row,index){//row就是一行的数据
		return row.sysDictInfoByGroupid.info;
	}
},
{
	field : 'sysmc',
	title : '所属单位',
	width : 180,
	formatter:function(value,row,index){//row就是一行的数据
		//获 取用户类型所对应 的业务代码，在代码中硬编码了
		var groupid = row.sysDictInfoByGroupid.dictcode;
		
		//1和2为监督单位
		if(groupid=='1' || groupid=='2'){
			return row.dwWsy.mc;
		}else if(groupid == '3'){//如果是医院获取useryy.mc
			return row.dwWss.mc;
		}else if(groupid == '4'){//供货商
			return row.dwGys.mc;
		}
		
		return "";
	}
},
{
	field : 'userstate',//datagrid不支持dictinfoByUserstate.info定义方式
	title : '用户状态',
	width : 180,
	formatter:function(value,row,index){//row就是一行的数据
		return row.sysDictInfoByUserstate.info;
	}
} ,
{
	field : 'opt1',
	title : '删除',
	width : 90,
	formatter:function(value,row,index){
		//alert(value+" "+index+"  "+row.code);
		//return '<span style="color:red">Edit Delete</span>';
		return '<a href=javascript:deluser("'+row.id+'")>删除 </a>';
	}
} ,
{
	field : 'opt2',
	title : '修改',
	width : 90,
	formatter:function(value,row,index){
		return '<a href=javascript:edituser("'+row.id+'")>修改 </a>';
	}
} 
]];

//定义toolbar工具栏
var toolbar = [
<shiro:hasPermission name="user:add">                
{
	id : 'sysuseradd',
	text : '添加',
	iconCls : 'icon-add',
	handler : sysuseradd//点击添加执行js
} 
</shiro:hasPermission>
 ];

//在预加载方法中加载datagrid
$(function(){
	$('#sysuserlist').datagrid({
		title : '系统用户列表',
		striped : true,
		url : '${baseurl}/user/queryuser_result.action',//返回json
		idField : 'id',//rows中每一行唯一标识的字段
		columns : columns,
		pagination : true,
		rownumbers : true,
		toolbar : toolbar,
		loadMsg : "",
		pageList : [ 15, 30, 50, 100 ],//每页显示下拉框值
		onClickRow : function(index, field, value) {
			$('#sysuserlist').datagrid('unselectRow', index);
		},
		onLoadSuccess:function(data){
			if(data && data.resultInfo){
				_alert(data);
			}
		}
	});
	
	
});
//删除用户
function deluser(id){
	//点击确定执行function() 
	_confirm('您确定要执行删除操作吗?', null, function() {
		//将id赋值给sysuserdelid对象
		$("#sysuserdelid").val(id);
		jquerySubByFId('sysuserdelForm', sysuserdel_callback, null, "json");
	});
}
//修改用户
function edituser(id){
	//打一个模态窗口 
	var sendUrl = "${baseurl}/user/edituser.action?sysUserCustom.id="+id;
	//参数：1、窗口标题、2、宽、3：高、4、url
	createmodalwindow("修改用户信息", 800, 250, sendUrl);
	
}
function sysuserdel_callback(data) {
	_alert(data);
	//重新查询用户列表
	sysuserquery();
}
//添加用户
function sysuseradd(){
	//打一个模态窗口 
	var sendUrl = "${baseurl}/user/adduser.action";
	//参数：1、窗口标题、2、宽、3：高、4、url
	createmodalwindow("添加用户信息", 800, 250, sendUrl);
	
}
function sysuserquery(){
	//查询数据列表，执行load方法重新加载datagrid，重新请求返回json的url获取json数据
	//load方法的参数就是输入查询条件，格式是json
	//load的参数是json数据，将form表单的内容转json
	//sysuserqueryForm就是form的id
	var formdata = $("#sysuserqueryForm").serializeJson();
	/*  $('#sysuserlist').datagrid('load',{
		'sysUserCustom.usercode': 'cmzzzc'
	});  */
	$('#sysuserlist').datagrid('load',formdata);
	

}
</script>
</head>
<body>
<!-- 先写布局 -->
<form id="sysuserqueryForm" name="sysuserqueryForm" method="post" action="">
			<TABLE class="table_search">
				<TBODY>
					<TR>
						<TD class="left">用户账号：${sysUserCustom.usercode }</td>
						<td><INPUT type="text" name="sysUserQueryCustom.usercode" /></TD>
						<TD class="left">用户名称：</TD>
						<td><INPUT type="text" name="sysUserQueryCustom.username" /></TD>

						<TD class="left">用户类型：</TD>
						<td>
							<select name="sysUserQueryCustom.sysDictInfoByGroupid.id">
								<option value="">请选择</option>
								<c:forEach items="${userGroupList}" var="dictinfo">
								  <option value="${dictinfo.id}">${dictinfo.info}</option>
								</c:forEach>
								
							</select>
						</TD>
						<td >
						<a id="btn" href="#" onclick="sysuserquery()"
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
					<table id="sysuserlist"></table>
				</TD>
			</TR>
		</TBODY>
</TABLE>
<!-- 此form用于删除用户 -->
<form id="sysuserdelForm" action="${baseurl }/user/deleteuser.action" method="post">
	<!-- form中包括要删除用户的id -->
	<input type="hidden"  id="sysuserdelid" name="sysUserCustom.id"/>
</form>
</body>

</html>
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

var columns=[[
{
	checkbox:true
},
{
	field : 'ypxxid',
	hidden : true,
	formatter: function(value,row,index){
		return '<input type="hidden" name="yycgdmxList['+index+'].ypxx.id" value="'+row.ypxx.id+'"/>';
	}
	
},
{
	field : 'bm',
	title : '流水号',
	width : 50,
	formatter: function(value,row,index){
		return row.ypxx.bm;
	}
	
},{
	field : 'mc',
	title : '通用名',
	width : 100,
	formatter: function(value,row,index){
		return row.ypxx.mc;
	}
},{
	field : 'jx',
	title : '剂型',
	width : 70,
	formatter: function(value,row,index){
		return row.ypxx.jx;
	}
},{
	field : 'gg',
	title : '规格',
	width : 70,
	formatter: function(value,row,index){
		return row.ypxx.gg;
	}
},{
	field : 'zhxs',
	title : '转换系数',
	width : 50,
	formatter: function(value,row,index){
		return row.ypxx.zhxs;
	}
},{
	field : 'zbjg',
	title : '中标价',
	width : 50
},{
	field : 'jyztmc',
	title : '交易状态',
	width : 50,
	formatter: function(value,row,index){
		return row.ypxx.sysDictInfoByJyzt.info;
	}
},{
	field : 'cgl',
	title : '采购量',
	width : 50,
	formatter: function(value,row,index){
		return '<input type="text" name="yycgdmxList['+index+'].cgl" value="'+value+'"/>';
	}
}
,{
	field : 'cgje',
	title : '采购金额',
	width : 50
}
     
     ]];

var toolbar=[
{
	id : 'yycgdmxaddshow',
	text : '采购药品添加',
	iconCls : 'icon-add',
	handler : yycgdmxaddshow
	}
	,{
		id : 'yycgdmxdelete',
		text : '采购药品删除',
		iconCls : 'icon-add',
		handler : yycgdmxdelete
	}
	,{
		id : 'yycgdmxsave',
		text : '保存采购量',
		iconCls : 'icon-add',
		handler : yycgdmxsave
	}  
    ];
function yycgdmxaddshow(){
	//打一个模态窗口 ,传入采购单id
	var sendUrl = "${baseurl}/cgd/addyycgdmx.action?yycgdCustom.id=${yycgd.id}";
	//参数：1、窗口标题、2、宽、3：高、4、url
	createmodalwindow("添加采购药品信息", 1124, 400, sendUrl);
}
function yycgdmxdelete(){
	
}
function yycgdmxsave(){
	_confirm('您确定要更改药品的采购量吗?',null,function(){
		//定义一个数组存储选中行的序号
		var ids = [];
		//通过getSelections获取datagrid中所有选中行
		var rows = $('#yycgdmxlist').datagrid('getSelections');  //数组，数组中有json
		for(var i=0;i<rows.length;i++){
			//获取行的序号
			var index = $('#yycgdmxlist').datagrid('getRowIndex',rows[i]);
			//alert(index);
			//将药品信息id设置到数组中
			ids.push(index);
		}
		if(ids.length==0){
			alert_warn('请选择要更改的药品!');
		}else{
			//将ids数组中药品信息id以逗号分隔方式拼接
			var ids_l = ids.join(",");
			//alert(ids_l);
			//将ids_l赋值给yycgdmxForm中indexs
			$('#indexs').val(ids_l);
			//ajaxform提交
			//要提交的参数
			jquerySubByFId('yycgdmxForm', yycgdmxsave_callback, null, "json");
			
		}
		
	});

	
}
function yycgdmxsave_callback(data){
	
	_alert(data);
	//重新 查询 采购药品列表，刷新 
	yycgdmxquery();
}
$(function (){
	
	//***********按钮**************
	$('#submitbtn').linkbutton({   
		iconCls: 'icon-ok'  
	});  
	$('#closebtn').linkbutton({   
		iconCls: 'icon-cancel'  
	});
	
	//加载datagrid
	$('#yycgdmxlist').datagrid({
		title : '采购单列表',
		striped : true,
		url : '${baseurl}/cgd/yycgdmx_result.action',//返回json
		queryParams:{//只在初始加载datagrid时使用
			'yycgdCustom.id':'${yycgd.id}'
		},
		idField : 'id',//rows中每一行唯一标识的字段
		columns : columns,
		pagination : true,
		rownumbers : true,
		toolbar : toolbar,
		loadMsg : "",
		pageList : [ 15, 30, 50, 100 ],//每页显示下拉框值
		onBeforeLoad : function(index, field, value) {//在加载datagrid之前执行unselectAll(取消所有选中的行)
			$('#yycgdmxlist').datagrid('unselectAll');
		}
	});
});
//保存采购单
function yycgdsave(){
	//ajaxForm提交
	jquerySubByFId('yycgdform',yycgdsave_callback,null,"json");
}
//回调
function yycgdsave_callback(result){
	_alert(result);
}
//查询采购药品明细
function yycgdmxquery(){
	var formdata = $("#yycgdmxForm").serializeJson();

	//这里使用load方法请求上边加载datagrid中定义的url  url : '${baseurl}/cgd/yycgdmx_result.action'，不会使用上边的queryParams参数
	$('#yycgdmxlist').datagrid('load', formdata);
	
}
function yycgdsubmit(){
	
	jquerySubByFId('yycgdform',yycgdsubmit_callback,null,"json");
}
function yycgdsubmit_callback(data){
	_alert(data);
}
</script>
<title>添加采购单</title>
</head>
<body>
<!-- 采购单基本信息 -->
<form id="yycgdform" action="${baseurl }/cgd/submit.action" method="post">
<!-- 采购单id -->
<input type="hidden" name="yycgdCustom.id" value="${yycgd.id }"/>
<!-- 任务id -->
<input type="hidden" name="taskId" value="${taskId}"/>
<TABLE border=0 cellSpacing=0 cellPadding=0 width="70%" bgColor=#c4d8ed align=center>
	<TBODY>
		<TR>
				<TD background=images/r_0.gif width="100%">
					<TABLE cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD>&nbsp;添加采购单</TD>
								<TD align=right>&nbsp;</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE class="toptable grid" border=1 cellSpacing=1 cellPadding=4
						align=center>
						<TBODY>
							<TR>
								<TD height=30 width="15%" align=right >采购单号：</TD>
								<TD class=category width="35%"> 
								${yycgd.id }
								</TD>
								<TD height=30 width="15%" align=right >采购单名称：</TD>
								<TD class=category width="35%">
								${yycgd.mc }
								</TD>
							</TR>
							<TR>
							   <TD height=30 width="15%" align=right >建单时间：</TD>
								<TD class=category width="35%">
									<fmt:formatDate value="${yycgd.cjsj}" pattern="yyyy-MM-dd"/>
								</TD>
								<TD height=30 width="15%" align=right >提交时间：</TD>
								<TD class=category width="35%">
								<fmt:formatDate value="${yycgd.tjsj}" pattern="yyyy-MM-dd"/>
								</TD>
								
							</TR>
								<TR>
								<TD height=30 width="15%" align=right>联系人：</TD>
								<TD class=category width="35%">
								<input type="text" name="yycgd.lxr" id="yycgd.lxr" value="${yycgd.lxr}"  style="width:260px" />
								</TD>
								<TD height=30 width="15%" align=right >联系电话：</TD>
								<TD class=category width="35%">
								<input type="text" name="yycgd.lxdh" id="yycgd.lxdh" value="${yycgd.lxdh}"  style="width:260px" />
								</TD>
							</TR>
							<TR>
								<TD height=30 width="15%" align=right>采购单状态：</TD>
								<TD class=category width="35%">
								${yycgd.sysDictInfoByzt.info}
								</TD>
								<TD height=30 width="15%" align=right>备注：</TD>
								<TD colspan=3>
									<textarea rows="2" cols="30" name="yycgd.bz">${yycgd.bz}</textarea>
								</TD>
							</TR>
							
							<TR>
								<TD height=30 width="15%" align=right>审核时间：</TD>
								<TD class=category width="35%">
								<fmt:formatDate value="${yycgd.shsj}" pattern="yyyy-MM-dd"/>
								</TD>
								<TD height=30 width="15%" align=right >审核意见：</TD>
								<TD class=category width="35%">
								${yycgd.shyj}
								</TD>
							</TR>
							
							<tr>
							  <td colspan=4 align=center class=category>
								<a  href="#" onclick="yycgdsave()" class="easyui-linkbutton" iconCls='icon-save'>保存</a>
							    <a  href="#" onclick="yycgdsubmit()" class="easyui-linkbutton" iconCls='icon-save'>提交</a>
							  </td>
							</tr>
						</TBODY>
					</TABLE>
				</TD>
		    </TR>
	</TBODY>
</TABLE>

</form>
<form id="yycgdmxForm" action="${baseurl }/cgd/saveyycgdmx.action" method="post">
<!-- 采购单id -->
<input type="hidden" name="yycgdCustom.id" value="${yycgd.id }"/>
<!-- 选中行的序号，以逗号分隔 -->
<input type="hidden" name="indexs" id="indexs" />
<!-- 采购单明细 -->
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed>
		<TBODY>
			<TR>
				<TD background=images/r_0.gif width="100%">
					<TABLE cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD>&nbsp;采购药品列表</TD>
								<TD align=right>&nbsp;</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
<TABLE  class="table_search">
				<TBODY>
					<TR>
						
						<TD class="left">通用名：</td>
						<td><INPUT type="text"  name="ypxxCustom.mc" /></TD>
						<TD class="left">剂型：</TD>
						<td ><INPUT type="text" name="ypxxCustom.jx" /></td>
						<TD class="left">规格：</TD>
						<td ><INPUT type="text" name="ypxxCustom.gg" /></td>
						<TD class="left">转换系数：</TD>
						<td ><INPUT type="text" name="ypxxCustom.zhxs" /></td>
					</TR>
					<TR>
						<TD class="left">流水号：</TD>
						<td ><INPUT type="text" name="ypxxCustom.bm" /></td>
						<TD class="left">生产企业：</TD>
						<td ><INPUT type="text" name="ypxxCustom.scqymc" /></td>
						<TD class="left">商品名称：</TD>
						<td ><INPUT type="text" name="ypxxCustom.spmc" /></td>
						 <td class="left">价格范围：</td>
				  		<td>
				      		<INPUT id="ypxxCustom.zbjglower" name="ypxxCustom.zbjglower" style="width:70px"/>
							至
							<INPUT id="ypxxCustom.zbjgupper" name="ypxxCustom.zbjgupper" style="width:70px"/>
							
				 		 </td>
					</tr>
					<tr>
					  
						<TD class="left">药品类别：</TD>
						<td >
							<!-- 药品类别从数据字典中取id作为页面传入action的value -->
							<select id="ypxxCustom.lb" name="ypxxCustom.lb" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${yplbList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
						</td>
						<TD class="left">交易状态：</TD>
						<td >
						    <!-- 交易状态从数据字典中取出dictcode作为页面传入action的value -->
							<select id="ypxxCustom.jyzt" name="ypxxCustom.jyzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${jyztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
						<TD class="left">采购状态：</TD>
						<td >
						   
							<select id="yycgdCustom.cgzt" name="yycgdCustom.cgzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${cgztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
				 		<TD class="left">供货状态：</TD>
						<td >
						   
							<select id="gysypmlCustom.control" name="gysypmlCustom.control" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${ghztList}" var="value">
									<option value="${value.dictcode}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>

				  		<td colspan=2>
				  		
						<a id="btn" href="#" onclick="yycgdmxquery()" class="easyui-linkbutton" iconCls='icon-search'>查询</a>
				  		</td>
						
					</TR>
					
				</TBODY>
			</TABLE>
			 <!-- datagrid -->
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
					<!-- 采购单明细列表 -->
						<table id="yycgdmxlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
</form>
</body>
</html>
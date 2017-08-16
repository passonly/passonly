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
var addyycgdmx = function(){
	_confirm('您确定要采购选择的药品吗?',null,function(){
		//定义一个数组存储药品信息id
		var ids = [];
		//通过getSelections获取datagrid中所有选中行
		var rows = $('#ypxxlist').datagrid('getSelections');  //数组，数组中有json
		for(var i=0;i<rows.length;i++){
			var ypxxid = rows[i].id;
			//将药品信息id设置到数组中
			ids.push(ypxxid);
		}
		if(ids.length==0){
			alert_warn('请选择要采购的药品!');
		}else{
			//将ids数组中药品信息id以逗号分隔方式拼接
			var ids_l = ids.join(",");
			//alert(ids_l);
			//将ids_l赋值给addyycgdmxForm中ypxxids
			$('#ypxxids').val(ids_l);
			//ajaxform提交
			//要提交的参数
			jquerySubByFId('addyycgdmxForm', addyycgdmx_callback, null, "json");
			
		}
	});
	
	
	
};


function addyycgdmx_callback(data) {
	_alert(data);
}

	//工具栏
	var toolbar = [ {
		id : 'ypxxdel',
		text : '确认采购',
		iconCls : 'icon-remove',
		handler : addyycgdmx
	} ];

	var frozenColumns;

	var columns = [ [ {
		field : 'id',
		title : '',
		checkbox : true
	}, {
		field : 'bm',
		title : '流水号',
		width : 80
	}, {
		field : 'mc',
		title : '通用名',
		width : 130
	}, {
		field : 'jx',
		title : '剂型',
		width : 80
	}, {
		field : 'gg',
		title : '规格',
		width : 100
	}, {
		field : 'zhxs',
		title : '转换系数',
		width : 50
	}, {
		field : 'scqymc',
		title : '生产企业',
		width : 180
	}, {
		field : 'spmc',
		title : '商品名称',
		width : 150
	}, {
		field : 'zbjg',
		title : '中标价',
		width : 50
	}, {
		field : 'jyzt',
		title : '交易状态',
		width : 60,
		//嵌套对象输出使用formatter方法
		formatter : function(value, row, index) {
			return row.sysDictInfoByJyzt.info;
		}
	}, {
		field : 'opt3',
		title : '详细',
		width : 60,
		formatter : function(value, row, index) {
			return '<a href=javascript:ypxxinfo(\'' + row.id + '\')>查看</a>';
		}
	} ] ];

	function initGrid() {
		$('#ypxxlist').datagrid({
			title : '药品信息列表',
			striped : true,
			url : '${baseurl}/cgd/addyycgdmx_result.action',
			idField : 'id',//唯一标记一条记录的列的key
			columns : columns,
			pagination : true,
			rownumbers : true,
			toolbar : toolbar,
			loadMsg : "",
			pageList : [ 15, 30, 50, 100 ],
			onClickRow : function(index, field, value) {
				$('#ypxxlist').datagrid('unselectRow', index);
			}
		});

	}
	$(function() {
		initGrid();

	});

	function ypxxquery() {

		var formdata = $("#ypxxqueryForm").serializeJson();
		$('#ypxxlist').datagrid('load', formdata);
	}

</script>
</HEAD>
<BODY>
<div id="ypxxquery_div">
    <form id="ypxxqueryForm" name="ypxxqueryForm" action="" method="post">
			<TABLE  class="table_search">
				<TBODY>
					<TR>
						
						<TD class="left">通用名：</td>
						<td><INPUT type="text"  name="ypxxQueryCustom.mc" /></TD>
						<TD class="left">剂型：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.jx" /></td>
						<TD class="left">规格：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.gg" /></td>
						<TD class="left">转换系数：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.zhxs" /></td>
					</TR>
					<TR>
						<TD class="left">流水号：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.bm" /></td>
						<TD class="left">生产企业：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.scqymc" /></td>
						<TD class="left">商品名称：</TD>
						<td ><INPUT type="text" name="ypxxQueryCustom.spmc" /></td>
						 <td class="left">价格范围：</td>
				  		<td>
				      		<INPUT id="ypxxQueryCustom.zbjglower" name="ypxxQueryCustom.zbjglower" style="width:70px"/>
							至
							<INPUT id="ypxxQueryCustom.zbjgupper" name="ypxxQueryCustom.zbjgupper" style="width:70px"/>
							
				 		 </td>
					</tr>
					<tr>
					  
						<TD class="left">药品类别：</TD>
						<td >
							<select id="ypxxQueryCustom.lb" name="ypxxQueryCustom.lb" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${yplbList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
						</td>
						<TD class="left">交易状态：</TD>
						<td >
							<select id="ypxxQueryCustom.jyzt" name="ypxxQueryCustom.jyzt" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${jyztList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
							</select>
							
						</td>
						
				 		 <td class="left" height="25">质量层次：</td>
				  		<td>
				  		<select id="ypxxQueryCustom.zlcc" name="ypxxQueryCustom.zlcc" style="width:150px">
								<option value="">全部</option>
								<c:forEach items="${ypzlccList}" var="value">
									<option value="${value.id}">${value.info}</option>
								</c:forEach>
						</select>
					
				  		</td>
						<td colspan=2 >
							<a id="btn" href="#" onclick="ypxxquery()" class="easyui-linkbutton" iconCls='icon-search'>查询</a>
						</td>
					</TR>
					
				</TBODY>
			</TABLE>
	    </form>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
		<TBODY>
			<TR>
				<TD>
					<table id="ypxxlist"></table>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>
<form id="addyycgdmxForm" action="${baseurl }/cgd/addyycgdmxsubmit.action" method="post">
<!-- 采购单id -->
<input  name="yycgdCustom.id" value="${yycgdCustom.id }">
<!-- 药品信息id串 -->
<input id="ypxxids" name="ypxxids">
</form>

</BODY>
</HTML>


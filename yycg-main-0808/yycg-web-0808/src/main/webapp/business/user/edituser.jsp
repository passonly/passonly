<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/tag.jsp"%>
<html>
  <head>
    <title>修改用户</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

<%@ include file="/common/common_css.jsp"%>
<%@ include file="/common/common_js.jsp"%>

	<script type="text/javascript">
		
	$(function (){
		//***********按钮**************
		$('#submitbtn').linkbutton({   
    		iconCls: 'icon-ok'  
		});  
		$('#closebtn').linkbutton({   
    		iconCls: 'icon-cancel'  
		});
		
		
	});
	function sysusersave_l(){
		//if($.formValidator.pageIsValid()){
			//jquerySubByFId('sysusereditform',sysusersave_callback,null,"json");
		//}
		//定义ajaxForm提交的胡数
		var options = {  
	 		    datatype:'json',//预期服务端响应的结果类型
	 		    //成功回调方法，result结果的结果，是json格式
	 		    success: function(result) {  
	 		    	//解析提交结果
	 		      alert(result.resultInfo.message);  
	 		    } };  
	 		  
	 		   // 将options传给ajaxForm  
	 		   //使用jquery的选择器指定form的id，调用ajaxSubmit，向form的action(url)进行ajax提交
	 		   //提交的内容是key/value串
	 		$('#sysusereditform').ajaxSubmit(options);  

	}

	function sysusersave(){
		//if($.formValidator.pageIsValid()){
			//使用封装js执行ajaxform提交。
			//参数：1、form的id，form的action配置url
			//2：回调方法
			//4：json表示 预期服务端响应的结果类型
			//5：async: false ,false表示同步提交，true表示异步提交，默认是true
			
			jquerySubByFId('sysusereditform',sysusersave_callback,null,"json");
			//当jquerySubByFId下边的代码需要在jquerySubByFId方法执行后来执行，采用同步
			//当jquerySubByFId下边的代码不依赖jquerySubByFId方法执行结果，可以采用异步，如果采用异步，单独启动一个线程执行ajax请求
			//alert(result);
		//}
		
	}
	//data是服务端响应的结果（json）,是一个固定的参数
	function sysusersave_callback(data){
		//alert(data.resultInfo.message);
		//采用_alert统一解析提交结果
		_alert(data);
	}
	
	</script>
 </HEAD>
<BODY>
<form id="sysusereditform" name="sysusereditform" action="${baseurl}/user/editusersubmit.action" method="post" >
<input type="hidden" name="sysUserCustom.id" value="${sysUserCustom.id}"/>
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed>
		<TBODY>
			<TR>
				<TD background=images/r_0.gif width="100%">
					<TABLE cellSpacing=0 cellPadding=0 width="100%">
						<TBODY>
							<TR>
								<TD>&nbsp;系统用户信息</TD>
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
								<TD height=30 width="15%" align=right >用户账号：</TD>
								<TD class=category width="35%">
								<div>
								<input type="text" id="sysuser_usercode" name="sysUserCustom.usercode" value="${sysUserCustom.usercode}"   />
								</div>
								<div id="sysuser_usercodeTip"></div>
								</TD>
								<TD height=30 width="15%" align=right >用户名称：</TD>
								<TD class=category width="35%">
								<div>
								<input type="text" id="sysuser_username" name="sysUserCustom.username" value="${sysUserCustom.username}"   />
								</div>
								<div id="sysuser_usernameTip"></div>
								</TD>
							</TR>
							
							
							<TR>
								<TD height=30 width="15%" align=right >用户密码：</TD>
								<TD class=category width="35%">
								<div>
									<input type="password" id="sysuser_password" name="sysUserCustom.pwd" value=""/>
								</div>
								<div id="sysuser_passwordTip"></div>
								</TD>
								<TD height=30 width="15%" align=right >用户类型：</TD>
								<TD class=category width="35%">
								<div>
								<select name="sysUserCustom.sysDictInfoByGroupid.id" id="sysuser_groupid">
									<option value="">请选择</option>
									<c:forEach items="${userGroupList}" var="dictinfo">
									   <option value="${dictinfo.id}" <c:if test="${sysUserCustom.sysDictInfoByGroupid.id== dictinfo.id}">selected</c:if>>${dictinfo.info}</option>
									</c:forEach>
								</select>
								</div>
								<div id="sysuser_groupidTip"></div>
								</TD>
								
							</TR>
							<TR>
							    <TD height=30 width="15%" align=right >用户单位名称：</TD>
								<TD class=category width="35%">
								<input type="text" name="sysUserCustom.sysmc" value="${sysUserCustom.sysmc}"/>
								</TD>
								<TD height=30 width="15%" align=right>用户状态：</TD>
								<TD class=category width="35%">
									<c:forEach items="${userStateList}" var="dictinfo">
									   <input type="radio" name="sysUserCustom.sysDictInfoByUserstate.id" value="${dictinfo.id}" <c:if test="${sysUserCustom.sysDictInfoByUserstate.id== dictinfo.id}">checked</c:if>/>${dictinfo.info}
									</c:forEach>
								</TD>
							</TR>
							<tr>
							  <td colspan=4 align=center class=category>
								<a id="submitbtn" href="#" onclick="sysusersave()">提交</a>
								<a id="closebtn" href="#" onclick="parent.closemodalwindow()">关闭</a>
							  </td>
							</tr>
						
						</TBODY>
					</TABLE>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

</BODY>
</HTML>


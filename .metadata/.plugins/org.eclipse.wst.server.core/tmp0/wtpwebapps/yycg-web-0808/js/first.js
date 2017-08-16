var pathName = window.location.pathname.substring(1); 
var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/')); 
var BaseUrl= window.location.protocol + '//' + window.location.host + '/'+ (webName ? webName + '/' : ''); 


var _menus;

$(function() {
	//加载菜单
	$.ajax({
		//url : BaseUrl+'menu.action',//请求动态数据，根据用户角色查询用户权限范围内的菜单
		url : BaseUrl+'menu.json',// 请求的是一个静态数据
		type : 'POST',
		dataType : 'json',
		success : function(data) {// data就是json数据
			_menus = data;
			initMenu(_menus);
		},
		error : function(msg) {
			alert('菜单加载异常!');
		}
	});
	//加载用户信息
	/*
	$.ajax({
		url : BaseUrl+'userinfo.action',// 请求的是一个静态数据
		type : 'POST',
		dataType : 'json',
		success : function(data) {// data就是json数据
			//alert(data.username);
			$('#userinfo').html(data.username);
		}
	});
	*/
	//加载系统信息
	/*
	$.ajax({
		url : BaseUrl+'sysinfo.action',// 请求的是一个静态数据
		type : 'POST',
		dataType : 'json',
		success : function(data) {// data就是json数据
			$('#version_number').html(data.version_number);
			$('#version_date').html(data.version_date);
		}
	});
	*/

	// tabClose();
	// tabCloseEven();

	$('#tabs').tabs('add', {
		title : '欢迎使用',
		content : createFrame(BaseUrl+'welcome.jsp')
	}).tabs({
		onSelect : function(title) {
			var currTab = $('#tabs').tabs('getTab', title);
			var iframe = $(currTab.panel('options').content);

			var src = iframe.attr('src');
			if (src)
				$('#tabs').tabs('update', {
					tab : currTab,
					options : {
						content : createFrame(src)
					}
				});

		}
	});

	// 修改密码
	$('#modifypwd').click(menuclick);

});

// 退出系统方法
function logout() {
	_confirm('您确定要退出本系统吗?', null, function() {
		location.href = BaseUrl+'auth/logout.action';
	})
}

// 帮助
function showhelp() {
	window.open(BaseUrl+'help/help.html', '帮助文档');
}

// 打开标签窗口
var opentabwindow = function(tabTitle, url) {
	addTab(tabTitle, url, 'icon icon-null');
};
// 菜单单击事件
var menuclick = function() {
	// var tabTitle = $(this).children('.nav').text();
	// 获取二级菜单的title
	var tabTitle = $(this).attr("title");
	// 获取二级菜单的url,rel是获取json数据时拼接成的html的一部分
	var url = $(this).attr("rel");
	var menuid = $(this).attr("ref");
	var icon = 'icon ' + $(this).attr("icon");
	addTab(tabTitle, url, icon);
	$('.easyui-accordion li div').removeClass("selected");
	$(this).parent().addClass("selected");
};
// 初始化左侧
function initMenu(menus_var) {

	$("#nav").accordion({
		animate : false
	});

	$.each(menus_var.menus, function(i, n) {
		var menulist = '';
		menulist += '<ul>';
		$.each(n.menus, function(j, o) {
			//如果/开头添加项目名称，否则原路径返回
			url = o? (o.url.startsWith('/') ? BaseUrl + o.url :  o.url) : '';
			menulist += '<li><div><a title="' + o.menuname + '" ref="'
					+ o.menuid + '" href="#" rel="' + url + '" icon="'
					+ o.icon + '"  ><span class="icon ' + o.icon
					+ '" >&nbsp;</span><span class="nav">' + o.menuname
					+ '</span></a></div></li> ';
		});
		menulist += '</ul>';

		$('#nav').accordion('add', {
			title : n.menuname,
			content : menulist,
			iconCls : 'icon ' + n.icon
			
		});

	});
	
	//选中第一个猜对
	if(menus_var.menus.length > 0){
		$("#nav").accordion("select",menus_var.menus[0].menuname);
	}
	

	$('.easyui-accordion li a').click(menuclick).hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});

}

function addTab(subtitle, url, icon) {
	if (!$('#tabs').tabs('exists', subtitle)) {
		$('#tabs').tabs('add', {
			title : subtitle,
			content : createFrame(url),
			closable : true,
			icon : icon
		});
	} else {
		$('#tabs').tabs('select', subtitle);
	}
}

function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
	return s;
}










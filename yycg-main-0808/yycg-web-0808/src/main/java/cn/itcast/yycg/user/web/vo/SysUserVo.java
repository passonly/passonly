package cn.itcast.yycg.user.web.vo;

import cn.itcast.yycg.user.pojo.SysUserCustom;
import cn.itcast.yycg.user.pojo.SysUserQueryCustom;

public class SysUserVo {
	
	    //PO类自定义：封装表单提交的数据，或表单回显的数据
		private SysUserCustom sysUserCustom;		
		
		//查询条件自定义对象：封装页面传递查询条件
		private SysUserQueryCustom sysUserQueryCustom;

		public SysUserCustom getSysUserCustom() {
			return sysUserCustom;
		}

		public void setSysUserCustom(SysUserCustom sysUserCustom) {
			this.sysUserCustom = sysUserCustom;
		}

		public SysUserQueryCustom getSysUserQueryCustom() {
			return sysUserQueryCustom;
		}

		public void setSysUserQueryCustom(SysUserQueryCustom sysUserQueryCustom) {
			this.sysUserQueryCustom = sysUserQueryCustom;
		}


}

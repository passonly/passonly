package cn.itcast.yycg.user.dao;

import cn.itcast.yycg.domain.po.SysUser;

public interface SysUserDao {
	
	/**
	 * 通过id查询用户
	 * @param id
	 * @return
	 */
	public SysUser findSysUserById(String id);

}

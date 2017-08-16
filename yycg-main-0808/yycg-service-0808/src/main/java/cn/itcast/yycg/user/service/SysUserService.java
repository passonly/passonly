package cn.itcast.yycg.user.service;

import cn.itcast.yycg.domain.po.SysUser;

public interface SysUserService {

	/**
	 * 根据id查询用户详情
	 * @param id
	 * @return
	 */
	public SysUser findSysUserById(String id);
}

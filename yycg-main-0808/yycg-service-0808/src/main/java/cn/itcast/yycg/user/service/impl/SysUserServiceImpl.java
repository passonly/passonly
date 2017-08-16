package cn.itcast.yycg.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itcast.yycg.domain.po.SysUser;
import cn.itcast.yycg.user.dao.SysUserDao;
import cn.itcast.yycg.user.service.SysUserService;

@Service
public class SysUserServiceImpl implements SysUserService {

	@Autowired
	private SysUserDao sysUserDao;
	
	@Override
	public SysUser findSysUserById(String id) {
		SysUser sysUser = sysUserDao.findSysUserById(id);
		return sysUser;
	}

}

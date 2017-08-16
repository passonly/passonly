package cn.itcast.yycg.user.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import cn.itcast.yycg.domain.po.SysUser;
import cn.itcast.yycg.user.dao.SysUserDao;

@Repository
public class SysUserDaoImpl extends HibernateDaoSupport implements SysUserDao {

	@Autowired
	public void setSF(SessionFactory sessionFactory){
		super.setSessionFactory(sessionFactory);
	}
	
	// 根据id查询用户详情
	@Override
	public SysUser findSysUserById(String id) {
		return this.getHibernateTemplate().get(SysUser.class, id);
	}

}
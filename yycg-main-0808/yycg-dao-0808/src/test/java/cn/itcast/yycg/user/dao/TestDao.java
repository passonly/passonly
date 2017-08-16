package cn.itcast.yycg.user.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.itcast.yycg.domain.po.SysUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/applicationContext-*.xml"})
public class TestDao {

	@Autowired
	private SysUserDao sysUserDao;
	
	@Test
	public void testfindSysUserById(){
		SysUser userById = sysUserDao.findSysUserById("53");
		System.out.println(userById);
	}
}

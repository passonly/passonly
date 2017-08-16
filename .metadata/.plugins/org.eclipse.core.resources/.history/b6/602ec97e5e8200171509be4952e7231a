package cn.itcast.yycg.user.web.action;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.yycg.domain.po.SysUser;
import cn.itcast.yycg.user.pojo.SysUserCustom;
import cn.itcast.yycg.user.service.SysUserService;
import cn.itcast.yycg.user.web.vo.SysUserVo;

@Controller
@Scope("prototype")
public class SysUserAction extends ActionSupport implements ModelDriven<SysUserVo>{

	@Autowired
	private SysUserService sysUserService;
	
	private SysUserVo sysUserVo = new SysUserVo();
	
	@Override
	public SysUserVo getModel() {
		return sysUserVo;
	}
	
	
	public String findById(){
		//从vo中获取id
		String id = sysUserVo.getSysUserQueryCustom().getId();
		
		//查询数据
		SysUser sysUserById = sysUserService.findSysUserById(id);
		
		//讲数据封装到Vo
		SysUserCustom sysUserCustom = new SysUserCustom();
		BeanUtils.copyProperties(sysUserById, sysUserCustom);
		sysUserVo.setSysUserCustom(sysUserCustom);
		
		
		return "findById";
	}

}

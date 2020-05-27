package com.sf.web.si.config.control;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sf.web.si.config.entity.OmsTeamGroup;
import com.sf.web.si.config.entity.OmsTeamUserLink;
import com.sf.web.si.config.service.EmployeeService;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.smart.SmartView;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.ParameterUtils;
import com.smartframework.web.system.index.entity.SysUser;
import com.smartframework.web.system.index.service.SysUserService;



/**
 * 测试系统中使用的用户信息管理
 * 
 * @author LIUJUN
 * 
 */
@SmartComment("用户管理")
public class EmployeeControl extends BasicControl
{
	private EmployeeService employeeService;
	private SysUserService sysUserService;
	public EmployeeService getEmployeeService() {
		return employeeService;
	}
	public void setEmployeeService(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}
	
	public SysUserService getSysUserService() {
		return sysUserService;
	}
	public void setSysUserService(SysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}
	@SmartComment("获取所有用户信息")
	public SmartView list(Integer teamId,String name,Integer pageSize,Integer pageIndex)
	{
		QueryFilter queryFilter = new QueryFilter();
		
		queryFilter.addNumberFieldEqualCondition("c.id", teamId);
		
		queryFilter.addNumberFieldGreaterThanCondition("u.user_type", 0);
		
		queryFilter.addNumberFieldEqualCondition("u.deleted", 0);
		
		if (!ParameterUtils.isEmptyOrNull(name))
		{
			queryFilter.beginBuildGroup().addStringFieldLikeCondition("u.user_name", name).or().addStringFieldLikeCondition("u.real_name", name).endBuildGroup();
		}
		PagingBean page = this.employeeService.list(queryFilter, pageSize, pageIndex);
		if(page==null)
		{
			return SmartView.ERROR("获取记录发生错误");
		}else
		{
			return this.pageView(page);
		}
	}
	@SmartComment("员工列表")
	public SmartView listEmployeeInfo()
	{
		List<Map<String,Object>> l = this.employeeService.getEmployeeInfo();
		if(l==null||l.isEmpty())
		{
			logger.info("员工组信息为空");
			return null;
		}
		return SmartView.SUCCESS(l);
		
	}
	@SmartComment("按组查询员工列表")
	public SmartView listEmployeeInfoByGroup(int grpId)
	{
		List<Map<String,Object>> l = this.employeeService.getEmployeeInfoByGroup(grpId);
		if(l==null||l.isEmpty())
		{
			logger.info("员工组信息为空");
			return null;
		}
		return SmartView.SUCCESS(l);
	}
	@SmartComment("只查询员工组信息")
	public SmartView listTeamGroup(Integer pageSize,Integer pageIndex)
	{
		PagingBean l = this.employeeService.listTeamGroup(pageSize, pageIndex);

		return this.pageView(l);
	}
	@SmartComment("员工组列表")
	public SmartView listEmployeeGroup()
	{
		List<Map<String,Object>> l = new ArrayList<Map<String,Object>>();
		l=this.employeeService.getEmployeeGroup();
		if(l==null||l.isEmpty())
		{
			logger.info("员工组信息为空");
			return null;
		}
		return SmartView.SUCCESS(l);
		
	}
	
	@SmartComment("保存员工组")
	public SmartView addEmployeeGroupInfo(OmsTeamGroup teamGroup)
	{
		return SmartView.SUCCESS(this.employeeService.saveEmployeeGroupInfo(teamGroup));
	}
	@SmartComment("根据员工组id获取员工组信息")
	public SmartView loadOne(Integer id)
	{
		OmsTeamGroup teamGroup = this.employeeService.loadOne(id);
		
		return SmartView.SUCCESS(teamGroup);
	}
	@SmartComment("加载员工信息")
	public SmartView loadEmployeeInfo(String employeeInfo,Integer teamId,Integer pageSize,Integer pageIndex)
	{
		QueryFilter queryFilter = new QueryFilter();
		
			if (!ParameterUtils.isEmptyOrNull(employeeInfo))
			{
				queryFilter.beginBuildGroup().addStringFieldLikeCondition("u.user_name", employeeInfo).or().addStringFieldLikeCondition("u.real_name", employeeInfo).endBuildGroup();
			}
			if (!ParameterUtils.isEmptyOrNull(teamId))
			{
				queryFilter.addNumberFieldEqualCondition("o.team_id", teamId);
			}
			PagingBean result = this.employeeService.loadEmployeeInfo(queryFilter, pageSize, pageIndex);
	
		return pageView(result);
	}
	@SmartComment("删除所属该员工组的员工信息")
	public SmartView deleteEmployeeInfo(List<Integer> userIds,Integer teamId)
	{
		return this.dbAccess(this.employeeService.deleteEmployeeInfo(userIds, teamId));
	}
	@SmartComment("删除该员工组所有信息")
	public SmartView deleteEmployeeGroup(Integer teamGroupId)
	{
		return this.dbAccess(this.employeeService.deleteEmployeeGroup(teamGroupId));
	}
	@SmartComment("将员工添加到该员工组下")
	public SmartView addToEmployeeGroup(List<Integer> userIds,Integer teamId)
	{
		return this.dbAccess(this.employeeService.addToEmployeeGroup(userIds, teamId));
	}
	@SmartComment("删除员工信息")
	public SmartView deleteEmployees(List<Integer> userIds, Integer logical)
	{
		//return this.dbAccess(this.userService.saveUserStatus(userIds, OperationType.DELETE_USER));
		if (logical == null)
			logical = 1;
		if (!logical.equals(1))
			logical = 0;
		return this.dbAccess(this.employeeService.deleteEmployees(userIds, logical));
	}
	@SmartComment("查询员工信息，过滤到已属于该员工组的员工")
	public SmartView queryEmployeeInfo(String employeeInfo,Integer teamId)
	{
		return SmartView.SUCCESS(this.employeeService.queryEmployeeInfo(employeeInfo,teamId));
	}
	@SmartComment("设置责任人")
	public SmartView assignManager(Integer userId,Integer teamId)
	{
		return this.dbAccess(this.employeeService.assignManager(userId, teamId));
	}

	@SmartComment("员工组员工关联")
	public SmartView listTeamUserLink(){
		return SmartView.SUCCESS(this.employeeService.listTeamUserLink());
	}
}

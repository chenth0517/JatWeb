package com.sf.web.si.config.service;

import java.util.List;
import java.util.Map;

import com.sf.web.si.config.entity.OmsTeamGroup;
import com.sf.web.si.config.entity.OmsTeamUserLink;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.system.index.entity.SysUser;


public interface EmployeeService
{
	
	/**
	 * 获取员工信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月27日<br>
	 */
	public List<Map<String,Object>> getEmployeeInfo();
	
	/**
	 * 按组获取员工信息
	 * 创建人：CHENTIANHAO
	 * 添加时间:2018年01月29日<br>
	 */
	public List<Map<String,Object>> getEmployeeInfoByGroup(int grpId);
	
	/**
	 * 获取员工组信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月27日<br>
	 */
	public List<Map<String,Object>> getEmployeeGroup();
	/**
	 * 保存员工组信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月27日<br>
	 */
	public String saveEmployeeGroupInfo(OmsTeamGroup omsTeamGroup);
	/**
	 * 根据员工组id获取相关员工组信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月27日<br>
	 */
	public OmsTeamGroup loadOne(Integer id);
	
	/**
	 * 获取员工信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月28日<br>
	 */
	public PagingBean loadEmployeeInfo(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);
	/**
	 * 删除所属该员工组的员工信息
	 * 创建人：CHENLIANG
	 * 添加时间:2017年12月28日<br>
	 */
	public String deleteEmployeeInfo(List<Integer> userIds,Integer teamId);
	/**
	 * 删除所属该员工组信息
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月2日<br>
	 */
	public String deleteEmployeeGroup(Integer teamGroupId);
	/**
	 * 获取所有用户信息
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月2日<br>
	 */
	public PagingBean list(QueryFilter queryFilter, Integer pageSize, Integer pageIndex);
	/**
	 * 只获取员工组信息
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月2日<br>
	 */
	public PagingBean listTeamGroup(Integer pageSize,Integer pageIndex);
	/**
	 * 将员工分配到员工组
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月2日<br>
	 */
	public String addToEmployeeGroup(List<Integer> userIds,Integer teamId);
	/**
	 * 删除员工信息
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月3日<br>
	 */
	public String deleteEmployees(List<Integer> userIds,Integer logicalDelete);
	/**
	 * 筛选员工信息
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月8日<br>
	 */
	public List<SysUser> queryEmployeeInfo(String name,Integer teamId);
	/**
	 * 设置责任人
	 * 创建人：CHENLIANG
	 * 添加时间:2018年1月8日<br>
	 */
	public String assignManager(Integer userId,Integer teamId);

	/**
	 * 获取组和员工关联
	 * 创建人：MIAOWUQIONG
	 * 添加时间:2018年1月9日<br>
	 */
	public List<OmsTeamUserLink> listTeamUserLink();
}

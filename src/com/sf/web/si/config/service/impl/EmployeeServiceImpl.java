package com.sf.web.si.config.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sf.web.si.config.dao.OmsTeamGroupOrmDao;
import com.sf.web.si.config.dao.OmsTeamUserLinkOrmDao;
import com.sf.web.si.config.entity.OmsTeamGroup;
import com.sf.web.si.config.entity.OmsTeamUserLink;
import com.sf.web.si.config.service.EmployeeService;
import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.core.smart.SmartView;
import com.smartframework.web.core.Constants;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.system.index.dao.SysOrgUserLinkOrmDao;
import com.smartframework.web.system.index.dao.SysRoleUserLinkOrmDao;
import com.smartframework.web.system.index.dao.SysUserOrmDao;
import com.smartframework.web.system.index.entity.SysOrgUserLink;
import com.smartframework.web.system.index.entity.SysRoleUserLink;
import com.smartframework.web.system.index.entity.SysUser;
import com.smartframework.web.system.index.entity.SysUser.FIND_CATEGORY;
import com.sun.media.jfxmedia.logging.Logger;
public class EmployeeServiceImpl implements EmployeeService
{

	private JdbcDao						jdbcDao;
	
	private SysUserOrmDao               sysUserOrmDao;
	
	private OmsTeamGroupOrmDao          omsTeamGroupOrmDao;
	
	private OmsTeamUserLinkOrmDao       omsTeamUserLinkOrmDao;
	
	private SysOrgUserLinkOrmDao        sysOrgUserLinkOrmDao;
	
	private SysRoleUserLinkOrmDao       sysRoleUserLinkOrmDao;
	
	public JdbcDao getJdbcDao() {
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao) {
		this.jdbcDao = jdbcDao;
	}

	public SysUserOrmDao getSysUserOrmDao() {
		return sysUserOrmDao;
	}

	public void setSysUserOrmDao(SysUserOrmDao sysUserOrmDao) {
		this.sysUserOrmDao = sysUserOrmDao;
	}

	public OmsTeamGroupOrmDao getOmsTeamGroupOrmDao() {
		return omsTeamGroupOrmDao;
	}

	public void setOmsTeamGroupOrmDao(OmsTeamGroupOrmDao omsTeamGroupOrmDao) {
		this.omsTeamGroupOrmDao = omsTeamGroupOrmDao;
	}

	public OmsTeamUserLinkOrmDao getOmsTeamUserLinkOrmDao() {
		return omsTeamUserLinkOrmDao;
	}

	public void setOmsTeamUserLinkOrmDao(OmsTeamUserLinkOrmDao omsTeamUserLinkOrmDao) {
		this.omsTeamUserLinkOrmDao = omsTeamUserLinkOrmDao;
	}

	public SysOrgUserLinkOrmDao getSysOrgUserLinkOrmDao() {
		return sysOrgUserLinkOrmDao;
	}

	public void setSysOrgUserLinkOrmDao(SysOrgUserLinkOrmDao sysOrgUserLinkOrmDao) {
		this.sysOrgUserLinkOrmDao = sysOrgUserLinkOrmDao;
	}

	public SysRoleUserLinkOrmDao getSysRoleUserLinkOrmDao() {
		return sysRoleUserLinkOrmDao;
	}

	public void setSysRoleUserLinkOrmDao(SysRoleUserLinkOrmDao sysRoleUserLinkOrmDao) {
		this.sysRoleUserLinkOrmDao = sysRoleUserLinkOrmDao;
	}

	@Override
	public List<Map<String, Object>> getEmployeeGroup()
	{
		List<Map<String, Object>> result= new ArrayList<Map<String, Object>>();
	
		List<OmsTeamGroup> list= new ArrayList<OmsTeamGroup>();
		Map<String,Object> map = null;
		
		list = this.omsTeamGroupOrmDao.findAll();

		
		if(list==null||list.isEmpty())
		{
				return null;
		}
		for(OmsTeamGroup l:list)
		{
			map = new HashMap<String,Object>();
			//根据员工组ID，计算属于此员工组的员工数
			List<OmsTeamUserLink> link = this.omsTeamUserLinkOrmDao.findByTeamId(l.getId());
			map.put("teamGroup", l);
			map.put("num", link.size());
			//负责人不存在时
			if(l.getManager()==null)
			{
			map.put("managerName", null);
			}else
			{
				//获取责任人的名字
				SysUser sysuser = this.sysUserOrmDao.findOne(l.getManager());
				map.put("managerName", sysuser.getRealName());
			}
			result.add(map);
		}
//		for(OmsTeamGroup l:list)
//		{
//			//根据员工组ID，计算属于此员工组的员工数
//			List<OmsTeamUserLink> link = this.omsTeamUserLinkOrmDao.findByTeamId(l.getId());
//			map.put("teamGroup", l);
//			map.put("num", link.size());
//			result.add(map);
//		}
		return result;
	}

	@Override
	public String saveEmployeeGroupInfo(OmsTeamGroup omsTeamGroup) {
		try
		{
			List<OmsTeamGroup> list = this.omsTeamGroupOrmDao.findByName(omsTeamGroup.getName());
			OmsTeamUserLink link = new OmsTeamUserLink();
			if(omsTeamGroup.getId()==null&&list!=null&&!list.isEmpty())
			{
				return I18n.message("error.team.group","该用户组已经存在");
			}
			if(omsTeamGroup.getId()==null)
			{
				link.setUserId(omsTeamGroup.getManager());
			}
			this.omsTeamGroupOrmDao.save(omsTeamGroup);
			link.setTeamId(omsTeamGroup.getId());
			this.omsTeamUserLinkOrmDao.save(link);
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return Constants.SUCCESS;
	}

	@Override
	public List<Map<String,Object>> getEmployeeInfo() {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		String sql ="select u.* from sys_user u where u.user_type > 0 and u.deleted = 0";
		list = this.jdbcDao.queryForList(sql);
		return list;
	}

	@Override
	public List<Map<String,Object>> getEmployeeInfoByGroup(int grpId) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		String sql ="select u.* from sys_user u right join oms_team_user_link tul on u.id = tul.user_id where u.user_type > 0 and u.deleted = 0 and tul.team_id = " + grpId;
		list = this.jdbcDao.queryForList(sql);
		return list;
	}

	@Override
	public OmsTeamGroup loadOne(Integer id) {
		OmsTeamGroup result= this.omsTeamGroupOrmDao.findOne(id);
		if(result==null)
		{
			return null;
		}
		return result;
	}

	@Override
	public PagingBean loadEmployeeInfo(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	{
		PagingBean bean = null;
		
		StringBuffer sql = new StringBuffer("");

		sql.append("select u.* from sys_user u left join oms_team_user_link o on o.user_id = u.id ");
		
		sql.append(queryFilter.getWhereSql());
		try
		{
			bean = jdbcDao.queryForPaging(sql.toString(), queryFilter.getConditionValues(), pageSize, pageIndex);
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return bean;
	}

	@Override
	public String deleteEmployeeInfo(List<Integer> userIds,Integer teamId) {
		try
		{
			//所选员工信息为员工组责任人，则提示先更换负责人
			OmsTeamGroup team = this.omsTeamGroupOrmDao.findOne(teamId);
			
			for(Integer userId :userIds)
			{
				if(userId.equals(team.getManager()))
				{
					return I18n.message("error.team.group","所选员工中有负责人，需先更换负责人才能删除");
				}
			}
			for(Integer userId :userIds)
			{
				List<OmsTeamUserLink> user = this.omsTeamUserLinkOrmDao.findByUserId(userId);
				
					for(OmsTeamUserLink res :user)
					{
						if(res.getTeamId().equals(teamId))
						{
							this.omsTeamUserLinkOrmDao.delete(res);
						}
					}
			}
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return Constants.SUCCESS;
	}

	@Override
	public String deleteEmployeeGroup(Integer teamGroupId) {
		// 根据员工组id，删除下面员工信息
		try
		{
			List<OmsTeamUserLink> teamUserLink = this.omsTeamUserLinkOrmDao.findByTeamId(teamGroupId);
			this.omsTeamUserLinkOrmDao.delete(teamUserLink);
			//删除员工组信息
			OmsTeamGroup teamGroup = this.omsTeamGroupOrmDao.findOne(teamGroupId);
			
			this.omsTeamGroupOrmDao.delete(teamGroup);
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return Constants.SUCCESS;
	}

	@Override
	public PagingBean list(QueryFilter queryFilter, Integer pageSize, Integer pageIndex) {
		PagingBean bean = null;
		StringBuffer sql = new StringBuffer("");
		
		sql.append("select u.*,GROUP_CONCAT(DISTINCT c.manager SEPARATOR '、') manager,GROUP_CONCAT(DISTINCT c.name SEPARATOR '、') as team_name from sys_user u left join oms_team_user_link p on p.user_id = u.id left join oms_team_group c on c.id = p.team_id ");
		
		sql.append(queryFilter.getWhereSql());

		sql.append("group by u.id");
		bean = jdbcDao.queryForPaging(sql.toString(), queryFilter.getConditionValues(), pageSize, pageIndex);
		return bean;
	}

	@Override
	public PagingBean listTeamGroup(Integer pageSize,Integer pageIndex) {
		PagingBean bean = null;
		
		String sql = "select o.*,u.real_name real_name from oms_team_group o left join sys_user u on o.manager = u.id";
		
		bean = this.jdbcDao.queryForPaging(sql.toString(), pageSize, pageIndex);
		
		return bean;
	}

	@Override
	public String addToEmployeeGroup(List<Integer> userIds,Integer teamId) {
		OmsTeamUserLink userLink = null;
		try{
			for(Integer userId :userIds)
			{
				userLink = new OmsTeamUserLink();
				userLink.setTeamId(teamId);
				userLink.setUserId(userId);
				this.omsTeamUserLinkOrmDao.save(userLink);
			}
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return Constants.SUCCESS;
		
	}

	@Override
	public String deleteEmployees(List<Integer> userIds, Integer logicalDelete) {
		//删除与员工关联的员工组信息
		List<OmsTeamUserLink> teamUserLinks = this.omsTeamUserLinkOrmDao.findByUserIdIn(userIds);
		
		this.omsTeamUserLinkOrmDao.delete(teamUserLinks);
		//若该员工是员工组负责人
		for(Integer id:userIds)
		{
			List<OmsTeamGroup> teamGroup = this.omsTeamGroupOrmDao.findByManager(id);
			if(teamGroup==null||teamGroup.isEmpty())
			{
				continue;
			}else
			{
				//将负责人设为空
				teamGroup.get(0).setName(null);
				this.omsTeamGroupOrmDao.save(teamGroup);
			}
		}
		// 删除用户与组织机构的关联关系
		List<SysOrgUserLink> orgUserLinks = this.sysOrgUserLinkOrmDao.findByUserIdIn(userIds);
		this.sysOrgUserLinkOrmDao.delete(orgUserLinks);

		// 删除用户与角色的关联关系
		List<SysRoleUserLink> roleUserLinks = this.sysRoleUserLinkOrmDao.findByUserIdIn(userIds);
		this.sysRoleUserLinkOrmDao.delete(roleUserLinks);
		
		List<SysUser> users = this.sysUserOrmDao.findByIdIn(userIds);
		
		if (logicalDelete == 1)
		{
			List<SysUser> userToDel = new ArrayList<SysUser>();
			for (SysUser u : users)
			{
			    // 用户已经被删除，则跳过
			    if (u.getDeleted().equals(1))
                {
                    continue;
                }

				String suffix = "%" + u.getId();
				u.setUserName(u.getUserName() + suffix);
				u.setEmail(u.getEmail() + suffix);
				u.setPhone(u.getPhone() + suffix);
				u.setDeleted(1);
				u.setDeleteTime(new Date());
				userToDel.add(u);
			}

			this.sysUserOrmDao.save(userToDel);
		}
		else
		{
			this.sysUserOrmDao.delete(users);
		}
		return Constants.SUCCESS;
	}

	@Override
	public List<SysUser> queryEmployeeInfo(String name,Integer teamId) {
		
		//根据teamId查询出已属于该组的员工
		List<OmsTeamUserLink>  link = this.omsTeamUserLinkOrmDao.findByTeamId(teamId);
		List<SysUser> user = new ArrayList<SysUser>();
		if(name==null)
		{
			 user = this.sysUserOrmDao.findAll();
		}else
		{
			 user = this.sysUserOrmDao.findByUserNameLikeOrRealNameLike(name, name);
		}
	
		
		List<SysUser> result = new ArrayList<SysUser>();
		Integer sum = null;
			try{
			for(SysUser u : user)
			{
				sum = 0;
				if(u.getDeleted()!=0||u.getUserType()==0)
				{
					continue;
				}
				for(OmsTeamUserLink l:link)
				{
					if(u.getId().equals(l.getUserId()))
					{
						//说明该员工已在此员工组下
						sum++;
						continue;
					}
				}
				if(sum==0)
				{
					result.add(u);
				}
		}
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	public String assignManager(Integer userId, Integer teamId) {
		
		OmsTeamGroup team =this.omsTeamGroupOrmDao.findOne(teamId);
		if(team==null) return I18n.message("error.team.not.exist","员工组不存在，请先创建员工组");
		//根据teamId获取员组名
		try{
				team.setManager(userId);
				this.omsTeamGroupOrmDao.save(team);
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return Constants.SUCCESS;
	}

	@Override
	public List<OmsTeamUserLink> listTeamUserLink() {
		List<OmsTeamUserLink> res = this.omsTeamUserLinkOrmDao.findAll();
		if(res==null || res.isEmpty()) return null;
		return res;
	}

}
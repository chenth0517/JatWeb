package com.sf.web.si.customer.service;

import java.util.*;
import com.sf.web.si.customer.entity.ActivityMember;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/05/29
 */
public interface ActivityMemberService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	save(ActivityMember activityMember);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ActivityMember> activityMemberList);
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2018/05/29<br>
	 *@param 
	 *@return
	 */
	public String 	delete(List<Integer> idList,boolean permanently);
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2018/05/29<br>
	 *@param 
	 *@return
	 */
	 public ActivityMember	get(Integer id);
	 
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2018/05/29<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);
}

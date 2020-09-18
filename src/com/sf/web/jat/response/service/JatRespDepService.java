package com.sf.web.jat.response.service;

import java.util.*;

import com.sf.web.jat.response.entity.JatRespDep;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/05/29
 */
public interface JatRespDepService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	save(JatRespDep jatRespDep);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<JatRespDep> jatRespDepList);
	
	/**
	 * 按ID批量读取实体对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	public List<JatRespDep> 	loadRecords(List<Integer> idList);
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/29<br>
	 *@param 
	 *@return
	 */
	public String 	delete(List<Integer> idList,boolean permanently);
	
	/**
	 * 根据ID改变对象顺序<br>
	 * 添加时间:2020/05/29<br>
	 *@param 
	 *@return
	 */
	public String 	changeOrder(Integer id, Integer isDown);
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/29<br>
	 *@param 
	 *@return
	 */
	 public JatRespDep	get(Integer id);
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/29<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryRecords(QueryFilter queryFilter);
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/08/07<br>
	 *@param 
	 *@return
	 */
	 public List<Map<String, Object>>	loadSysOrg();
}

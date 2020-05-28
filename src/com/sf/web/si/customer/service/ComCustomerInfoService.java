package com.sf.web.si.customer.service;

import java.util.*;

import com.sf.web.si.customer.entity.ComCustomerInfo;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface ComCustomerInfoService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public String 	save(ComCustomerInfo comCustomerInfo);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ComCustomerInfo> comCustomerInfoList);
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/28<br>
	 *@param 
	 *@return
	 */
	public String 	delete(List<Integer> idList,boolean permanently);
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/28<br>
	 *@param 
	 *@return
	 */
	public ComCustomerInfo	get(Integer id);
	 
	 
	/**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/28<br>
	 *@param 
	 *@return
	 */
	public PagingBean	queryRecords(Integer currUserId,Integer fastFilter,QueryFilter queryFilter,Integer pageSize,Integer pageIndex);
	 
	/**
	 * 定时提醒查询<br>
	 * 添加时间:2018/03/13<br>
	 *@param 
	 *@return
	 */
	public List<Map<String,Object>> getCustomersForTimingNotify(int dayInterval);
	
	/**
	 * 生日提醒查询<br>
	 * 添加时间:2018/03/13<br>
	 *@param 
	 *@return
	 */
	public List<Map<String,Object>> getCustomersForBirthdayNotify(int dayAhead);
	
	/**
	 * 更新已拜访列<br>
	 * 添加时间:2018/03/14<br>
	 *@param 
	 *@return
	 */
	public String visit(List<Integer> idList);
	
	/**
	 * 获取待办事项<br>
	 * 添加时间:2018/03/15<br>
	 *@param 
	 *@return
	 */
	public List<Map<String,Object>> getTodoList(int dayInterval, int dayAhead, int dayCurrent);
}

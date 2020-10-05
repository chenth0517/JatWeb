package com.sf.web.jat.response.service;

import java.util.*;

import com.sf.web.jat.response.entity.JatRespOrgLink;
import com.sf.web.jat.response.entity.JatRespOrgLinkDisp;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/08/08
 */
public interface JatRespOrgLinkService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	public String 	save(Integer respId, Integer incharge, List<Integer> participate, List<Integer> relate);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<JatRespOrgLink> jatRespOrgLinkList);
	
	/**
	 * 按ID批量读取实体对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	public List<JatRespOrgLink> 	loadRecords(List<Integer> idList);
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/08/08<br>
	 *@param 
	 *@return
	 */
	public String 	delete(List<Integer> idList,boolean permanently);
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/08/08<br>
	 *@param 
	 *@return
	 */
	 public JatRespOrgLinkDisp	loadOne(Integer respId);
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/08/08<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryRecords(QueryFilter queryFilter);
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/08/08<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryCurrUserRespByRespType(Integer respType, Integer userId, QueryFilter queryFilter);
}

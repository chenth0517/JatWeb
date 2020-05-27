package com.sf.web.si.config.service;

import java.util.*;
import com.sf.web.si.config.entity.ComTagDef;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/01/02
 */
public interface SysManagerService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	public String 	save(ComTagDef comTagDef);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ComTagDef> comTagDefList);
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2018/01/02<br>
	 *@param 
	 *@return
	 */
	public String 	delete(List<Integer> idList,boolean permanently);
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2018/01/02<br>
	 *@param 
	 *@return
	 */
	 public ComTagDef	get(Integer id);
	 
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2018/01/02<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryTagRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);
}

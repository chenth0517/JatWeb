package com.sf.web.si.order.service;

import java.util.*;

import com.sf.web.si.order.entity.OmsOpHistory;
import com.sf.web.si.order.entity.OmsOrderTask;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.server.file.entity.SysFileInfo;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/01/02
 */
public interface OmsOrderTaskService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	public String 	save(OmsOrderTask omsOrderTask);

	public String  saveOpHistory(OmsOpHistory opHistory);
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<OmsOrderTask> omsOrderTaskList);
	
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
	 public OmsOrderTask	get(Integer id);
	 
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2018/01/02<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);

	 public List<Map<String, Object>> loadOneTaskOpHistory(Integer taskId);

	 public List<OmsOpHistory> loadTaskOpHistoryByUser(Integer taskId, Integer userId);

	 public List<SysFileInfo> loadOphFileInfos(Integer historyId);

	 public String deleteFileAndLink(String fileId);
}

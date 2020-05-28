package com.sf.web.si.order.service;

import java.util.*;

import com.sf.web.si.config.entity.ComTagDef;
import com.sf.web.si.order.entity.OmsOrderFileLink;
import com.sf.web.si.order.entity.OmsOrderMain;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.server.file.entity.SysFileInfo;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface OrderMngService
{
	/**
	 * 保存实体对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public String 	save(OmsOrderMain omsOrderMain);
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<OmsOrderMain> omsOrderMainList);
	
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
	 public Map<String,Object>	get(Integer id);
	 
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/28<br>
	 *@param 
	 *@return
	 */
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);

	/**
	 * 获取附件列表
	 */
	public List<SysFileInfo> loadLinkFiles(Integer orderId);

	/**
	 * 删除附件时同时删除关联
	 * @param fileId
	 * @return
	 */
	public String deleteFileAndLink(String fileId);

	/**
	 * 获取工单标签
	 * @param orderId
	 * @return
	 */
	public List<ComTagDef> loadLinkTags(Integer orderId);

	/**
	 * 根据角色查询可操作工单
	 * @param queryFilter
	 * @param pageSize
	 * @param pageIndex
	 * @return
	 */
	public PagingBean queryRecordsByRole(QueryFilter queryFilter, Integer pageSize, Integer pageIndex);

	public PagingBean queryOrderOpHistory(QueryFilter queryFilter, Integer pageSize, Integer pageIndex);

	public String updateOrderStatus(Integer orderId, Integer status);
}

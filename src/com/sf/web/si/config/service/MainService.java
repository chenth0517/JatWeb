package com.sf.web.si.config.service;

import java.util.List;
import java.util.Map;

import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.queryfilter.QueryFilter;

public interface MainService {
	/**
	 * 查询工单信息<br>
	 * 添加时间:2018/01/12<br>
	 * @param 
	 * @return
	 */
	public PagingBean queryOrderInfo(QueryFilter queryFilter,Integer pageSize,Integer pageIndex);
	/**
	 * 统计工单数<br>
	 * 添加时间:2018/01/12<br>
	 * @param 
	 * @return
	 */
	public List<Map<String,Object>> countOrder(Integer respUser);
	/**
	 * 统计最近七天关闭工单数<br>
	 * 添加时间:2020/05/25<br>
	 * @param 
	 * @return
	 */
	public List<Map<String,Object>> computedClosedOrder(Integer respUser);
}

package com.sf.web.si.customer.service.impl;

import java.util.*;

import com.sf.web.si.customer.entity.Activity;
import com.sf.web.si.customer.dao.ActivityOrmDao;
import com.sf.web.si.customer.service.ActivityService;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.database.ColumnRefInfo;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/05/29
 */
public class ActivityServiceImpl implements ActivityService
{
	private Logger	logger	= Logger.getLogger(ActivityServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private ActivityOrmDao activityOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public ActivityOrmDao getActivityOrmDao()
	{
		return activityOrmDao;
	}

	public void setActivityOrmDao(ActivityOrmDao activityOrmDao)
	{
		this.activityOrmDao = activityOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(Activity activity)
	{
		try
		{
			AnnotationAccessUtil.validateEntityBean(activity);
			this.activityOrmDao.save(activity);
		}
		catch(Exception e)
		{
			logger.warn("Save activity Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<Activity> activityList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<Activity> list = this.activityOrmDao.findAll(idList);
			this.activityOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	 public Activity	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.activityOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2018/05/29<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	if(pageSize==null||pageIndex==null) return null;
		String sql = "select e.* from activity e";
		
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
		List<Map<String,Object>> records = pb.getData();
		Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
		dictNameFieldNameMap.put("status", "SMART_INFO_DIC_STATUS");
		CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, DictItemColumRefType.ID_COLUMN);
		
		Map<String, ColumnRefInfo> filedRefInfoMap = new HashMap<String,ColumnRefInfo>();
		filedRefInfoMap.put("manager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
		CommonTranslateUtil.translateMultiReferenceColumn(records, null, DictItemColumRefType.ID_COLUMN, filedRefInfoMap);
		return pb;
	 }
}

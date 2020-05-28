package com.sf.web.si.customer.service.impl;

import java.util.*;

import com.sf.web.si.customer.entity.ActivityMember;
import com.sf.web.si.customer.dao.ActivityMemberOrmDao;
import com.sf.web.si.customer.service.ActivityMemberService;

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
 * @创建人    chenth
 * @日期    2020/05/29
 */
public class ActivityMemberServiceImpl implements ActivityMemberService
{
	private Logger	logger	= Logger.getLogger(ActivityMemberServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private ActivityMemberOrmDao activityMemberOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public ActivityMemberOrmDao getActivityMemberOrmDao()
	{
		return activityMemberOrmDao;
	}

	public void setActivityMemberOrmDao(ActivityMemberOrmDao activityMemberOrmDao)
	{
		this.activityMemberOrmDao = activityMemberOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(ActivityMember activityMember)
	{
		try
		{
			AnnotationAccessUtil.validateEntityBean(activityMember);
			this.activityMemberOrmDao.save(activityMember);
		}
		catch(Exception e)
		{
			logger.warn("Save activityMember Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ActivityMember> activityMemberList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<ActivityMember> list = this.activityMemberOrmDao.findAll(idList);
			this.activityMemberOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	 public ActivityMember	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.activityMemberOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	if(pageSize==null||pageIndex==null) return null;
		String sql = "select e.* from activity_member e";
		
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
		List<Map<String,Object>> records = pb.getData();
		
		Map<String, ColumnRefInfo> filedRefInfoMap = new HashMap<String,ColumnRefInfo>();
		filedRefInfoMap.put("customerId", new ColumnRefInfo("com_customer_info", "id", "name", ""));
		CommonTranslateUtil.translateMultiReferenceColumn(records, null, DictItemColumRefType.ID_COLUMN, filedRefInfoMap);
		return pb;
	 }
}

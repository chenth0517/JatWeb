package com.sf.web.si.config.service.impl;

import java.util.*;
import com.sf.web.si.config.entity.ComTagDef;
import com.sf.web.si.config.dao.ComTagDefOrmDao;
import com.sf.web.si.config.service.SysManagerService;
import org.apache.log4j.Logger;
import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/01/02
 */
public class SysManagerServiceImpl implements SysManagerService
{
	private Logger	logger	= Logger.getLogger(SysManagerServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private ComTagDefOrmDao comTagDefOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public ComTagDefOrmDao getComTagDefOrmDao()
	{
		return comTagDefOrmDao;
	}

	public void setComTagDefOrmDao(ComTagDefOrmDao comTagDefOrmDao)
	{
		this.comTagDefOrmDao = comTagDefOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(ComTagDef comTagDef)
	{
		try
		{
			AnnotationAccessUtil.validateEntityBean(comTagDef);
			this.comTagDefOrmDao.save(comTagDef);
		}
		catch(Exception e)
		{
			logger.warn("Save comTagDef Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ComTagDef> comTagDefList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<ComTagDef> list = this.comTagDefOrmDao.findAll(idList);
			this.comTagDefOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	 public ComTagDef	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.comTagDefOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2018/01/02<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryTagRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	if(pageSize==null||pageIndex==null) return null;
		String sql = "select e.* from com_tag_def e";
		return jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
	 }
}

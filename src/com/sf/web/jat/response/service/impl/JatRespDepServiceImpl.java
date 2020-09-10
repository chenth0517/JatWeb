package com.sf.web.jat.response.service.impl;

import java.util.*;

import com.sf.web.jat.response.entity.JatRespDep;
import com.sf.web.jat.response.dao.JatRespDepOrmDao;
import com.sf.web.jat.response.service.JatRespDepService;
import com.sf.web.si.customer.entity.ComCustomerInfo;
import com.sf.web.si.customer.entity.ComFamilyInfo;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.database.ColumnRefInfo;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.util.TranslateUtil.DictItemColumRefType;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.core.Constants;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/05/29
 */
public class JatRespDepServiceImpl implements JatRespDepService
{
	private Logger	logger	= Logger.getLogger(JatRespDepServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private JatRespDepOrmDao jatRespDepOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public JatRespDepOrmDao getJatRespDepOrmDao()
	{
		return jatRespDepOrmDao;
	}

	public void setJatRespDepOrmDao(JatRespDepOrmDao jatRespDepOrmDao)
	{
		this.jatRespDepOrmDao = jatRespDepOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(JatRespDep jatRespDep)
	{
		try
		{
			if(ParameterUtils.isNotValidateId(jatRespDep.getId()))
			{
				//不存在，按照业务需求设定检查逻辑
			}
			else
			{
				JatRespDep oldEntity = this.jatRespDepOrmDao.findOne(jatRespDep.getId());
				AnnotationAccessUtil.mergeEntity(oldEntity, jatRespDep);
			}
			//按照SmartFieldAnnotation检查参数合法性
			AnnotationAccessUtil.validateEntityBean(jatRespDep);
			this.jatRespDepOrmDao.save(jatRespDep);
		}
		catch(Exception e)
		{
			logger.warn("Save jatRespDep Error",e);
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
	@Override
	public String 	saveList(List<JatRespDep> jatRespDepList)
	{
		try{
			this.jatRespDepOrmDao.save(jatRespDepList);
		}
		catch(Exception e)
		{
			logger.warn("Bacth Save jatRespDep Error",e);
			return I18n.message("error.save.validate","对象批量保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 按ID批量读取实体对象<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public List<JatRespDep> 	loadRecords(List<Integer> idList)
	{
		return this.jatRespDepOrmDao.findAll(idList);
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
			List<JatRespDep> list = this.jatRespDepOrmDao.findAll(idList);
			for (JatRespDep jatRespDep:list) {
				List<JatRespDep> memList = this.jatRespDepOrmDao.findById(jatRespDep.getId());
				this.jatRespDepOrmDao.delete(memList);
			}
			this.jatRespDepOrmDao.delete(list);
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
	 @Override
	 public JatRespDep	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.jatRespDepOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public PagingBean	queryRecords(QueryFilter queryFilter)
	{
		String sql = "select e.* from jat_resp_dep e";
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), queryFilter.getPageSize(), queryFilter.getPageIndex());
	 
		List<Map<String,Object>> records = pb.getData();
		Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
		//dictNameFieldNameMap.put("gender", "SMART_INFO_DIC_GENDER");
		dictNameFieldNameMap.put("type", "JAT_RESP_TYPE");
		dictNameFieldNameMap.put("disabled", "JAT_DISABLED");
		dictNameFieldNameMap.put("isKey", "JAT_YES_OR_NO");
		dictNameFieldNameMap.put("singleResp", "JAT_YES_OR_NO");
		dictNameFieldNameMap.put("isSafeResp", "JAT_YES_OR_NO");
		try {
			CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, DictItemColumRefType.ID_COLUMN);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Map<String, ColumnRefInfo> filedRefInfoMap = new HashMap<String,ColumnRefInfo>();
		filedRefInfoMap.put("pid", new ColumnRefInfo("jat_resp_dep", "id", "name", ""));
//		filedRefInfoMap.put("technicalManager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
//		filedRefInfoMap.put("adviseManager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
		try {
			CommonTranslateUtil.translateMultiReferenceColumn(records, null, DictItemColumRefType.ID_COLUMN, filedRefInfoMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pb;
	}

	public List<Map<String, Object>>	loadSysOrg()
	{
		String printFullSql = "select id, name from sys_organization";
		logger.info(printFullSql);
		return this.jdbcDao.queryForList(printFullSql);
	}
}

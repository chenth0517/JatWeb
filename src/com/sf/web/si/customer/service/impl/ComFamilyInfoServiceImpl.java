package com.sf.web.si.customer.service.impl;

import java.util.*;

import com.sf.web.si.customer.entity.ComFamilyInfo;
import com.sf.web.si.customer.dao.ComFamilyInfoOrmDao;
import com.sf.web.si.customer.service.ComFamilyInfoService;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;

/**
 * @创建人    chenth
 * @日期    2020/05/22
 */
public class ComFamilyInfoServiceImpl implements ComFamilyInfoService
{
	private Logger	logger	= Logger.getLogger(ComFamilyInfoServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private ComFamilyInfoOrmDao comFamilyInfoOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public ComFamilyInfoOrmDao getComFamilyInfoOrmDao()
	{
		return comFamilyInfoOrmDao;
	}

	public void setComFamilyInfoOrmDao(ComFamilyInfoOrmDao comFamilyInfoOrmDao)
	{
		this.comFamilyInfoOrmDao = comFamilyInfoOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(ComFamilyInfo comFamilyInfo)
	{
		try
		{
			AnnotationAccessUtil.validateEntityBean(comFamilyInfo);
			this.comFamilyInfoOrmDao.save(comFamilyInfo);
		}
		catch(Exception e)
		{
			logger.warn("Save comFamilyInfo Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ComFamilyInfo> comFamilyInfoList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<ComFamilyInfo> list = this.comFamilyInfoOrmDao.findAll(idList);
			this.comFamilyInfoOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	 public ComFamilyInfo	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.comFamilyInfoOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
		 if(pageSize==null||pageIndex==null) return null;
			String sql = "select e.*, t1.name as cus_name from com_family_info e left join com_customer_info t1 on e. customer_id = t1.id";
			//翻译字典：开始
			PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
			List<Map<String,Object>> records = pb.getData();
			Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
			dictNameFieldNameMap.put("job", "SMART_INFO_DIC_OCCUPATION");
			dictNameFieldNameMap.put("membership", "SMART_INFO_DIC_RELATIONSHIP");
			dictNameFieldNameMap.put("interest", "SMART_INFO_DIC_INTERESTS");
			CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, DictItemColumRefType.ID_COLUMN);
			//翻译字典：结束
			return pb;
	 }
}

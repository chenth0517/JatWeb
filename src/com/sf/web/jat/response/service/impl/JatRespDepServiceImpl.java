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
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;
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
	 * 根据ID改变对象顺序<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	changeOrder(Integer id, Integer isDown)
	{
		JatRespDep currRecord = get(id);
		if(currRecord == null) return "错误：未找到所选的记录。";
		
		String oldIdxStr = currRecord.getIdx();
		if(ParameterUtils.isEmptyOrNull(oldIdxStr)) return "错误：索引为空。";
		
		String oldNumStr = oldIdxStr.substring(oldIdxStr.lastIndexOf(".")+1);
		Integer oldNum = Integer.parseInt(oldNumStr);
		Integer newNum = oldNum;
		Integer tmpNum = 999;
		if(isDown == 1)
		{
			newNum = oldNum+1;
		}
		else
		{
			newNum = oldNum-1;
		}
		String tmpIdxStr = oldIdxStr.substring(0, oldIdxStr.lastIndexOf(".")+1) + tmpNum.toString();
		String newIdxStr = oldIdxStr.substring(0, oldIdxStr.lastIndexOf(".")+1) + newNum.toString();
		
		if (oldNum == 1 && isDown == 0) 
		{
			return "已经是第一条，不能再往上移了。";
		}
		else
		{
			String tmpSql = "select * from jat_resp_dep where idx like '"+newIdxStr+"%'";
			List<Map<String, Object>> records = this.jdbcDao.queryForList(tmpSql);
			if (records.size() == 0 && isDown == 1) return "已经是最后一条不能再往下移了。";
			String sql01 = "update jat_resp_dep set idx = '"+tmpIdxStr+"' where idx = '"+newIdxStr+"';";
			String sql02 = "update jat_resp_dep set idx = concat('"+tmpIdxStr+"',substr(idx,"+String.valueOf(newIdxStr.length()+1)+")) where idx like '"+newIdxStr+".%';";
			String sql03 = "update jat_resp_dep set idx = '"+newIdxStr+"' where idx = '"+oldIdxStr+"';";
			String sql04 = "update jat_resp_dep set idx = concat('"+newIdxStr+"',substr(idx,"+String.valueOf(oldIdxStr.length()+1)+")) where idx like '"+oldIdxStr+".%';";
			String sql05 = "update jat_resp_dep set idx = '"+oldIdxStr+"' where idx = '"+tmpIdxStr+"';";
			String sql06 = "update jat_resp_dep set idx = concat('"+oldIdxStr+"',substr(idx,"+String.valueOf(tmpIdxStr.length()+1)+")) where idx like '"+tmpIdxStr+".%';";
			try {
				logger.info(sql01);
				jdbcDao.update(sql01);
				logger.info(sql02);
				jdbcDao.update(sql02);
				logger.info(sql03);
				jdbcDao.update(sql03);
				logger.info(sql04);
				jdbcDao.update(sql04);
				logger.info(sql05);
				jdbcDao.update(sql05);
				logger.info(sql06);
				jdbcDao.update(sql06);
			} catch (Exception e) {			
				e.printStackTrace();
			}
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
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(), queryFilter.getConditionValues(), 
				queryFilter.getPageSize(), queryFilter.getPageIndex(), "idx");
	 
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

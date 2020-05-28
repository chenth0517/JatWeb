package com.sf.web.si.customer.service.impl;

import java.util.*;

import com.sf.web.si.customer.entity.ComCustomerInfo;
import com.sf.web.si.customer.entity.ComFamilyInfo;
import com.sf.web.si.customer.dao.ComCustomerInfoOrmDao;
import com.sf.web.si.customer.dao.ComFamilyInfoOrmDao;
import com.sf.web.si.customer.service.ComCustomerInfoService;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.database.ColumnRefInfo;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;
import com.smartframework.web.system.index.entity.UserLoginRegister;
import com.smartframework.web.system.utility.entity.SysDictDef;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public class ComCustomerInfoServiceImpl implements ComCustomerInfoService
{
	private Logger	logger	= Logger.getLogger(ComCustomerInfoServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private ComCustomerInfoOrmDao comCustomerInfoOrmDao;
	
	private ComFamilyInfoOrmDao comFamilyInfoOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public ComCustomerInfoOrmDao getComCustomerInfoOrmDao()
	{
		return comCustomerInfoOrmDao;
	}

	public void setComCustomerInfoOrmDao(ComCustomerInfoOrmDao comCustomerInfoOrmDao)
	{
		this.comCustomerInfoOrmDao = comCustomerInfoOrmDao;
	}
	
	public ComFamilyInfoOrmDao getComFamilyInfoOrmDao() {
		return comFamilyInfoOrmDao;
	}

	public void setComFamilyInfoOrmDao(ComFamilyInfoOrmDao comFamilyInfoOrmDao) {
		this.comFamilyInfoOrmDao = comFamilyInfoOrmDao;
	}

	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(ComCustomerInfo comCustomerInfo)
	{
		try
		{
			String newNote = comCustomerInfo.getVisitNoteNew().trim();
			if (newNote.length()>0)
			{
				newNote = DateUtil.format(new Date()) + "\n" + newNote + "\n";
				comCustomerInfo.setVisitNote(newNote+comCustomerInfo.getVisitNote());
			}
			if (null != comCustomerInfo.getId())
			{
				ComCustomerInfo old = this.comCustomerInfoOrmDao.findOne(comCustomerInfo.getId());
				if(null != old)
				{
					AnnotationAccessUtil.mergeEntity(old, comCustomerInfo);
				}
			}
			AnnotationAccessUtil.validateEntityBean(comCustomerInfo);
			this.comCustomerInfoOrmDao.save(comCustomerInfo);
		}
		catch(Exception e)
		{
			logger.warn("Save comCustomerInfo Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<ComCustomerInfo> comCustomerInfoList)
	{
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<ComCustomerInfo> list = this.comCustomerInfoOrmDao.findAll(idList);
			for (ComCustomerInfo comCustomerInfo:list) {
				List<ComFamilyInfo> memList = this.comFamilyInfoOrmDao.findByCustomerId(comCustomerInfo.getId());
				this.comFamilyInfoOrmDao.delete(memList);
			}
			this.comCustomerInfoOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	public ComCustomerInfo	get(Integer id)
	{
		if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
		return this.comCustomerInfoOrmDao.findOne(id);
	}
	 
	/**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/28<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(Integer currUserId,Integer fastFilter,QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	if(pageSize==null||pageIndex==null) return null;
	 	
	 	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		String sqlteam = "select count(*) as count from oms_team_user_link where user_id = " + currUserId + " and team_id = 3";
		list = this.jdbcDao.queryForList(sqlteam);
		String sql = "select e.*, t1.name as team_name, t2.real_name from com_customer_info e left join oms_team_group t1 on e.resp_group = t1.id left join sys_user t2 on t1.manager = t2.id";
		if (list.get(0).get("count").toString().equalsIgnoreCase("1"))//顾问的数据原本就需要过滤
		{
			queryFilter.addNumberFieldEqualCondition("e.advise_manager", currUserId);
		}
		else//顾问以外的情况，参照客服
		{
			if(fastFilter != null && fastFilter == 1)
			{
				queryFilter.addNumberFieldEqualCondition("e.service_manager", currUserId);
			}
		}
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
		List<Map<String,Object>> records = pb.getData();
		Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
		dictNameFieldNameMap.put("gender", "SMART_INFO_DIC_GENDER");
		dictNameFieldNameMap.put("job", "SMART_INFO_DIC_OCCUPATION");
		dictNameFieldNameMap.put("interest", "SMART_INFO_DIC_INTERESTS");
		dictNameFieldNameMap.put("project", "SMART_INFO_DIC_PROJECT");
		dictNameFieldNameMap.put("progress", "SMART_INFO_DIC_PROGRESS");
		CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, DictItemColumRefType.ID_COLUMN);
		
		Map<String, ColumnRefInfo> filedRefInfoMap = new HashMap<String,ColumnRefInfo>();
		filedRefInfoMap.put("serviceManager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
		filedRefInfoMap.put("technicalManager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
		filedRefInfoMap.put("adviseManager", new ColumnRefInfo("sys_user", "id", "real_name", ""));
		CommonTranslateUtil.translateMultiReferenceColumn(records, null, DictItemColumRefType.ID_COLUMN, filedRefInfoMap);
		return pb;
	}
	 
	@Override
	public List<Map<String,Object>> getCustomersForTimingNotify(int dayInterval)
	{
	 	String sql = "select c.name as customer_name, 1 as timing, DATE_FORMAT(c.birthday,'%m月%d日') as customer_birthday, u.id as user_id, u.email as service_email from com_customer_info c left join sys_user u on c.service_manager = u.id where c.last_visit_date is null or (datediff(curdate(), date(c.last_visit_date)) > "+dayInterval+") order by service_email";
	 	List<Map<String,Object>> records = jdbcDao.queryForList(sql);
		return records;
	}
	
	@Override
	public List<Map<String,Object>> getCustomersForBirthdayNotify(int dayAhead)
	{
		String sql = "select c.name as customer_name, 0 as timing, DATE_FORMAT(c.birthday,'%m月%d日') as customer_birthday, u.id as user_id, u.email as service_email from com_customer_info c left join sys_user u on c.service_manager = u.id where datediff(date(CONCAT(DATE_FORMAT(now(),'%Y'),DATE_FORMAT(birthday,'-%m-%d'))),now()) = "+dayAhead+" order by service_email";
	 	List<Map<String,Object>> records = jdbcDao.queryForList(sql);
		return records;
	}
	
	public List<Map<String,Object>> getCustomersForBirthdayNotifyAhead(int dayAhead)
	{
		String sql = "select c.name as customer_name, 0 as timing, DATE_FORMAT(c.birthday,'%m月%d日') as customer_birthday, u.id as user_id, u.email as service_email from com_customer_info c left join sys_user u on c.service_manager = u.id where datediff(date(CONCAT(DATE_FORMAT(now(),'%Y'),DATE_FORMAT(birthday,'-%m-%d'))),now()) between 0 and "+dayAhead+" order by service_email";
	 	List<Map<String,Object>> records = jdbcDao.queryForList(sql);
		return records;
	}
	
	/**
	 * 更新已拜访列<br>
	 * 添加时间:2018/03/14<br>
	 * @param 
	 * @return
	 */
	@Override
	public String visit(List<Integer> idList)
	{
		try
		{
			List<ComCustomerInfo> list = this.comCustomerInfoOrmDao.findAll(idList);
			for (ComCustomerInfo comCustomerInfo:list) {
				comCustomerInfo.setLastVisitDate(new Date());
			}
			this.comCustomerInfoOrmDao.save(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 获取待办事项<br>
	 * 添加时间:2018/03/15<br>
	 *@param 
	 *@return
	 */
	@Override
	public List<Map<String,Object>> getTodoList(int dayInterval, int dayAhead, int dayCurrent)
	{
		List<Map<String,Object>> allTodoList = getCustomersForBirthdayNotifyAhead(7);
		allTodoList.addAll(getCustomersForTimingNotify(90));
		//删除其中与当前客服无关的事项
		int size = allTodoList.size();
		for (int i=0; i<size; i++)
		{
			Map<String,Object> matter = allTodoList.get(i);
			Object obj = matter.get("userId");
			if (obj == null)
			{
				allTodoList.remove(i);
				i--;
				size--;
			}
			else if ((int)matter.get("userId") != UserLoginRegister.getCurrentUser().getId())
			{
				allTodoList.remove(i);
				i--;
				size--;
			}
		}
		return allTodoList;
	}
}

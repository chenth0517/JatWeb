package com.sf.web.jat.addition.service.impl;

import java.util.*;

import com.sf.web.jat.addition.service.JatSysAdditionService;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.web.core.database.ColumnRefInfo;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.ParameterUtils;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/05/29
 */
public class JatSysAdditionServiceImpl implements JatSysAdditionService
{
	private Logger	logger	= Logger.getLogger(JatSysAdditionServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}

	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/29<br>
	 * @param 
	 * @return
	 */
	@Override
	public Map<String, String> queryRoleListString()
	{
		String sql = "select ru.user_id, r.name from sys_role r inner join sys_role_user_link ru on r.id = ru.role_id order by ru.user_id;";
		logger.info(sql);
		List<Map<String,Object>> records = jdbcDao.queryForList(sql);
		Map<String, String> result = new HashMap<String, String>();
		for (int i=0; i<records.size(); i++)
		{
			String userId = records.get(i).get("userId").toString();
			String name = records.get(i).get("name").toString();
			if (result.get(userId) == null)
			{
				result.put(userId, name);
			}
			else
			{
				result.put(userId, result.get(userId) + "/" + name);
			}
		}
		return result;
	}

}

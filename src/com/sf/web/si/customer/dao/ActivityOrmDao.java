package com.sf.web.si.customer.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.customer.entity.Activity;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface ActivityOrmDao extends OrmDao<Activity,  Integer>
{
	public List<Activity> findByName(String name);
	
	public List<Activity> findByDescription(String description);
	
	public List<Activity> findByBeginTime(Date beginTime);
	
	public List<Activity> findByDays(Integer days);
	
	public List<Activity> findByPlace(String place);
	
	public List<Activity> findByAddress(String address);
	
	public List<Activity> findByManager(Integer manager);
	
	public List<Activity> findByCost(Float cost);
	
	public List<Activity> findByStatus(Integer status);
	
}

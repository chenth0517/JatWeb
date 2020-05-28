package com.sf.web.si.customer.dao;

import java.util.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.customer.entity.ComCustomerInfo;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface ComCustomerInfoOrmDao extends OrmDao<ComCustomerInfo,  Integer>
{
	public List<ComCustomerInfo> findByName(String name);
	
	public List<ComCustomerInfo> findByPhone(String phone);
	
	public List<ComCustomerInfo> findByEmail(String email);
	
	public List<ComCustomerInfo> findByTel(String tel);
	
	public List<ComCustomerInfo> findByRespGroup(Integer respGroup);
	
	public List<ComCustomerInfo> findByRegisterDate(Date registerDate);
	
	public List<ComCustomerInfo> findByRespManager(Integer respManager);
	
	public List<ComCustomerInfo> findByGender(Integer gender);
	
	public List<ComCustomerInfo> findByAdviseManager(Integer adviseManager);
	
	public List<ComCustomerInfo> findByServiceManager(Integer serviceManager);
	
	public List<ComCustomerInfo> findByTechnicalManager(Integer technicalManager);
	
	public List<ComCustomerInfo> findByBirthday(Date birthday);
	
	public List<ComCustomerInfo> findBySpecialDay(Date specialDay);
	
	public List<ComCustomerInfo> findByHomeAddr(String homeAddr);
	
	public List<ComCustomerInfo> findByOfficeAddr(String officeAddr);
	
	public List<ComCustomerInfo> findByInterest(String interest);
	
}

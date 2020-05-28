package com.sf.web.si.customer.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.customer.entity.ComFamilyInfo;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface ComFamilyInfoOrmDao extends OrmDao<ComFamilyInfo,  Integer>
{
	public List<ComFamilyInfo> findByMembership(Integer membership);
	
	public List<ComFamilyInfo> findByName(String name);
	
	public List<ComFamilyInfo> findByPhone(String phone);
	
	public List<ComFamilyInfo> findByJob(String job);
	
	public List<ComFamilyInfo> findByInterest(String interest);
	
	public List<ComFamilyInfo> findByCustomerId(Integer customerId);
	
	public List<ComFamilyInfo> findByPhotoFile(String photoFile);
	
}

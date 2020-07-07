package com.sf.web.jat.response.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.jat.response.entity.JatRespDep;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/05/29
 */
public interface JatRespDepOrmDao extends OrmDao<JatRespDep,  Integer>
{
	public List<JatRespDep> findByName(String name);
	
	public List<JatRespDep> findByDescription(String description);
	
	public List<JatRespDep> findByDisabled(Integer disabled);
	
	public List<JatRespDep> findByType(String type);
	
	public List<JatRespDep> findByIsKey(Integer isKey);
	
	public List<JatRespDep> findBySingleResp(Integer singleResp);
	
	public List<JatRespDep> findByIsSafeResp(Integer isSafeResp);
	
}

package com.sf.web.si.config.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.config.entity.OmsTeamGroup;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface OmsTeamGroupOrmDao extends OrmDao<OmsTeamGroup,  Integer>
{
	public List<OmsTeamGroup> findByName(String name);
	
	//public List<OmsTeamGroup> findByNameAndDisabled(String name,Integer disabled);
	
	public List<OmsTeamGroup> findByManager(Integer manager);
	
	//public List<OmsTeamGroup> findByManagerAndDisabled(Integer manager,Integer disabled);
	
	//public List<OmsTeamGroup> findByPidAndDisabled(Integer pid,Integer disabled);
	

	@Modifying
	@Query("UPDATE OmsTeamGroup p SET disabled=0 WHERE p.id=:id")
	public Integer enableRecord(Integer id);
	
}

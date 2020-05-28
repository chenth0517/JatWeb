package com.sf.web.si.config.dao;

import java.util.*;

import org.springframework.data.jpa.repository.*;

import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.config.entity.OmsTeamUserLink;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface OmsTeamUserLinkOrmDao extends OrmDao<OmsTeamUserLink,  Integer>
{
	public List<OmsTeamUserLink> findByUserId(Integer userId);
	
	//public List<OmsTeamUserLink> findByUserIdAndDisabled(Integer userId,Integer disabled);
	
	public List<OmsTeamUserLink> findByTeamId(Integer teamId);
	
	//public List<OmsTeamUserLink> findByTeamIdAndDisabled(Integer teamId,Integer disabled);
	
	public List<OmsTeamUserLink> findByUserIdIn(List<Integer> userIds);
	public List<OmsTeamUserLink> findByTeamIdIn(List<Integer> teamIds);

	@Modifying
	@Query("UPDATE OmsTeamUserLink p SET disabled=0 WHERE p.id=:id")
	public Integer enableRecord(Integer id);
	
}

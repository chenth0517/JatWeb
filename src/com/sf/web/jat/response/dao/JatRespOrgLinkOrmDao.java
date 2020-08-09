package com.sf.web.jat.response.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.jat.response.entity.JatRespOrgLink;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/08/08
 */
public interface JatRespOrgLinkOrmDao extends OrmDao<JatRespOrgLink,  Integer>
{
	public List<JatRespOrgLink> findByRespId(Integer respId);
	
	public List<JatRespOrgLink> findByType(Integer type);
	
	public List<JatRespOrgLink> findByOrgId(Integer orgId);
	
}

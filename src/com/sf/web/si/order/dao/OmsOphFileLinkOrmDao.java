package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOphFileLink;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
public interface OmsOphFileLinkOrmDao extends OrmDao<OmsOphFileLink,  Integer>
{
	public List<OmsOphFileLink> findByFileId(String fileId);
	
	public List<OmsOphFileLink> findByHistoryId(Integer historyId);

	public List<OmsOphFileLink> findByHistoryIdIn(List<Integer> historyIds);
}

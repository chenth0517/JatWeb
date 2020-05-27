package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOrderFileLink;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
public interface OmsOrderFileLinkOrmDao extends OrmDao<OmsOrderFileLink,  Integer>
{
	public List<OmsOrderFileLink> findByFileId(String fileId);
	
	public List<OmsOrderFileLink> findByOrderId(Integer orderId);

	public List<OmsOrderFileLink> findByOrderIdIn(List<Integer> orderIds);
}

package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOrderTagLink;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
public interface OmsOrderTagLinkOrmDao extends OrmDao<OmsOrderTagLink,  Integer>
{
	public List<OmsOrderTagLink> findByTagId(Integer tagId);
	
	public List<OmsOrderTagLink> findByOrderId(Integer orderId);

	public List<OmsOrderTagLink> findByOrderIdIn(List<Integer> orderIds);
}

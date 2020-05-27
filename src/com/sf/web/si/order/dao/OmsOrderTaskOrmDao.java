package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOrderTask;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/01/02
 */
public interface OmsOrderTaskOrmDao extends OrmDao<OmsOrderTask,  Integer>
{
	public List<OmsOrderTask> findByName(String name);
	
	public List<OmsOrderTask> findByHolderUserId(Integer holderUserId);
	
	public List<OmsOrderTask> findByCreateTime(Date createTime);
	
	public List<OmsOrderTask> findByDueDate(Date dueDate);
	
	public List<OmsOrderTask> findByContent(String content);
	
	public List<OmsOrderTask> findByOrdeId(Integer ordeId);

	public OmsOrderTask findTopByOrderByIdDesc();

	@Query("select a.ordeId from OmsOrderTask a where a.holderUserId = :holderUserId")
	public List<Integer> findOrderIdByHolderUserId(Integer holderUserId);

	
}

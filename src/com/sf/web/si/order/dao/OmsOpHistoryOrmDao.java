package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOpHistory;

/**
 * @创建人    chenth
 * @日期    2020/05/28
 */
public interface OmsOpHistoryOrmDao extends OrmDao<OmsOpHistory,  Integer>
{
	public List<OmsOpHistory> findByOrderId(Integer orderId);
	
	public List<OmsOpHistory> findByRemark(String remark);
	
	public List<OmsOpHistory> findByResult(Integer result);

	public List<OmsOpHistory> findByTaskId(Integer taskId);

	public List<OmsOpHistory> findByTaskIdAndUserId(Integer taskId, Integer userId);

	public List<OmsOpHistory> findByTaskIdIn(List<Integer> taskIds);
}

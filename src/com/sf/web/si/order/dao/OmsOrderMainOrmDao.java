package com.sf.web.si.order.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.order.entity.OmsOrderMain;

/**
 * @创建人    chenth
 * @日期    2020/05/25
 */
public interface OmsOrderMainOrmDao extends OrmDao<OmsOrderMain,  Integer>
{
	public List<OmsOrderMain> findByTopic(String topic);
	
	
	public List<OmsOrderMain> findByContent(String content);
	
	
	public List<OmsOrderMain> findByCustomerId(Integer customerId);
	
	
	public List<OmsOrderMain> findByRespUser(Integer respUser);
	
	
	public List<OmsOrderMain> findByStatus(Integer status);
	
	
	public List<OmsOrderMain> findByPriority(Integer priority);
	
	
	public List<OmsOrderMain> findByCreateTime(Date createTime);
	
	
	public List<OmsOrderMain> findByInstanceId(String instanceId);
	
	
	public List<OmsOrderMain> findByCloseTime(Date closeTime);

	public  OmsOrderMain findFirstByOrderByIdDesc();

	@Modifying
	@Query("UPDATE OmsOrderMain p SET disabled=0 WHERE p.id=:id")
	public Integer enableRecord(Integer id);

}

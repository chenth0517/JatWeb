package com.sf.web.si.customer.dao;

import java.util.*;
import org.springframework.data.jpa.repository.*;
import com.smartframework.core.dao.OrmDao;
import com.sf.web.si.customer.entity.ActivityMember;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/05/30
 */
public interface ActivityMemberOrmDao extends OrmDao<ActivityMember,  Integer>
{
	public List<ActivityMember> findByActivityId(Integer activityId);
	
	public List<ActivityMember> findByCustomerId(Integer customerId);
	
	public List<ActivityMember> findByInvited(Integer invited);
	
	public List<ActivityMember> findByConfirm(Integer confirm);
	
	public List<ActivityMember> findByReject(Integer reject);
	
	public List<ActivityMember> findBySeats(Integer seats);
	
	public List<ActivityMember> findByAppear(Integer appear);
	
	public List<ActivityMember> findByComment(String comment);
	
}

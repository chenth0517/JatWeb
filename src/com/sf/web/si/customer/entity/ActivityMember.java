package com.sf.web.si.customer.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * activity_member
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/05/30
 */
@Entity
@Table(name = "activity_member")
@SmartComment("activity_member")
public class ActivityMember  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_ACTIVITY_MEMBER")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "activity_id" ,length = 10)  
	@SmartFieldAnnotation(description="活动编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer activityId;
    
    
	@Column(name = "customer_id" ,length = 10)  
	@SmartFieldAnnotation(description="客户编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer customerId;
    
    
	@Column(name = "invited" ,length = 10)  
	@SmartFieldAnnotation(description="已请",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer invited;
    
    
	@Column(name = "confirm" ,length = 10)  
	@SmartFieldAnnotation(description="已确认",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer confirm;
    
    
	@Column(name = "reject" ,length = 10)  
	@SmartFieldAnnotation(description="已拒绝",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer reject;
    
    
	@Column(name = "seats" ,length = 10)  
	@SmartFieldAnnotation(description="预留人数",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer seats;
    
    
	@Column(name = "appear" ,length = 10)  
	@SmartFieldAnnotation(description="到场人数",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer appear;
    
    
	@Column(name = "comment" ,length = 256)  
	@SmartFieldAnnotation(description="备注",checkValueRange=false ,minLength=0,maxLength = 256)
    private String comment;
    
    

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setActivityId(Integer activityId)
    {
        this.activityId = activityId ;
    }
    
    public Integer getActivityId()
    {
        return this.activityId ;
    }

    
    public void setCustomerId(Integer customerId)
    {
        this.customerId = customerId ;
    }
    
    public Integer getCustomerId()
    {
        return this.customerId ;
    }

    
    public void setInvited(Integer invited)
    {
        this.invited = invited ;
    }
    
    public Integer getInvited()
    {
        return this.invited ;
    }

    
    public void setConfirm(Integer confirm)
    {
        this.confirm = confirm ;
    }
    
    public Integer getConfirm()
    {
        return this.confirm ;
    }

    
    public void setReject(Integer reject)
    {
        this.reject = reject ;
    }
    
    public Integer getReject()
    {
        return this.reject ;
    }

    
    public void setSeats(Integer seats)
    {
        this.seats = seats ;
    }
    
    public Integer getSeats()
    {
        return this.seats ;
    }

    
    public void setAppear(Integer appear)
    {
        this.appear = appear ;
    }
    
    public Integer getAppear()
    {
        return this.appear ;
    }

    
    public void setComment(String comment)
    {
        this.comment = comment ;
    }
    
    public String getComment()
    {
        return this.comment ;
    }

    
}

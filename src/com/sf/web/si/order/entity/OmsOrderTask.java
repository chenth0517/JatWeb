package com.sf.web.si.order.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_order_task
 * @创建人    chenth
 * @日期    2020/05/20
 */
@Entity
@Table(name = "oms_order_task")
@SmartComment("oms_order_task")
public class OmsOrderTask  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_ORDER_TASK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="任务编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "name" ,length = 128)  
	@SmartFieldAnnotation(description="名称",checkValueRange=false ,minLength=0,maxLength = 128)
    private String name;
    
    
	@Column(name = "holder_user_id" ,length = 10)  
	@SmartFieldAnnotation(description="任务受理人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer holderUserId;
    
    
	@Column(name = "create_time" ,length = 19)  
	@SmartFieldAnnotation(description="创建时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date createTime;

    @Column(name = "begin_time" ,length = 19)
    @SmartFieldAnnotation(description="时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date beginTime;

	@Column(name = "due_date" ,length = 19)  
	@SmartFieldAnnotation(description="最后期限",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date dueDate;
    
    
	@Column(name = "content" ,length = 512)  
	@SmartFieldAnnotation(description="处理内容",checkValueRange=false ,minLength=0,maxLength = 512)
    private String content;
    
    
	@Column(name = "orde_id" ,length = 10)  
	@SmartFieldAnnotation(description="工单编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer ordeId;
    


    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setName(String name)
    {
        this.name = name ;
    }
    
    public String getName()
    {
        return this.name ;
    }

    
    public void setHolderUserId(Integer holderUserId)
    {
        this.holderUserId = holderUserId ;
    }
    
    public Integer getHolderUserId()
    {
        return this.holderUserId ;
    }

    
    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime ;
    }
    
    public Date getCreateTime()
    {
        return this.createTime ;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public void setDueDate(Date dueDate)
    {
        this.dueDate = dueDate ;
    }
    
    public Date getDueDate()
    {
        return this.dueDate ;
    }

    
    public void setContent(String content)
    {
        this.content = content ;
    }
    
    public String getContent()
    {
        return this.content ;
    }

    
    public void setOrdeId(Integer ordeId)
    {
        this.ordeId = ordeId ;
    }
    
    public Integer getOrdeId()
    {
        return this.ordeId ;
    }


}

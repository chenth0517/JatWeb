package com.sf.web.si.customer.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * activity
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/05/30
 */
@Entity
@Table(name = "activity")
@SmartComment("activity")
public class Activity  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_ACTIVITY")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "name" ,length = 128)  
	@SmartFieldAnnotation(description="名称",checkValueRange=false ,minLength=0,maxLength = 128)
    private String name;
    
    
	@Column(name = "description" ,length = 4096)  
	@SmartFieldAnnotation(description="描述",checkValueRange=false ,minLength=0,maxLength = 4096)
    private String description;
    
    
	@Column(name = "begin_time" ,length = 19)  
	@SmartFieldAnnotation(description="开始时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date beginTime;
    
    
	@Column(name = "days" ,length = 10)  
	@SmartFieldAnnotation(description="持续天数",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer days;
    
    
	@Column(name = "place" ,length = 256)  
	@SmartFieldAnnotation(description="地点",checkValueRange=false ,minLength=0,maxLength = 256)
    private String place;
    
    
	@Column(name = "address" ,length = 256)  
	@SmartFieldAnnotation(description="地址",checkValueRange=false ,minLength=0,maxLength = 256)
    private String address;
    
    
	@Column(name = "manager" ,length = 10)  
	@SmartFieldAnnotation(description="负责人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer manager;
    
    
	@Column(name = "cost" ,length = 10)  
	@SmartFieldAnnotation(description="开销",checkValueRange=false)
    private Float cost;
    
    
	@Column(name = "status" ,length = 10)  
	@SmartFieldAnnotation(description="活动状态",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer status;
    
    

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

    
    public void setDescription(String description)
    {
        this.description = description ;
    }
    
    public String getDescription()
    {
        return this.description ;
    }

    
    public void setBeginTime(Date beginTime)
    {
        this.beginTime = beginTime ;
    }
    
    public Date getBeginTime()
    {
        return this.beginTime ;
    }

    
    public void setDays(Integer days)
    {
        this.days = days ;
    }
    
    public Integer getDays()
    {
        return this.days ;
    }

    
    public void setPlace(String place)
    {
        this.place = place ;
    }
    
    public String getPlace()
    {
        return this.place ;
    }

    
    public void setAddress(String address)
    {
        this.address = address ;
    }
    
    public String getAddress()
    {
        return this.address ;
    }

    
    public void setManager(Integer manager)
    {
        this.manager = manager ;
    }
    
    public Integer getManager()
    {
        return this.manager ;
    }

    
    public void setCost(Float cost)
    {
        this.cost = cost ;
    }
    
    public Float getCost()
    {
        return this.cost ;
    }

    
    public void setStatus(Integer status)
    {
        this.status = status ;
    }
    
    public Integer getStatus()
    {
        return this.status ;
    }

    
}

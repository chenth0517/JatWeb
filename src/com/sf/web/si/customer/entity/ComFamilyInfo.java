package com.sf.web.si.customer.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.web.core.util.ParameterUtils;
import com.smartframework.core.annotation.SmartComment;

import java.util.*;
/**
 * com_family_info
 * @创建人    chenth
 * @日期    2020/05/22
 */
@Entity
@Table(name = "com_family_info")
@SmartComment("com_family_info")
public class ComFamilyInfo  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_COM_FAMILY_INFO")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="成员编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "membership" ,length = 10)  
	@SmartFieldAnnotation(description="成员关系（1-户主，2-夫妻，3-子女，4-兄妹，5-父母）",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer membership;
    
    
	@Column(name = "name" ,length = 64)  
	@SmartFieldAnnotation(description="姓名",checkValueRange=false ,minLength=0,maxLength = 64)
    private String name;
    
    
	@Column(name = "phone" ,length = 32)  
	@SmartFieldAnnotation(description="联系电话",checkValueRange=false ,minLength=0,maxLength = 32)
    private String phone;
    
    
	@Column(name = "job" ,length = 10)  
	@SmartFieldAnnotation(description="职业",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer job;
    
    
	@Column(name = "interest" ,length = 128)  
	@SmartFieldAnnotation(description="兴趣爱好",checkValueRange=false ,minLength=0,maxLength = 128)
    private String interest;
    
    
	@Column(name = "customer_id" ,length = 10)  
	@SmartFieldAnnotation(description="客户编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer customerId;
    
    
	@Column(name = "photo_file" ,length = 64)  
	@SmartFieldAnnotation(description="证件文件扫描件",checkValueRange=false ,minLength=0,maxLength = 64)
    private String photoFile;
    
	@Column(name = "birthday" ,length = 19)  
	@SmartFieldAnnotation(description="生日",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date birthday;
    
	

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setMembership(Integer membership)
    {
        this.membership = membership ;
    }
    
    public Integer getMembership()
    {
        return this.membership ;
    }

    
    public void setName(String name)
    {
        this.name = name ;
    }
    
    public String getName()
    {
        return this.name ;
    }

    
    public void setPhone(String phone)
    {
        this.phone = phone ;
    }
    
    public String getPhone()
    {
        return this.phone ;
    }

    
    public void setJob(Integer job)
    {
        this.job = job ;
    }
    
    public Integer getJob()
    {
        return this.job ;
    }

    
    public void setInterest(List<String> interest)
    {
        this.interest = ParameterUtils.join(interest.toArray(), ",") ;
    }

    public String getInterest()
    {
        return this.interest ;
    }

    
    public void setCustomerId(Integer customerId)
    {
        this.customerId = customerId ;
    }
    
    public Integer getCustomerId()
    {
        return this.customerId ;
    }

    
    public void setPhotoFile(String photoFile)
    {
        this.photoFile = photoFile ;
    }
    
    public String getPhotoFile()
    {
        return this.photoFile ;
    }

    public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	
}

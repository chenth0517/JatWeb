package com.sf.web.jat.response.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * jat_resp_dep
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/05/29
 */
@Entity
@Table(name = "jat_resp_dep")
@SmartComment("jat_resp_dep")
public class JatRespDep  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_JAT_RESP_DEP")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="职责编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "name" ,length = 255)  
	@SmartFieldAnnotation(description="职责名称",checkValueRange=false ,minLength=0,maxLength = 255)
    private String name;
    
    
	@Column(name = "description" ,length = 255)  
	@SmartFieldAnnotation(description="职责描述",checkValueRange=false ,minLength=0,maxLength = 255)
    private String description;
    
    
	@Column(name = "disabled" ,length = 10)  
	@SmartFieldAnnotation(description="启用该职责",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer disabled;
    
    
	@Column(name = "type" ,length = 255)  
	@SmartFieldAnnotation(description="1代表部门责任，2代表岗位责任",checkValueRange=false ,minLength=0,maxLength = 255)
    private String type;
    
    
	@Column(name = "is_key" ,length = 10)  
	@SmartFieldAnnotation(description="is_key",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer isKey;
    
    
	@Column(name = "single_resp" ,length = 10)  
	@SmartFieldAnnotation(description="single_resp",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer singleResp;
    
    
	@Column(name = "is_safe_resp" ,length = 10)  
	@SmartFieldAnnotation(description="is_safe_resp",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer isSafeResp;
    
    

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

    
    public void setDisabled(Integer disabled)
    {
        this.disabled = disabled ;
    }
    
    public Integer getDisabled()
    {
        return this.disabled ;
    }

    
    public void setType(String type)
    {
        this.type = type ;
    }
    
    public String getType()
    {
        return this.type ;
    }

    
    public void setIsKey(Integer isKey)
    {
        this.isKey = isKey ;
    }
    
    public Integer getIsKey()
    {
        return this.isKey ;
    }

    
    public void setSingleResp(Integer singleResp)
    {
        this.singleResp = singleResp ;
    }
    
    public Integer getSingleResp()
    {
        return this.singleResp ;
    }

    
    public void setIsSafeResp(Integer isSafeResp)
    {
        this.isSafeResp = isSafeResp ;
    }
    
    public Integer getIsSafeResp()
    {
        return this.isSafeResp ;
    }

    
}

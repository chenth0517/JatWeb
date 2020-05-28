package com.sf.web.si.config.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * com_tag_def
 * @创建人    chenth
 * @日期    2020/05/28
 */
@Entity
@Table(name = "com_tag_def")
@SmartComment("com_tag_def")
public class ComTagDef  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_COM_TAG_DEF")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="标签ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "name" ,length = 64)  
	@SmartFieldAnnotation(description="标签描述",checkValueRange=false ,minLength=0,maxLength = 64)
    private String name;
    
    

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

    
}

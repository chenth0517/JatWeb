package com.sf.web.si.config.entity;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_team_group
 * @创建人    chenth
 * @日期    2020/05/28
 */
@Entity
@Table(name = "oms_team_group")
@SmartComment("oms_team_group")
public class OmsTeamGroup
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_TEAM_GROUP")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="服务团队编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "name" ,length = 64)  
	@SmartFieldAnnotation(description="团队名称",checkValueRange=false ,minLength=0,maxLength = 64)
    private String name;
    
    
	@Column(name = "manager" ,length = 10)  
	@SmartFieldAnnotation(description="责任人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer manager;
    
 

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

    
    public void setManager(Integer manager)
    {
        this.manager = manager ;
    }
    
    public Integer getManager()
    {
        return this.manager ;
    }

    
}

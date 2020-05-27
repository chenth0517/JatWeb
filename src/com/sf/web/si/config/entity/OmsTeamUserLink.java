package com.sf.web.si.config.entity;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_team_user_link
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/28
 */
@Entity
@Table(name = "oms_team_user_link")
@SmartComment("oms_team_user_link")
public class OmsTeamUserLink
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_TEAM_USER_LINK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="序号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "user_id" ,length = 10)  
	@SmartFieldAnnotation(description="用户ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer userId;
    
    
	@Column(name = "team_id" ,length = 10)  
	@SmartFieldAnnotation(description="小组ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer teamId;
    
    

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setUserId(Integer userId)
    {
        this.userId = userId ;
    }
    
    public Integer getUserId()
    {
        return this.userId ;
    }

    
    public void setTeamId(Integer teamId)
    {
        this.teamId = teamId ;
    }
    
    public Integer getTeamId()
    {
        return this.teamId ;
    }

    
}

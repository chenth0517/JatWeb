package com.sf.web.jat.response.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * jat_resp_org_link
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/08/08
 */
@Entity
@Table(name = "jat_resp_org_link")
@SmartComment("jat_resp_org_link")
public class JatRespOrgLink  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_JAT_RESP_ORG_LINK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "resp_id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="职责编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer respId;
    
    
	@Column(name = "type" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="类型：1-负责 2-参与 3-相关",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer type;
    
    
	@Column(name = "org_id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="组织编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer orgId;
    
    

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setRespId(Integer respId)
    {
        this.respId = respId ;
    }
    
    public Integer getRespId()
    {
        return this.respId ;
    }

    
    public void setType(Integer type)
    {
        this.type = type ;
    }
    
    public Integer getType()
    {
        return this.type ;
    }

    
    public void setOrgId(Integer orgId)
    {
        this.orgId = orgId ;
    }
    
    public Integer getOrgId()
    {
        return this.orgId ;
    }

    
}

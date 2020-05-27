package com.sf.web.si.order.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.sf.web.si.config.entity.ComTagDef;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;

/**
 * oms_order_tag_link
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
@Entity
@Table(name = "oms_order_tag_link")
@SmartComment("oms_order_tag_link")
public class OmsOrderTagLink  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_ORDER_TAG_LINK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="序号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "tag_id" ,length = 10)  
	@SmartFieldAnnotation(description="标签ID",checkValueRange=false ,minValue=0,maxValue = 0,referenceTable="com_tag_def",referenceColumn="id",referenceDisplayColumn="id")
    private Integer tagId;
    /*
    @OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="tag_id")
    */
    @Transient
    private ComTagDef comTagDef;
    
    
	@Column(name = "order_id" ,length = 10)  
	@SmartFieldAnnotation(description="工单编号",checkValueRange=false ,minValue=0,maxValue = 0,referenceTable="oms_order_main",referenceColumn="id",referenceDisplayColumn="id")
    private Integer orderId;
    /*
    @OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="order_id")
    */
    @Transient
    private OmsOrderMain omsOrderMain;
    
    

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setTagId(Integer tagId)
    {
        this.tagId = tagId ;
    }
    
    public Integer getTagId()
    {
        return this.tagId ;
    }

    public void setComTagDef(ComTagDef comTagDef)
    {
        this.comTagDef = comTagDef ;
    }
    
    public ComTagDef getComTagDef()
    {
        return this.comTagDef ;
    }
    public void setOrderId(Integer orderId)
    {
        this.orderId = orderId ;
    }
    
    public Integer getOrderId()
    {
        return this.orderId ;
    }

    public void setOmsOrderMain(OmsOrderMain omsOrderMain)
    {
        this.omsOrderMain = omsOrderMain ;
    }
    
    public OmsOrderMain getOmsOrderMain()
    {
        return this.omsOrderMain ;
    }
}

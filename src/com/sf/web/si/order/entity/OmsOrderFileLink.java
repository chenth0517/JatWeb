package com.sf.web.si.order.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_order_file_link
 * @创建人    chenth
 * @日期    2020/05/28
 */
@Entity
@Table(name = "oms_order_file_link")
@SmartComment("oms_order_file_link")
public class OmsOrderFileLink  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_ORDER_FILE_LINK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="序号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "file_id" ,length = 64)  
	@SmartFieldAnnotation(description="文件ID",checkValueRange=false ,minLength=0,maxLength = 64)
    private String fileId;
    
    
	@Column(name = "order_id" ,length = 10)  
	@SmartFieldAnnotation(description="关联工单编号",checkValueRange=false ,minValue=0,maxValue = 0,referenceTable="oms_order_main",referenceColumn="id",referenceDisplayColumn="id")
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

    
    public void setFileId(String fileId)
    {
        this.fileId = fileId ;
    }
    
    public String getFileId()
    {
        return this.fileId ;
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

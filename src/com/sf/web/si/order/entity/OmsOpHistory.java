package com.sf.web.si.order.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_op_history
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2018/01/10
 */
@Entity
@Table(name = "oms_op_history")
@SmartComment("oms_op_history")
public class OmsOpHistory  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_OP_HISTORY")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="工单处理流水号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "order_id" ,length = 10)  
	@SmartFieldAnnotation(description="工单编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer orderId;
    
    
	@Column(name = "remark" ,length = 512)  
	@SmartFieldAnnotation(description="处理过程描述",checkValueRange=false ,minLength=0,maxLength = 512)
    private String remark;
    
    
	@Column(name = "result" ,length = 10)  
	@SmartFieldAnnotation(description="处理结果", enumName = "SMART_INFO_DIC_TASKSTATUS", checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer result;

    @Column(name = "op_time" ,length = 19)
    @SmartFieldAnnotation(description="操作时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date opTime;
    
    @Column(name = "op_type" ,length = 10)
    @SmartFieldAnnotation(description = "操作类型", enumName = "SMART_INFO_DIC_OPHISTORYTYPE", checkValueRange = false, minValue = 0, maxValue = 0)
    private Integer opType;

	@Column(name = "user_id" ,length = 10)  
	@SmartFieldAnnotation(description="处理人员ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer userId;
    
    
	@Column(name = "task_id" ,length = 10)  
	@SmartFieldAnnotation(description="任务编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer taskId;
    
    @Transient
    private Map<String, String> mapFileNameId;

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setOrderId(Integer orderId)
    {
        this.orderId = orderId ;
    }
    
    public Integer getOrderId()
    {
        return this.orderId ;
    }

    
    public void setRemark(String remark)
    {
        this.remark = remark ;
    }
    
    public String getRemark()
    {
        return this.remark ;
    }

    
    public void setResult(Integer result)
    {
        this.result = result ;
    }
    
    public Integer getResult()
    {
        return this.result ;
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public Integer getOpType() {
        return opType;
    }

    public void setOpType(Integer opType) {
        this.opType = opType;
    }

    public void setUserId(Integer userId)
    {
        this.userId = userId ;
    }
    
    public Integer getUserId()
    {
        return this.userId ;
    }

    
    public void setTaskId(Integer taskId)
    {
        this.taskId = taskId ;
    }
    
    public Integer getTaskId()
    {
        return this.taskId ;
    }

    public Map<String, String> getMapFileNameId() {
        return mapFileNameId;
    }

    public void setMapFileNameId(Map<String, String> mapFileNameId) {
        this.mapFileNameId = mapFileNameId;
    }
}

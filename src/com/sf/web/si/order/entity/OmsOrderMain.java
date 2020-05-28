package com.sf.web.si.order.entity;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_order_main
 * @创建人    chenth
 * @日期    2020/05/25
 */
@Entity
@Table(name = "oms_order_main")
@SmartComment("oms_order_main")
public class OmsOrderMain
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_ORDER_MAIN")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="工单ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "topic" ,length = 128)  
	@SmartFieldAnnotation(description="主题",checkValueRange=false ,minLength=0,maxLength = 128)
    private String topic;
    
    
	@Column(name = "content" ,length = 512)  
	@SmartFieldAnnotation(description="受理内容",checkValueRange=false ,minLength=0,maxLength = 512)
    private String content;
    
    
	@Column(name = "customer_id" ,length = 10)  
	@SmartFieldAnnotation(description="客户编号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer customerId;
    
    
	@Column(name = "resp_user" ,length = 10)  
	@SmartFieldAnnotation(description="创建人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer respUser;
    
    
	@Column(name = "status" ,length = 10)  
	@SmartFieldAnnotation(description="状态（1新建、2解决中、3已解决、4已关闭）",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer status;
    
    
	@Column(name = "priority" ,length = 10)  
	@SmartFieldAnnotation(description="优先级(1低，2中，3高)",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer priority;
    
    
	@Column(name = "create_time" ,length = 19)  
	@SmartFieldAnnotation(description="受理时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date createTime;
    
    
	@Column(name = "instance_id" ,length = 32)  
	@SmartFieldAnnotation(description="模板工单的流程实例ID",checkValueRange=false ,minLength=0,maxLength = 32)
    private String instanceId;
    
    
	@Column(name = "close_time" ,length = 19)  
	@SmartFieldAnnotation(description="close_time",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date closeTime;
    
    @Transient
    private Map<String, String> mapFileNameId;

    @Transient
    private List<Integer> orderTagIds;

    @Transient
    private List<String> deleteFileIds;

    public void setId(Integer id)
    {
        this.id = id ;
    }
    
    public Integer getId()
    {
        return this.id ;
    }

    
    public void setTopic(String topic)
    {
        this.topic = topic ;
    }
    
    public String getTopic()
    {
        return this.topic ;
    }

    
    public void setContent(String content)
    {
        this.content = content ;
    }
    
    public String getContent()
    {
        return this.content ;
    }

    
    public void setCustomerId(Integer customerId)
    {
        this.customerId = customerId ;
    }
    
    public Integer getCustomerId()
    {
        return this.customerId ;
    }

    
    public void setRespUser(Integer respUser)
    {
        this.respUser = respUser ;
    }
    
    public Integer getRespUser()
    {
        return this.respUser ;
    }

    
    public void setStatus(Integer status)
    {
        this.status = status ;
    }
    
    public Integer getStatus()
    {
        return this.status ;
    }

    
    public void setPriority(Integer priority)
    {
        this.priority = priority ;
    }
    
    public Integer getPriority()
    {
        return this.priority ;
    }

    
    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime ;
    }
    
    public Date getCreateTime()
    {
        return this.createTime ;
    }

    
    public void setInstanceId(String instanceId)
    {
        this.instanceId = instanceId ;
    }
    
    public String getInstanceId()
    {
        return this.instanceId ;
    }

    
    public void setCloseTime(Date closeTime)
    {
        this.closeTime = closeTime ;
    }
    
    public Date getCloseTime()
    {
        return this.closeTime ;
    }

    public Map<String, String> getMapFileNameId() {
        return mapFileNameId;
    }

    public void setMapFileNameId(Map<String, String> mapFileNameId) {
        this.mapFileNameId = mapFileNameId;
    }

    public List<Integer> getOrderTagIds() {
        return orderTagIds;
    }

    public void setOrderTagIds(List<Integer> orderTagIds) {
        this.orderTagIds = orderTagIds;
    }

    public List<String> getDeleteFileIds() {
        return deleteFileIds;
    }

    public void setDeleteFileIds(List<String> deleteFileIds) {
        this.deleteFileIds = deleteFileIds;
    }
}

package com.sf.web.si.order.entity;

import java.io.Serializable;
import javax.persistence.*;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.core.annotation.SmartComment;
import java.util.*;
/**
 * oms_oph_file_link
 * @创建人    chenth
 * @日期    2020/05/28
 */
@Entity
@Table(name = "oms_oph_file_link")
@SmartComment("oms_oph_file_link")
public class OmsOphFileLink  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_OMS_OPH_FILE_LINK")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="序号",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
    
	@Column(name = "file_id" ,length = 64)  
	@SmartFieldAnnotation(description="文件ID",checkValueRange=false ,minLength=0,maxLength = 64)
    private String fileId;
    
    
	@Column(name = "history_id" ,length = 10)  
	@SmartFieldAnnotation(description="关联工单处理过程编号",checkValueRange=false ,minValue=0,maxValue = 0,referenceTable="oms_op_history",referenceColumn="id",referenceDisplayColumn="id")
    private Integer historyId;
    /*
    @OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="history_id")
    */
    @Transient
    private OmsOpHistory omsOpHistory;
    
    

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

    
    public void setHistoryId(Integer historyId)
    {
        this.historyId = historyId ;
    }
    
    public Integer getHistoryId()
    {
        return this.historyId ;
    }

    public void setOmsOpHistory(OmsOpHistory omsOpHistory)
    {
        this.omsOpHistory = omsOpHistory ;
    }
    
    public OmsOpHistory getOmsOpHistory()
    {
        return this.omsOpHistory ;
    }
}

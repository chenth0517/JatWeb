package com.sf.web.si.customer.entity;

import java.io.Serializable;

import javax.persistence.*;

import com.sf.web.si.config.entity.OmsTeamGroup;
import com.smartframework.web.core.annotation.SmartFieldAnnotation;
import com.smartframework.web.core.util.ParameterUtils;
import com.smartframework.core.annotation.SmartComment;

import java.util.*;
/**
 * com_customer_info
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
@Entity
@Table(name = "com_customer_info")
@SmartComment("com_customer_info")
public class ComCustomerInfo  implements Serializable
{
	@Id
	@SequenceGenerator(name = "_generated_id", allocationSize = 1,initialValue=1,sequenceName="SQ_COM_CUSTOMER_INFO")
	@GeneratedValue(strategy = GenerationType.AUTO,generator="_generated_id")
	@Column(name = "id" ,length = 10 ,nullable = false)  
	@SmartFieldAnnotation(description="客户ID",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer id;
    
	@Column(name = "name" ,length = 128)  
	@SmartFieldAnnotation(description="客户名称",checkValueRange=false ,minLength=0,maxLength = 128)
    private String name;
    
	@Column(name = "phone" ,length = 32)  
	@SmartFieldAnnotation(description="联系手机号",checkValueRange=false ,minLength=0,maxLength = 32)
    private String phone;
    
	@Column(name = "email" ,length = 128)  
	@SmartFieldAnnotation(description="邮箱",checkValueRange=false ,minLength=0,maxLength = 128)
    private String email;
    
	@Column(name = "tel" ,length = 32)  
	@SmartFieldAnnotation(description="联系电话",checkValueRange=false ,minLength=0,maxLength = 32)
    private String tel;
    
	@Column(name = "resp_group" ,length = 10)  
	@SmartFieldAnnotation(description="责任项目组",checkValueRange=false ,minValue=0,maxValue = 0,referenceTable="oms_team_group",referenceColumn="id",referenceDisplayColumn="id")
    private Integer respGroup;
    /*
    @OneToOne(cascade={CascadeType.ALL})
    @JoinColumn(name="resp_group")
    */
    @Transient
    private OmsTeamGroup omsTeamGroup;
    
    @Column(name = "resp_manager" ,length = 10)  
	@SmartFieldAnnotation(description="负责人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer respManager;
	
	@Column(name = "register_date" ,length = 19)  
	@SmartFieldAnnotation(description="登记时间",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date registerDate;
    
	@Column(name = "gender" ,length = 10)  
	@SmartFieldAnnotation(description="性别（0-女，1-男）",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer gender;
    
	@Column(name = "advise_manager" ,length = 10)  
	@SmartFieldAnnotation(description="顾问接口人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer adviseManager;
	
	@Column(name = "service_manager" ,length = 10)  
	@SmartFieldAnnotation(description="客服接口人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer serviceManager;
	
	@Column(name = "technical_manager" ,length = 10)  
	@SmartFieldAnnotation(description="技术接口人",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer technicalManager;
	
	@Column(name = "birthday" ,length = 19)  
	@SmartFieldAnnotation(description="生日",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date birthday;
    
	@Column(name = "special_day" ,length = 19)  
	@SmartFieldAnnotation(description="纪念日",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "1970-01-01 00:00:00")
    private Date specialDay;
    
	@Column(name = "home_addr" ,length = 255)  
	@SmartFieldAnnotation(description="家庭住址",checkValueRange=false ,minLength=0,maxLength = 255)
    private String homeAddr;
    
	@Column(name = "office_addr" ,length = 255)  
	@SmartFieldAnnotation(description="办公地址",checkValueRange=false ,minLength=0,maxLength = 255)
    private String officeAddr;
    
	@Column(name = "comment" ,length = 255)  
	@SmartFieldAnnotation(description="注释",checkValueRange=false ,minLength=0,maxLength = 255)
    private String comment;
    
	@Column(name = "interest" ,length = 128)  
	@SmartFieldAnnotation(description="兴趣爱好",checkValueRange=false ,minLength=0,maxLength = 128)
    private String interest;
    
	@Column(name = "job" ,length = 10)  
	@SmartFieldAnnotation(description="职业",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer job;
    
	@Column(name = "last_visit_date" ,length = 19)  
	@SmartFieldAnnotation(description="最近拜访",checkValueRange=false ,minDate="1970-01-01 00:00:00",maxDate = "2999-01-01 00:00:00")
    private Date lastVisitDate;
    
	@Column(name = "project" ,length = 10)  
	@SmartFieldAnnotation(description="项目",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer project;
    
	@Column(name = "progress" ,length = 10)  
	@SmartFieldAnnotation(description="进展",checkValueRange=false ,minValue=0,maxValue = 0)
    private Integer progress;
	
	@Column(name = "visit_note" ,length = 10240)  
	@SmartFieldAnnotation(description="拜访笔记",checkValueRange=false ,minLength=0,maxLength = 10240)
    private String visitNote;
    
	@Column(name = "visit_note_new" ,length = 255)  
	@SmartFieldAnnotation(description="新笔记",checkValueRange=false ,minLength=0,maxLength = 255)
	private String visitNoteNew;
	
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

    
    public void setPhone(String phone)
    {
        this.phone = phone ;
    }
    
    public String getPhone()
    {
        return this.phone ;
    }

    
    public void setEmail(String email)
    {
        this.email = email ;
    }
    
    public String getEmail()
    {
        return this.email ;
    }

    public void setTel(String tel)
    {
        this.tel = tel ;
    }
    
    public String getTel()
    {
        return this.tel ;
    }

    
    public void setRespGroup(Integer respGroup)
    {
        this.respGroup = respGroup ;
    }
    
    public Integer getRespGroup()
    {
        return this.respGroup ;
    }

    public void setOmsTeamGroup(OmsTeamGroup omsTeamGroup)
    {
        this.omsTeamGroup = omsTeamGroup ;
    }
    
    public OmsTeamGroup getOmsTeamGroup()
    {
        return this.omsTeamGroup ;
    }
    
    public Integer getRespManager() {
		return respManager;
	}

	public void setRespManager(Integer respManager) {
		this.respManager = respManager;
	}

	public void setRegisterDate(Date registerDate)
    {
        this.registerDate = registerDate ;
    }
    
    public Date getRegisterDate()
    {
        return this.registerDate ;
    }

    
    public void setGender(Integer gender)
    {
        this.gender = gender ;
    }
    
    public Integer getGender()
    {
        return this.gender ;
    }
    
    public Integer getAdviseManager() {
		return adviseManager;
	}

	public void setAdviseManager(Integer adviseManager) {
		this.adviseManager = adviseManager;
	}

	public Integer getServiceManager() {
		return serviceManager;
	}

	public void setServiceManager(Integer serviceManager) {
		this.serviceManager = serviceManager;
	}

	public Integer getTechnicalManager() {
		return technicalManager;
	}

	public void setTechnicalManager(Integer technicalManager) {
		this.technicalManager = technicalManager;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getSpecialDay() {
		return specialDay;
	}

	public void setSpecialDay(Date specialDay) {
		this.specialDay = specialDay;
	}

	public String getHomeAddr() {
		return homeAddr;
	}

	public void setHomeAddr(String homeAddr) {
		this.homeAddr = homeAddr;
	}

	public String getOfficeAddr() {
		return officeAddr;
	}

	public void setOfficeAddr(String officeAddr) {
		this.officeAddr = officeAddr;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getJob() {
		return job;
	}

	public void setJob(Integer job) {
		this.job = job;
	}

	public String getInterest() {
		return interest;
	}
	
	public void setInterest(List<String> interest)
    {
        this.interest = ParameterUtils.join(interest.toArray(), ",") ;
    }

	public Date getLastVisitDate() {
		return lastVisitDate;
	}

	public void setLastVisitDate(Date lastVisitDate) {
		this.lastVisitDate = lastVisitDate;
	}

	public Integer getProject() {
		return project;
	}

	public void setProject(Integer project) {
		this.project = project;
	}

	public Integer getProgress() {
		return progress;
	}

	public void setProgress(Integer progress) {
		this.progress = progress;
	}
	
	public String getVisitNote() {
		return visitNote;
	}

	public void setVisitNote(String visitNote) {
		this.visitNote = visitNote;
	}

	public String getVisitNoteNew() {
		return visitNoteNew;
	}

	public void setVisitNoteNew(String visitNoteNew) {
		this.visitNoteNew = visitNoteNew;
	}

}

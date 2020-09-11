package com.sf.web.jat.response.entity;

import java.io.Serializable;
import java.util.List;

public class JatRespOrgLinkDisp
  implements Serializable
{
  private Integer respId;
  private String respName;
  private Integer incharge;
  private List<Integer> participate;
  private List<Integer> relate;
  
  public Integer getRespId()
  {
    return this.respId;
  }
  
  public void setRespId(Integer respId)
  {
    this.respId = respId;
  }
  
  public String getRespName()
  {
    return this.respName;
  }
  
  public void setRespName(String respName)
  {
    this.respName = respName;
  }
  
  public Integer getIncharge()
  {
    return this.incharge;
  }
  
  public void setIncharge(Integer incharge)
  {
    this.incharge = incharge;
  }
  
  public List<Integer> getParticipate()
  {
    return this.participate;
  }
  
  public void setParticipate(List<Integer> participate)
  {
    this.participate = participate;
  }
  
  public List<Integer> getRelate()
  {
    return this.relate;
  }
  
  public void setRelate(List<Integer> relate)
  {
    this.relate = relate;
  }
}

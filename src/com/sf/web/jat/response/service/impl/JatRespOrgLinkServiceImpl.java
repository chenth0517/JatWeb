package com.sf.web.jat.response.service.impl;

import java.util.*;

import com.sf.web.jat.response.entity.JatRespOrgLink;
import com.sf.web.jat.response.entity.JatRespOrgLinkDisp;
import com.sf.web.jat.response.dao.JatRespOrgLinkOrmDao;
import com.sf.web.jat.response.service.JatRespOrgLinkService;

import org.apache.log4j.Logger;

import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;
import com.smartframework.web.system.index.entity.UserLoginRegister;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import com.smartframework.web.system.utility.util.CommonTranslateUtil.DictItemColumRefType;
/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2020/08/08
 */
public class JatRespOrgLinkServiceImpl implements JatRespOrgLinkService
{
	private Logger	logger	= Logger.getLogger(JatRespOrgLinkServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private JatRespOrgLinkOrmDao jatRespOrgLinkOrmDao;
	
	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public JatRespOrgLinkOrmDao getJatRespOrgLinkOrmDao()
	{
		return jatRespOrgLinkOrmDao;
	}

	public void setJatRespOrgLinkOrmDao(JatRespOrgLinkOrmDao jatRespOrgLinkOrmDao)
	{
		this.jatRespOrgLinkOrmDao = jatRespOrgLinkOrmDao;
	}
	
	private void commonSetMultiPara(List<Integer> myMember, Object myObj) {
		if (myObj == null)
		{
			myMember = null;
			return;
		}
		if (myObj instanceof String)
		{
			if(!((String)myObj).equals(""))
			{
				List<String> myString = Arrays.asList(((String)myObj).split(","));
				for(int i=0; i<myString.size(); i++)
				{
					myMember.add(Integer.parseInt(myString.get(i)));
				}
			}
		}
		else if(myObj instanceof List)
		{
			List tr = (List)myObj;
			for(int i=0; i<tr.size(); i++)
			{
				myMember.add(Integer.parseInt(tr.get(i).toString()));
			}
		}
		else
		{
			myMember = null;
		}
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(Integer respId, Integer incharge, List<Integer> participate, List<Integer> relate)
	{
		String sql="delete from jat_resp_org_link where resp_id = "+respId+";";
		try {
			jdbcDao.update(sql);
		} catch (Exception e) {			
			e.printStackTrace();
		}
		
		int i=0;
		List<String> sb = new ArrayList<String>();
		sb.add("insert into jat_resp_org_link(resp_id, type, org_id) values("+respId+",1,"+incharge+");");
		for (i=0; i<participate.size(); i++)
		{
			sb.add("insert into jat_resp_org_link(resp_id, type, org_id) values("+respId+",2,"+participate.get(i)+");");
		}
		for (i=0; i<relate.size(); i++)
		{
			sb.add("insert into jat_resp_org_link(resp_id, type, org_id) values("+respId+",3,"+relate.get(i)+");");
		}
		
		for (i=0; i<sb.size(); i++)
		{
			logger.info(sb.get(i));
			try {
				jdbcDao.insert(sb.get(i));
			} catch (Exception e) {			
				e.printStackTrace();
			}
		}
		
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	saveList(List<JatRespOrgLink> jatRespOrgLinkList)
	{
		try{
			this.jatRespOrgLinkOrmDao.save(jatRespOrgLinkList);
		}
		catch(Exception e)
		{
			logger.warn("Bacth Save jatRespOrgLink Error",e);
			return I18n.message("error.save.validate","对象批量保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 按ID批量读取实体对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	@Override
	public List<JatRespOrgLink> 	loadRecords(List<Integer> idList)
	{
		return this.jatRespOrgLinkOrmDao.findAll(idList);
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<JatRespOrgLink> list = this.jatRespOrgLinkOrmDao.findAll(idList);
			if(permanently)
			{
				this.jatRespOrgLinkOrmDao.delete(list);
			}
			else
			{
				for(JatRespOrgLink item:list)
				{
					//如果有disabled字段请放开下面注释语句，如果逻辑删除为其他字段请坐相应修改
					//item.setDisabled(1);//假删除
				}
				this.jatRespOrgLinkOrmDao.save(list);
			}
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public JatRespOrgLinkDisp	loadOne(Integer respId)
	 {
		 List<JatRespOrgLink> linkList = this.jatRespOrgLinkOrmDao.findByRespId(respId);
		 JatRespOrgLinkDisp jatRespOrgLinkDisp = new JatRespOrgLinkDisp();
		 if(linkList.size()==0) return null;
		 // 职责
		 jatRespOrgLinkDisp.setRespId(linkList.get(0).getRespId());
		 int i=0;

		 List<Integer> participateList = new ArrayList<Integer>();
		 List<Integer> relateList = new ArrayList<Integer>();
		 
		 for(i=0; i<linkList.size(); i++)
		 {
			 if(linkList.get(i).getType()==1)
			 {
				 jatRespOrgLinkDisp.setIncharge(linkList.get(i).getOrgId());
			 }
			 if(linkList.get(i).getType()==2)
			 {
				 participateList.add(linkList.get(i).getOrgId());
			 }
			 if(linkList.get(i).getType()==3)
			 {
				 relateList.add(linkList.get(i).getOrgId());
			 }
		 }
		 jatRespOrgLinkDisp.setParticipate(participateList);
		 jatRespOrgLinkDisp.setRelate(relateList);
		 return jatRespOrgLinkDisp;
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/08/08<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter)
	 {
		String sql = "select e.* from jat_resp_org_link e";
		return jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), queryFilter.getPageSize(), queryFilter.getPageIndex());
	 }
	 
	/**
	* 多字段组合查询<br>
	* 添加时间:2020/08/08<br>
	* @param 
	* @return
	*/
	@Override
	public PagingBean	queryCurrUserRespByRespType(Integer respType, Integer userId, QueryFilter queryFilter)
	{
		Integer cuid = UserLoginRegister.currentUserId();
		StringBuilder sb = new StringBuilder();
		sb.append("select e1.id, e1.name as resp_name, e1.disabled as resp_status, e1.type as resp_type, tmp.type from jat_resp_dep e1 inner join ");
		sb.append("( ");
		sb.append("select e2.resp_id, e2.type from jat_resp_org_link e2 where ");
		if(!ParameterUtils.isEmptyOrNull(respType))
		{
			sb.append(" e2.type = ");
			sb.append(respType);
			sb.append(" and ");
		}
		sb.append(" e2.org_id in ");
		sb.append("( ");
		sb.append("select e3.org_id from sys_org_user_link e3 where e3.user_id = ");
		if(!ParameterUtils.isEmptyOrNull(userId))
		{
			sb.append(userId);
		}
		else
		{
			sb.append(cuid.toString());
		}
		sb.append(" ) ");
		sb.append(") tmp on e1.id = tmp.resp_id order by tmp.type, e1.id");
		String sql = sb.toString();
		logger.info("[SQL_LOG]: "+sql);
		PagingBean pb = jdbcDao.queryForPaging(sql, queryFilter.getPageSize(), queryFilter.getPageIndex());
		
		List<Map<String,Object>> records = pb.getData();
		for (int i=0; i<records.size(); i++)
		{
			if(records.get(i).get("type").toString().equals("1"))
			{
				records.get(i).put("type_t_description", "负责");
			}else if(records.get(i).get("type").toString().equals("2"))
			{
				records.get(i).put("type_t_description", "参与");
			}else
			{
				records.get(i).put("type_t_description", "相关");
			}
		}
		Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
		dictNameFieldNameMap.put("respType", "JAT_RESP_TYPE");
		dictNameFieldNameMap.put("respStatus", "JAT_DISABLED");
		try {
			CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, DictItemColumRefType.ID_COLUMN);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pb;
	}
}

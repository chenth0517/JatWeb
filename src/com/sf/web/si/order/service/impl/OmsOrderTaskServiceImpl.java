package com.sf.web.si.order.service.impl;

import java.util.*;

import com.sf.web.si.order.dao.OmsOpHistoryOrmDao;
import com.sf.web.si.order.dao.OmsOphFileLinkOrmDao;
import com.sf.web.si.order.entity.OmsOpHistory;
import com.sf.web.si.order.entity.OmsOphFileLink;
import com.sf.web.si.order.entity.OmsOrderTask;
import com.sf.web.si.order.dao.OmsOrderTaskOrmDao;
import com.sf.web.si.order.service.OmsOrderTaskService;
import com.smartframework.web.core.file.FileClient;
import com.smartframework.web.server.file.dao.SysFileInfoOrmDao;
import com.smartframework.web.server.file.entity.SysFileInfo;
import com.smartframework.web.server.file.service.FileManagerService;
import com.smartframework.web.system.index.entity.UserLoginRegister;
import com.smartframework.web.system.utility.dao.SysDictItemOrmDao;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;
import org.apache.log4j.Logger;
import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.*;
import com.smartframework.web.core.Constants;
import org.h2.engine.User;

/**
 * @创建人    chenth
 * @日期    2020/05/22
 */
public class OmsOrderTaskServiceImpl implements OmsOrderTaskService
{
	private Logger	logger	= Logger.getLogger(OmsOrderTaskServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private OmsOrderTaskOrmDao omsOrderTaskOrmDao;
	private OmsOpHistoryOrmDao opHistoryOrmDao;
	private OmsOphFileLinkOrmDao ophFileLinkOrmDao;
	private SysFileInfoOrmDao sysFileInfoOrmDao;
	private SysDictItemOrmDao sysDictItemOrmDao;

	public SysDictItemOrmDao getSysDictItemOrmDao() {
		return sysDictItemOrmDao;
	}

	public void setSysDictItemOrmDao(SysDictItemOrmDao sysDictItemOrmDao) {
		this.sysDictItemOrmDao = sysDictItemOrmDao;
	}

	public SysFileInfoOrmDao getSysFileInfoOrmDao() {
		return sysFileInfoOrmDao;
	}

	public void setSysFileInfoOrmDao(SysFileInfoOrmDao sysFileInfoOrmDao) {
		this.sysFileInfoOrmDao = sysFileInfoOrmDao;
	}

	public OmsOphFileLinkOrmDao getOphFileLinkOrmDao() {
		return ophFileLinkOrmDao;
	}

	public void setOphFileLinkOrmDao(OmsOphFileLinkOrmDao ophFileLinkOrmDao) {
		this.ophFileLinkOrmDao = ophFileLinkOrmDao;
	}

	public OmsOpHistoryOrmDao getOpHistoryOrmDao() {
		return opHistoryOrmDao;
	}

	public void setOpHistoryOrmDao(OmsOpHistoryOrmDao opHistoryOrmDao) {
		this.opHistoryOrmDao = opHistoryOrmDao;
	}

	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public OmsOrderTaskOrmDao getOmsOrderTaskOrmDao()
	{
		return omsOrderTaskOrmDao;
	}

	public void setOmsOrderTaskOrmDao(OmsOrderTaskOrmDao omsOrderTaskOrmDao)
	{
		this.omsOrderTaskOrmDao = omsOrderTaskOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(OmsOrderTask omsOrderTask)
	{
		boolean bNewTask = true;
		try
		{
			if(ParameterUtils.isValidateId(omsOrderTask.getId()))
			{
				bNewTask = false;
				OmsOrderTask old = this.omsOrderTaskOrmDao.findOne(omsOrderTask.getId());
				String ret = AnnotationAccessUtil.mergeEntity(old,omsOrderTask);
				if(!Constants.SUCCESS.equals(ret))
				{
					return ret;
				}
			}
			else
			{
				omsOrderTask.setCreateTime(new Date());
			}

			AnnotationAccessUtil.validateEntityBean(omsOrderTask);
			this.omsOrderTaskOrmDao.save(omsOrderTask);
		}
		catch(Exception e)
		{
			logger.warn("Save omsOrderTask Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}

		//记录
		try {
			if (bNewTask) {
				//OmsOrderTask newTask =  this.omsOrderTaskOrmDao.findTopByOrderByIdDesc();
				//Integer newTaskId = omsOrderTask.getId();
				OmsOpHistory history = new OmsOpHistory();
				history.setOrderId(omsOrderTask.getOrdeId());
				history.setUserId(UserLoginRegister.getCurrentUser().getId());
				history.setOpType(this.sysDictItemOrmDao.findByCode("SIDOPHT_ADDTASK").get(0).getId());
				history.setRemark("任务编号："+omsOrderTask.getId()+",任务名称："+omsOrderTask.getName());
				history.setOpTime(new Date());
				AnnotationAccessUtil.validateEntityBean(history);
				this.opHistoryOrmDao.save(history);
			}
		}
		catch (Exception e){
			logger.warn("Save OmsOpHistory Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}

	@Override
	public String saveOpHistory(OmsOpHistory opHistory) {
		try
		{
			opHistory.setUserId(UserLoginRegister.currentUserId());
			opHistory.setOpType(this.sysDictItemOrmDao.findByCode("SIDOPHT_PROCESSTASK").get(0).getId());
			opHistory.setOpTime(new Date());
			AnnotationAccessUtil.validateEntityBean(opHistory);
			this.opHistoryOrmDao.save(opHistory);

			HashMap<String,String> fileMap = (HashMap<String, String>) opHistory.getMapFileNameId();

			int ophId = opHistory.getId();

			List<OmsOphFileLink> fileLinks=this.ophFileLinkOrmDao.findByHistoryId(ophId);
			if(fileLinks==null||fileLinks.isEmpty()){}
			else{
				for(OmsOphFileLink fileLink:fileLinks){
					this.ophFileLinkOrmDao.delete(fileLink);
				}
			}

			if(fileMap==null||fileMap.isEmpty()){}
			else{
				//保存附件关联
				Collection cl = fileMap.values();
				Iterator itr = cl.iterator();
				while(itr.hasNext()){
					OmsOphFileLink fileLink = new OmsOphFileLink();
					fileLink.setFileId(itr.next().toString());
					fileLink.setHistoryId(ophId);
					AnnotationAccessUtil.validateEntityBean(fileLink);
					this.ophFileLinkOrmDao.save(fileLink);
				}
			}
		}
		catch(Exception e)
		{
			logger.warn("Save omsOpHistory Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}
		return Constants.SUCCESS;
	}

	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<OmsOrderTask> omsOrderTaskList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<OmsOrderTask> list = this.omsOrderTaskOrmDao.findAll(idList);

			//删除关联文件op_file
			List<OmsOpHistory> historys = this.opHistoryOrmDao.findByTaskIdIn(idList);
			List<Integer> ophIds = new ArrayList<>();
			for(OmsOpHistory history:historys){
				ophIds.add(history.getId());
			}
			List<OmsOphFileLink> links = this.ophFileLinkOrmDao.findByHistoryIdIn(ophIds);

			List<String> ids = new ArrayList<>();
			for(OmsOphFileLink link : links){
				ids.add(link.getFileId());
			}

			FileClient fileClient = FileClient.getSysClient();
			fileClient.delete(ids);

			this.ophFileLinkOrmDao.delete(links);
			//删除关联历史记录op_history
			this.opHistoryOrmDao.delete(historys);
			this.omsOrderTaskOrmDao.delete(list);

			//记录删除操作
			//OmsOrderTask newTask =  this.omsOrderTaskOrmDao.findTopByOrderByIdDesc();
			//Integer newTaskId = newTask.getId();
			OmsOpHistory history = new OmsOpHistory();
			history.setOrderId(list.get(0).getOrdeId());
			history.setUserId(UserLoginRegister.getCurrentUser().getId());
			history.setOpType(this.sysDictItemOrmDao.findByCode("SIDOPHT_DELETETASK").get(0).getId());
			StringBuilder sb = new StringBuilder();
			for (OmsOrderTask task:list){
				sb.append("任务编号：").append(task.getId()).append("<br />");
			}
			history.setRemark(sb.toString());
			history.setOpTime(new Date());
			//history.setRemark("创建了工单");
			AnnotationAccessUtil.validateEntityBean(history);
			this.opHistoryOrmDao.save(history);

		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	 public OmsOrderTask	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
	 	return this.omsOrderTaskOrmDao.findOne(id);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2020/05/22<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	//根据用户角色显示列表
	 	if(pageSize==null||pageIndex==null) return null;
		//String sql = "select e.* , u.real_name from oms_order_task e left join sys_user u on e.holder_user_id = u.id";
		 String sql = "select e.* , u.real_name, t.result from oms_order_task e left join sys_user u on e.holder_user_id = u.id left join oms_op_history t on t.task_id = e.id";
		 PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
		 List<Map<String,Object>> records = pb.getData();
		 Map<String,String> dictNameFieldNameMap = new HashMap<String,String>();
		 dictNameFieldNameMap.put("result", "SMART_INFO_DIC_TASKSTATUS");
		 //dictNameFieldNameMap.put("membership", "SMART_INFO_DIC_RELATIONSHIP");
		 //dictNameFieldNameMap.put("interest", "SMART_INFO_DIC_INTERESTS");
		 CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, CommonTranslateUtil.DictItemColumRefType.ID_COLUMN);
		 //翻译字典：结束
		return pb;
	 }

	@Override
	public List<Map<String, Object>> loadOneTaskOpHistory(Integer taskId) {
		List<OmsOpHistory> list = this.opHistoryOrmDao.findByTaskId(taskId);
		List<Object> olist=new ArrayList<>();
		for (OmsOpHistory history : list){
			olist.add(history);
		}
		List<Map<String, Object>> relist = CommonTranslateUtil.translateDictForBeanList(olist, CommonTranslateUtil.DictItemColumRefType.ID_COLUMN);
		if(relist==null || relist.isEmpty())
	 		return null;
		return relist;
	}

	@Override
	public List<OmsOpHistory> loadTaskOpHistoryByUser(Integer taskId, Integer userId) {
		List<OmsOpHistory> list = this.opHistoryOrmDao.findByTaskIdAndUserId(taskId,userId);
		if(list==null || list.isEmpty())
			return null;
		return list;
	}

	@Override
	public List<SysFileInfo> loadOphFileInfos(Integer historyId) {
	 	List<OmsOphFileLink> list = this.ophFileLinkOrmDao.findByHistoryId(historyId);
	 	List<SysFileInfo> files = new ArrayList<>();
	 	for(OmsOphFileLink link : list){
			SysFileInfo file = this.sysFileInfoOrmDao.findOne(link.getFileId());
			if(file!=null)
				files.add(file);
		}
		if (files==null || files.isEmpty()) return null;
		return files;
	}

	@Override
	public String deleteFileAndLink(String fileId) {
		FileClient fileClient = FileClient.getSysClient();

		try
		{
			List<OmsOphFileLink> list = this.ophFileLinkOrmDao.findByFileId(fileId);
			if(list == null || list.isEmpty())
			{
				SysFileInfo file = this.sysFileInfoOrmDao.findOne(fileId);
				if(file != null){
					List<String > ids = new ArrayList<>();
					ids.add(fileId);
					fileClient.delete(ids);
				}
			}
			else {
				this.ophFileLinkOrmDao.delete(list);

				List<String> ids = new ArrayList<>();
				ids.add(fileId);
				fileClient.delete(ids);
			}
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
}

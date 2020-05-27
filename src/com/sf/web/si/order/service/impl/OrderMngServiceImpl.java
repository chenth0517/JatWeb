package com.sf.web.si.order.service.impl;

import java.util.*;

import com.sf.web.si.config.dao.ComTagDefOrmDao;
import com.sf.web.si.config.entity.ComTagDef;
import com.sf.web.si.order.dao.*;
import com.sf.web.si.order.entity.OmsOpHistory;
import com.sf.web.si.order.entity.OmsOrderFileLink;
import com.sf.web.si.order.entity.OmsOrderMain;
import com.sf.web.si.order.entity.OmsOrderTagLink;
import com.sf.web.si.order.service.OrderMngService;
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
import org.apache.xalan.xsltc.util.IntegerArray;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * @创建人    SmartWeb Code Plugin Created.
 * @日期    2017/12/27
 */
public class OrderMngServiceImpl implements OrderMngService
{
	private Logger	logger	= Logger.getLogger(OrderMngServiceImpl.class);

	private JdbcDao		jdbcDao;
	
	private OmsOrderMainOrmDao omsOrderMainOrmDao;
	private OmsOrderFileLinkOrmDao omsOrderFileLinkOrmDao;
	private OmsOrderTagLinkOrmDao omsOrderTagLinkOrmDao;
	private SysFileInfoOrmDao sysFileInfoOrmDao;
	private ComTagDefOrmDao	tagDefOrmDao;
	private OmsOrderTaskOrmDao orderTaskOrmDao;
	private OmsOpHistoryOrmDao	opHistoryOrmDao;
	private SysDictItemOrmDao sysDictItemOrmDao;

	public SysDictItemOrmDao getSysDictItemOrmDao() {
		return sysDictItemOrmDao;
	}

	public void setSysDictItemOrmDao(SysDictItemOrmDao sysDictItemOrmDao) {
		this.sysDictItemOrmDao = sysDictItemOrmDao;
	}

	public OmsOpHistoryOrmDao getOpHistoryOrmDao() {
		return opHistoryOrmDao;
	}

	public void setOpHistoryOrmDao(OmsOpHistoryOrmDao opHistoryOrmDao) {
		this.opHistoryOrmDao = opHistoryOrmDao;
	}

	public OmsOrderTaskOrmDao getOrderTaskOrmDao() {
		return orderTaskOrmDao;
	}

	public void setOrderTaskOrmDao(OmsOrderTaskOrmDao orderTaskOrmDao) {
		this.orderTaskOrmDao = orderTaskOrmDao;
	}

	public ComTagDefOrmDao getTagDefOrmDao() {
		return tagDefOrmDao;
	}

	public void setTagDefOrmDao(ComTagDefOrmDao tagDefOrmDao) {
		this.tagDefOrmDao = tagDefOrmDao;
	}

	public OmsOrderTagLinkOrmDao getOmsOrderTagLinkOrmDao() {
		return omsOrderTagLinkOrmDao;
	}

	public void setOmsOrderTagLinkOrmDao(OmsOrderTagLinkOrmDao omsOrderTagLinkOrmDao) {
		this.omsOrderTagLinkOrmDao = omsOrderTagLinkOrmDao;
	}

	public SysFileInfoOrmDao getSysFileInfoOrmDao() {
		return sysFileInfoOrmDao;
	}

	public void setSysFileInfoOrmDao(SysFileInfoOrmDao sysFileInfoOrmDao) {
		this.sysFileInfoOrmDao = sysFileInfoOrmDao;
	}
	public OmsOrderFileLinkOrmDao getOmsOrderFileLinkOrmDao()
	{
		return omsOrderFileLinkOrmDao;
	}

	public void setOmsOrderFileLinkOrmDao(OmsOrderFileLinkOrmDao omsOrderFileLinkOrmDao)
	{
		this.omsOrderFileLinkOrmDao = omsOrderFileLinkOrmDao;
	}

	public JdbcDao getJdbcDao()
	{
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao)
	{
		this.jdbcDao = jdbcDao;
	}
	
	public OmsOrderMainOrmDao getOmsOrderMainOrmDao()
	{
		return omsOrderMainOrmDao;
	}

	public void setOmsOrderMainOrmDao(OmsOrderMainOrmDao omsOrderMainOrmDao)
	{
		this.omsOrderMainOrmDao = omsOrderMainOrmDao;
	}
	
	/**
	 * 保存实体对象<br>
	 * 自行修改保存后的研判条件<br>
	 * 添加时间:2017/12/27<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	save(OmsOrderMain omsOrderMain)
	{
		boolean newOrder = true;
		try
		{
			if(ParameterUtils.isValidateId(omsOrderMain.getId()))
			{
				newOrder = false;
				OmsOrderMain old = this.omsOrderMainOrmDao.findOne(omsOrderMain.getId());
				String ret = AnnotationAccessUtil.mergeEntity(old,omsOrderMain);
				if(!Constants.SUCCESS.equals(ret))
				{
					return ret;
				}
			}else{
				omsOrderMain.setCreateTime(new Date());
				omsOrderMain.setRespUser(UserLoginRegister.getCurrentUser().getId());
			}
			AnnotationAccessUtil.validateEntityBean(omsOrderMain);
			this.omsOrderMainOrmDao.save(omsOrderMain);
		}
		catch(Exception e)
		{
			logger.warn("Save omsOrderMain Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}

		HashMap<String,String> fileMap = (HashMap<String, String>) omsOrderMain.getMapFileNameId();
		List<Integer> tags = omsOrderMain.getOrderTagIds();

		/*int newId = -1;
		//获取新保存的工单
		OmsOrderMain newOrder =  this.omsOrderMainOrmDao.findFirstByOrderByIdDesc();
		newId = newOrder.getId();*/

		//保存建立历史
		try {
			if (newOrder) {
				OmsOpHistory history = new OmsOpHistory();
				history.setOrderId(omsOrderMain.getId());
				history.setUserId(UserLoginRegister.getCurrentUser().getId());
				history.setOpType(this.sysDictItemOrmDao.findByCode("SIDOPHT_CREATORDER").get(0).getId());
				history.setOpTime(new Date());
				//history.setRemark("创建了工单");
				AnnotationAccessUtil.validateEntityBean(history);
				this.opHistoryOrmDao.save(history);
			}
		}
		catch(Exception e)
		{
			logger.warn("Save OmsOpHistory Error",e);
			return I18n.message("error.save.validate","对象保存时失败{0}",new Object[]{e.getMessage()});
		}


		try
		{
			List<OmsOrderFileLink> fileLinks=this.omsOrderFileLinkOrmDao.findByOrderId(omsOrderMain.getId());
			if(fileLinks==null||fileLinks.isEmpty()){}
			else{
				for(OmsOrderFileLink fileLink:fileLinks){
					this.omsOrderFileLinkOrmDao.delete(fileLink);
				}
			}
			if(fileMap==null||fileMap.isEmpty()){}
			else{
				//保存附件关联
				Collection cl = fileMap.values();
				Iterator itr = cl.iterator();
				while(itr.hasNext()){
					OmsOrderFileLink fileLink = new OmsOrderFileLink();
					fileLink.setFileId(itr.next().toString());
					fileLink.setOrderId(omsOrderMain.getId());
					AnnotationAccessUtil.validateEntityBean(fileLink);
					this.omsOrderFileLinkOrmDao.save(fileLink);
				}
			}

			List<String> deleteFileIds = omsOrderMain.getDeleteFileIds();
			if(deleteFileIds != null){
				FileClient fileClient = FileClient.getSysClient();
				fileClient.delete(deleteFileIds);
			}
		}
		catch (Exception e)
		{
			return e.getMessage();
		}

		try
		{
			List<OmsOrderTagLink> tagLinks = this.omsOrderTagLinkOrmDao.findByOrderId(omsOrderMain.getId());
			if(tagLinks==null || tagLinks.isEmpty()){}
			else {
				for (OmsOrderTagLink tagLink : tagLinks) {
					this.omsOrderTagLinkOrmDao.delete(tagLink);
				}
			}
			if(tags==null || tags.isEmpty()){}
			else{
				for (int i=0;i<tags.size();i++){
					OmsOrderTagLink tagLink = new OmsOrderTagLink();
					tagLink.setTagId(tags.get(i));
					tagLink.setOrderId(omsOrderMain.getId());
					AnnotationAccessUtil.validateEntityBean(tagLink);
					this.omsOrderTagLinkOrmDao.save(tagLink);
				}
			}
		}
		catch (Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 批量保存实体对象<br>
	 * 添加时间:2017/12/27<br>
	 * @param 
	 * @return
	 */
	public String 	saveList(List<OmsOrderMain> omsOrderMainList)
	{
		return Constants.SUCCESS;
	}
	/**
	 * 根据ID删除对象<br>
	 * 添加时间:2017/12/27<br>
	 * @param 
	 * @return
	 */
	@Override
	public String 	delete(List<Integer> idList,boolean permanently)
	{
		try
		{
			List<OmsOrderMain> list = this.omsOrderMainOrmDao.findAll(idList);
			//获取富文本中上传图片
			List<String> imgList=new ArrayList<>();
			for	(OmsOrderMain orderMain:list){
				String htmlContent = orderMain.getContent();
				Document document = Jsoup.parse(htmlContent);
				Elements elements = document.getElementsByTag("img");
				for (Element element:elements){
					String imgSrc=element.attr("src");
					Integer idx = imgSrc.indexOf("id=");
					if(idx > -1){
						String imgId = imgSrc.substring(idx+3);
						imgList.add(imgId);
					}
				}
			}
			if (imgList.size()>0){
				FileClient fileClient = FileClient.getSysClient();
				fileClient.delete(imgList);
			}
			//删除tag关联
			List<OmsOrderTagLink> tagLinks = this.omsOrderTagLinkOrmDao.findByOrderIdIn(idList);
			this.omsOrderTagLinkOrmDao.delete(tagLinks);
			//删除附件关联
			List<OmsOrderFileLink> fileLinks = this.omsOrderFileLinkOrmDao.findByOrderIdIn(idList);
			List<String> fileIds = new ArrayList<>();
			for (OmsOrderFileLink fileLink:fileLinks){
				fileIds.add(fileLink.getFileId());
			}
			this.omsOrderFileLinkOrmDao.delete(fileLinks);
			FileClient fileClient = FileClient.getSysClient();
			fileClient.delete(fileIds);

			this.omsOrderMainOrmDao.delete(list);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
	
	/**
	 * 根据ID值查询<br>
	 * 添加时间:2017/12/27<br>
	 * @param 
	 * @return
	 */
	 public Map<String,Object>	get(Integer id)
	 {
	 	if(ParameterUtils.isNotValidateId(id))
		{
			return null;
		}
		String sql="select e.*,b.real_name as respName from oms_order_main e left join sys_user b on e.resp_user = b.id where e.id = " + id;
	 	List<Map<String,Object>> list = jdbcDao.queryForList(sql);
	 	if(list==null || list.isEmpty()) return null;
	 	return list.get(0);
	 }
	 
	 /**
	 * 多字段组合查询<br>
	 * 添加时间:2017/12/27<br>
	 * @param 
	 * @return
	 */
	 @Override
	 public PagingBean	queryRecords(QueryFilter queryFilter,Integer pageSize,Integer pageIndex)
	 {
	 	if(pageSize==null||pageIndex==null) return null;
		String sql = "select e.* , u.name from oms_order_main e left JOIN com_customer_info u on e.customer_id = u.id";
		System.err.println(sql+queryFilter.getWhereSql());
		System.err.println(queryFilter.getConditionValues());
		return jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
	 }

	@Override
	public List<SysFileInfo> loadLinkFiles(Integer orderId) {
		List<OmsOrderFileLink> links = this.omsOrderFileLinkOrmDao.findByOrderId(orderId);
		if(links == null || links.isEmpty()) return null;

		List<SysFileInfo> fileInfos = new ArrayList<>();
		List<Integer> fileIds = new ArrayList<>();
		for (OmsOrderFileLink link: links){
			SysFileInfo fileInfo = this.sysFileInfoOrmDao.findOne(link.getFileId());
			fileInfos.add(fileInfo);
		}
		if(fileInfos == null || fileInfos.isEmpty()) return null;
		return  fileInfos;
	}

	@Override
	public String deleteFileAndLink(String fileId) {
		try
		{
			List<OmsOrderFileLink> list = this.omsOrderFileLinkOrmDao.findByFileId(fileId);
			this.omsOrderFileLinkOrmDao.delete(list);
			List<String> ids = new ArrayList<>();
			ids.add(fileId);
			FileClient fileClient = FileClient.getSysClient();
			fileClient.delete(ids);
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}

	@Override
	public List<ComTagDef> loadLinkTags(Integer orderId) {
		List<OmsOrderTagLink> tagLinks = this.omsOrderTagLinkOrmDao.findByOrderId(orderId);
		if(tagLinks==null||tagLinks.isEmpty()) return null;

		List<ComTagDef> tagDefs = new ArrayList<>();
		for (OmsOrderTagLink link: tagLinks){
			ComTagDef tagDef = this.tagDefOrmDao.findOne(link.getTagId());
			tagDefs.add(tagDef);
		}
		if(tagDefs == null || tagDefs.isEmpty()) return null;
		return  tagDefs;
	}

	@Override
	public PagingBean queryRecordsByRole(QueryFilter queryFilter, Integer pageSize, Integer pageIndex) {
		if(pageSize==null||pageIndex==null) return null;
		List<Integer> orderIds = this.orderTaskOrmDao.findOrderIdByHolderUserId(UserLoginRegister.currentUserId());
		String sql = "select e.* , u.real_name from oms_order_main e left JOIN sys_user u on e.resp_user = u.id";
		queryFilter.addNumberFieldInCondition("e.id", orderIds);
		return jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
	}

	@Override
	public PagingBean queryOrderOpHistory(QueryFilter queryFilter, Integer pageSize, Integer pageIndex) {
		if(pageSize==null||pageIndex==null) return null;
		String sql = "select e.remark,e.op_time,e.op_type,u.real_name from oms_op_history e left join sys_user u on e.user_id = u.id";
		queryFilter.addSorted("e.id","desc");
		PagingBean pb = jdbcDao.queryForPaging(sql+queryFilter.getWhereSql(),queryFilter.getConditionValues(), pageSize, pageIndex);
		List<Map<String,Object>> records = pb.getData();
		Map<String,String> dictNameFieldNameMap = new HashMap<>();
		dictNameFieldNameMap.put("opType","SMART_INFO_DIC_OPHISTORYTYPE");
		CommonTranslateUtil.translateMultiDictColumn(records, dictNameFieldNameMap, CommonTranslateUtil.DictItemColumRefType.ID_COLUMN);
		return pb;
	}

	@Override
	public String updateOrderStatus(Integer orderId, Integer status) {
	 	try {
	 		String closeTime = DateUtil.format(new Date());
	 		String sql = "update oms_order_main e set e.status = " + status +", e.close_time = '" + closeTime + "' where e.id = " + orderId;
	 		jdbcDao.update(sql);

			//保存建立历史
			OmsOpHistory history = new OmsOpHistory();
			history.setOrderId(orderId);
			history.setUserId(UserLoginRegister.getCurrentUser().getId());
			if(status == 3){
				history.setRemark("更改工单状态为：已解决");
			}
			else if(status==4)
			{
				history.setRemark("更改工单状态为: 已关闭");
			}

			history.setOpType(this.sysDictItemOrmDao.findByCode("SIDOPHT_UPDATESTATUS").get(0).getId());
			history.setOpTime(new Date());
			AnnotationAccessUtil.validateEntityBean(history);
			this.opHistoryOrmDao.save(history);
		} 
		catch(Exception e)
		{
			return e.getMessage();
		}
		return Constants.SUCCESS;
	}
}

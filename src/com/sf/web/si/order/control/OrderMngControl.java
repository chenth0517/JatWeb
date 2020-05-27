package com.sf.web.si.order.control;

import java.util.*;
import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.smartframework.web.core.file.FileClient;
import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.si.order.service.OrderMngService;
import com.sf.web.si.order.entity.OmsOrderMain;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
import com.smartframework.web.system.index.entity.SysRole;
import com.smartframework.web.system.index.entity.UserLoginRegister;

import org.apache.http.HttpRequest;
import org.apache.xpath.operations.Bool;
import org.h2.engine.User;

/**
 * @desc    OrderMngControl.java SmartWeb Code Plugin Created.
 * @date    2017/12/27
 */
@SmartComment("OmsOrderMain实例增删改查接口层")
public class OrderMngControl extends BasicControl
{
	private OrderMngService 	orderMngService;//Service

	public OrderMngService getOrderMngService()
	{
		return orderMngService;
	}
	
	public void setOrderMngService(OrderMngService orderMngService)
	{
		this.orderMngService=orderMngService;
	}


	//CRUD 操作列表
	@SmartComment("保存OmsOrderMain实例")
	public SmartView save(OmsOrderMain omsOrderMain)
	{
		//TODO 请先验证参数有效性再使用
		//保存成功后保存对应fileId
		return this.dbAccess(this.orderMngService.save(omsOrderMain));
	}
	
	@SmartComment("按ID列表删除OmsOrderMain对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.orderMngService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除OmsOrderMain对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.orderMngService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个OmsOrderMain实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.orderMngService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取OmsOrderMain实例的分页查询结果")
	public SmartView list(String topic,String customerName,Integer priority, Integer respUser, Integer status,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(topic))
		{
			queryFilter.addStringFieldLikeCondition("e.topic", topic);
		}
		if(!ParameterUtils.isEmptyOrNull(customerName))
		{
			queryFilter.addStringFieldLikeCondition("u.name", customerName);
		}
		if(!ParameterUtils.isEmptyOrNull(priority))
		{
			queryFilter.addNumberFieldEqualCondition("e.priority", priority);
		}

		if(!ParameterUtils.isEmptyOrNull(respUser))
		{
			queryFilter.addNumberFieldEqualCondition("e.resp_user", respUser);
		}

		if(!ParameterUtils.isEmptyOrNull(status))
		{
			queryFilter.addNumberFieldEqualCondition("e.status", status);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}

		PagingBean page = null;
		if(UserLoginRegister.currentUserHasRole("APP_ORDER_MNG") || UserLoginRegister.currentUserIsSuperAdmin()
				|| UserLoginRegister.currentUserIsAppAdmin() || UserLoginRegister.currentUserIsSysAdmin()){
			page = this.orderMngService.queryRecords(queryFilter,pageSize,pageIndex);
		}else if(UserLoginRegister.currentUserHasRole("APP_TASK_OPER")){
			page= this.orderMngService.queryRecordsByRole(queryFilter,pageSize,pageIndex);
		}
		// TODO 导出时使用 List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class);
		// ExcelDataUtil.createExcelByMapList(page.getData(),headers).write(outputStream);
		//在Service中构建PagingBean实例
		return this.pageView(page);
		
	}

	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("按当前用户获取OmsOrderMain实例的分页查询结果")
	public SmartView listByUser(String name,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		Integer cuid = UserLoginRegister.currentUserId();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(cuid))
		{
			queryFilter.addNumberFieldEqualCondition("e.resp_user", cuid);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.orderMngService.queryRecords(queryFilter,pageSize,pageIndex);
		// TODO 导出时使用 List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class); 
		// ExcelDataUtil.createExcelByMapList(page.getData(),headers).write(outputStream);
		//在Service中构建PagingBean实例
		return this.pageView(page);
	}

	public SmartView loadUserRole(){
		if(UserLoginRegister.currentUserHasRole("APP_ORDER_MNG") || UserLoginRegister.currentUserIsSuperAdmin()
				|| UserLoginRegister.currentUserIsAppAdmin() || UserLoginRegister.currentUserIsSysAdmin()){
			return SmartView.SUCCESS(false);
		}else if(UserLoginRegister.currentUserHasRole("APP_TASK_OPER")){
			return SmartView.SUCCESS(true);
		}
		return SmartView.SUCCESS(false);
	}

	@SmartComment("获取附件列表")
	public SmartView loadLinkFiles(Integer orderId) {
		if (!ParameterUtils.isEmptyOrNull(orderId))
			return SmartView.SUCCESS(this.orderMngService.loadLinkFiles(orderId));
	    return SmartView.SUCCESS();
	}

	public SmartView deleteFileAndLink(String fileId){
		return this.dbAccess(this.orderMngService.deleteFileAndLink(fileId));
	}

	@SmartComment("获取工单标签列表")
	public SmartView loadLinkTags(Integer orderId){
		if(!ParameterUtils.isEmptyOrNull(orderId))
			return SmartView.SUCCESS(this.orderMngService.loadLinkTags(orderId));
		return SmartView.SUCCESS();
	}

	@SmartComment("获取工单操作记录")
	public SmartView loadOrderOpHistory(Integer orderId,Integer pageSize,Integer pageIndex){
		QueryFilter queryFilter = new QueryFilter();
		if(!ParameterUtils.isEmptyOrNull(orderId)){
			queryFilter.addNumberFieldEqualCondition("e.order_id",orderId);
		}
		PagingBean page = this.orderMngService.queryOrderOpHistory(queryFilter,pageSize,pageIndex);
		return this.pageView(page);
	}

	@SmartComment("修改工单状态")
	public SmartView updateOrderStatus(Integer orderId, Integer status){
		return this.dbAccess(this.orderMngService.updateOrderStatus(orderId, status));
	}

	@SmartComment("删除文件")
	public SmartView deleteFile(String fileId){
		FileClient fileClient = FileClient.getSysClient();
		return this.dbAccess(fileClient.delete(fileId));
	}
	//参数名 file 请勿轻易修改
	@SmartComment("Excel文件导入")
	public SmartView importFile(File file)
	{
		return SmartView.SUCCESS();
	}
}

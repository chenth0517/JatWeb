package com.sf.web.si.order.control;

import java.util.*;
import java.io.File;

import com.sf.web.si.order.entity.OmsOpHistory;
import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.system.index.entity.UserLoginRegister;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.si.order.service.OmsOrderTaskService;
import com.sf.web.si.order.entity.OmsOrderTask;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
import com.smartframework.web.system.utility.util.CommonTranslateUtil;

/**
 * @desc    OmsOrderTaskControl.java SmartWeb Code Plugin Created.
 * @date    2018/01/02
 */
@SmartComment("OmsOrderTask实例增删改查接口层")
public class OmsOrderTaskControl extends BasicControl
{
	private OmsOrderTaskService 	omsOrderTaskService;//Service
	
	public OmsOrderTaskService getOmsOrderTaskService()
	{
		return omsOrderTaskService;
	}
	
	public void setOmsOrderTaskService(OmsOrderTaskService omsOrderTaskService)
	{
		this.omsOrderTaskService=omsOrderTaskService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存OmsOrderTask实例")
	public SmartView save(OmsOrderTask omsOrderTask)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.omsOrderTaskService.save(omsOrderTask));
	}

	@SmartComment("保存任务处理历史")
	public SmartView saveOpHistory(OmsOpHistory omsOpHistory)
	{
		return this.dbAccess(this.omsOrderTaskService.saveOpHistory(omsOpHistory));
	}
	@SmartComment("按ID列表删除OmsOrderTask对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.omsOrderTaskService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除OmsOrderTask对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.omsOrderTaskService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个OmsOrderTask实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.omsOrderTaskService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取OmsOrderTask实例的分页查询结果")
	public SmartView list(Integer ordeId,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(ordeId))
		{
			queryFilter.addNumberFieldEqualCondition("e.orde_id", ordeId);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}

		if(UserLoginRegister.currentUserHasRole("APP_ORDER_MNG") || UserLoginRegister.currentUserIsSuperAdmin()
				|| UserLoginRegister.currentUserIsAppAdmin() || UserLoginRegister.currentUserIsSysAdmin()){

		}else if(UserLoginRegister.currentUserHasRole("APP_TASK_OPER")){
			queryFilter.addNumberFieldEqualCondition("e.holder_user_id", UserLoginRegister.currentUserId());
		}

		PagingBean page = this.omsOrderTaskService.queryRecords(queryFilter,pageSize,pageIndex);
		// TODO 导出时使用 List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class); 
		// ExcelDataUtil.createExcelByMapList(page.getData(),headers).write(outputStream);
		//在Service中构建PagingBean实例
		return this.pageView(page);
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("按当前用户获取OmsOrderTask实例的分页查询结果")
	public SmartView listByUser(Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		Integer cuid = UserLoginRegister.currentUserId();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(cuid))
		{
			queryFilter.addNumberFieldEqualCondition("e.holder_user_id", cuid);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.omsOrderTaskService.queryRecords(queryFilter,pageSize,pageIndex);
		// TODO 导出时使用 List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class); 
		// ExcelDataUtil.createExcelByMapList(page.getData(),headers).write(outputStream);
		//在Service中构建PagingBean实例
		return this.pageView(page);
	}

	@SmartComment("按任务编号获取任务处理历史")
	public SmartView loadOneTaskOpHistory(Integer taskId){
		return SmartView.SUCCESS(this.omsOrderTaskService.loadOneTaskOpHistory(taskId));
	}

	public SmartView loadTaskOpHistoryByUserId(Integer taskId, Integer userId){
		return SmartView.SUCCESS(this.omsOrderTaskService.loadTaskOpHistoryByUser(taskId,userId));
	}

	@SmartComment("按任务处理历史记录编号获取记录关联文件")
	public SmartView loadOphFileInfos(Integer historyId){
		return SmartView.SUCCESS(this.omsOrderTaskService.loadOphFileInfos(historyId));
	}

	@SmartComment("删除任务处理历史编号关联的文件")
	public SmartView deleteFileAndLink(String fileId)
	{
		return this.dbAccess(this.omsOrderTaskService.deleteFileAndLink(fileId));
	}
	//参数名 file 请勿轻易修改
	@SmartComment("Excel文件导入")
	public SmartView importFile(File file)
	{
		return SmartView.SUCCESS();
	}
}

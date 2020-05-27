package com.sf.web.si.customer.control;

import java.util.*;
import java.io.File;

import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.si.customer.service.ActivityMemberService;
import com.sf.web.si.customer.entity.ActivityMember;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    ActivityMemberControl.java SmartWeb Code Plugin Created.
 * @date    2018/05/29
 */
@SmartComment("ActivityMember实例增删改查接口层")
public class ActivityMemberControl extends BasicControl
{
	private ActivityMemberService 	activityMemberService;//Service
	
	public ActivityMemberService getActivityMemberService()
	{
		return activityMemberService;
	}
	
	public void setActivityMemberService(ActivityMemberService activityMemberService)
	{
		this.activityMemberService=activityMemberService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存ActivityMember实例")
	public SmartView save(ActivityMember activityMember)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityMemberService.save(activityMember));
	}
	
	@SmartComment("按ID列表删除ActivityMember对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityMemberService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除ActivityMember对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityMemberService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个ActivityMember实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.activityMemberService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取ActivityMember实例的分页查询结果")
	public SmartView list(String name,Integer activityId,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(name))
		{
			queryFilter.addStringFieldLikeCondition("e.name", name);
		}
		if(!ParameterUtils.isEmptyOrNull(activityId))
		{
			queryFilter.addNumberFieldEqualCondition("e.activity_id", activityId);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.activityMemberService.queryRecords(queryFilter,pageSize,pageIndex);
		// TODO 导出时使用 List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class); 
		// ExcelDataUtil.createExcelByMapList(page.getData(),headers).write(outputStream);
		//在Service中构建PagingBean实例
		return this.pageView(page);
		
	}
	//参数名 file 请勿轻易修改
	@SmartComment("Excel文件导入")
	public SmartView importFile(File file)
	{
		return SmartView.SUCCESS();
	}
}

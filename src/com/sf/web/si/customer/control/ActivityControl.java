package com.sf.web.si.customer.control;

import java.util.*;
import java.io.File;
import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;

import com.smartframework.core.dao.page.PagingBean;

import com.sf.web.si.customer.service.ActivityService;
import com.sf.web.si.customer.entity.Activity;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    ActivityControl.java chenth
 * @date    2020/05/28
 */
@SmartComment("Activity实例增删改查接口层")
public class ActivityControl extends BasicControl
{
	private ActivityService 	activityService;//Service
	
	public ActivityService getActivityService()
	{
		return activityService;
	}
	
	public void setActivityService(ActivityService activityService)
	{
		this.activityService=activityService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存Activity实例")
	public SmartView save(Activity activity)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityService.save(activity));
	}
	
	@SmartComment("按ID列表删除Activity对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除Activity对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.activityService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个Activity实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.activityService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取Activity实例的分页查询结果")
	public SmartView list(String name,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(name))
		{
			queryFilter.addStringFieldLikeCondition("e.name", name);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.activityService.queryRecords(queryFilter,pageSize,pageIndex);
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

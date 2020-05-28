package com.sf.web.si.config.control;

import java.util.*;
import java.io.File;
import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;

import com.smartframework.core.dao.page.PagingBean;

import com.sf.web.si.config.service.SysManagerService;
import com.sf.web.si.config.entity.ComTagDef;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    SysManagerControl.java chenth
 * @date    2020/05/22
 */
@SmartComment("ComTagDef实例增删改查接口层")
public class SysManagerControl extends BasicControl
{
	private SysManagerService 	sysManagerService;//Service
	
	public SysManagerService getSysManagerService()
	{
		return sysManagerService;
	}
	
	public void setSysManagerService(SysManagerService sysManagerService)
	{
		this.sysManagerService=sysManagerService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存ComTagDef实例")
	public SmartView save(ComTagDef comTagDef)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.sysManagerService.save(comTagDef));
	}
	
	@SmartComment("按ID列表删除ComTagDef对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.sysManagerService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除ComTagDef对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.sysManagerService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个ComTagDef实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.sysManagerService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取ComTagDef实例的分页查询结果")
	public SmartView listTags(String name,Integer pageSize,Integer pageIndex,String columns,String method)
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
		PagingBean page = this.sysManagerService.queryTagRecords(queryFilter,pageSize,pageIndex);
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

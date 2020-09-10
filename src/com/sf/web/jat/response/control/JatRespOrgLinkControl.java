package com.sf.web.jat.response.control;

import java.util.*;
import java.io.*;

import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.jat.response.service.JatRespOrgLinkService;
import com.sf.web.jat.response.entity.JatRespOrgLink;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    JatRespOrgLinkControl.java <br>
 * @auth	SmartWeb Code Plugin Created. <br>
 * @date    2020/08/08
 * 注意:请不要以get、set作为接口方法名的前缀
 */
@SmartComment("JatRespOrgLink实例增删改查接口层")
public class JatRespOrgLinkControl extends BasicControl
{
	private JatRespOrgLinkService 	jatRespOrgLinkService;//Service
	
	public JatRespOrgLinkService getJatRespOrgLinkService()
	{
		return jatRespOrgLinkService;
	}
	
	public void setJatRespOrgLinkService(JatRespOrgLinkService jatRespOrgLinkService)
	{
		this.jatRespOrgLinkService=jatRespOrgLinkService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存JatRespOrgLink实例")
	public SmartView save(Integer respId, Integer incharge, List<Integer> participate, List<Integer> relate)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespOrgLinkService.save(respId, incharge, participate, relate));
	}
	
	@SmartComment("按ID列表删除JatRespOrgLink对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespOrgLinkService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除JatRespOrgLink对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespOrgLinkService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个JatRespOrgLink实例")
	public SmartView loadOne(Integer respId)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.jatRespOrgLinkService.loadOne(respId));
	}
	
	@SmartComment("获取JatRespOrgLink实例的分页查询结果")
	public SmartView list(String name,Integer pageSize,Integer pageIndex,String sortField,String sortOrder,String columns,String method)
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
		//设置分页和排序
		queryFilter.addSorted(sortField, sortOrder);
		queryFilter.setPageInfo(pageSize, pageIndex);
		
		PagingBean page = this.jatRespOrgLinkService.queryRecords(queryFilter);
		return this.pageView(page);
	}

	@SmartComment("用户对应的职责")
	public SmartView listCurrUserRespByRespType(Integer respType,Integer pageSize,Integer pageIndex,String sortField,String sortOrder)
	{
		QueryFilter queryFilter = new QueryFilter();
		if(!ParameterUtils.isEmptyOrNull(respType))
		{
			queryFilter.addNumberFieldEqualCondition("e2.type", respType);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		//设置分页和排序
		queryFilter.addSorted(sortField, sortOrder);
		queryFilter.setPageInfo(pageSize, pageIndex);
		
		PagingBean page = this.jatRespOrgLinkService.queryCurrUserRespByRespType(queryFilter);
		return this.pageView(page);
	}

	//参数名 file 请勿轻易修改
	@SmartComment("Excel文件导入")
	public SmartView importFile(File file)
	{
		return SmartView.SUCCESS();
	}
}

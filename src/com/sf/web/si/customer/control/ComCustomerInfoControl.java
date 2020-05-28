package com.sf.web.si.customer.control;

import java.util.*;
import java.io.File;

import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.system.index.entity.UserLoginRegister;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.si.customer.service.ComCustomerInfoService;
import com.sf.web.si.customer.entity.ComCustomerInfo;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    ComCustomerInfoControl.java chenth
 * @date    2020/05/28
 */
@SmartComment("ComCustomerInfo实例增删改查接口层")
public class ComCustomerInfoControl extends BasicControl
{
	private ComCustomerInfoService 	comCustomerInfoService;//Service
	
	public ComCustomerInfoService getComCustomerInfoService()
	{
		return comCustomerInfoService;
	}
	
	public void setComCustomerInfoService(ComCustomerInfoService comCustomerInfoService)
	{
		this.comCustomerInfoService=comCustomerInfoService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存ComCustomerInfo实例")
	public SmartView save(ComCustomerInfo comCustomerInfo)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.comCustomerInfoService.save(comCustomerInfo));
	}
	
	@SmartComment("按ID列表删除ComCustomerInfo对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.comCustomerInfoService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除ComCustomerInfo对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.comCustomerInfoService.delete(ids,false));
	}
	
	@SmartComment("按ID获取单个ComCustomerInfo实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.comCustomerInfoService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取ComCustomerInfo实例的分页查询结果")
	public SmartView list(String name,String phone,String email,Integer agegt,Integer agelt,Integer fastFilter,Integer pageSize,Integer pageIndex,String columns,String method)
	{
		Integer currUserId = UserLoginRegister.currentUserId();
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(name))
		{
			queryFilter.addStringFieldLikeCondition("e.name", name);
		}
		if(!ParameterUtils.isEmptyOrNull(phone))
		{
			queryFilter.addStringFieldLikeCondition("e.phone", phone);
		}
		if(!ParameterUtils.isEmptyOrNull(email))
		{
			queryFilter.addStringFieldLikeCondition("e.email", email);
		}
		if(!ParameterUtils.isEmptyOrNull(agegt))
		{
			queryFilter.addDateFieldLessEqualCondition("e.birthday", DateUtil.addYears(new Date(), -1 * agegt));
		}
		if(!ParameterUtils.isEmptyOrNull(agelt))
		{
			queryFilter.addDateFieldGreaterEqualCondition("e.birthday", DateUtil.addYears(new Date(), -1 * agelt));
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.comCustomerInfoService.queryRecords(currUserId,fastFilter,queryFilter,pageSize,pageIndex);
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
	
	@SmartComment("更新ComCustomerInfo对象的最近拜访时间为当前时间")
	public SmartView visit(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.comCustomerInfoService.visit(ids));
	}
	
	@SmartComment("获取ComCustomerInfo实例的分页查询结果")
	public SmartView todoList(int dayInterval, int dayAhead, int dayCurrent)
	{
		List<Map<String,Object>> list = this.comCustomerInfoService.getTodoList(dayInterval, dayAhead, dayCurrent);
		return SmartView.SUCCESS(list);
	}
}

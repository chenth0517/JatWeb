package com.sf.web.jat.response.control;

import java.util.*;
import java.io.*;
import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;

import com.smartframework.core.dao.page.PagingBean;

import com.sf.web.jat.response.service.JatRespDepService;
import com.sf.web.jat.response.entity.JatRespDep;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    JatRespDepControl.java <br>
 * @auth	SmartWeb Code Plugin Created. <br>
 * @date    2020/05/29
 * 注意:请不要以get、set作为接口方法名的前缀
 */
@SmartComment("JatRespDep实例增删改查接口层")
public class JatRespDepControl extends BasicControl
{
	private JatRespDepService 	jatRespDepService;//Service
	
	public JatRespDepService getJatRespDepService()
	{
		return jatRespDepService;
	}
	
	public void setJatRespDepService(JatRespDepService jatRespDepService)
	{
		this.jatRespDepService=jatRespDepService;
	}
	
	//CRUD 操作列表
	@SmartComment("保存JatRespDep实例")
	public SmartView save(JatRespDep jatRespDep)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespDepService.save(jatRespDep));
	}
	
	@SmartComment("按ID列表删除JatRespDep对象")
	public SmartView delete(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespDepService.delete(ids,false));
	}
	
	@SmartComment("按ID列表彻底删除JatRespDep对象")
	public SmartView deletePermanently(List<Integer> ids)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespDepService.delete(ids,false));
	}
	
	@SmartComment("按ID列表删除JatRespDep对象")
	public SmartView changeOrder(Integer id, Integer isDown)
	{
		//TODO 请先验证参数有效性再使用
		return this.dbAccess(this.jatRespDepService.changeOrder(id, isDown));
	}
	
	@SmartComment("按ID获取单个JatRespDep实例")
	public SmartView loadOne(Integer id)
	{
		//TODO 请先验证参数有效性再使用
		return SmartView.SUCCESS(this.jatRespDepService.get(id));
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取JatRespDep实例的分页查询结果")
	public SmartView list(String name,Integer pid,Integer pageSize,Integer pageIndex,String sortField,String sortOrder,String columns,String method)
	{
		QueryFilter queryFilter = new QueryFilter();
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(name))
		{
			queryFilter.addStringFieldLikeCondition("e.name", name);
		}
		if(!ParameterUtils.isEmptyOrNull(pid))
		{
			queryFilter.addNumberFieldEqualCondition("e.pid", pid);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		//设置分页和排序
		queryFilter.addSorted(sortField, sortOrder);
		queryFilter.setPageInfo(pageSize, pageIndex);
		
		PagingBean page = this.jatRespDepService.queryRecords(queryFilter);
		// TODO 导出时使用
		// if("export".equals(method))
		// {
		// 		List<HeaderConfig> headers = JsonUtil.getBeanListByJsonArray(columns, HeaderConfig.class); 
		// 		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		//			try
		//			{
		//				ExcelDataUtil.createExcelByMapList(page.getData(), headers).write(outputStream);
		//			}
		//			catch (IOException e)
		//			{
		//				return SmartView.ERROR(I18n.message("error.excel.export", new Object[] { e.getMessage() }));
		//			}
		//		return SmartView.FileView(outputStream, "文件.xls");
		//}
		//在Service中构建PagingBean实例,建议使用 return SmartView.pagingData(page); 代替下面语句
		return this.pageView(page);
		
	}
	
	//参数名 file 请勿轻易修改
	@SmartComment("Excel文件导入")
	public SmartView importFile(File file)
	{
		return SmartView.SUCCESS();
	}
	
	@SmartComment("获取所有设备类型")
	public SmartView loadSysOrg() {
		return SmartView.SUCCESS(this.jatRespDepService.loadSysOrg());
	}
}

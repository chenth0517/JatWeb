package com.sf.web.jat.addition.control;

import java.util.*;
import java.io.*;

import com.smartframework.web.core.util.*;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.bean.HeaderConfig;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.core.dao.page.PagingBean;
import com.sf.web.jat.addition.service.JatSysAdditionService;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.smart.SmartView;
/**
 * @desc    JatSysAdditionControl.java <br>
 * @auth	SmartWeb Code Plugin Created. <br>
 * @date    2020/05/29
 * 注意:请不要以get、set作为接口方法名的前缀
 */
@SmartComment("JatSysAddition实例增删改查接口层")
public class JatSysAdditionControl extends BasicControl
{
	private JatSysAdditionService 	jatSysAdditionService;//Service
	
	public JatSysAdditionService getJatSysAdditionService()
	{
		return jatSysAdditionService;
	}
	
	public void setJatSysAdditionService(JatSysAdditionService jatSysAdditionService)
	{
		this.jatSysAdditionService=jatSysAdditionService;
	}
	
	//method标识是否执行导出,并根据pageSize<0确定是否全部导出
	@SmartComment("获取JatSysAddition实例的分页查询结果")
	public SmartView listRoleString()
	{
		Map<String, String> result = this.jatSysAdditionService.queryRoleListString();
		return SmartView.SUCCESS(result);
	}
	
}

package com.sf.web.si.config.control;

import java.util.List;
import java.util.Map;

import com.sf.web.si.config.service.MainService;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.core.smart.SmartView;
import com.smartframework.web.core.control.BasicControl;
import com.smartframework.web.core.queryfilter.QueryFilter;
import com.smartframework.web.core.util.ParameterUtils;
import com.smartframework.web.system.index.entity.UserLoginRegister;

public class MainControl extends BasicControl{
	
	private MainService mainService;
	

	public MainService getMainService() {
		return mainService;
	}

	public void setMainService(MainService mainService) {
		this.mainService = mainService;
	}

	@SmartComment("未解决工单")
	public SmartView listOrder(Integer pageSize,Integer pageIndex)
	{
		QueryFilter queryFilter = new QueryFilter();
		Integer cuid = UserLoginRegister.currentUserId();
		queryFilter.addNumberFieldNotEqualCondition("c.status", 4);
		//在这里根据输入的查询参数构建QueryFilter实例并执行 Service中默认SQL对象的别名是 e
		if(!ParameterUtils.isEmptyOrNull(cuid))
		{
			queryFilter.addNumberFieldEqualCondition("e.holder_user_id", cuid);
		}
		if(pageSize==null||pageIndex==null)
		{
			return SmartView.ERROR(I18n.message("error.parameter.empty","分页参数{0}不能为空",new Object[]{"pageIndex,pageSize"}));
		}
		PagingBean page = this.mainService.queryOrderInfo(queryFilter,pageSize,pageIndex);

		return this.pageView(page);
	}
	@SmartComment("统计工单数")
	public SmartView countOrder()
	{
		Integer cuid = UserLoginRegister.currentUserId();

		 List<Map<String, Object>> l = this.mainService.countOrder(cuid);
		 
		return SmartView.SUCCESS(l);
	}
	@SmartComment("统计最近七天关闭的工单")
	public SmartView computedClosedOrder()
	{
		Integer cuid = UserLoginRegister.currentUserId();
		
		 List<Map<String, Object>> l = this.mainService.computedClosedOrder(cuid);
		 
		return SmartView.SUCCESS(l);
	}
}

package com.smartframework.tasks;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sf.web.si.config.service.EmployeeService;
import com.sf.web.si.config.service.impl.EmployeeServiceImpl;
import com.sf.web.si.customer.service.ComCustomerInfoService;
import com.sf.web.si.customer.service.impl.ComCustomerInfoServiceImpl;
import com.smartframework.core.annotation.SmartComment;
import com.smartframework.core.annotation.SmartTaskAutoStart;
import com.smartframework.core.schedule.SmartQuartzTask;
import com.smartframework.core.smart.SmartHelper;
import com.smartframework.web.core.util.IMSenderUtil;
import com.smartframework.web.server.message.control.MsgMngControl;

@SmartComment("日期提醒服务")
@SmartTaskAutoStart
public class NotificationTask extends SmartQuartzTask
{
	private static final long serialVersionUID = 905827394380591089L;
	
	public NotificationTask()
	{
		super();
		this.setGroup("JetWeb");
		this.setName("NotificationTask");
		this.setNotes("日期提醒服务");
		/**
		 * 设置定时任务周期
		 */
		this.setCron("0 0 7 1/1 * ?");
		//this.setCron("0 1/1 * * * ?");
	}
	@Override
	public void run()
	{
		// TODO Auto-generated method stub
		ComCustomerInfoService comCustomerInfoService = SmartHelper.getBean(ComCustomerInfoService.class);
		
		System.out.println("定期拜访提醒服务");
		List<Map<String,Object>> customerInfoMap = comCustomerInfoService.getCustomersForTimingNotify(90);//90天未联系的客户
		for(int i=0;i<customerInfoMap.size();i++)
		{
			Map<String,Object> customerInfo = customerInfoMap.get(i);
			Map<String, Object> vars = new HashMap<String, Object>();
			String customerName = customerInfo.get("customerName").toString();
			Object obj = customerInfo.get("serviceEmail");
			if (obj != null)
			{
				String emailAddr = obj.toString();
				vars.put("customer", customerName);
				vars.put("day", "90");
				boolean ok = IMSenderUtil.sendMessage(new String[]{emailAddr}, vars, "TimingNotify");
				if(ok)
				{
					System.out.println("定期拜访提醒服务：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的定期拜访提醒成功");
				}
				else
				{
					System.err.println("定期拜访提醒服务：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的定期拜访提醒失败");
				}
			}
		}
		
		System.out.println("生日问候[提前7天]提醒服务");
		customerInfoMap = comCustomerInfoService.getCustomersForBirthdayNotify(7);//7天后过生日的客户
		for(int i=0;i<customerInfoMap.size();i++)
		{
			Map<String,Object> customerInfo = customerInfoMap.get(i);
			Map<String, Object> vars = new HashMap<String, Object>();
			String customerName = customerInfo.get("customerName").toString();
			String birthday = customerInfo.get("customerBirthday").toString();
			Object obj = customerInfo.get("serviceEmail");
			if (obj != null)
			{
				String emailAddr = obj.toString();
				vars.put("customer", customerName);
				vars.put("date", birthday);
				vars.put("day", "7");
				boolean ok = IMSenderUtil.sendMessage(new String[]{emailAddr}, vars, "BirthdayNotify7");
				if(ok)
				{
					System.out.println("生日问候提醒服务[提前7天]：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的生日问候提醒成功");
				}
				else
				{
					System.err.println("生日问候提醒服务[提前7天]：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的生日问候提醒失败");
				}
			}
		}
		
		System.out.println("生日问候[今日]提醒服务");
		customerInfoMap = comCustomerInfoService.getCustomersForBirthdayNotify(0);//7天后过生日的客户
		for(int i=0;i<customerInfoMap.size();i++)
		{
			Map<String,Object> customerInfo = customerInfoMap.get(i);
			Map<String, Object> vars = new HashMap<String, Object>();
			String customerName = customerInfo.get("customerName").toString();
			String birthday = customerInfo.get("customerBirthday").toString();
			Object obj = customerInfo.get("serviceEmail");
			if (obj != null)
			{
				String emailAddr = obj.toString();
				vars.put("customer", customerName);
				vars.put("date", birthday);
				vars.put("day", "7");
				boolean ok = IMSenderUtil.sendMessage(new String[]{emailAddr}, vars, "BirthdayNotify0");
				if(ok)
				{
					System.out.println("生日问候提醒服务[今日]：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的生日问候提醒成功");
				}
				else
				{
					System.err.println("生日问候提醒服务[今日]：向邮箱 "+emailAddr+" 发送"+"客户  "+customerName+" 的生日问候提醒失败");
				}
			}
		}
	}

}

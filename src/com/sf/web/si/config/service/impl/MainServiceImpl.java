package com.sf.web.si.config.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.sf.web.si.config.service.MainService;
import com.sf.web.si.order.dao.OmsOrderMainOrmDao;
import com.sf.web.si.order.entity.OmsOrderMain;
import com.smartframework.core.dao.JdbcDao;
import com.smartframework.core.dao.page.PagingBean;
import com.smartframework.core.i18n.I18n;
import com.smartframework.web.core.queryfilter.QueryFilter;

public class MainServiceImpl implements MainService {
	private JdbcDao						jdbcDao;
	private OmsOrderMainOrmDao     		omsOrderMainOrmDao;
	public JdbcDao getJdbcDao() {
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao) {
		this.jdbcDao = jdbcDao;
	}

	public OmsOrderMainOrmDao getOmsOrderMainOrmDao() {
		return omsOrderMainOrmDao;
	}

	public void setOmsOrderMainOrmDao(OmsOrderMainOrmDao omsOrderMainOrmDao) {
		this.omsOrderMainOrmDao = omsOrderMainOrmDao;
	}

	@Override
	public PagingBean queryOrderInfo(QueryFilter queryFilter,
			Integer pageSize, Integer pageIndex) {
		PagingBean bean = null;
		
		StringBuffer sql = new StringBuffer("");
		
		sql.append("select c.*,u.real_name as real_name from  oms_order_main c  left join oms_order_task e on e.orde_id = c.id left join sys_user u on u.id = e.holder_user_id  ");
	
		sql.append(queryFilter.getWhereSql());
		
		bean = jdbcDao.queryForPaging(sql.toString(), queryFilter.getConditionValues(), pageSize, pageIndex);
		
		return bean;
	}

	@Override
	public List<Map<String, Object>> countOrder(Integer respUser) {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		int []data = new int[4];
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		try{
			//先统计解决中的工单数
			List<OmsOrderMain> order = this.omsOrderMainOrmDao.findByRespUser(respUser);
			
			if(order==null||order.isEmpty())
			{
				return null;
			}
			for(OmsOrderMain o: order) 
			{
				if(o.getStatus()==1)
				{
					//新建的工单即未解决工单
					data[0]++;
				}else{
					if(o.getStatus()==2)
					{
						//解决中的工单数
						data[1]++;
					}else{
						if(o.getStatus()==3)
						{
							//已解决的工单
							data[2]++;
						}else{
							if(o.getStatus()==4)
							{
								//已关闭的工单
								data[3]++;
							}
						}
					}
				}
			}
		}catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
			map.put("new", data[0]);
			map.put("solving", data[1]);
			map.put("solved", data[2]);
			map.put("closed", data[3]);
			list.add(map);
			return list;
	}

	@Override
	public List<Map<String, Object>> computedClosedOrder(Integer respUser) {
		 Date dat = null;
		 int []data = new int[7];
		 List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		 Map<String, Object> map = new LinkedHashMap<String, Object>();
		 SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
		 List<String> l = new ArrayList<String>();
		 for(int i = -7;i<0;i++)
		 {
			 Calendar cd = Calendar.getInstance();
			 cd.add(Calendar.DATE, i);
			 dat = cd.getTime();
			 String date = dformat.format(dat);
			 l.add(date);
		 }
   //      System.out.println(l);
         //获取工单关闭日期，取其年月日
         List<OmsOrderMain> orderMain = this.omsOrderMainOrmDao.findByRespUser(respUser);
         if(orderMain==null||orderMain.isEmpty())
         {
        	 return null;
         }
         for(OmsOrderMain o : orderMain)
         {
        	 if(o.getStatus()!=4)
        	 {
        		 continue;
        	 }
        	 String closeDate = dformat.format(o.getCloseTime());
        	 //判断日期
        	 if(closeDate.equals(l.get(0)))
        	 {
        		 data[0]++;
        	 }else{
        		 if(closeDate.equals(l.get(1)))
        		 {
        			 data[1]++;
        		 }else{
        			 if(closeDate.equals(l.get(2)))
            		 {
            			 data[2]++;
            		 }else {
            			 if(closeDate.equals(l.get(3)))
                		 {
                			 data[3]++;
                		 }else {
                			 if(closeDate.equals(l.get(4)))
                    		 {
                    			 data[4]++;
                    		 }else{
                    			 if(closeDate.equals(l.get(5)))
                        		 {
                        			 data[5]++;
                        		 }else{
                        			 if(closeDate.equals(l.get(6)))
                            		 {
                            			 data[6]++;
                            		 }
                        		 }
                    		 }
                		 }
            		 }
        		 }
        	 }
         }
         map.put("zero", data[0]);
         map.put("one", data[1]);
         map.put("two", data[2]);
         map.put("three", data[3]);
         map.put("four", data[4]);
         map.put("five", data[5]);
         map.put("six", data[6]);
         list.add(map);
		return list;
         
	}

}

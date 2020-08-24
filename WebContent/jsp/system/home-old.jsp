<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仪表盘</title>
	<%@include file="../include/common-rss.jsp"%>
    <style>
        .header-label{
            height: 200px;
            font-size: 15px;
            border: 3px lightblue;
            background-color: #FFFACD;
        }
        .sys-notice{
        	height: 400px;
            font-size: 15px;
            margin-top: 10px;
            border: 3px lightblue;
            background-color: #FFFACD;
        }
        .org-div{
            float: left;
            width: 420px;
            height:500px;
        }
        .user-div{
        	
/*             margin-left: 420px; */
            min-width:1200px;
            height: 700px;
/*             background: #DDCEC3;  */
    		color: #333;
        }
        .order-info{
         	float: left;
          	margin-left: 10px;
            margin-bottom: 10px;
        	width: 300px;
            height:170px;
            background: #d3dce6;
    		color: #333;
        }
        .div{
        	float: left;
        	margin-top: 20px;
          	margin-left: 10px;
            margin-bottom: 10px;
        	width: 1190px;
            height:360px;
/*             background:#7fff00  */
        }
        .div1{
       		float: left;
          	margin-left: 10px;
          	padding-right: 10px;
/*             margin-bottom: 10px; */
        	width: 390px;
            height:390px;
            background: FloralWhite; 
/*             color: #333; */
            background: PaleTurquoise ;
        }
        .total-order
        {
        	float: left;
/*             margin-top: 10px; */
          	margin-left: 10px;
/*             margin-bottom: 10px; */
        	width: 700px;
            height:390px;
            background: FloralWhite; 
/*     		color: #333; */
        }
        .list-order
        {
        	float: left;
            margin-top: 10px; 
          	margin-left: 10px;
            margin-bottom: 10px;
        	width: 1110px;
            height:250px;
            background: SkyBlue; 
        }
        p{
			margin-top:20px;
			margin-left:20px;
			font-size:14px;
        }
    </style>
</head>
<body>
<div id="home-page">
	<div class="basic">
<!-- 	    		 <div class="org-div"> -->
<!-- 			            <div class="header-label"> -->
<!-- 			              	<p>公司公告</p> -->
<!-- 			                	<p> 管理员在管理中心【账户设置】中，编辑公司公告显示内容</p> -->
<!-- 			             </div> -->
<!-- 			          <div class="sys-notice"> -->
<!-- 			     		<p>系统公告</p> -->
<!-- 			     		<ul> -->
<!-- 			     			<li><a href="https://www.baidu.com" target="_blank" style="text-decoration:none;">社会主义好</a></li> -->
<!-- 			     			<li><a href="https://www.baidu.com" target="_blank" style="text-decoration:none;">党的接班人</a></li> -->
<!-- 			     			<li><a href="https://www.baidu.com" target="_blank" style="text-decoration:none;">迎接新时达</a></li> -->
<!-- 			     			<li><a href="https://www.baidu.com" target="_blank" style="text-decoration:none;">创美好未来</a></li> -->
<!-- 			     		</ul> -->
<!-- 		          	  </div> -->
<!-- 		          </div> -->
		          <div class="user-div">
		       		 <div class="div">
<!-- 		        		<div class="div1"> -->
<!-- 				         	<div class="order-info" style="background-color:#6A87BE;cursor:pointer;"onclick="window.location='./jsp/si/oms_order_main.jsp?defaultActive=4'" > -->
<!-- 					            <img style="margin-top:30px;margin-left:30px;" src="./resources/images/1.png" /> -->
<!-- 					            <font color="#FFFFFF" size=4>{{orderData[0].solving}}</font> -->
<!-- 					            <br><p style="margin-left:80px;font-size:15px;"><font color="#FFFFFF">解决中的工单</font></p> -->
<!-- 					        </div> -->
<!-- 					        <div class="order-info" style="background-color:#FC8675;cursor:pointer;" onclick="javascript:location.href='./jsp/si/oms_order_main.jsp?defaultActive=3'"> -->
<!-- 				         		<img style="margin-top:30px;margin-left:30px;" src="./resources/images/2.png"/> -->
<!-- 				         		<font color="#FFFFFF" size=4>{{orderData[0].new}}</font> -->
<!-- 				         		<br><p style="margin-left:80px;font-size:15px;"><font color="#FFFFFF">未解决的工单</font></p> -->
<!-- 				          	</div> -->
<!-- 				          	<div class="order-info" style="background-color:#5AB6DF;cursor:pointer;" onclick="javascript:location.href='./jsp/si/oms_order_main.jsp?defaultActive=5'"> -->
<!-- 				         		<img style="margin-top:30px;margin-left:30px;" src="./resources/images/3.png"/> -->
<!-- 				         		<font color="#FFFFFF" size=4>{{orderData[0].solved}}</font> -->
<!-- 				         		<br><p style="margin-left:80px;font-size:15px;"><font color="#FFFFFF">已解决的工单</font></p> -->
<!-- 				          	</div> -->
<!-- 				            <div class="order-info" style="background-color:#4ACACB;cursor:pointer;" onclick="javascript:location.href='./jsp/si/oms_order_main.jsp?defaultActive=6'"> -->
<!-- 				         		<img style="margin-top:30px;margin-left:30px;" src="./resources/images/4.png"/> -->
<!-- 				         		<font color="#FFFFFF" size=4>{{orderData[0].closed}}</font> -->
<!-- 				         		<br><p style="margin-left:80px;font-size:15px;"><font color="#FFFFFF">已关闭的工单数</font></p> -->
<!-- 				          	</div> -->
<!-- 				        </div> -->
				        <div class="div1">
			                <div style="margin-left:10px;margin-bottom:10px;">
			                <h1 style="font-size:15px;margin-top:10px;">待办事项提醒</h1>
			                </div>
			                <div id="home-page" style="height:335px; overflow:auto">
			                <ul>
			                	<li v-for="element in todoList">{{element.text}}</li>
			     			</ul>
			     			</div>
						</div>
					         <div class="total-order" style="background-color:#FFF5EE;color:white;" >
								<ve-line :data="chartData" :settings="chartSettings"></ve-line>
					   		 </div>
					    <div class="list-order">
							<div style="margin-left:10px;margin-bottom:10px;">
								<div id="header">
				                <h1 style="font-size:15px;">我的未解决工单</h1>
				                </div>
<!-- 								<div style="font-size:15px;float:left;margin-top:10px;">我的未解决工单</div>  -->
								<div id="more" style="float:right;">  
<!-- 								   	<el-button type="success" icon="fa-employee-plus" :disabled="!currentRow" @click="onQueryMore">查看更多</el-button> -->
								</div> 
							</div>
							<div style="margin-top:15px;">
						       <sf-table ref="employeeTable" 
						             highlight-current-row
						             @row-click="onQueryMore"
						             @current-change="onCurrentChange"
						             :height="150"
						             style="cursor:pointer"
						             :show-import="false" 
						             url="si/config/main/listOrder.do"
						           >
						            <el-table-column label="序号" prop="id" width="200" ></el-table-column>
				                    <el-table-column label="主题" prop="topic" width="200" ></el-table-column>
				                    <el-table-column label="状态" prop="status" width="150">
				                 	   <template scope="scope">
											<el-tag :type="onStatusTagType(scope)">{{onStatusTagText(scope)}}</el-tag>
										</template>
				                    </el-table-column>
				                    <el-table-column label="优先级" prop="priority" width="150">
				                     	<template scope="scope">
											<el-tag :type="onPriorityTagType(scope)">{{onPriorityTagText(scope)}}</el-tag>
										</template>
									</el-table-column>
				                    <el-table-column label="受理人" prop="realName" width="200"></el-table-column>
				                    <el-table-column label="工单关闭时间" prop="closeTime" ></el-table-column>
	              		  		</sf-table>
              		  		</div>
					    </div>
		          </div>
		</div>
	</div>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ajax.js"></script>
<script>

	var mapStatusTagType={1:"primary",2:"warning",3:"success",4:"gray"};
	var mapStatusTagText = {1:"新建",2:"解决中",3:"已解决",4:"已关闭"};
	var mapPriorityTagText={1:"低",2:"中",3:"高"};
	var mapPriorityTagType={1:"gray",2:"success",3:"danger"};
	
	var myDate = new Date();
	myDate.setDate(myDate.getDate() - 7);
	var dateArray = []; 
	var dateTemp; 
	var flag = 1; 
	var orderData = [];
	for (var i = 0; i < 7; i++) {
		    dateTemp =(myDate.getMonth()+1)+"-"+myDate.getDate();
		    dateArray.push(dateTemp);
		    myDate.setDate(myDate.getDate() + flag);
		}
    var userManagement = new Vue({
        el: '#home-page',
        data:{
        	myDate :new Date(),
			dateArray:[],
			todoList:[],
			orderData:[{"new":0,"solving":0,"solved":0,"closed":0}],
			dateTemp:'',
		    currentRow: null,
			flag:2,
			totalData:[{"zero":0,"one":0,"two":0,"three":0,"four":0,"five":0,"six":0}],
			chartData:{},
			chartSettings:{},
        },
        methods: {
        	 onCurrentChange:function(currentRow){
             	this.currentRow = currentRow;
             },
            onStatusTagType:function(scope){
                var status = Number(scope.row.status);
                return mapStatusTagType[status];
			},
            onStatusTagText:function(scope){
                var status = Number(scope.row.status);
                return mapStatusTagText[status];
			},
		    onPriorityTagType:function(scope){
	                var priority=Number(scope.row.priority);
	                return mapPriorityTagType[priority];
				},
	        onPriorityTagText:function (scope) {
	                var priority=Number(scope.row.priority);
	                return mapPriorityTagText[priority];
	            },	
	        onQueryMore:function(){
        		
        		 var self = this;
        		 console.log(self.currentRow);
        		var menu={};
				menu.id="工单处理";
				menu.name="工单处理";
				var para = this.currentRow;
				menu.url="./jsp/si/oms_order_main_deploy.jsp?orderId=" + self.currentRow.id;
                window.parent.systemManagement.tabs.push(menu);
                        window.parent.systemManagement.activeTab = "工单处理";
        	},
        	onGetOrderData:function(){
        		var self = this;
        		self.$post('si/config/main/countOrder.do', {
        		}, function(json) {
        				if(json.data==null)
        				{
        					self.orderData = [{"new":0,"solving":0,"solved":0,"closed":0}];
        				}else{
        					 self.orderData = json.data;
        					}
        				});
        	},
        	onComputed:function()
        	{
        		var self = this;
        		self.$post('si/config/main/computedClosedOrder.do', {
        		}, function(json) {
        			if(json.data==null)
        				{
        				 self.totalData =[{"zero":0,"one":0,"two":0,"three":0,"four":0,"five":0,"six":0}];
        				}else{
        					 self.totalData = json.data;
        					}
        			  self.chartData = {
        	                  columns: ['日期', '最近七天关闭工单数'],
        	                  rows: [
        	                    { '日期': dateArray[0], '最近七天关闭工单数': self.totalData[0].zero},
        	                    { '日期': dateArray[1], '最近七天关闭工单数': self.totalData[0].one},
        	                    { '日期': dateArray[2], '最近七天关闭工单数': self.totalData[0].two},
        	                    { '日期': dateArray[3], '最近七天关闭工单数': self.totalData[0].three},
        	                    { '日期': dateArray[4], '最近七天关闭工单数': self.totalData[0].four},
        	                    { '日期': dateArray[5], '最近七天关闭工单数': self.totalData[0].five},
        	                    { '日期': dateArray[6], '最近七天关闭工单数': self.totalData[0].six}
        	                  ]
        	                },
        	                self.chartSettings = {}
        				});
        			}
      		  },
        mounted:function(){
        	this.onGetOrderData();
        	this.onComputed();
        },
		created: function () {
			AjaxUtils.commitAction('si/customer/comCustomerInfo/todoList.do?dayInterval=90&dayAhead=7&dayCurrent=0', {
			}, function(json) {
				var todoDatas = json.data;
				for (var i = 0; i < todoDatas.length; i++) {
					if (todoDatas[i].timing == "1")
					{
						this.userManagement.todoList.push({text:"客户 ["+todoDatas[i].customerName+"] 已经有超过90天没有拜访过了。"});
					}
					else if (todoDatas[i].timing == "0")
					{
						this.userManagement.todoList.push({text:todoDatas[i].customerBirthday+"是客户 ["+todoDatas[i].customerName+"] 的生日，别忘了准备礼物并送上祝福哦。"});
					}
				}
			});
		}
    })
</script>
</body>
</html>
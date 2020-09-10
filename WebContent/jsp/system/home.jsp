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
            min-width:1200px;
            height: 700px;
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
          	margin-left: 20px;
            margin-right: 20px;
        }
        .div-incharge{
            background: SkyBlue;
            height: 800px;
        }
        .div-participate
        {
            background: PaleTurquoise;
            height: 800px;
        }
        .div-relate
        {
            background: FloralWhite;
            height: 800px;
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
		<div class="user-div">
			<div class="div">
				<el-row :gutter="20">
					<el-col :span="8">
						<div class="div-incharge">
							<div style="margin-left:10px;margin-bottom:10px;">
								<div id="header">
									<h1 style="padding-top:10px;font-size:15px;">我负责的职责</h1>
								</div>
							</div>
							<div style="margin-left:10px;margin-right:10px;">
							   <sf-table ref="employeeTable" 
									 highlight-current-row
									 @row-click="onQueryMore"
									 @current-change="onCurrentChange"
						             :height="700"
									 style="cursor:pointer"
									 :show-import="false" 
									 url="jat/response/jatRespOrgLink/listCurrUserRespByRespType.do?respType=1"
								   >
									<el-table-column label="职责名称" prop="respName" width="280"></el-table-column>
									<el-table-column label="职责类型" prop="respStatus_t_description" width="100"></el-table-column>
									<el-table-column label="职责状态" prop="respType_t_description" width="100"></el-table-column>
								</sf-table>
							</div>
						</div>
					</el-col>
					<el-col :span="8">
						<div class="div-participate">
							<div style="margin-left:10px;margin-bottom:10px;">
								<div id="header">
									<h1 style="padding-top:10px;font-size:15px;">我参与的职责</h1>
								</div>
							</div>
							<div style="margin-left:10px;margin-right:10px;">
							   <sf-table ref="employeeTable" 
									 highlight-current-row
									 @row-click="onQueryMore"
									 @current-change="onCurrentChange"
						             :height="700"
									 style="cursor:pointer"
									 :show-import="false" 
									 url="jat/response/jatRespOrgLink/listCurrUserRespByRespType.do?respType=2"
								   >
									<el-table-column label="职责名称" prop="respName" width="280"></el-table-column>
									<el-table-column label="职责类型" prop="respStatus_t_description" width="100"></el-table-column>
									<el-table-column label="职责状态" prop="respType_t_description" width="100"></el-table-column>
								</sf-table>
							</div>
						</div>
					</el-col>
					<el-col :span="8">
						<div class="div-relate">
							<div style="margin-left:10px;margin-bottom:10px;">
								<div id="header">
									<h1 style="padding-top:10px;font-size:15px;">与我相关的职责</h1>
								</div>
							</div>
							<div style="margin-left:10px;margin-right:10px;">
							   <sf-table ref="employeeTable" 
									 highlight-current-row
									 @row-click="onQueryMore"
									 @current-change="onCurrentChange"
						             :height="700"
									 style="cursor:pointer"
									 :show-import="false" 
									 url="jat/response/jatRespOrgLink/listCurrUserRespByRespType.do?respType=3"
								   >
									<el-table-column label="职责名称" prop="respName" width="280"></el-table-column>
									<el-table-column label="职责类型" prop="respStatus_t_description" width="100"></el-table-column>
									<el-table-column label="职责状态" prop="respType_t_description" width="100"></el-table-column>
								</sf-table>
							</div>
						</div>
					</el-col>
				</el-row>
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
			orderData:[{"new":0,"solving":0,"solved":0,"closed":0}],
			dateTemp:'',
		    currentRow: null,
			flag:2,
			totalData:[{"zero":0,"one":0,"two":0,"three":0,"four":0,"five":0,"six":0}],
        },
        methods: {
        	 onCurrentChange:function(currentRow){
             	this.currentRow = currentRow;
             },
            onStatusTagType:function(scope){
                var status = Number(scope.row.status);
                return mapStatusTagType[status];
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
        				});
        			}
      		  },
        mounted:function(){
        	this.onGetOrderData();
        	this.onComputed();
        },
		created: function () {
			
		}
    })
</script>
</body>
</html>
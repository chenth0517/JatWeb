<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/common-rss.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>oms_order_task-维护页面</title>
	<style>
		.inline-toolbar div{
			display:inline-block;
		}
		.el-dialog--tiny{
			width:50%;
		}
	</style>
</head>
<st:jspId value="oms_order_task"></st:jspId>
<body>
<div id="vue_homepage">
	<el-row>
		<el-col :span="14">
			<sf-panel title="我的任务列表" v-cloak>
				<el-row>
					<div class="oms_order_task-div">
						<sf-table ref="omsOrderTaskTable"
								  highlight-current-row
								  :height="500"
								  url="si/order/omsOrderTask/listByUser.do"
								  :show-import="false"
								  @current-change="onCurrentChange">
								<el-table-column width="70" label="编号" prop="id"></el-table-column>
								<el-table-column label="任务名称" prop="name"></el-table-column>
								<el-table-column width="180" label="创建时间" prop="createTime"></el-table-column>
								<el-table-column width="180" label="最后期限" prop="dueDate"></el-table-column>
								<el-table-column width="100" label="工单编号" prop="ordeId"></el-table-column>
								<el-table-column width="160" label="操作" width="150">
								<template scope="scope">
									<el-button size="mini" type="success" icon="edit" @click="onProcessTask(scope.row)">处理</el-button>
									<el-button size="mini" type="danger" icon="fa-gavel" @click="deleteOmsOrderTask(scope.row)">拒绝</el-button>
								</template>
							</el-table-column>
						</sf-table>
					</div>
				</el-row>
			</sf-panel>
		</el-col>
		<el-col :span="10">
			<sf-panel title="与我有关的工单列表" v-cloak>
				<el-row>
					<div class="oms_order_main-div">
						<sf-table ref="omsOrderMainTable"
								  highlight-current-row
								  :height="500"
								  url="si/order/orderMng/listByUser.do"
								  :show-import="false"
								  @current-change="onCurrentChange">
							<el-table-column width="70" label="编号" prop="id"></el-table-column>
							<el-table-column width="180" label="受理时间" prop="createTime"></el-table-column>
							<el-table-column label="主题" prop="topic"></el-table-column>
							<el-table-column width="100" label="客户编号" prop="customerId"></el-table-column>
							<el-table-column width="90" label="操作">
								<template scope="scope">
									<el-button size="mini" type="success" icon="fa-binoculars"  @click="checkOmsOrder(scope.row)">查看</el-button>
								</template>
							</el-table-column>
						</sf-table>
					</div>
				</el-row>
			</sf-panel>
		</el-col>
	</el-row>
	<sf-form-dialog ref="omsOrderTaskModal"
				 title="任务处理记录"
				 v-model="showOmsOrderTaskModal"
				 :edit-mode="omsOrderTaskEditMode"
				 url="si/order/omsOrderTask/save.do" 
				 :model="omsOrderTaskForm"
				 :rules="omsOrderTaskValidate"
				 @on-success="onOmsOrderTaskModalSuccess">
		<el-form-item label="工单编号" prop="id">
			<el-input v-model.trim="omsOrderTaskForm.id" placeholder="工单编号" readonly></el-input>
		</el-form-item>
		<el-form-item label="名称" prop="name">
			<el-input v-model.trim="omsOrderTaskForm.name" placeholder="名称" ></el-input>
		</el-form-item>
		<el-form-item label="任务受理人" prop="holderUserId">
			<el-input v-model.trim="omsOrderTaskForm.holderUserId" placeholder="任务受理人" ></el-input>
		</el-form-item>
		<el-form-item label="创建时间" prop="createTime">
			<el-date-picker v-model="omsOrderTaskForm.createTime" @change="setFormatCreateTime" format="yyyy-MM-dd HH:mm:ss" type="datetime" placeholder="选择时间" style="width: 200px;"></el-date-picker>
		</el-form-item>
		<el-form-item label="最后期限" prop="dueDate">
			<el-date-picker v-model="omsOrderTaskForm.dueDate" @change="setFormatDueDate" format="yyyy-MM-dd HH:mm:ss" type="datetime" placeholder="选择时间" style="width: 200px;"></el-date-picker>
		</el-form-item>
		<el-form-item label="处理内容" prop="content">
			<el-input v-model.trim="omsOrderTaskForm.content" placeholder="处理内容" ></el-input>
		</el-form-item>
		<el-form-item label="工单编号" prop="ordeId">
			<el-input v-model.trim="omsOrderTaskForm.ordeId" placeholder="工单编号" ></el-input>
		</el-form-item>
	</sf-form-dialog>
	
	<div>
		<task-process v-model="taskProcessdialogVisible" :task-id="taskId" @refreshtable="onRefreshTaskTable"></task-process>
	</div>
</div>
<script>

	var homepage = new Vue({
		el: '#vue_homepage',
		components:{
            'task-process': loadComponent(webRootPath + 'jsp/components/oms_order_task_process.vue')
		},
        data: {
			//根据需要填写查询字段
			queryCondition: {
				name: ''
			},
			currentRow: null,
			omsOrderTaskTableColumns: [
				{
					title: '工单编号',
					key: 'id'
				},
				{
					title: '名称',
					key: 'name'
				},
				{
					title: '任务受理人',
					key: 'holderUserId'
				},
				{
					title: '创建时间',
					key: 'createTime'
				},
				{
					title: '最后期限',
					key: 'dueDate'
				},
				{
					title: '处理内容',
					key: 'content'
				},
				{
					title: '工单编号',
					key: 'ordeId'
				}
			],
			showOmsOrderTaskModal: false,
			omsOrderTaskEditMode: false,
			omsOrderTaskForm: {
				id: null ,
				name: null ,
				holderUserId: null ,
				createTime: null ,
				dueDate: null ,
				content: null ,
				ordeId: null 
			},
			omsOrderTaskValidate: {
				//此处添加字段数据合理性验证
				//id: [{required: true, message: '工单编号不能为空', trigger: 'blur'}],
			},			
			//////////////////
			omsOrderMainTableColumns: [
				{
					title: '工单ID',
					key: 'id'
				},
				{
					title: '主题',
					key: 'topic'
				},
				{
					title: '受理内容',
					key: 'content'
				},
				{
					title: '客户编号',
					key: 'customerId'
				},
				{
					title: '受理人',
					key: 'respUser'
				},
				{
					title: '状态（新建、解决中、已解决、已关闭）',
					key: 'status'
				},
				{
					title: '优先级',
					key: 'priority'
				},
				{
					title: '受理时间',
					key: 'createTime'
				},
				{
					title: '模板工单的流程实例ID',
					key: 'instanceId'
				}
			],
			taskProcessdialogVisible:false,
		},
		methods: {
			handleClick:function(row) {
				this.currentRow = row;
			},
			setFormatCreateTime:function(val){
				//设置创建时间为格式化时间字符串
				this.omsOrderTaskForm.createTime = val;
			},
			setFormatDueDate:function(val){
				//设置最后期限为格式化时间字符串
				this.omsOrderTaskForm.dueDate = val;
			},
			onCurrentChange: function(currentRow){
				this.currentRow = currentRow;
			},
			editOmsOrderTask: function (row) {
				this.omsOrderTaskForm.id = row.id;

				var menu={};
				menu.id="工单处理";
				menu.name="工单处理";
				menu.url="jsp/si/oms_order_main_deploy.jsp?orderId=" + row.id;
                window.parent.systemManagement.tabs.push(menu);
                window.parent.systemManagement.activeTab = "工单处理";
				
			},
			onOmsOrderTaskModalSuccess: function () {
				this.$refs['omsOrderTaskTable'].reload();
			},
			deleteOmsOrderTask: function (row) {
				var self = this;
				this.$confirm("拒绝任务[" + row.name + ']将会删除相关记录，请确认?','提示',{
					type: 'warning',
					callback: function(action){
						if(action === 'confirm'){
							self.$post('si/order/omsOrderTask/delete.do', {ids: [row.id]}, function () {
								self.$message.success('删除成功！');
								self.$refs['omsOrderTaskTable'].reload();
							});
						}
					}
				});
			},
			////////////////////////////////////////
			checkOmsOrder:function (row) {
				var menu={};
				menu.id="处理"+row.id+"号工单";
				menu.name="处理"+row.id+"号工单";
				var para = row;
				menu.url="jsp/si/oms_order_main_deploy.jsp?orderId=" + row.id;
                window.parent.systemManagement.tabs.push(menu);
                window.parent.systemManagement.activeTab = "处理"+row.id+"号工单";
            },
            onProcessTask:function (row) {
				this.taskProcessdialogVisible=true;
				this.taskId = row.id;
            },
		}
	});
</script>
</body>
</html>
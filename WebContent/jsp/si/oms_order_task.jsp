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
	</style>
</head>
<st:jspId value="oms_order_task"></st:jspId>
<body>
<div id="vue_oms_order_task">
    <sf-panel title="oms_order_task管理" v-cloak>
        <el-row>
            <div class="oms_order_task-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入检索关键字" v-model.trim="queryCondition.name" icon="search" style="width: 400px;"></el-input>
                        <el-button type="success" icon="search" @click="search">查询</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addOmsOrderTask">添加</el-button>
                    <el-button type="info" icon="edit" @click="editOmsOrderTask" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteOmsOrderTask" :disabled="!currentRow">删除</el-button>
                </sf-toolbar>
                <sf-table ref="omsOrderTaskTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="omsOrderTaskTableColumns"
                          url="si/order/omsOrderTask/list.do" 
                          import-url="si/order/omsOrderTask/importFile.do"
                          @current-change="onCurrentChange">
                        <el-table-column type="selection" width="50" align="center" reserve-selection></el-table-column>
                    	<el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    	<el-table-column label="工单编号" prop="id"></el-table-column>
                    	<el-table-column label="名称" prop="name"></el-table-column>
                    	<el-table-column label="任务受理人" prop="holderUserId"></el-table-column>
                    	<el-table-column label="创建时间" prop="createTime"></el-table-column>
                    	<el-table-column label="最后期限" prop="dueDate"></el-table-column>
                    	<el-table-column label="处理内容" prop="content"></el-table-column>
                    	<el-table-column label="工单编号" prop="ordeId"></el-table-column>
                    
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="omsOrderTaskModal"
                    title="oms_order_task"
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
</div>
<script>

    var omsOrderTaskManagement = new Vue({
        el: '#vue_oms_order_task',
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
            buttonLoading: false,
        },
        methods: {
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
            search: function() {
            	this.$refs['omsOrderTaskTable'].reload();
            },
            addOmsOrderTask: function () {
                this.omsOrderTaskForm.id = null;
                this.omsOrderTaskEditMode = false;
                this.showOmsOrderTaskModal = true;
            },
            editOmsOrderTask: function () {
                for(var key in this.omsOrderTaskForm){
                    if(this.currentRow[key])
                        this.omsOrderTaskForm[key] = this.currentRow[key];
                }
                this.omsOrderTaskEditMode = true;
                this.showOmsOrderTaskModal = true;
            },
            onOmsOrderTaskModalSuccess: function () {
                this.$refs['omsOrderTaskTable'].reload();
            },
            deleteOmsOrderTask: function () {
                var self = this;
                this.$confirm("确定删除[" + self.currentRow.name + ']?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/order/omsOrderTask/delete.do', {ids: [self.currentRow.id]}, function () {
                                self.$message.success('删除成功！');
                                self.$refs['omsOrderTaskTable'].reload();
                            });
                        }
                    }
                });
            }
        }
    })
</script>
</body>
</html>
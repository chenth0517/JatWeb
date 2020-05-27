<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>activity_member-维护页面</title>
    <style>
		.inline-toolbar div{
        	display:inline-block;
        }
	</style>
</head>
<st:jspId value="activity_member"></st:jspId>
<body>
<div id="vue_activity_member">
    <sf-panel title="activity_member管理" v-cloak>
        <el-row>
            <div class="activity_member-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入检索关键字" v-model.trim="queryCondition.name" icon="search" style="width: 400px;"></el-input>
                        <el-button type="success" icon="search" @click="search">查询</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addActivityMember">添加</el-button>
                    <el-button type="info" icon="edit" @click="editActivityMember" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteActivityMember" :disabled="!currentRow">删除</el-button>
                </sf-toolbar>
                <sf-table ref="activityMemberTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="activityMemberTableColumns"
                          url="si/customer/activityMember/list.do" 
                          import-url="si/customer/activityMember/importFile.do"
                          @current-change="onCurrentChange">
                        <el-table-column type="selection" width="50" align="center" reserve-selection></el-table-column>
                    	<el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    	<el-table-column label="编号" prop="id"></el-table-column>
                    	<el-table-column label="活动编号" prop="activityId"></el-table-column>
                    	<el-table-column label="客户编号" prop="customerId"></el-table-column>
                    	<el-table-column label="已邀请" prop="invited"></el-table-column>
                    	<el-table-column label="已确认" prop="confirm"></el-table-column>
                    	<el-table-column label="已拒绝" prop="reject"></el-table-column>
                    	<el-table-column label="预留人数" prop="seats"></el-table-column>
                    	<el-table-column label="到场人数" prop="appear"></el-table-column>
                    	<el-table-column label="备注" prop="comment"></el-table-column>
                    
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="activityMemberModal"
                    title="activity_member"
                    v-model="showActivityMemberModal"
                    :edit-mode="activityMemberEditMode"
                    url="si/customer/activityMember/save.do" 
                    :model="activityMemberForm"
                    :rules="activityMemberValidate"
                    @on-success="onActivityMemberModalSuccess">
        
					<el-form-item label="编号" prop="id">
			            <el-input v-model.trim="activityMemberForm.id" placeholder="编号" readonly></el-input>
			        </el-form-item>
					<el-form-item label="活动编号" prop="activityId">
			            <el-input v-model.trim="activityMemberForm.activityId" placeholder="活动编号" ></el-input>
			        </el-form-item>
					<el-form-item label="客户编号" prop="customerId">
			            <el-input v-model.trim="activityMemberForm.customerId" placeholder="客户编号" ></el-input>
			        </el-form-item>
					<el-form-item label="已邀请" prop="invited">
			            <el-input v-model.trim="activityMemberForm.invited" placeholder="已邀请" ></el-input>
			        </el-form-item>
					<el-form-item label="已确认" prop="confirm">
			            <el-input v-model.trim="activityMemberForm.confirm" placeholder="已确认" ></el-input>
			        </el-form-item>
					<el-form-item label="已拒绝" prop="reject">
			            <el-input v-model.trim="activityMemberForm.reject" placeholder="已拒绝" ></el-input>
			        </el-form-item>
					<el-form-item label="预留人数" prop="seats">
			            <el-input v-model.trim="activityMemberForm.seats" placeholder="预留人数" ></el-input>
			        </el-form-item>
					<el-form-item label="到场人数" prop="appear">
			            <el-input v-model.trim="activityMemberForm.appear" placeholder="到场人数" ></el-input>
			        </el-form-item>
					<el-form-item label="备注" prop="comment">
			            <el-input v-model.trim="activityMemberForm.comment" placeholder="备注" ></el-input>
			        </el-form-item>
    </sf-form-dialog>
</div>
<script>

    var activityMemberManagement = new Vue({
        el: '#vue_activity_member',
        data: {
        	//根据需要填写查询字段
            queryCondition: {
                name: ''
            },
            currentRow: null,
            activityMemberTableColumns: [
                {
                    title: '编号',
                    key: 'id'
                },
                {
                    title: '活动编号',
                    key: 'activityId'
                },
                {
                    title: '客户编号',
                    key: 'customerId'
                },
                {
                    title: '已邀请',
                    key: 'invited'
                },
                {
                    title: '已确认',
                    key: 'confirm'
                },
                {
                    title: '已拒绝',
                    key: 'reject'
                },
                {
                    title: '预留人数',
                    key: 'seats'
                },
                {
                    title: '到场人数',
                    key: 'appear'
                },
                {
                    title: '备注',
                    key: 'comment'
                }
            ],
            showActivityMemberModal: false,
            activityMemberEditMode: false,
            activityMemberForm: {
                id: null ,
                activityId: null ,
                customerId: null ,
                invited: null ,
                confirm: null ,
                reject: null ,
                seats: null ,
                appear: null ,
                comment: null 
            },
            activityMemberValidate: {
            	//此处添加字段数据合理性验证
                //id: [{required: true, message: '编号不能为空', trigger: 'blur'}],
            },
            buttonLoading: false,
        },
        methods: {
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            search: function() {
            	this.$refs['activityMemberTable'].reload();
            },
            addActivityMember: function () {
                this.activityMemberForm.id = null;
                this.activityMemberEditMode = false;
                this.showActivityMemberModal = true;
            },
            editActivityMember: function () {
                for(var key in this.activityMemberForm){
                    if(this.currentRow[key])
                        this.activityMemberForm[key] = this.currentRow[key];
                }
                this.activityMemberEditMode = true;
                this.showActivityMemberModal = true;
            },
            onActivityMemberModalSuccess: function () {
                this.$refs['activityMemberTable'].reload();
            },
            deleteActivityMember: function () {
                var self = this;
                this.$confirm("确定删除[" + self.currentRow.name + ']?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/customer/activityMember/delete.do', {ids: [self.currentRow.id]}, function () {
                                self.$message.success('删除成功！');
                                self.$refs['activityMemberTable'].reload();
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
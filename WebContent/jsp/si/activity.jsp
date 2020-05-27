<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>activity-维护页面</title>
    <style>
		.inline-toolbar div{
        	display:inline-block;
        }
        .el-dialog--tiny {
 			width: 40%;
 		}
 		.el-dialog--small {
		    width: 60%;
		}
	</style>
</head>
<st:jspId value="activity"></st:jspId>
<body>
<div id="vue_activity" v-cloak>
    <sf-panel title="活动信息">
        <el-row>
            <div class="activity-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入检索关键字" v-model.trim="queryCondition.name" icon="search" style="width: 400px;"></el-input>
                        <el-button type="success" icon="search" @click="search">查询</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addActivity">添加</el-button>
                    <el-button type="info" icon="edit" @click="editActivity" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteActivity" :disabled="!currentRow">删除</el-button>
                </sf-toolbar>
                <sf-table ref="activityTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="activityTableColumns"
                          url="si/customer/activity/list.do" 
                          import-url="si/customer/activity/importFile.do"
                          @current-change="onCurrentChange">
                        <el-table-column type="selection" width="50" align="center" reserve-selection></el-table-column> -->
<!--                     	<el-table-column label="#" prop="__index" width="50" align="center"></el-table-column> -->
<!--                    	<el-table-column label="编号" prop="id"></el-table-column> -->
                    	<el-table-column fixed width="120" label="名称" prop="name"></el-table-column>
                    	<el-table-column label="描述" prop="description"></el-table-column>
                    	<el-table-column width="180" label="开始时间" prop="beginTime"></el-table-column>
<!--                    	<el-table-column label="持续天数" prop="days"></el-table-column> -->
                    	<el-table-column label="地点" prop="place"></el-table-column>
                    	<el-table-column label="地址" prop="address"></el-table-column>
                    	<el-table-column width="95" label="负责人" prop="manager_t_description"></el-table-column>
                    	<el-table-column width="110" label="开销（元）" prop="cost"></el-table-column>
                    	<el-table-column width="90" label="状态" prop="status_t_description">
                    		<template scope="scope">
								<el-tag :type="onStatusTagType(scope)">{{onStatusTagText(scope)}}</el-tag>
							</template>
                    	</el-table-column>
                    	<el-table-column width="80" fixed="right" label="操作">
							<template scope="scope">
								<el-tooltip class="item" effect="light" content="参加登记" placement="bottom">
									<el-button size="mini" type="info" icon="fa-user-plus" @click="editMemberInfo(scope.row)"></el-button>
								</el-tooltip>
							</template>
						</el-table-column>
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="activityModal"
                    title="活动"
                    v-model="showActivityModal"
                    :edit-mode="activityEditMode"
                    url="si/customer/activity/save.do" 
                    :model="activityForm"
                    :rules="activityValidate"
                    @on-success="onActivityModalSuccess">
        
<!-- 		<el-form-item label="编号" prop="id"> -->
<!--             <el-input v-model.trim="activityForm.id" placeholder="编号" readonly></el-input> -->
<!--         </el-form-item> -->
<!-- 		<el-form-item label="持续天数" prop="days"> -->
<!--             <el-input v-model.trim="activityForm.days" placeholder="持续天数" ></el-input> -->
<!--         </el-form-item> -->
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="名称" prop="name">
		            <el-input v-model.trim="activityForm.name" placeholder="名称" ></el-input>
		        </el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="状态" prop="status">
		            <sf-select width="100%" label="" v-model.trim="activityForm.status" placeholder="状态" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_STATUS" value-field="id" text-field="displayValue"></sf-select>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="24">
				<el-form-item label="描述" prop="description">
		            <el-input v-model.trim="activityForm.description" type="textarea" placeholder="描述" :autosize="{ minRows: 2, maxRows: 4}"></el-input>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="开始时间" prop="beginTime">
				 	<el-date-picker v-model="activityForm.beginTime" @change="setFormatBeginTime" format="yyyy-MM-dd HH:mm:ss" type="datetime" placeholder="选择时间" style="width: 200px;"></el-date-picker>
				</el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="地点" prop="place">
		            <el-input v-model.trim="activityForm.place" placeholder="地点" ></el-input>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="24">
				<el-form-item label="地址" prop="address">
		            <el-input v-model.trim="activityForm.address" placeholder="地址" ></el-input>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="负责人" prop="manager">
		            <sf-select width="100%" label="" v-model.trim="activityForm.manager"
						   placeholder="负责人" url="si/config/employee/listEmployeeInfoByGroup.do?grpId=1" 
						   value-field="id" text-field="realName">
					</sf-select>
				</el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="开销（元）" prop="cost">
		            <el-input v-model.trim="activityForm.cost" placeholder="开销（元）" ></el-input>
		        </el-form-item>
			</el-col>
		</el-row>
    </sf-form-dialog>
    
    <el-dialog title="活动参与登记" :visible.sync="dialogTableVisible" width="100%" fullscreen="true">
    	<sf-toolbar>
            <el-button type="success" icon="plus" @click="addActivityMember">添加</el-button>
            <el-button type="info" icon="edit" @click="editActivityMember" :disabled="!memberCurrentRow">编辑</el-button>
            <el-button type="danger" icon="delete" @click="deleteActivityMember" :disabled="!memberCurrentRow">删除</el-button>
        </sf-toolbar>
		<sf-table ref="activityMemberTable"
                  highlight-current-row
                  :height="300"
                  :show-import="false"
                  url="si/customer/activityMember/list.do" 
                  import-url="si/customer/activityMember/importFile.do"
                  @current-change="onMemberCurrentChange"
                  @selection-change="onSelectionChange"
                  :query-condition="memberQueryCondition">
            <el-table-column type="selection" width="50" align="center" reserve-selection></el-table-column>
<!--             <el-table-column label="#" prop="__index" width="50" align="center"></el-table-column> -->
<!--             <el-table-column label="编号" prop="id"></el-table-column> -->
<!--            	<el-table-column label="活动编号" prop="activityId"></el-table-column> -->
           	<el-table-column width="95" label="客户姓名" prop="customerId_t_description"></el-table-column>
           	<el-table-column width="90" label="已邀请" prop="invited">
	           	<template scope="scope">
					<el-tag :type="onInvitedTagType(scope)">{{onInvitedTagText(scope)}}</el-tag>
				</template>
           	</el-table-column>
           	<el-table-column width="95" label="确认状态" prop="confirm">
           		<template scope="scope">
					<el-tag :type="onConfirmTagType(scope)">{{onConfirmTagText(scope)}}</el-tag>
				</template>
           	</el-table-column>
<!--            	<el-table-column label="已拒绝" prop="reject"></el-table-column> -->
           	<el-table-column width="95" label="预留人数" prop="seats"></el-table-column>
           	<el-table-column width="95" label="到场人数" prop="appear"></el-table-column>
           	<el-table-column label="备注" prop="comment"></el-table-column>
        </sf-table>
		<span slot="footer" class="dialog-footer">
			<el-button @click="dialogTableVisible=false">取 消</el-button>
			<el-button type="primary" @click="dialogTableVisible=false">确 定</el-button>
		</span>
	</el-dialog>
	
	<sf-form-dialog ref="activityMemberModal"
                    title="参与活动成员"
                    v-model="showActivityMemberModal"
                    :edit-mode="activityMemberEditMode"
                    url="si/customer/activityMember/save.do" 
                    :model="activityMemberForm"
                    @on-success="onActivityMemberModalSuccess">
        
<!-- 		<el-form-item label="编号" prop="id"> -->
<!--             <el-input v-model.trim="activityMemberForm.id" placeholder="编号" readonly></el-input> -->
<!--         </el-form-item> -->
		<el-row :gutter="10">
			<el-col :span="24">
<!-- 				<el-form-item label="活动名称" prop="activityId"> -->
<!-- 		            <el-input v-model.trim="activityMemberForm.activityId" placeholder="活动名称" :readonly="true"></el-input> -->
<!-- 		        </el-form-item> -->
		        <el-form-item label="活动名称" prop="activityId">
		            <sf-select width="100%" label="" v-model="activityMemberForm.activityId"
						   placeholder="活动名称" url="si/customer/activity/list.do" 
						   value-field="id" text-field="name" disabled>
					</sf-select>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
<!-- 				<el-form-item label="客户姓名" prop="customerId"> -->
<!-- 		            <el-input v-model.trim="activityMemberForm.customerId" placeholder="客户姓名" ></el-input> -->
<!-- 		        </el-form-item> -->
		        <el-form-item label="客户" prop="customerName">
					<el-autocomplete v-model="activityMemberForm.customerName" :fetch-suggestions="querySearchCustomer" placeholder="客户姓名" @select="handleSelect" style="width:100%;">
					</el-autocomplete>
				</el-form-item>
			</el-col>
			<el-col :span="6">
				<el-form-item label="邀请状态" prop="invited">
					<el-select v-model="activityMemberForm.invited" placeholder="邀请状态" style="width:100%;">
						<el-option label="未邀请" value="0"></el-option>
						<el-option label="已邀请" value="1"></el-option>
					</el-select>
				</el-form-item>
			</el-col>
			<el-col :span="6">
		        <el-form-item label="确认状态" prop="confirm">
					<el-select v-model="activityMemberForm.confirm" placeholder="确认状态" style="width:100%;">
						<el-option label="未确认" value="0"></el-option>
						<el-option label="已确认" value="1"></el-option>
						<el-option label="已拒绝" value="2"></el-option>
					</el-select>
				</el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="预留人数" prop="seats">
		            <el-input v-model.trim="activityMemberForm.seats" placeholder="预留人数" ></el-input>
		        </el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="到场人数" prop="appear">
		            <el-input v-model.trim="activityMemberForm.appear" placeholder="到场人数" ></el-input>
		        </el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="24">
				<el-form-item label="备注" prop="comment">
            <el-input v-model.trim="activityMemberForm.comment" type="textarea" placeholder="备注" :autosize="{ minRows: 2, maxRows: 4}"></el-input>
        </el-form-item>
			</el-col>
		</el-row>
<!-- 		<el-form-item label="已拒绝" prop="reject"> -->
<!--             <el-input v-model.trim="activityMemberForm.reject" placeholder="已拒绝" ></el-input> -->
<!--         </el-form-item> -->
    </sf-form-dialog>
</div>
<script>
	var mapStatusTagType={65:"warning",66:"success",67:"gray",0:"primary"};
	var mapInvitedTagType={0:"gray",1:"primary"};
	var mapInvitedTagText = {0:"未邀请",1:"已邀请"};
	var mapConfirmTagType={0:"gray",1:"success",2:"warning"};
	var mapConfirmTagText = {0:"未确认",1:"已确认",2:"已拒绝"};
    var activityManagement = new Vue({
        el: '#vue_activity',
        data: {
        	//根据需要填写查询字段
            queryCondition: {
                name: ''
            },
            memberQueryCondition: {
				activityId: null
			},
			currentRow: null,
			currentActivityName: null,
            activityTableColumns: [
                {
                    title: '编号',
                    key: 'id'
                },
                {
                    title: '名称',
                    key: 'name'
                },
                {
                    title: '描述',
                    key: 'description'
                },
                {
                    title: '开始时间',
                    key: 'beginTime'
                },
                {
                    title: '持续天数',
                    key: 'days'
                },
                {
                    title: '地点',
                    key: 'place'
                },
                {
                    title: '地址',
                    key: 'address'
                },
                {
                    title: '负责人',
                    key: 'manager'
                },
                {
                    title: '开销（元）',
                    key: 'cost'
                },
                {
                    title: '状态',
                    key: 'status'
                }
            ],
            showActivityModal: false,
            activityEditMode: 'add',
            activityForm: {
                id: null ,
                name: null ,
                description: null ,
                beginTime: null ,
                days: null ,
                place: null ,
                address: null ,
                manager: null ,
                cost: null ,
                status: null 
            },
            activityValidate: {
            	//此处添加字段数据合理性验证
                //id: [{required: true, message: '编号不能为空', trigger: 'blur'}],
            },
            buttonLoading: false,
            dialogTableVisible: false,
            ////////////////////activity_member/////////////////////
            customers:[],			//客户列表
			mapCustomerId:{},
			selection: [],
			memberCurrentRow: null,
            showActivityMemberModal: false,
            activityMemberEditMode: 'add',
            activityMemberForm: {
                id: null ,
                activityId: null ,
                customerId: null ,
                customerName: null ,
                invited: null ,
                confirm: null ,
                reject: null ,
                seats: null ,
                appear: null ,
                comment: null 
            }
        },
        methods: {
        	onStatusTagText:function(scope){
				return scope.row.status_t_description;
			},
            onStatusTagType:function(scope){
                return mapStatusTagType[Number(scope.row.status)];
			},
			onInvitedTagText:function(scope){
                return mapInvitedTagText[Number(scope.row.invited)];
			},
			onInvitedTagType:function(scope){
                return mapInvitedTagType[Number(scope.row.invited)];
			},
            onConfirmTagText:function(scope){
                return mapConfirmTagText[Number(scope.row.confirm)];
			},
			onConfirmTagType:function(scope){
				return mapConfirmTagType[Number(scope.row.confirm)];
			},
            setFormatBeginTime:function(val){
        		//设置开始时间为格式化时间字符串
        		this.activityForm.beginTime = val;
        	},
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            search: function() {
            	this.$refs['activityTable'].reload();
            },
            addActivity: function () {
                this.activityForm.id = null;
                this.activityEditMode = 'add';
                this.showActivityModal = true;
            },
            editActivity: function () {
                for(var key in this.activityForm){
                    if(this.currentRow[key])
                        this.activityForm[key] = this.currentRow[key];
                }
                this.activityEditMode = 'edit';
                this.showActivityModal = true;
            },
            onActivityModalSuccess: function () {
                this.$refs['activityTable'].reload();
            },
            deleteActivity: function () {
                var self = this;
                this.$confirm("确定删除[" + self.currentRow.name + ']?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/customer/activity/delete.do', {ids: [self.currentRow.id]}, function () {
                                self.$message.success('删除成功！');
                                self.$refs['activityTable'].reload();
                            });
                        }
                    }
                });
            },
            editMemberInfo: function (row) {
				this.memberQueryCondition.activityId = row.id;
				this.currentActivityName = row.name;
				this.dialogTableVisible = true;
			},
			///////////////activity_member//////////////////
			onMemberCurrentChange: function(currentRow){
                this.memberCurrentRow = currentRow;
            },
            onSelectionChange: function (selection) {
	            this.selection = selection;
	        },
	        addActivityMember: function () {
                this.activityMemberForm.id = null;
                this.activityMemberForm.activityId = this.memberQueryCondition.activityId;
                this.activityMemberEditMode = 'add';
                this.showActivityMemberModal = true;
            },
            editActivityMember: function () {
                for(var key in this.activityMemberForm){
//                     if(this.memberCurrentRow[key])
// 					console.log(key+">>" + typeof(this.memberCurrentRow[key]));
                    this.activityMemberForm[key] = this.memberCurrentRow[key]+"";
                }
                this.activityMemberForm.activityId = this.memberQueryCondition.activityId;
                this.activityMemberForm.customerName = this.memberCurrentRow.customerId_t_description;
                this.activityMemberEditMode = 'edit';
                this.showActivityMemberModal = true;
            },
            onActivityMemberModalSuccess: function () {
                this.$refs['activityMemberTable'].reload();
            },
            deleteActivityMember: function () {
                var self = this;
                this.$confirm("确定删除所选活动参与者?",'提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/customer/activityMember/delete.do', 
                            	{ids: self.selection.map(function (member) {
                                        return member.id;
                                    })}, 
                            	function () {
                                self.$message.success('删除成功！');
                                self.$refs['activityMemberTable'].reload();
                            });
                        }
                    }
                });
            },
          	//获取客户列表
			loadCustomers:function(){
				var self=this;
				this.$post('si/customer/comCustomerInfo/list.do',{name:null,pageSize:-1,pageIndex:0,columns:null,method:null},
					function(success){
				    	success.data.map(function (t) {
							t.value = t.name;
							self.mapCustomerId[t.id] = t.name;
                        });
				    	self.customers = success.data;
					},
					function(error){
					    console.log(error);
					}
				)
			},
			querySearchCustomer:function(queryString, cb) {
                var customers = this.customers;
                var results = queryString ? customers.filter(this.createFilter(queryString)) : customers;
                // 调用 callback 返回建议列表的数据
                cb(results);
            },
            createFilter:function(queryString) {
                return (customer) => {
                    return (customer.name.indexOf(queryString.toLowerCase()) === 0);
                };
            },
            handleSelect:function(item) {
            	this.activityMemberForm.customerId = item.id;
            }
        },
        mounted:function(){
		    //获取客户列表
            this.loadCustomers();
   		}
    })
</script>
</body>
</html>
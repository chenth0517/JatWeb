<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工管理</title>
	<%@include file="../include/common-rss.jsp"%>
    <style>
        .header-label{
            height: 26px;
            font-size: 17px;
        }
        .group-div{
            float: left;
            width: 300px;
        }
        .employee-div{
            margin-left: 320px;
            min-width: 1030px;
        }
 	.group-div .el-pagination__total{
 		display:none;
 	}
 	.el-dialog__body .page-bar{
 		display:none;
 	}

    </style>
</head>
<body>
<div id="employee-management">
    <sf-panel title="组管理" v-cloak>
        <el-row>
            <div class="group-div">
                <div class="header-label">员工组</div>
                <sf-toolbar>
                    <el-button type="success" icon="fa-plus" @click="addEmployeeGroup">添加</el-button>
                    <el-tooltip placement="top" content="请先选择员工组" :disabled="!!currentRow">
                        <el-button type="info" icon="fa-pencil" :disabled="!currentRow" @click="editEmployeeGroup">编辑</el-button>
                    </el-tooltip>
                    <el-tooltip placement="top" content="请先选择员工组" :disabled="!!currentRow">
                        <el-button type="danger" icon="fa-trash" :disabled="!currentRow" @click="delateEmployeeGroup">删除</el-button>
                    </el-tooltip>
                </sf-toolbar>
	                <sf-table ref="employeeGroupTable" 
		                 highlight-current-row
		                :height="500" 
		                :show-import="false" 
		                url="si/config/employee/listTeamGroup.do" 
		                @current-change="onCurrentChange">
	                    <el-table-column label="序号" prop="id"  width="80"></el-table-column>
	                    <el-table-column label="员工组名" prop="name" align="center"></el-table-column>
<!-- 	                    <el-table-column label="责任人" prop="manager"></el-table-column> -->
	                </sf-table>
            </div>
            <div class="employee-div">
                <div class="header-label">
                    <span>组员列表</span>
                    <el-tag closable color="#58B7FF" v-if="currentRow" @close="handleClose" style="margin-left: 10px;">{{currentRow.name}}</el-tag>
                </div>
                <sf-toolbar>
					<div slot="searcher">
                        <el-input placeholder="输入账户名或者姓名" v-model="filterString" icon="search" style="width: 400px;"></el-input>
                    </div>
                    <div>
                         <el-button type="success" icon="fa-employee-plus" :disabled="!currentRow" @click="addEmployeeInfoToGroup">员工组管理(员工添加)</el-button>
                         <el-button type="danger" icon="fa-employee-plus" :disabled="!currentRow" @click="deleteEmployee">员工组管理(员工删除)</el-button>
                         <el-button type="primary" icon="fa-users" :disabled="!currentEmployeeRow" @click="assignManager">设为责任人</el-button>
                    </div>
                </sf-toolbar>
                <sf-table ref="employeeManagementTable" 
                    	 :height="500"
                    	  highlight-current-row
               		 	 :show-import="false" 
                 		 url="si/config/employee/list.do"
                 	   	 :query-condition="queryCondition"
                 		 @current-change="onCurrentEmployeeChange"
                 		 @selection-change="onSelectionChange">
                    <el-table-column type="selection" width="80" align="center"></el-table-column>
<!--                     <el-table-column label=" #" prop="__index" width="80" align="center"></el-table-column> -->
                    <el-table-column label="id" align="center" prop="id"  width="80"></el-table-column>
                    <el-table-column label="账户名" align="center" prop="userName" ></el-table-column>
                    <el-table-column label="姓名" align="center" prop="realName" ></el-table-column>
                    <el-table-column label="邮箱" align="center" prop="email" width="250"></el-table-column>
                    <el-table-column label="联系电话" align="center" prop="phone" width="150"></el-table-column>
                    <el-table-column label="员工组" align="center" prop="teamName" width="150"></el-table-column>
                    <el-table-column label="是否为责任人"  align="center" prop="manager" width="150">
      					 <template scope="scope">
	                        	<!-- <el-tag type="success" >{{testfun(scope.row)}}</el-tag> -->
	                     		<el-tag type="danger" v-for = " i in scope.row.manager" v-if="scope.row.id ==i">是</el-tag>
	                     </template>
                     </el-table-column>
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    
     <sf-form-dialog ref="employeeGroupModal"
                    title="员工组"
                    v-model="showEmployeeGroupModal"
                    :mode="employeeGroupEditMode"
                    url="si/config/employee/addEmployeeGroupInfo.do"
                    :model="employeeGroupForm"
                    :rules="employeeGroupValidate"
                    label-width="95px"
                    label-position="right"
                    @on-success="onEmployeeGroupModalSuccess">
        <el-form-item label="组名" prop="name" required>
            <el-input type="text" v-model.trim="employeeGroupForm.name" placeholder="组名" ></el-input>
        </el-form-item>
        <el-form-item label="责任人" prop="manager" required >
           	<el-select placeholder="请选择责任人" 
           					:disabled="employeeGroupEditMode==='edit'"
							v-model.trim="employeeGroupForm.manager" 
							style="width: 100%;"
							>
					<el-option v-for="item in options"
								:key="item.value" 
								:label="item.label" 
								:value="item.value">
					</el-option>
			</el-select>
        </el-form-item>
    </sf-form-dialog>
    
     <el-dialog :visible.sync="showEmployee"
               :modal-append-to-body="false"
               @close="onEmployeeDialogClose"
               v-cloak>
        <span slot="title" style="color:#f60;">
            <sf-icon icon="fa-user-circle" left></sf-icon>添加员工到员工组
        </span>
        <sf-toolbar>
            <div slot="searcher">
             <el-input placeholder="输入员工账号名或姓名" v-model="employeeQueryCondition.employeeInfo" icon="search" style="width: 400px;"></el-input>
            </div>
        </sf-toolbar>
        <sf-table ref="employeeTable"		
                  highlight-current-row
                  :show-import="false"
                  max-height="400"
                  row-key="id"
                  url="si/config/employee/queryEmployeeInfo.do"
                  :query-condition="employeeQueryCondition"
                  @selection-change="onSelectionChange">
                    <el-table-column type="selection" width="80" align="center"></el-table-column>
           			<el-table-column label="id" prop="id" sortable="custom" width="100"></el-table-column>
                    <el-table-column label="账户名" prop="userName" sortable="custom" width="100"></el-table-column>
                    <el-table-column label="姓名" prop="realName" sortable="custom"></el-table-column>
                    <el-table-column label="邮箱" prop="email" width="200"></el-table-column>
                    <el-table-column label="联系电话" prop="phone" width="150"></el-table-column>
        </sf-table>
        <div slot="footer">
            <el-button @click="showEmployee=false">取消</el-button>
            <el-button type="primary" :loading="buttonLoading" @click="addToTeamGroup">确定</el-button>
        </div>
    </el-dialog>
    
<!--      <el-dialog :visible.sync="editEmployee" -->
<!--                :modal-append-to-body="false" -->
<!--                @close="onEmployeeDialogClose" -->
<!--                v-cloak> -->
<!--         <span slot="title" style="color:#f60;"> -->
<!--             <sf-icon icon="fa-user-circle" left></sf-icon>员工信息 -->
<!--         </span> -->
<!--         <sf-table ref="employeeInfoTable" -->
<!--                   highlight-current-row -->
<!--                   :show-import="false" -->
<!--                   max-height="400" -->
<!--                   row-key="id" -->
<!--                   url="si/config/employee/loadEmployeeInfo.do" -->
<!--                   :query-condition="employeeQueryCondition"> -->
<!--            			<el-table-column label="id" prop="id" sortable="custom" width="100"></el-table-column> -->
<!--                     <el-table-column label="账户名" prop="userName" sortable="custom" width="100"></el-table-column> -->
<!--                     <el-table-column label="姓名" prop="realName" sortable="custom"></el-table-column> -->
<!--                     <el-table-column label="邮箱" prop="email" width="200"></el-table-column> -->
<!--                     <el-table-column label="联系电话" prop="phone" width="150"></el-table-column> -->
<!--                     <el-table-column label="操作" align="center" width="100"> -->
<!--                         <template scope="scope"> -->
<!--                             <el-button size="small" type="info" @click="deleteEmployee(scope.row)">删除</el-button> -->
<!--                         </template> -->
<!--                     </el-table-column> -->
<!--         </sf-table> -->
<!--         <div slot="footer"> -->
<!--             <el-button @click="showEmployee=false">取消</el-button> -->
<!--             <el-button type="primary" :loading="buttonLoading" @click="">确定</el-button> -->
<!--         </div> -->
<!--     </el-dialog> -->
</div>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ajax.js"></script>
<script>
var options = [];
AjaxUtils.commitAction('si/config/employee/listEmployeeInfo.do', {
	
}, function(json) {
	var data = json.data;
	for (var i = 0; i < data.length; i++) {
		options.push({
			value: data[i].id,
			label: data[i].realName
		});
	}
	console.log(options);
});
    var employeeManagement = new Vue({
        el: '#employee-management',
        data: {
           options: options,
            showEmployeeGroupModal:false,
            employeeGroupEditMode: 'add',
            userEditMode: 'add',
            showEmployee: false,
            editEmployee: false,
            currentRow: null,
            currentEmployeeRow:null,
            filterString: '',
            employeeInfo:'',
            teamId:-1,
            selection: [],
            showemployeeModal: false,
            employeeEditMode: 'add',
            employeeGroupForm:{
            	id:null,
            	name:"",
            	manager:'',
            },
            employeeGroupValidate: {
                name: [
                    {required: true, message: '组名不能为空', trigger: 'blur'}
                 ]
            },
            employeeQueryCondition: {
            	employeeInfo: '',
            	teamId:-1
            },
            buttonLoading: false,
        },
        computed: {
            queryCondition: function () {
                return {
                    teamId: this.currentRow ? this.currentRow.id : 0,
                    name: this.filterString
                }
            }
        },
        methods: {
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            onCurrentChange:function(currentRow){
            	this.currentRow = currentRow;
            },
            onCurrentEmployeeChange:function(currentRow){
            	this.currentEmployeeRow = currentRow;
            },
            addEmployeeGroup: function () {
                this.employeeGroupForm.id = null;
                this.employeeGroupEditMode = 'add';
                this.showEmployeeGroupModal = true;
            },
            editEmployeeGroup: function () {
            	var self = this;
            	if(self.currentRow.id <= 3){
                	self.$message.warning('缺省的员工组（客服/文案/顾问）不允许重命名。');
                }
                else{
                	for(var key in this.employeeGroupForm){
						if(this.currentRow[key])
							this.employeeGroupForm[key] = this.currentRow[key];
					}
                	this.employeeGroupEditMode = 'edit';
                	this.showEmployeeGroupModal = true;
                }
              //  console.log((this.employeeGroupEditMode=='add'));
            },
            delateEmployeeGroup:function(){
                //批量删除接口
                var self = this;
                if(self.currentRow.id <= 3){
                	self.$message.warning('缺省的员工组（客服/文案/顾问）不允许删除。');
                }
                else{
	                this.$confirm('确定解散该员工组?','提示',{
	                    type: 'warning',
	                    callback: function(action){
	                        if(action === 'confirm'){
	                            self.$post('si/config/employee/deleteEmployeeGroup.do', {
	                                teamGroupId:self.currentRow.id
	                            }, function () {
	                                self.$message.success('删除员工组成功！');
	                               self.$refs['employeeGroupTable'].reload();
	                            });
	                        }
	                    }
	                });
                }
            },
            employeeManagement: function () {
            	var self = this;
            	this.employeeQueryCondition.teamId = self.currentRow.id;
            	employssInfo = this.employeeInfo;
                this.showEmployee = true;
            },
            addEmployeeInfoToGroup:function(){
            	var self = this;
            	this.employeeQueryCondition.teamId = self.currentRow.id;
                this.showEmployee = true;
            },
            handleClose: function(){
               this.$refs['employeeGroupTable'].reload();
            },
            addToTeamGroup:function()
            {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个用户！');
                }
                //批量删除接口
                var self = this;
                this.$confirm('确定添加所选用户?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/config/employee/addToEmployeeGroup.do', {
                                userIds: self.selection.map(function (user) {
                                    return user.id;
                                }),
                                teamId:self.currentRow.id
                            }, function () {
                                self.$message.success('添加员工成功！');
                             //   this.showEmployee = false;
                               self.$refs['employeeTable'].reload();
                              
                            });
                        }
                    }
                });
               
            },
            deleteEmployee:function(employee)
            {
				  if(this.selection.length === 0){
              		  return this.$message.warning('请至少选择一个用户！');
          		  }
            	 var self = this;
                 this.$confirm('确定删除所选员工?','提示',{
                     type: 'warning',
                     callback: function(action){
                         if(action === 'confirm'){
                             self.$post('si/config/employee/deleteEmployeeInfo.do', {
                            	 userIds: self.selection.map(function (user) {
                             	 return user.id;
                         		 }),
                                 teamId:self.currentRow.id
                             }, function () {
                                 self.$message.success('删除员工信息成功！');
                                 self.$refs['employeeManagementTable'].reload();
                                 self.$refs['employeeTable'].reload();
                             });
                         }
                     }
                 });
             //    self.$refs['employeeManagementTable'].reload();
            },
            editEmployeeInfo:function(){
            	var self = this;
            	this.employeeQueryCondition.teamId = self.currentRow.id;
            	this.editEmployee = true;
            },
			assignManager:function(){
				 var self = this;
                 this.$confirm('确定设为责任人?','提示',{
                     type: 'warning',
                     callback: function(action){
                         if(action === 'confirm'){
                             self.$post('si/config/employee/assignManager.do', {
 								 userId:self.currentEmployeeRow.id,
                                 teamId:self.currentRow.id
                             }, function () {
                                 self.$message.success('设置成功！');
                                 self.$refs['employeeManagementTable'].reload();
                             });
                         }
                     }
                 });
			},
            onEmployeeGroupModalSuccess: function () {
            	this.showEmployeeGroupModal = false;
                this.$refs['employeeGroupTable'].reload();
            },
            onEmployeeDialogClose: function(){
                this.buttonLoading = false;
                this.employeeInfo = '';
                this.$refs['employeeManagementTable'].reload();
                
            }
        }
    })
</script>
</body>
</html>
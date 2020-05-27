<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工组管理</title>
	<%@include file="../include/common-rss.jsp"%>
    <style>
        .header-label{
            height: 26px;
            font-size: 17px;
        }

        .org-div{
            float: left;
            width: 300px;
        }

        .user-div{
            margin-left: 320px;
            min-width: 1080px;
        }

    </style>
</head>
<body>
<div id="employee-group">
    <sf-panel title="员工组" v-cloak>
            <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入用户名或账户名" v-model="filterString" icon="search" style="width: 400px;"></el-input>
                    </div>
                    <div>
                        <el-button type="success" icon="fa-user-plus"  @click="addEmployeeGroup">添加员工组</el-button>
                    </div>
                </sf-toolbar>
        <sf-table ref="employeeGroupTable"
                  highlight-current-row
                  :height="650"
                  url="si/config/employee/listEmployeeGroup.do"
                  :query-condition="queryCondition"
                  :show-import="false"
            	 @selection-change="onSelectionChange">
            <el-table-column label="#" prop="__index" width="100" align="center"></el-table-column>
            <el-table-column label="ID" prop="teamGroup.id" width="100" ></el-table-column>
            <el-table-column label="名称" prop="teamGroup.name" ></el-table-column>
            <el-table-column label="员工数" prop="num" ></el-table-column>
            <el-table-column label="责任人" prop="managerName" align="center"></el-table-column>
 			<el-table-column label="操作" align="center" >
                        <template scope="scope">
                            <el-button size="small" type="success" @click="editEmployeeGroup(scope.row)">编辑</el-button>
                            <el-button size="small" type="info" @click="employeeManagement(scope.row)">人员管理</el-button>
                            <el-button size="small" type="warning" @click="delateEmployeeGroup(scope.row)">删除</el-button>
                        </template>
          </el-table-column>
        </sf-table>
    </sf-panel>
    
        <sf-form-dialog ref="employeeGroupModal"
                    title="员工组"
                    v-model="showEmployeeGroupModal"
                    :mode="employeeGroupEditMode"
                    url="si/config/employee/addEmployeeGroupInfo.do"
                    load-url="si/config/employee/loadOne.do"
                    :model="employeeGroupForm"
                    :rules="employeeGroupValidate"
                    label-width="95px"
                    label-position="right"
                    @on-success="onEmployeeGroupModalSuccess">
        <el-form-item label="组名" prop="name" required>
            <el-input type="text" v-model.trim="employeeGroupForm.name" placeholder="组名" ></el-input>
        </el-form-item>
        <el-form-item label="责任人" prop="manager" required>
<!--             <el-input type="text" v-model.trim="employeeGroupForm.manager" placeholder="责任人"></el-input> -->
           	<el-select placeholder="请选择责任人" 
							v-model.trim="employeeGroupForm.manager" 
							allow-create 
							style="width: 100%;">
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
            <sf-icon icon="fa-user-circle" left></sf-icon>员工信息
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
                  url="si/config/employee/loadEmployeeInfo.do"
                  :query-condition="employeeQueryCondition">
           			<el-table-column label="id" prop="id" sortable="custom" width="100"></el-table-column>
                    <el-table-column label="账户名" prop="userName" sortable="custom" width="100"></el-table-column>
                    <el-table-column label="姓名" prop="realName" sortable="custom"></el-table-column>
                    <el-table-column label="邮箱" prop="email" width="200"></el-table-column>
                    <el-table-column label="联系电话" prop="phone" width="150"></el-table-column>
                    <el-table-column label="操作" align="center" width="100">
                        <template scope="scope">
                            <el-button size="small" type="info" @click="deleteEmployee(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
        </sf-table>
        <div slot="footer">
            <el-button @click="showEmployee=false">取消</el-button>
            <el-button type="primary" :loading="buttonLoading" @click="onEmployeeSelected">确定</el-button>
        </div>
    </el-dialog>
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
});
    var employeeGroupManagement = new Vue({
        el: '#employee-group',
        data: {
            filterString: '',
            employeeInfo:'',
            options: options,
            showEmployeeGroupModal: false,
            employeeGroupEditMode: 'add',
            showEmployee: false,
            selection: [],
            showUserModal: false,
            userEditMode: 'add',
            employeeGroupForm: {
                id: -1,
                name: "",
                manager: '',
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
            buttonLoading: false
        },
        computed: {
            queryCondition: function () {
                return {
                    name: this.filterString
                }
            }
        },
        methods: {
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            addEmployeeGroup: function () {
                this.employeeGroupForm.id = null;
                this.employeeGroupEditMode = 'add';
                this.showEmployeeGroupModal = true;
            },
            editEmployeeGroup: function (row) {
               
				console.log(row.teamGroup.id);
				
                this.employeeGroupForm.id = row.teamGroup.id;

                this.employeeGroupEditMode = 'edit';
                this.showEmployeeGroupModal = true;
            },
            onEmployeeGroupModalSuccess: function () {
                this.$refs['employeeGroupTable'].reload();
            },
            employeeManagement: function (employee) {
            	this.employeeQueryCondition.teamId = employee.teamGroup.id;
                this.showEmployee = true;
            },
            onEmployeeDialogClose: function(){
                this.buttonLoading = false;
                this.employeeInfo = '';
                this.$refs['employeeTable'].clearSelection();
            },
            deleteEmployee:function(employee)
            {
            	 var self = this;
                 this.$confirm('确定删除所选员工?','提示',{
                     type: 'warning',
                     callback: function(action){
                         if(action === 'confirm'){
                             self.$post('si/config/employee/deleteEmployeeInfo.do', {
                                 id: employee.id
                             }, function () {
                                 self.$message.success('删除员工信息成功！');
                                 self.$refs['employeeTable'].reload();
                             });
                         }
                     }
                 });
            },
            deleteEmployee:function(employeeGroup)
            {
            	 var self = this;
                 this.$confirm('确定删除所选员工组和所属下的员工信息?','提示',{
                     type: 'warning',
                     callback: function(action){
                         if(action === 'confirm'){
                             self.$post('si/config/employee/deleteEmployeeGroup.do', {
                                 teamGroupId: employeeGroup.id
                             }, function () {
                                 self.$message.success('删除员工组信息成功！');
                                 self.$refs['employeeGroupTable'].reload();
                             });
                         }
                     }
                 });
            },
            onEmployeeSelected: function () {
            	 var self = this;
            	 self.showEmployee = false;
            	 this.$refs['employeeGroupTable'].reload();
            }
        }
    })
</script>
</body>
</html>
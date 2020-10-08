<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统用户管理</title>
	<%@include file="../include/common-rss.jsp"%>
	<style type="text/css" src="../resources/css/index.css"></style>
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
<div id="user-management">
    <sf-panel title="用户管理" v-cloak>
        <el-row>
            <div class="org-div">
                <div class="header-label">组织机构</div>
                <sf-toolbar>
                    <el-button type="success" icon="fa-plus" @click="addOrg">添加</el-button>
                    <el-tooltip placement="top" content="请先选择组织机构" :disabled="!!currentOrgNode">
                        <el-button type="info" icon="fa-pencil" :disabled="!currentOrgNode" @click="editOrg">编辑</el-button>
                    </el-tooltip>
                    <el-tooltip placement="top" content="请先选择组织机构" :disabled="!!currentOrgNode">
                        <el-button type="danger" icon="fa-trash" :disabled="!currentOrgNode" @click="deleteOrg">删除</el-button>
                    </el-tooltip>
                </sf-toolbar>
                <sf-lazy-tree ref="orgTree" height="500" url="organization/list.do" :props="orgProps" @current-change="onCurrentOrgChange"></sf-lazy-tree>
            </div>
            <div class="user-div">
                <div class="header-label">
                    <span>用户列表</span>
                    <el-tag closable color="#58B7FF" v-if="currentOrgNode" @close="handleClose" style="margin-left: 10px;">{{currentOrgNode.data.name}}</el-tag>
                </div>
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入用户名或账户名" v-model="filterString" icon="search" style="width: 400px;"></el-input>
                    </div>
                    <div>
                        <el-tooltip placement="top" content="请先选择组织机构" :disabled="!!currentOrgNode">
                            <el-button type="success" icon="fa-user-plus" :disabled="!currentOrgNode" @click="addUser">添加</el-button>
                        </el-tooltip>

                        <el-button type="info" icon="fa-pencil" @click="editUser">编辑</el-button>
                        <el-button type="danger" icon="fa-trash" @click="deleteUser">删除</el-button>
                        <el-button type="info" icon="fa-lock" @click="changeUserStatus(false)">锁定</el-button>
                        <el-button type="success" icon="fa-unlock" @click="changeUserStatus(true)">解锁</el-button>
                        <el-button type="warning" icon="fa-key" @click="resetPassword">重置密码</el-button>
                        <el-button type="primary" icon="fa-users" @click="changeOrg">变更组织机构</el-button>
                    </div>
                </sf-toolbar>
                <sf-table ref="userTable" :height="500" :export-columns="userTableColumns" url="user/list.do" :query-condition="queryCondition" @selection-change="onSelectionChange">
                    <el-table-column type="selection" width="50" align="center"></el-table-column>
                    <el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    <el-table-column label="账户名" prop="userName" sortable="custom"></el-table-column>
                    <el-table-column label="姓名" prop="realName" sortable="custom">
                    	<template scope="scope">{{scope.row.realName}}
							<el-tooltip class="item" effect="light" placement="right">
								<div slot="content">{{demo}}</div>
								<el-button size="mini" circle icon="fa-search"></el-button>
							</el-tooltip>
						</template>
                    </el-table-column>
                    <el-table-column label="账户状态" align="center" width="120">
                        <template scope="scope">
                            <el-tag type="danger" v-if="scope.row.deleted==1">删除</el-tag>
                            <el-tag :type="scope.row.disabled ? 'danger' : 'success' " v-else>{{scope.row.disabled ? '锁定' : '正常'}}</el-tag>
<!--                             <el-tag type="success" v-if="scope.row.disabled==0" >正常</el-tag> -->
<!--                             <el-tag type="danger" v-else >{{scope.row.disabled==1 ? '锁定' : '删除'}}</el-tag> -->
<!--                             <el-tag :type="scope.row.disabled ? 'danger' : 'success' ">{{scope.row.disabled ? '锁定' : '正常'}}</el-tag> -->
                        </template>
                    </el-table-column>
                    <el-table-column label="邮箱" prop="email" width="200"></el-table-column>
                    <el-table-column label="联系电话" prop="phone" width="150"></el-table-column>
                    <el-table-column label="操作" align="center" width="200">
                        <template scope="scope">
                            <el-button size="small" type="info" @click="changeUserRole(scope.row)">岗位授权</el-button>
                            <el-button size="small" type="success" @click="displayResp(scope.row)">查看职责</el-button>
                        </template>
                    </el-table-column>
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="orgModal"
                    title="组织机构"
                    submit-on-enter
                    v-model="showOrgModal"
                    :mode="orgEditMode"
                    url="organization/save.do"
                    :model="orgForm"
                    :rules="orgValidate"
                    @on-success="onOrgModalSuccess">
        <el-form-item label="组织机构名称" prop="name">
            <el-input v-model.trim="orgForm.name" placeholder="组织机构名称"></el-input>
        </el-form-item>
        <el-form-item label="上级机构" prop="superiorOrgName">
            <el-input :value="orgForm.superiorOrgName" placeholder="上级机构" readonly></el-input>
        </el-form-item>
    </sf-form-dialog>

    <sf-form-dialog ref="userModal"
                    title="用户"
                    v-model="showUserModal"
                    :mode="userEditMode"
                    url="user/save.do"
                    load-url="user/loadOne.do"
                    :model="userForm"
                    :rules="userValidate"
                    label-width="95px"
                    label-position="right"
                    @on-success="onUserModalSuccess">
        <el-form-item label="账户名" prop="userName" required>
            <el-input type="text" v-model.trim="userForm.userName" placeholder="用户名/邮箱/手机号" :disabled="userEditMode==='edit'"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="realName" required>
            <el-input type="text" v-model.trim="userForm.realName" placeholder="用户姓名"></el-input>
        </el-form-item>
        <el-form-item label="部门" prop="orgFullName">
            <el-input :value="userForm.orgFullName" placeholder="上级机构" readonly></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email" required>
            <el-input type="text" v-model.trim="userForm.email" placeholder="邮箱"></el-input>
        </el-form-item>
        <el-form-item label="联系电话" prop="phone" required>
            <el-input type="text" v-model.trim="userForm.phone" placeholder="手机号"></el-input>
        </el-form-item>
    </sf-form-dialog>

    <el-dialog ref="dialog1"
               :visible.sync="showOrgSelector"
               :modal-append-to-body="false"
               @close="onClose" v-cloak
               size="tiny">
        <span slot="title" style="color:#f60;">
            <sf-icon icon="fa-users" left></sf-icon>组织机构选择
        </span>
        <sf-lazy-tree ref="orgSelector" height="300" url="organization/list.do" :props="orgProps"></sf-lazy-tree>
        <div slot="footer">
            <el-button @click="showOrgSelector=false">取消</el-button>
            <el-button type="primary" :loading="buttonLoading" @click="onOrgSelected">确定</el-button>
        </div>
    </el-dialog>

    <el-dialog ref="dialog2"
               :visible.sync="showRoleSelector"
               :modal-append-to-body="false"
               @close="onRoleDialogClose"
               v-cloak>
        <span slot="title" style="color:#f60;">
            <sf-icon icon="fa-user-circle" left></sf-icon>岗位授权
        </span>
        <sf-toolbar>
            <div slot="searcher">
                <el-input placeholder="输入岗位名称" v-model.trim="roleQueryCondition.roleName" icon="search" style="width: 400px;"></el-input>
            </div>
        </sf-toolbar>
        <sf-table ref="roleTable"
                  highlight-current-row
                  :show-import="false"
                  :show-page="false"
                  max-height="400"
                  row-key="id"
                  url="role/list.do"
                  :query-condition="roleQueryCondition"
                  @selection-change="onRoleSelectionChange">
            <el-table-column type="selection" width="50" align="center" reserve-selection></el-table-column>
            <el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
            <el-table-column label="岗位名称" prop="name" width="200" sortable="custom"></el-table-column>
            <el-table-column label="岗位描述" prop="description"></el-table-column>
        </sf-table>
        <div slot="footer">
            <el-button @click="showRoleSelector=false">取消</el-button>
            <el-button type="primary" :loading="buttonLoading" @click="onRoleSelected">确定</el-button>
        </div>
    </el-dialog>
    
    <el-dialog title="查看职责" :visible.sync="respDlgVisible">
		<sf-table ref="subRespTable"
                  highlight-current-row
                  :height="300"
                  :show-import="false"
                  url="jat/response/jatRespOrgLink/listCurrUserRespByRespType.do" 
                  @current-change="onCurrentChange"
                  :query-condition="respCondition">
            <el-table-column width="120" label="与我相关" prop="type_t_description"></el-table-column>
            <el-table-column label="职责名称" prop="respName"></el-table-column>
        </sf-table>
		<span slot="footer" class="dialog-footer">
			<el-button type="primary" @click="respDlgVisible=false">确 定</el-button>
		</span>
	</el-dialog>
</div>
<script>
    var userManagement = new Vue({
        el: '#user-management',
        data: {
            orgProps: {
                idField: 'id',
                parentField: 'pid',
                label: 'name'
            },
            demo: '此处显示岗位',
            showOrgModal: false,
            orgEditMode: 'add',
            currentOrgNode: null,
            orgForm: {
                id: -1,
                name: '',
                pid: 0,
                superiorOrgName: ""
            },
            orgValidate: {
                name: [{required: true, message: '名称不能为空', trigger: 'blur'}]
            },
            filterString: '',
            userTableColumns: [
                {
                    title: '账户名',
                    key: 'userName'
                },
                {
                    title: '姓名',
                    key: 'realName'
                },
                {
                    title: '账户状态',
                    key: 'disabled'
                },
                {
                    title: '邮箱',
                    key: 'email'
                },
                {
                    title: '联系电话',
                    key: 'phone'
                }
            ],
            selection: [],
            showUserModal: false,
            userEditMode: 'add',
            userForm: {
                id: -1,
                userName: '',
                realName: '',
                orgId: '',
                orgFullName: '',
                email: '',
                phone: '',
            },
            userValidate: {
                userName: [
                    {required: true, message: '账户名不能为空', trigger: 'blur'}
                ],
                realName: [
                    {required: true, message: '姓名不能为空', trigger: 'blur'}
                ],
                phone: [
                    {required: true, message: '手机号不能为空', trigger: 'blur'},
                    {pattern: /^1[34578][0-9]{9}$/, message: '手机号码格式不正确', trigger: 'blur'}
                ],
                email: [
                    { required: true, message: '邮箱不能为空', trigger: 'blur' },
                    { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
                ]
            },
            showOrgSelector: false,
            buttonLoading: false,
            showRoleSelector: false,
            respDlgVisible: false,
            roleQueryCondition: {
                roleName: ''
            },
            respCondition: {
            	userId: -1
            },
            roleSelection: [],
            roleUser: null
        },
        computed: {
            queryCondition: function () {
                return {
                    orgId: this.currentOrgNode ? this.currentOrgNode.data.id : 0,
                    name: this.filterString
                }
            }
        },
        methods: {
            onCurrentOrgChange: function(nodeData, node){
                this.currentOrgNode = node;
            },
            addOrg: function () {
                this.orgEditMode = 'add';
                this.showOrgModal = true;
                this.orgForm.id = null;
                this.orgForm.pid = this.$refs['orgTree'].getCurrentKeys(true)[0] || 0;
                this.orgForm.superiorOrgName = this.$refs['orgTree'].getCurrentLabels().join(' / ');
            },
            editOrg: function () {
                this.orgEditMode = 'edit';
                this.showOrgModal = true;

                var keys = this.$refs['orgTree'].getCurrentKeys();
                var labels = this.$refs['orgTree'].getCurrentLabels();
                this.orgForm.id = keys.pop();
                this.orgForm.name = labels.pop();
                this.orgForm.pid = keys.pop();
                this.orgForm.superiorOrgName = labels.join(' / ');
            },
            onOrgModalSuccess: function(json){
                if(this.orgEditMode === 'edit'){//编辑
                    //option 1: reload current parent node
                    //this.$refs['orgTree'].reloadNode(this.currentOrgNode.parent);

                    //option 2: update current node description
                    this.$refs['orgTree'].updateNode(this.currentOrgNode, json.data);
                }else{//新增

                    //option 1: reload current node
                    //this.$refs['orgTree'].reloadNode(this.currentOrgNode);

                    //option 2: no reload, add child
                    this.$refs['orgTree'].insertChild(json.data, this.currentOrgNode);
                }
            },
            deleteOrg: function () {

                var orgId = this.currentOrgNode.data.id;
                var orgName = this.currentOrgNode.data.name;

                var self = this;
                this.$confirm('确定删除' + orgName + '?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('organization/delete.do', {id: orgId}, function () {
                                self.$refs['orgTree'].removeNode(self.currentOrgNode);
                            });
                        }
                    }
                });
            },
            handleClose: function(){
                this.$refs['orgTree'].clearCurrentNode();
            },
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            addUser: function () {
                this.userForm.id = null;
                this.userForm.orgId = this.currentOrgNode.data.id;
                this.userForm.orgFullName = this.$refs['orgTree'].getCurrentLabels().join(' / ');

                this.userEditMode = 'add';
                this.showUserModal = true;
            },
            editUser: function () {
                if(this.selection.length !== 1){
                    return this.$message.warning('只允许选择一个用户!');
                }

                this.userForm.id = this.selection[0].id;

                this.userEditMode = 'edit';
                this.showUserModal = true;
            },
            onUserModalSuccess: function () {
                this.$refs['userTable'].reload();
            },
            deleteUser: function () {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个用户！');
                }
                //批量删除接口

                var self = this;
                this.$confirm('确定删除所选用户?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('user/delete.do', {
                                userIds: self.selection.map(function (user) {
                                    return user.id;
                                })
                            }, function () {
                                self.$message.success('删除用户成功！');
                                self.$refs['userTable'].reload();
                            });
                        }
                    }
                });
            },
            changeUserStatus: function (status) {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个用户！');
                }

                var action = status ? '解锁' : '锁定';
                var url = status ? 'user/enableUser.do' : 'user/disableUser.do';
                //批量接口
                var self = this;
                self.$post(url, {
                    userIds: this.selection.map(function (user) {
                        return user.id;
                    })
                }, function () {
                    self.$message.success(action + '用户成功！');
                    self.$refs['userTable'].reload();
                });
            },
            resetPassword: function () {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个用户！');
                }
                //批量接口
                var self = this;
                self.$post('user/resetUserPwd.do', {
                    userIds: this.selection.map(function (user) {
                        return user.id;
                    })
                }, function () {
                    self.$message.success('密码重置成功！');
                });
            },
            changeOrg: function () {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个用户！');
                }

                this.showOrgSelector = true;
            },
            onOrgSelected: function () {
                var orgId = this.$refs['orgSelector'].getCurrentKeys(true)[0] || -1;

                var self = this;
                if(orgId < 0){
                    return this.$message.error('不能将所选用户所属组织机构设为空!');
                }else{
                    self.buttonLoading = true;
                    self.$post('organization/changeUserDefault.do', {
                        userIds: self.selection.map(function (user) {
                            return user.id;
                        }),
                        orgId: orgId
                    }, function () {
                        self.$message.success('修改用户所属组织机构成功！');
                        self.$refs['userTable'].reload();
                        self.showOrgSelector = false;
                    });
                }
            },
            onClose: function(){
                this.buttonLoading = false;
                this.$refs['orgSelector'].clear();
            },
            changeUserRole: function (user) {
                this.showRoleSelector = true;
                this.roleUser = user;

                var self = this;
                self.$post('role/listRoleByUser.do',{
                    userId: user.id
                }, function (json) {
                    self.$refs['roleTable'].setCurrentSelection(json.data);
                });
            },
            displayResp: function (row) {
            	this.respCondition.userId = row.id;
                this.respDlgVisible = true;
            },
            onRoleSelectionChange: function(selection){
                this.roleSelection = selection;
            },
            onRoleSelected: function () {
                var self = this;
                self.buttonLoading = true;
                self.$post('role/assignToUser.do', {
                    roleIds: this.roleSelection.map(function (role) {
                        return role.id;
                    }),
                    userId: self.roleUser.id
                }, function () {
                    self.showRoleSelector = false;
                    self.$message.success('给用户' + self.roleUser.realName +'更改岗位成功！');
                })
            },
            onRoleDialogClose: function(){
                this.buttonLoading = false;
                this.roleQueryCondition.roleName = '';
                this.$refs['roleTable'].clearSelection();
            }
        },
        mounted: function(){
            this.$refs['dialog1'].rendered = true;
            this.$refs['dialog2'].rendered = true;
        }
    })
</script>
</body>
</html>
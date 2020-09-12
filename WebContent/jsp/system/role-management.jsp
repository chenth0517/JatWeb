<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统用户管理</title>
    <style>
        .role-div{
            margin-right: 320px;
        }
        .menu-div{
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
        }
    </style>
</head>
<body>
<div id="role-management">
    <sf-panel title="岗位定义" v-cloak>
        <el-row style="min-width: 1200px;">
            <div class="role-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入用岗位名称" v-model.trim="queryCondition.roleName" icon="search" style="width: 400px;"></el-input>
                    </div>
                    <el-button type="success" icon="plus" @click="addRole">添加</el-button>
                    <el-button type="info" icon="edit" @click="editRole" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteRole" :disabled="!currentRow">删除</el-button>
                    <el-button type="primary" icon="fa-gears" @click="roleMenuFuncSetting" :disabled="!currentRow">岗位配置</el-button>
                </sf-toolbar>
                <sf-table ref="roleTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="roleTableColumns"
                          url="role/list.do"
                          :query-condition="queryCondition"
                          @current-change="onCurrentChange">
                    <el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    <el-table-column label="岗位编码" prop="roleCode" width="200"></el-table-column>
                    <el-table-column label="岗位名称" prop="name" sortable="custom"  width="200"></el-table-column>
                    <el-table-column label="岗位描述" prop="description"></el-table-column>
                </sf-table>
            </div>
            <div class="menu-div">
                <el-tabs v-model="activeTab">
                    <el-tab-pane label="菜单权限" name="menu">
                        <sf-tree ref="roleMenuTree"
                                 height="500"
                                 highlight-current
                                 node-key="id"
                                 :props="treeProps"
                                 :data="roleMenuTreeData">
                        </sf-tree>
                    </el-tab-pane>
                    <el-tab-pane label="功能权限" name="func">
                        <sf-tree ref="roleFuncTree"
                                 height="500"
                                 highlight-current
                                 node-key="id"
                                 :props="treeProps"
                                 :data="roleFuncTreeData">
                        </sf-tree>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="roleModal"
                    title="岗位"
                    v-model="showRoleModal"
                    :mode="roleEditMode"
                    url="role/save.do"
                    :model="roleForm"
                    :rules="roleValidate"
                    @on-success="onRoleModalSuccess">
        <el-form-item label="岗位编码" prop="roleCode">
            <el-input v-model.trim="roleForm.roleCode" placeholder="输入岗位 编码"></el-input>
        </el-form-item>
        <el-form-item label="岗位名称" prop="name">
            <el-input v-model.trim="roleForm.name" placeholder="输入岗位名称"></el-input>
        </el-form-item>
        <el-form-item label="岗位描述" prop="description">
            <el-input v-model.trim="roleForm.description"
                      placeholder="简要描述岗位功能及职责"
                      type="textarea"
                      :autosize="{ minRows: 2, maxRows: 4}">
            </el-input>
        </el-form-item>
    </sf-form-dialog>
    <el-dialog :visible.sync="showRoleMenuFuncDialog"
               :modal-append-to-body="false"
               v-cloak
               size="tiny">
        <span slot="title" style="color:#f60;">
            <sf-icon icon="fa-gears" left></sf-icon>岗位菜单功能配置
        </span>
        <el-tabs v-model="activeTab">
            <el-tab-pane label="菜单权限" name="menu">
                <sf-tree ref="menuTree"
                         height="400"
                         show-checkbox
                         highlight-current
                         node-key="id"
                         :props="treeProps"
                         :data="menuTreeData"
                         @check-change="menuChanged = true">
                </sf-tree>
            </el-tab-pane>
            <el-tab-pane label="功能权限" name="func">
                <sf-tree ref="funcTree"
                         height="400"
                         show-checkbox
                         highlight-current
                         node-key="url"
                         :props="treeProps"
                         :data="funcTreeData"
                         @check-change="funcChanged = true">
                </sf-tree>
            </el-tab-pane>
        </el-tabs>
        <div slot="footer">
            <el-button @click="showRoleMenuFuncDialog=false">取消</el-button>
            <el-button type="primary" :loading="buttonLoading" @click="saveRoleFunc">确定</el-button>
        </div>
    </el-dialog>
</div>
<script>

    var roleManagement = new Vue({
        el: '#role-management',
        data: {
            queryCondition: {
                roleName: ''
            },
            currentRow: null,
            roleTableColumns: [
                {
                    title: '岗位编码',
                    key: 'roleCode'
                },
                {
                    title: '岗位名称',
                    key: 'name'
                },
                {
                    title: '岗位描述',
                    key: 'description'
                }
            ],
            showRoleModal: false,
            roleEditMode: 'add',
            roleForm: {
                id: -1,
                roleCode: '',
                name: '',
                description: ""
            },
            roleValidate: {
                roleCode: [{required: true, message: '岗位编码不能为空', trigger: 'blur'}],
                name: [{required: true, message: '岗位名称不能为空', trigger: 'blur'}],
                description: [{required: true, message: '岗位描述不能为空', trigger: 'blur'}]
            },
            activeTab: 'menu',
            treeProps: {
                label: 'name',
                children: 'children'
            },
            menuTreeData: [],
            funcTreeData: [],
            roleMenuListData: [],
            roleFuncListData: [],
            showRoleMenuFuncDialog: false,
            loadingTreeData: false,
            buttonLoading: false,
            menuChanged: false,
            funcChanged: false
        },
        computed: {
            roleMenuTreeData: function () {
                return this.$listToTree(this.roleMenuListData);
            },
            roleFuncTreeData: function () {
                return this.$listToTree(this.roleFuncListData, 'url', 'parentUrl');
            },
            idMenuItemMap: function () {
                return this.$treeToMap(this.menuTreeData);
            },
            urlFuncItemMap: function () {
                return this.$treeToMap(this.funcTreeData, 'url');
            }
        },
        methods: {
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
                this.getRoleTreeData();
            },
            isLeaf: function (nodeData) {
                return nodeData.children.length === 0;
            },
            addRole: function () {
                this.roleForm.id = null;
                this.roleEditMode = 'add';
                this.showRoleModal = true;
            },
            editRole: function () {
                for(var key in this.roleForm){
                    if(this.currentRow[key])
                        this.roleForm[key] = this.currentRow[key];
                }
                this.roleEditMode = 'edit';
                this.showRoleModal = true;
            },
            onRoleModalSuccess: function () {
                this.$refs['roleTable'].reload();
            },
            deleteRole: function () {
                var self = this;
                this.$confirm("确定删除角色（" + self.currentRow.name + '）?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('role/delete.do', {roleId: self.currentRow.id}, function () {
                                self.$message.success('删除岗位成功！');
                                self.$refs['roleTable'].reload();
                            });
                        }
                    }
                });
            },
            roleMenuFuncSetting: function () {
                this.showRoleMenuFuncDialog = true;
                this.$nextTick(function () {
                    this.$refs['menuTree'].setCheckedKeys(this.roleMenuListData.filter(function (t) { return t.type !== 0;}).map(function (t) { return t.id; }));
                    this.$refs['funcTree'].setCheckedKeys(this.roleFuncListData.filter(function (t) { return t.url.indexOf('.do') > 0; }).map(function (t) { return t.url; }));
                });
            },
            getRoleTreeData: function () {
                var self = this;
                if(self.currentRow){
                    //获取岗位具有的菜单权限
                    self.$post('role/listRoleMenus.do',{
                        roleId: self.currentRow.id
                    },function (json) {
                        self.roleMenuListData = json.data;
                    });

                    //获取岗位具有的功能权限
                    self.$post('role/listRoleActions.do',{
                        roleId: self.currentRow.id
                    },function (json) {
                        self.roleFuncListData = json.data;
                    });
                }else{
                    self.roleMenuListData = [];
                    self.roleFuncListData = [];
                }
            },
            getMenuTree: function () {
                var self = this;
                this.$post('menu/list.do',function (json) {
                    self.menuTreeData = json.data;
                });

                this.$post('function/loadActionTree.do', function (json) {
                    self.funcTreeData = json.data;
                });
            },
            getMenuTreeCheckedKeys: function(){
                var idList = [];
                var keyList = this.$refs['menuTree'].getCheckedKeys();

                var self = this;
                keyList.forEach(function (id) {
                    idList.push(id);
                    var pid = self.idMenuItemMap[id].pid;
                    while( pid > 0){
                        if(idList.indexOf(pid) < 0)
                            idList.push(pid);
                        pid = self.idMenuItemMap[pid].pid;
                    }
                });
                return idList;
            },
            getFuncTreeCheckedKeys: function () {
                var idList = [];
                var nodeDataList = this.$refs['funcTree'].getCheckedNodes();

                var self = this;
                nodeDataList.forEach(function (nodeData) {
                    idList.push(nodeData.id);
                    var parentUrl = nodeData.parentUrl;
                    while (parentUrl){
                        var node = self.urlFuncItemMap[parentUrl];
                        if(idList.indexOf(node.id) < 0)
                            idList.push(node.id);
                        parentUrl = node.parentUrl;
                    }
                });
                return idList;
            },
            saveRoleFunc: function () {
                var self = this;
                self.buttonLoading = true;
                var saveMenu = function(){
                    if(self.menuChanged){
                        return self.$post('role/assignMenus.do', {
                            menuIds: self.getMenuTreeCheckedKeys(),
                            roleId: self.currentRow.id
                        }, function () {
                            self.$notify.success({
                                title: '提示',
                                message: '保存岗位菜单成功!',
                                duration: 1000
                            });
                            self.menuChanged = false;
                        });
                    }
                };
                var saveFunc = function () {
                    if(self.funcChanged){
                        return self.$post('role/assignActions.do', {
                            actionIds: self.getFuncTreeCheckedKeys(),
                            roleId: self.currentRow.id
                        }, function () {
                            self.$notify.success({
                                title: '提示',
                                message: '保存岗位功能成功!',
                                duration: 1000
                            });
                            self.funcChanged = false;
                        });
                    }
                };

                self.$http.all([saveMenu(), saveFunc()]).then(self.$http.spread(function () {
                    self.buttonLoading = false;
                    self.showRoleMenuFuncDialog = false;
                    self.getRoleTreeData();
                }));
            }
        },
        created: function () {
            this.getMenuTree();
        }
    })
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单管理</title>
</head>
<body>
<div id="menu-management">
    <sf-panel title="菜单管理" v-cloak>
        <div style="width: 800px;">
            <sf-toolbar>
                <div slot="searcher">
                    <el-input placeholder="输入菜单名称过滤" v-model.trim="filterText" icon="search" style="width: 300px;"></el-input>
                </div>
                <el-dropdown @command="addMenu">
                    <el-button type="success" icon="fa-plus">添加<sf-icon icon="caret-bottom" right></sf-icon></el-button>
                    <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="group"><sf-icon icon="fa-object-group" left fix-width></sf-icon>分组</el-dropdown-item>
                        <el-dropdown-item command="menu"><sf-icon icon="fa-list-ol" left fix-width></sf-icon>菜单</el-dropdown-item>
                        <el-dropdown-item command="link"><sf-icon icon="fa-external-link" left fix-width></sf-icon>链接</el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
                <el-button type="info" icon="edit" :disabled="!currentTreeNode" @click="editMenu">编辑</el-button>
                <el-button type="danger" icon="delete" :disabled="!currentTreeNode" @click="deleteMenu">删除</el-button>
            </sf-toolbar>
            <sf-tree ref="menuTree"
                     height="500"
                     highlight-current
                     node-key="id"
                     :props="treeProps"
                     :data="menuTreeData"
                     :filter-node-method="filterNode"
                     @current-change="onCurrentChange"
                     :current-node-key="currentTreeNode ? currentTreeNode.data.id : '' "
                     :default-expanded-keys="defaultExpandedKeys"
                     :render-content="renderContent">
            </sf-tree>
        </div>
    </sf-panel>
    <sf-form-dialog ref="menuModal"
                    :title="menuModalTitle"
                    v-model="showMenuModal"
                    :mode="menuEditMode"
                    url="menu/save.do"
                    :model="menuForm"
                    :rules="menuValidate"
                    label-width="110px"
                    label-position="right"
                    @on-success="onMenuModalSuccess">
        <el-form-item label="所属分组">
            <sf-cascader ref="cascader" v-model="selectedGroups" url="menu/listFolder.do" :props="treeProps" style="width: 100%;"></sf-cascader>
        </el-form-item>
        <el-form-item label="名称" prop="name" required>
            <el-input v-model.trim="menuForm.name" placeholder="输入名称"></el-input>
        </el-form-item>
        <el-form-item label="URL" v-if="showUrl" prop="url">
            <el-input v-model.trim="menuForm.url" placeholder="输入URL"></el-input>
        </el-form-item>
        <el-form-item label="图标" prop="icon">
            <sf-icon-picker v-model="menuForm.icon" :color="menuForm.iconColor"></sf-icon-picker>
            <el-form-item label="图标颜色" label-width="80px" prop="iconColor" style="display: inline-block;">
                <sf-color-picker v-model="menuForm.iconColor"></sf-color-picker>
            </el-form-item>
        </el-form-item>
        <el-form-item label="是否导航菜单" prop="showOnNavi">
            <el-switch v-model="menuForm.showOnNavi" :on-value="1" :off-value="0" on-text="是" off-text="否"></el-switch>
        </el-form-item>
    </sf-form-dialog>
</div>
<script>

    var MenuType = {
        MENU_FOLDER: 0,
        FILE_URL: 1,
        OUTER_PAGE: 99
    };

    var menuManagement = new Vue({
        el: '#menu-management',
        data: {
            filterText: '',
            treeProps: {
                label: 'name',
                children: 'children'
            },
            colors: [{value: 'red', label: '红色'},{value: 'green', label: '绿色'}],
            menuTreeData: [],
            currentTreeNode: null,
            menuModalTitle: '',
            showMenuModal: false,
            menuEditMode: 'add',
            menuForm: {
                id: null,
                pid: 0,
                name: '',
                type: MenuType.MENU_FOLDER,
                url: '',
                icon: '',
                iconColor: '#FFFFFF',
                showOnNavi: 1,
                orderno: 0
            },
            menuValidate: {
                name: [{required: true, message: '角色名称不能为空', trigger: 'blur'}],
                url: [
                    { required: true, message: 'URL地址不能为空', trigger: 'blur' }
                ]
            },
            expandedKeys: []
        },
        computed: {
            showUrl: function () {
                return this.menuForm.type !== MenuType.MENU_FOLDER;
            },
            idMenuItemMap: function () {
                var menuMap = {};

                var treeFunc = function (tree) {
                    tree.forEach(function (item) {
                        menuMap[item.id] = item;
                        if(item.children.length)
                            treeFunc(item.children);
                    });
                };
                treeFunc(this.menuTreeData);
                return menuMap;
            },
            selectedGroups: {
                get: function () {
                    var result = [];
                    var pid = this.menuForm.pid;
                    while(pid > 0){
                        result.unshift(pid);
                        pid = this.idMenuItemMap[pid].pid;
                    }
                    return result;
                },
                set: function (val) {
                    if(val.length){
                        this.menuForm.pid = val[val.length - 1];
                    }else {
                        this.menuForm.pid = 0;
                    }
                }
            },
            defaultExpandedKeys: function () {
                if(this.currentTreeNode){
                    return [this.currentTreeNode.data.id];
                }else{
                    return this.expandedKeys;
                }
            }
        },
        watch: {
            filterText: function(val){
                this.$refs['menuTree'].filter(val);
            },
            'menuForm.type': function () {
                if(this.menuForm.type === MenuType.MENU_FOLDER)
                    this.menuModalTitle = "分组";
                else if(this.menuForm.type === MenuType.FILE_URL)
                    this.menuModalTitle = "菜单";
                else if(this.menuForm.type === MenuType.OUTER_PAGE)
                    this.menuModalTitle = "链接";
            }
        },
        methods: {
            renderContent: function (h, params) {
                var self = this;
                return h('span', [
                    h('sf-icon', {
                        props: {
                            icon: params.data.icon || '',
                            fixWidth: !!params.data.icon,
                            color: params.data.iconColor
                        }
                    }),
                    params.node.label,
                    h('span', {
                        style: {
                            float: 'right',
                            marginRight: '50px'
                        }
                    }, [
                        h('el-button', {
                            props: {
                                plain: true,
                                type: 'info',
                                size: 'small',
                                icon: 'fa-arrow-up'
                            },
                            on: {
                                click: function(event){
                                    // 阻止 事件冒泡
                                    event.stopPropagation();
                                    self.upOrder(params.node);
                                }
                            }
                        }),
                        h('el-button', {
                            props: {
                                plain: true,
                                type: 'primary',
                                size: 'small',
                                icon: 'fa-arrow-down'
                            },
                            on: {
                                click: function(event){
                                    // 阻止 事件冒泡
                                    event.stopPropagation();
                                    self.downOrder(params.node);
                                }
                            }
                        })
                    ])
                ]);
            },
            loadMenuTree: function () {
                var self = this;
                this.$post('menu/list.do',function (json) {
                    self.menuTreeData = json.data;
                    self.$nextTick(function () {
                        self.currentTreeNode = self.$refs['menuTree'].store.getCurrentNode();
                    });
                });
            },
            filterNode: function (value, data) {
                if (!value) return true;
                return data.name.indexOf(value) !== -1;
            },
            onCurrentChange: function(nodeData, node){
                this.currentTreeNode = node;
            },
            setNewOrder: function () {
                var maxOrderNo = 0;
                var val = this.menuForm.pid;
                if(val === 0){
                    this.menuTreeData.forEach(function (item) {
                        if(item.orderno > maxOrderNo)
                            maxOrderNo = item.orderno;
                    });
                }else{
                    this.idMenuItemMap[val].children.forEach(function (item) {
                        if(item.orderno > maxOrderNo)
                            maxOrderNo = item.orderno;
                    });
                }

                this.menuForm.orderno = maxOrderNo + 1;
            },
            addMenu: function (type) {
                this.menuForm.id = null;
                if(this.currentTreeNode){
                    if(this.currentTreeNode.data.type === MenuType.MENU_FOLDER)
                        this.menuForm.pid = this.currentTreeNode.data.id;
                    else
                        this.menuForm.pid = this.currentTreeNode.data.pid;
                }else{
                    this.menuForm.pid = 0;
                }

                this.setNewOrder();

                if(type === 'group'){
                    this.menuForm.type = MenuType.MENU_FOLDER;
                }else if(type === 'menu'){
                    this.menuForm.type = MenuType.FILE_URL;
                }else if(type === 'link'){
                    this.menuForm.type = MenuType.OUTER_PAGE;
                }

                this.menuEditMode = 'add';
                this.showMenuModal = true;
            },
            editMenu: function () {
                for(var key in this.menuForm){
                    if(this.currentTreeNode.data[key])
                        this.menuForm[key] = this.currentTreeNode.data[key];
                }

                this.menuEditMode = 'edit';
                this.showMenuModal = true;
            },
            onMenuModalSuccess: function () {
                this.menuForm.pid = 0;
                this.menuForm.icon = "";
                this.menuForm.iconColor = "";
                this.menuForm.url = "";
                this.reloadData();
            },
            deleteMenu: function () {
                this.menuForm.type = this.currentTreeNode.data.type;
                if(this.currentTreeNode.data.pid > 0){
                    this.expandedKeys = [this.currentTreeNode.data.pid];
                }else {
                    this.expandedKeys = [];
                }

                var self = this;

                this.$nextTick(function () {
                    self.$confirm('确定删除所选' + self.menuModalTitle + '(' + self.currentTreeNode.label + ')?','提示',{
                        type: 'warning',
                        callback: function(action){
                            if(action === 'confirm'){
                                self.$post('menu/delete.do', {menuIds: [self.currentTreeNode.data.id]}, function () {
                                    self.$message.success('删除成功！');
                                    self.$refs['menuTree'].store.setCurrentNode(null);
                                    self.reloadData();
                                });
                            }
                        }
                    });
                });

            },
            reloadData: function () {
                this.loadMenuTree();
                if(this.menuForm.type === MenuType.MENU_FOLDER){
                    this.$refs['cascader'] && this.$refs['cascader'].debounceLoad();
                }
            },
            upOrder: function (node) {
                var nodes = node.parent.childNodes;
                var index = nodes.indexOf(node);
                if(index === 0)
                    return;
                var otherNode = nodes[index - 1];
                this.saveChangeOrder(node, otherNode);
            },
            downOrder: function (node) {
                var nodes = node.parent.childNodes;
                var index = nodes.indexOf(node);
                if(index === nodes.length - 1)
                    return;
                var otherNode = nodes[index + 1];
                this.saveChangeOrder(node, otherNode);
            },
            saveChangeOrder: function (node1, node2) {
                var self = this;
                this.$post('menu/changeOrder.do',{
                    id1: node1.data.id,
                    id2: node2.data.id
                },function (json) {
                    self.loadMenuTree();
                    self.$refs['cascader'] && self.$refs['cascader'].debounceLoad();
                });
            }
        },
        created: function () {
            this.loadMenuTree();
        }
    })
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>首页</title>
		<%@include file="./jsp/include/common-rss.jsp"%>
        <style type="text/css">
            /* 页面公共 */
            html,body{padding:0;}
            html,body{
                width: 100%;
                height: 100%;
                overflow-x: auto;
                overflow-y: hidden;
                display: block;
                margin: 0;
                padding: 0;
            }

            .layout{
                height: 100%;
                width: 100%;
            }
            .layout-header{
                position: relative;
                top: 0;
                left: 0;
                right: 0;
                height: 50px;
                background: #133b78;
            }

            .layout-header-logo{
                float: left;
                position: relative;
                left: 20px;
            }

            #layout-header-search{
                float: right;
                margin-top: 8px;
                margin-right: 20px;
            }

            .layout-header-info{
                float: right;
                margin-right: 20px;
                line-height: 50px;
            }

            .layout-content{
                margin-top: 50px;
                height: 100%;
            }
            .layout-content-sidebar{
                position: fixed;
                top: 50px;
                bottom: 0;
                width: 280px;
                padding-top: 20px;
                background: #324157;
                overflow-y: auto;
            }
            .layout-content-main{
/*                 margin-top: 10px; */
/*                 margin-left: 20px; */
                position: fixed;
                top: 50px;
                bottom: 0;
                left: 280px;
                right: 0;
                background-color: #efefef;
            }

            .badge{
                margin-right: 30px;
            }

            .badge a{
                font-size: 22px;
                color: #fff;
            }
            .user-info{
                color: #fff;
                font-family: Arial,serif;
                font-size: 12px;
                text-decoration: none;
                font-weight:bold;
            }

            .full-display{
                width: 100%;
                height: 100%;
            }

            #system-management .el-tabs .el-tabs__content{
                position: absolute;
                top: 42px;
                left: 0;
                right: 0;
                bottom: 0;
                overflow: auto;
                padding: 0;
            }

        </style>
	</head>
<body>
	<div id="system-management" class="layout" v-cloak>
        <div class="layout-header">
            <div class="layout-header-logo">
                <a href="dashboard.do"><img src="resources/data/JatWeb.png" style="margin-top:-2px;"></a>
            </div>
            <div class="layout-header-info">
                    <a href="javascript:void(0)" class="user-info">
                        ${UserObject.realName }
                    </a>
                    <a href="logoutView.do" style="text-decoration: none;color:#FFF;" title="注销离开"><sf-icon icon="fa-sign-out" fix-width></sf-icon></a>
                    <a href="user/changePwdView.do" style="text-decoration: none;color:#FFF;" title="修改密码"><sf-icon icon="fa-pencil" fix-width></sf-icon></a>
            </div>
        </div>
        <div class="layout-content">
            <div class="layout-content-sidebar">
                <el-menu theme="dark" @select="menuSelect" :default-active="activeTab" unique-opened style="width: 100%;">
                    <el-submenu v-for="menu in menus" :index="menu.id + ''" :key="menu.id">
                        <template slot="title">
                            <sf-icon v-if="menu.icon" :icon="menu.icon" :color="menu.iconColor" fix-width></sf-icon>{{menu.name}}
                        </template>
                        <el-menu-item v-for="submenu in menu.children" :index="submenu.id + ''" :key="submenu.id">
                            <sf-icon v-if="submenu.icon" :icon="submenu.icon" :color="submenu.iconColor" fix-width></sf-icon>{{submenu.name}}
                        </el-menu-item>
                    </el-submenu>
                </el-menu>
            </div>
            <div class="layout-content-main">
                <el-tabs type="border-card" v-model="activeTab" @tab-remove="handleTabRemove" style="height: 100%;">
                    <el-tab-pane label="首页" name="index" class="full-display">
                        <span slot="label"><sf-icon icon="fa-home"></sf-icon> 首页</span>
                        <iframe frameborder="0" src="pageView-home.do" class="full-display"></iframe>
                    </el-tab-pane>
                    <el-tab-pane v-for="tab in tabs" closable :key="tab.id" :name="tab.id + ''" :label="tab.name" class="full-display">
                        <iframe frameborder="0" :src="tab.url" class="full-display"></iframe>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>
    </div>
    <script>
        var systemManagement = new Vue({
            el: '#system-management',
            data: {
                menus: [],
                tabs: [],
                activeTab: 'index'
            },
            methods: {
                getMenus: function () {
                    var self = this;
//                    this.$get("resources/data/menu.json", function (json) {
//                        self.menus = json.data;
                    this.$get("menuTree.do", function (json) {
                        self.menus = json.data;
                    }, function () {
                        self.$message.error("加载菜单失败！");
                    });
                },
                getMenuByName: function (name, menus) {
                    if(menus instanceof Array){
                        for(var i = 0; i < menus.length; i++){
                            if(menus[i].id + '' === name)
                            {
                            	return menus[i];
                            }
                            var result = this.getMenuByName(name, menus[i].children);
                            if(result !== null)
                                return result;
                        }
                    }
                    return null;
                },
                menuSelect: function(name){
                    this.activeTab = name;
                    if(this.getMenuByName(name, this.tabs))
                        return;
                    var menu = this.getMenuByName(name, this.menus);
                    if(menu.url)
                        this.tabs.push(menu);
                },
                handleTabRemove: function(name) {
                    function findTabByName(tabs,name){
                        for(var i = 0;i < tabs.length ; ++i){
                            if(tabs[i].id + '' === name)
                                return i;
                        }
                        return -1;
                    }

                    var index = findTabByName(this.tabs, name);
                    if(this.activeTab === name){
                        var nexTab = this.tabs[index + 1] || this.tabs[index - 1];
                        if(nexTab)
                            this.activeTab = nexTab.id + '';
                        else
                            this.activeTab = "index";
                    }
                    if(index >= 0){
                        this.tabs.splice(index,1);
                    }
                }
            },
            mounted: function () {
                this.getMenus();
            }
        });
    </script>
</body>
</html>
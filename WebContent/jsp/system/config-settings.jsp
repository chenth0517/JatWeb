<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>参数配置</title>
	<%@include file="../include/common-rss.jsp"%>
</head>
<body>
<div id="config-settings" v-cloak>
	<div>
		<a class="el-button el-button--primary" style="margin-left:20px;text-decoration:none;" href="utility/settings/export.do" target="_blank">导出系统配置</a>
		<el-button type="success" icon="fa-refresh" @click="reloadRuntimeCfg" style="display:inline;">刷新系统配置</el-button>
	</div>
    <el-card v-for="(value,key) in settings" :header="key" :key="key" style=" margin: 20px;">
        <el-form label-width="300px">
            <el-form-item v-for="item in value" :key="item.id" :label="item.description">
                <template v-if="item.dataType===0">
                    <el-input v-model="item.value"></el-input>
                </template>
                <template v-else-if="item.dataType===1">
                    <el-input-number v-model="item.value" :min="0"></el-input-number>
                </template>
                <template v-else-if="item.dataType===2">
                    <el-radio-group v-model="item.value">
                        <el-radio v-for="json in item.jsonData" :key="json.id" :label="json.id + '' ">{{json.text}}</el-radio>
                    </el-radio-group>
                </template>
                <template v-else-if="item.dataType===3">
                    <el-checkbox-group v-model="item.value">
                        <el-checkbox v-for="json in item.jsonData" :key="json.id" :label="json.id + '' ">{{json.text}}</el-checkbox>
                    </el-checkbox-group>
                </template>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="saveSettings(value,key)" style="float: right">保存</el-button>
            </el-form-item>
        </el-form>
    </el-card>
</div>
<script>
    var configSettings = new Vue({
        el: '#config-settings',
        data: {
            settings: {}
        },
        methods: {
            loadSettings: function(){
                var self = this;
                this.$post("utility/settings/loadSettings.do", function (json) {
                    var map = {};
                    json.data.forEach(function (item) {
                        if(item.dataType >= 2){
                            item.jsonData = JSON.parse(item.jsonData);
                            if(item.dataType === 3){
                                item.value = item.value.split(",");
                            }
                        }
                        if(!map[item.groupName])
                            map[item.groupName] = [];
                        map[item.groupName].push(item);
                    });
                    self.settings = map;
                });
            },
            saveSettings: function(settings, key){
                var data = [];
                settings.forEach(function (item) {
                    var setting = Object.assign({}, item);
                    if(setting.dataType === 3){
                        setting.value = setting.value.join(",");
                    }

                    if(setting.jsonData){
                        setting.jsonData = JSON.stringify(setting.jsonData);
                    }
                    data.push(setting);
                });
                var self = this;
                this.$post("utility/settings/saveSettings.do", data, function () {
                    self.$message.success("保存" + key + "的配置成功！");
                });
            },
            reloadRuntimeCfg:function(){
            	var self = this;
            	this.$post("utility/settings/reloadCfg.do", {}, function () {
                    self.$message.success("重新加载系统配置成功！");
                    self.loadSettings();
                });
            }
        },
        created: function () {
            this.loadSettings();
        }
    })
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>参数配置</title>
	<%@include file="../include/common-rss.jsp"%>
</head>
<st:jspId value="config-settings"></st:jspId>
<body>
<div id="config-settings" v-cloak>
	<sf-toolbar>
        <div slot="searcher">
			<el-input v-model="filterName" style="width:300px;margin-left:20px;" placeholder="请输入配置描述或者配置项ID的关键字搜索" @change="loadSettings"></el-input>
			<a class="el-button el-button--primary" style="margin-left:20px;text-decoration:none;" href="utility/settings/export.do" target="_blank">
		<i class="fa fa-download"></i>导出全部配置</a>
		<el-button type="success" icon="fa-refresh" @click="reloadRuntimeCfg" style="display:inline;">刷新系统配置</el-button>
		</div>
	</sf-toolbar>
    <el-card v-for="(value,key) in settings" :header="key" :key="key" style=" margin: 20px;">
        <el-form label-width="300px">
            <el-form-item v-for="item in value" :key="item.id" :label="item.description + (item.allowEdit===0?'[*需重启*]':'')">
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
                <el-button type="primary" icon="fa-save" @click="saveSettings(value,key)" style="margin-left:10px;float: right">保存</el-button>
                <el-button type="success" icon="fa-plus" @click="addNewCfgItem(key)" style="float: right;">新增配置项</el-button>
            </el-form-item>
        </el-form>
    </el-card>
    
    <sf-form-dialog ref="settingDialog"
		title="配置参数" 
		v-model="showSettingModal" 
		:edit-mode="sysSettingEditMode"
		url="utility/settings/addSetting.do" 
		:model="settingForm" 
		:rules="settingValidate" 
		@on-success="loadSettings">
<!-- 	    <el-form-item label="分组" prop="groupName"> -->
<!-- 	        <el-input :value="settingForm.groupName" placeholder="格式:序号-分组名称"></el-input> -->
<!-- 	    </el-form-item> -->
	    <el-form-item label="参数ID" prop="id">
	        <el-input v-model.trim="settingForm.id" placeholder="长度在 8 到 64 个字符"></el-input>
	    </el-form-item>
	    <el-form-item label="参数描述" prop="description">
	        <el-input v-model.trim="settingForm.description" placeholder="参数描述"></el-input>
	    </el-form-item>
	    <el-form-item label="参数值" prop="value">
	        <el-input v-model.trim="settingForm.value" placeholder="数值"></el-input>
	    </el-form-item>
	    <el-form-item label="数据类型" prop="dataType">
	        <el-select v-model="settingForm.dataType">
			    <el-option v-for="item in settingDataTypeOptions" :key="item.value" :label="item.label" :value="item.value">
			    </el-option>
			</el-select>
	    </el-form-item>
	    <el-form-item label="选项配置" prop="jsonData">
	        <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" :value="settingForm.jsonData" placeholder="JSON格式化字符串"></el-input>
	    </el-form-item>
	     <el-form-item label="运行期可修改" prop="allowEdit">
	        <el-select v-model="settingForm.allowEdit">
			    <el-option v-for="item in allowOptions" :key="item.value" :label="item.label" :value="item.value">
			    </el-option>
			</el-select>
	    </el-form-item>
	</sf-form-dialog>
</div>
<script>
    var configSettings = new Vue({
        el: '#config-settings',
        data: {
            settings: {},
            settingDataTypeOptions:[
							  {
							    value: 0,
							    label: '字符串'
							  }, {
							    value: 1,
							    label: '数值'
							  }, {
							    value: 2,
							    label: '选项'
							  }
            ],
            allowOptions:[
        							{
        							    value: 0,
        							    label: '不允许'
        							  }, {
        							    value: 1,
        							    label: '允许'
        							  }
                    ],
            showSettingModal:false,
            sysSettingEditMode:false,
            settingForm:{
            	id:null,
            	description:null,
            	groupName:null,
            	dataType:0,
            	value:null,
            	allowEdit:1,
            	jsonData:''
            },
            
            settingValidate:{
				id:[{required: true, message: 'ID不能为空', trigger: 'blur'},{ min: 8, max: 64, message: '长度在 8 到 64 个字符', trigger: 'blur' }],
// 				dataType:[{required: true, message: '数据类型不能为空', trigger: 'blur'}],
				description:[{required: true, message: '描述不能为空', trigger: 'blur'}],             
            	groupName:[{required: true, message: '分组不能为空', trigger: 'blur'}],
//             	allowEdit:[{required: true, message: '描述不能为空', trigger: 'blur'}]
            },
            filterName:''
        },
        methods: {
            loadSettings: function(){
                var self = this;
                this.$post("utility/settings/loadSettings.do",{name:this.filterName}, function (json) {
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
            },
            addNewCfgItem:function(key){
            	this.showSettingModal = true;
            	this.settingForm={
                	id:null,
                	description:null,
                	groupName:key,
                	dataType:0,
                	value:null,
                	allowEdit:1
                }
            }
        },
        created: function () {
            this.loadSettings();
        }
    })
</script>
</body>
</html>
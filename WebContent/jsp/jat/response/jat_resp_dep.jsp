<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>jat_resp_dep-维护页面</title>
    <style>
		.inline-toolbar div{
        	display:inline-block;
        }
	</style>
</head>
<st:jspId value="jat_resp_dep"></st:jspId>
<!-- For table:jat_resp_dep CRUD Operation -->
<body>
<div id="vue_jat_resp_dep">
    <sf-panel title="jat_resp_dep管理" v-cloak>
        <el-row>
            <div class="jat_resp_dep-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入检索关键字" v-model.trim="queryCondition.name" icon="search" style="width: 400px;"></el-input>
                        <el-button type="success" icon="search" @click="search">查询</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addJatRespDep">添加</el-button>
                    <el-button type="info" icon="edit" @click="editJatRespDep" :disabled="!currentRow">编辑</el-button>
                    <!-- el-button type="danger" icon="delete" @click="deleteJatRespDep" :disabled="JatRespDepSelection.length<1">删除</el-button -->
                </sf-toolbar>
                <sf-table ref="jatRespDepTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="jatRespDepTableColumns"
                          url="jat/response/jatRespDep/list.do"
                          :query-condition="queryCondition" 
                          import-url="jat/response/jatRespDep/importFile.do"
                          :show-import="true"
                          @current-change="onCurrentChange"
                          @selection-change="onJatRespDepSelectionChange">
                        <el-table-column type="selection" width="50" align="center"></el-table-column>
                    	<el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    	<el-table-column label="职责编号" prop="id"></el-table-column>
                    	<el-table-column label="职责名称" prop="name"></el-table-column>
                    	<el-table-column label="职责描述" prop="description"></el-table-column>
                    	<el-table-column label="停用该职责" prop="disabled_t_description"></el-table-column>
                    	<el-table-column label="责任类型" prop="type_t_description"></el-table-column>
                    	<el-table-column label="是否关键责任" prop="isKey_t_description"></el-table-column>
                    	<el-table-column label="是否独立责任" prop="singleResp_t_description"></el-table-column>
                    	<el-table-column label="是否安全责任" prop="isSafeResp_t_description"></el-table-column>
                    
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="jatRespDepModal"
                    title="jat_resp_dep"
                    v-model="showJatRespDepModal"
                    :mode="jatRespDepEditMode"
                    url="jat/response/jatRespDep/save.do" 
                    :model="jatRespDepForm"
                    :rules="jatRespDepValidate"
                    @on-success="onJatRespDepModalSuccess">
        
					<!-- el-form-item label="职责编号" prop="id">
			            <el-input v-model.trim="jatRespDepForm.id" placeholder="职责编号" readonly></el-input>
			        </el-form-item -->
					<el-form-item label="职责名称" prop="name">
			            <el-input v-model.trim="jatRespDepForm.name" placeholder="职责名称" ></el-input>
			        </el-form-item>
					<el-form-item label="职责描述" prop="description">
			            <el-input v-model.trim="jatRespDepForm.description" placeholder="职责描述" ></el-input>
			        </el-form-item>
					<el-form-item label="停用该职责" prop="disabled">
			            <sf-select v-model.trim="jatRespDepForm.disabled" placeholder="停用该职责" url="utility/dictionary/loadDictItemsByName.do?name=JAT_DISABLED" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="责任类型" prop="type">
			            <sf-select v-model.trim="jatRespDepForm.type" placeholder="责任类型" url="utility/dictionary/loadDictItemsByName.do?name=JAT_RESP_TYPE" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="是否关键责任" prop="is_key">
			            <sf-select width="100%" v-model.trim="jatRespDepForm.isKey" placeholder="是否关键责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="是否独立责任" prop="single_resp">
			            <sf-select v-model.trim="jatRespDepForm.singleResp" placeholder="是否独立责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="是否安全责任" prop="is_safe_resp">
			            <sf-select v-model.trim="jatRespDepForm.isSafeResp" placeholder="是否安全责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
    </sf-form-dialog>
</div>
<script>

    var jatRespDepManagement = new Vue({
        el: '#vue_jat_resp_dep',
        data: {
        	//根据需要填写查询字段
            queryCondition: {
                name: ''
            },
            currentRow: null,
			jatRespDepSelection:[],
            jatRespDepTableColumns: [
                {
                    title: '职责编号',
                    key: 'id'
                },
                {
                    title: '职责名称',
                    key: 'name'
                },
                {
                    title: '职责描述',
                    key: 'description'
                },
                {
                    title: '停用该职责',
                    key: 'disabled'
                },
                {
                    title: '责任类型',
                    key: 'type'
                },
                {
                    title: 'is_key',
                    key: 'isKey'
                },
                {
                    title: 'single_resp',
                    key: 'singleResp'
                },
                {
                    title: 'is_safe_resp',
                    key: 'isSafeResp'
                }
            ],
            showJatRespDepModal: false,
            jatRespDepEditMode: 'add',//'edit','view'
            jatRespDepForm: {
                id: null ,
                name: null ,
                description: null ,
                disabled: null ,
                type: null ,
                isKey: null ,
                singleResp: null ,
                isSafeResp: null 
            },
            jatRespDepValidate: {
            	//此处添加字段数据合理性验证
                //id: [{required: true,type:'number', message: '职责编号不能为空', trigger: 'blur'}],
            },
            buttonLoading: false,
        },
        methods: {
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            onJatRespDepSelectionChange:function(selection){
                this.jatRespDepSelection = selection;
            },
            search: function() {
            	this.$refs['jatRespDepTable'].reload();
            },
            addJatRespDep: function () {
                this.jatRespDepForm.id = null;
                this.jatRespDepEditMode = 'add';
                this.showJatRespDepModal = true;
            },
            editJatRespDep: function () {
                for(var key in this.jatRespDepForm){
                    if(this.currentRow[key])
                        this.jatRespDepForm[key] = this.currentRow[key];
                }
                this.jatRespDepEditMode = 'edit';
                this.showJatRespDepModal = true;
            },
            onJatRespDepModalSuccess: function () {
                this.$refs['jatRespDepTable'].reload();
            },
            deleteJatRespDep: function () {
                var self = this;
                if(self.JatRespDepSelection.length==0)
                {
                	self.$message.warning('请选中要删除的记录！');
                	return;
                }
                this.$confirm('确定删除[' + self.JatRespDepSelection.length+']条记录?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                        	var ids = [];
                        	for(var i=0;i<self.JatRespDepSelection.length;i++)
                        	{
                        		ids.push(self.JatRespDepSelection[i].id);
                        	}
                            self.$post('jat/response/jatRespDep/delete.do', {ids: ids}, function () {
                                self.$message.success('删除成功！');
                                self.$refs['jatRespDepTable'].reload();
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
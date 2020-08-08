<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>职责定义-维护页面</title>
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
    <sf-panel title="职责管理" v-cloak>
        <el-row>
            <div class="jat_resp_dep-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入检索关键字" v-model.trim="queryCondition.name" icon="search" style="width: 400px;"></el-input>
                        <el-button type="success" icon="search" @click="search">查询</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addJatRespDep">添加</el-button>
                    <el-button type="info" icon="edit" @click="editJatRespDep" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteJatRespDep" :disabled="jatRespDepSelection.length==0">删除</el-button>
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
                    	<!-- el-table-column label="职责编号" prop="id"></el-table-column -->
                    	<el-table-column label="职责名称" prop="name"></el-table-column>
                    	<el-table-column width="300" label="职责描述" prop="description"></el-table-column>
                    	<el-table-column width="120" label="停用该职责" prop="disabled_t_description"></el-table-column>
                    	<el-table-column width="100" label="责任类型" prop="type_t_description"></el-table-column>
                    	<el-table-column width="100" label="关键责任" prop="isKey_t_description"></el-table-column>
                    	<el-table-column width="100" label="独立责任" prop="singleResp_t_description"></el-table-column>
                    	<el-table-column width="100" label="安全责任" prop="isSafeResp_t_description"></el-table-column>
                    	<el-table-column label="上层责任" prop="pid_t_description"></el-table-column>
						<el-table-column width="140" fixed="right" label="操作">
							<template scope="scope">
								<!-- el-tooltip class="item" effect="light" content="责任查看" placement="bottom">
									<el-button size="mini" type="warning" icon="fa-check" @click="viewDetail(scope.row)"></el-button>
								</el-tooltip -->
								<el-tooltip class="item" effect="light" content="责任分解" placement="bottom">
									<el-button size="mini" type="info" icon="fa-user-plus" @click="editSubResp(scope.row)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="下层责任" placement="bottom">
									<el-button size="mini" type="success" icon="fa-users" @click="viewSubResp(scope.row)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="责任绑定" placement="bottom">
									<el-button size="mini" type="warning" icon="fa-exchange" @click="bindResp(scope.row)"></el-button>
								</el-tooltip>
							</template>
						</el-table-column>
                    
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="jatRespDepModal"
                    title="职责"
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
					<el-form-item label="关键责任" prop="is_key">
			            <sf-select width="100%" v-model.trim="jatRespDepForm.isKey" placeholder="关键责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="独立责任" prop="single_resp">
			            <sf-select v-model.trim="jatRespDepForm.singleResp" placeholder="独立责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
					<el-form-item label="安全责任" prop="is_safe_resp">
			            <sf-select v-model.trim="jatRespDepForm.isSafeResp" placeholder="安全责任" url="utility/dictionary/loadDictItemsByName.do?name=JAT_YES_OR_NO" value-field="id" text-field="displayValue"/>
			        </el-form-item>
    </sf-form-dialog>
    <el-dialog title="查看下层责任" :visible.sync="dialogTableVisible">
		<sf-table ref="subRespTable"
                          highlight-current-row
                          :height="500"
                          :show-import="false"
                          url="jat/response/jatRespDep/list.do" 
                          @current-change="onCurrentChange"
                          :query-condition="subRespCondition">
            <el-table-column label="职责名称" prop="name"></el-table-column>
           	<el-table-column width="300" label="职责描述" prop="description"></el-table-column>
           	<!-- el-table-column width="120" label="停用该职责" prop="disabled_t_description"></el-table-column -->
           	<el-table-column width="100" label="责任类型" prop="type_t_description"></el-table-column>
           	<!-- el-table-column width="100" label="关键责任" prop="isKey_t_description"></el-table-column -->
           	<!-- el-table-column width="100" label="独立责任" prop="singleResp_t_description"></el-table-column -->
           	<!-- el-table-column width="100" label="安全责任" prop="isSafeResp_t_description"></el-table-column -->
           	<el-table-column label="上层责任" prop="pid_t_description"></el-table-column>
        	<el-table-column width="90" label="操作">
				<template scope="scope">
					<el-button size="mini" type="danger" icon="delete" @click="deleteSubResp(scope.row)">删除</el-button>
				</template>
			</el-table-column>
        </sf-table>
		<span slot="footer" class="dialog-footer">
			<el-button @click="dialogTableVisible=false">取 消</el-button>
			<el-button type="primary" @click="dialogTableVisible=false">确 定</el-button>
		</span>
	</el-dialog>
    <sf-form-dialog ref="jatRespBindModal"
                    title="职责绑定"
                    v-model="showJatRespBindModal"
                    :mode="jatRespBindEditMode"
                    url="jat/response/jatRespDep/save111111.do" 
                    :model="jatRespBindForm">
        
					<!-- el-form-item label="关系编号" prop="id">
			            <el-input v-model.trim="jatRespBindForm.id" placeholder="职责编号" readonly></el-input>
			        </el-form-item -->
					<el-form-item label="职责名称" prop="respName">
			            <el-input v-model.trim="jatRespBindForm.respName" placeholder="职责名称"  readonly></el-input>
			        </el-form-item>
					<el-form-item label="负责" prop="incharge">
			            <sf-select width="100%" v-model.trim="jatRespBindForm.incharge" placeholder="负责" :multiple="false" url="jat/response/jatRespDep/loadSysOrg.do" value-field="id" text-field="name"/>
			        </el-form-item>
					<el-form-item label="参与" prop="participate">
			            <sf-select width="100%" v-model.trim="jatRespBindForm.participate" placeholder="参与" :multiple="true" url="jat/response/jatRespDep/loadSysOrg.do" value-field="id" text-field="name"/>
			        </el-form-item>
					<el-form-item label="相关" prop="relate">
			            <sf-select width="100%" v-model.trim="jatRespBindForm.relate" placeholder="关联" :multiple="true" url="jat/response/jatRespDep/loadSysOrg.do" value-field="id" text-field="name"/>
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
            subRespCondition: {
				pid: null
			},
			currentRow: null,
			jatRespDepSelection: [],
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
            showJatRespBindModal: false,
			dialogTableVisible: false,
			jatRespDepEditMode: 'add',//'edit','view'
			jatRespBindEditMode: 'add',//'edit','view'
            jatRespDepForm: {
                id: null ,
                name: null ,
                description: null ,
                disabled: null ,
                type: null ,
                isKey: null ,
                singleResp: null ,
                isSafeResp: null ,
                pid: null
            },
            jatRespBindForm: {
            	id: null ,
            	respName: null ,
            	incharge: null ,
            	participate: null ,
            	relate: null
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
                this.jatRespDepForm.pid = null;
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
                this.$confirm('确定删除所选职责及相关信息?','提示',{
                	type: 'warning',
					callback: function(action){
						if(action === 'confirm'){
							self.$post('jat/response/jatRespDep/delete.do', 
								{ids: self.jatRespDepSelection.map(function (user) {
                                    return user.id;
                                })},
								function () {
									self.$message.success('删除成功！');
									self.$refs['jatRespDepTable'].reload();
								}
							);
						}
					}
                });
            },
            viewDetail: function (row) {
				this.jatRespDepForm.id = row.id;
                this.jatRespDepEditMode = 'view';
                this.showJatRespDepModal = true;
			},
			editSubResp: function (row) {
				this.jatRespDepForm.pid = row.id;
				this.jatRespDepForm.id = null;
                this.jatRespDepEditMode = 'add';
                this.showJatRespDepModal = true;
			},
			viewSubResp: function (row) {
				this.subRespCondition.pid = row.id;
				this.dialogTableVisible = true;
			},
			bindResp: function (row) {
				this.jatRespBindForm.id = row.id;
				this.jatRespBindForm.respName = row.name;
                this.jatRespBindEditMode = 'edit';
				this.showJatRespBindModal = true;
			},
			deleteSubResp: function (row) {
				var self = this;
				this.$confirm("确定删除[" + row.name + ']?','提示',{
					type: 'warning',
					callback: function(action){
						if(action === 'confirm'){
							self.$post('jat/response/jatRespDep/delete.do', {ids: [row.id]}, function () {
								self.$message.success('删除成功！');
								self.$refs['subRespTable'].reload();
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
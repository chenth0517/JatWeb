<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>消息管理</title>
</head>
<st:jspId value="msg-template"></st:jspId>
<body>
<div id="msg-template">
    <sf-panel title="消息模板管理" v-cloak>
           <sf-toolbar>
               <div slot="searcher">
                    <el-row>
	                     <el-date-picker
						      v-model="startDate"
						      type="datetime"
						      placeholder="选择开始时间"
						      style="width: 200px;"
						      >
		    			</el-date-picker>
		     		    <el-date-picker
						      v-model="endDate"
						      type="datetime"
						      placeholder="选择结束时间"
						      style="width: 200px;"
						      >
		   			    </el-date-picker>
                        <el-input placeholder="输入模板名称" v-model="name" icon="search" style="width: 200px;"></el-input>
                     </el-row>
                     <el-row>
                        <el-input placeholder="输入模板编码" v-model="id" icon="search" style="width: 200px;"></el-input>
                        <el-input placeholder="输入应用编码" v-model="appId" icon="search" style="width: 200px;"></el-input>
                        <el-input placeholder="输入模板内容" v-model="content" icon="search" style="width: 200px;"></el-input>
                        <el-button type="warning" icon="fa-key" @click="resetSearchCondition">重置</el-button>
                        <el-button type="success" icon="plus" @click="addmsg">添加</el-button>
                   		<el-button type="info" icon="edit" @click="editmsg" :disabled="!currentRow">编辑</el-button>
                    	<el-button type="danger" icon="delete" @click="deletemsg" :disabled="!currentRow">删除</el-button>
                     </el-row>
                    </div>
                </sf-toolbar>
                <sf-table ref="msgTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="msgTableColumns"
                          :query-condition="queryCondition" 
                          url="server/message/msgMng/listTemplate.do" 
                          @selection-change="onSelectionChange"
                          @current-change="onCurrentChange">
                    <el-table-column type="selection" width="50" align="center"></el-table-column>
                    <el-table-column label="#" prop="__index" width="100" align="center"></el-table-column>
                    <el-table-column label="模板编码" prop="id" width="200"></el-table-column>
                    <el-table-column label="应用编码" prop="appId" width="300"></el-table-column>
                    <el-table-column label="模板创建时间" prop="createTime"></el-table-column>
                    <el-table-column label="模板名" prop="name"></el-table-column>
                    <el-table-column label="模板内容" prop="content"></el-table-column>
                </sf-table>
    </sf-panel>
    <sf-form-dialog ref="msgModal"
                    title="模板"
                    v-model="showmsgModal"
                    :edit-mode="msgEditMode"
                    url="server/message/msgMng/saveTemplate.do" 
                    :model="msgForm"
                    :rules="msgValidate"
                    @on-success="onmsgModalSuccess">
        <el-form-item label="模板ID" prop="id">
            <el-input v-model.trim="msgForm.id" placeholder="输入模板ID"></el-input>
        </el-form-item>
         <el-form-item label="应用ID" prop="appId">
            <el-input v-model.trim="msgForm.appId" placeholder="输入应用ID"></el-input>
        </el-form-item>
         <el-form-item label="模板名" prop="name">
            <el-input v-model.trim="msgForm.name" placeholder="输入模板名"></el-input>
        </el-form-item>
        <el-form-item label="模板内容" prop="content">
            <el-input v-model.trim="msgForm.content" placeholder="输入模板内容"
              type="textarea"
              :autosize="{ minRows: 2, maxRows: 4}"></el-input>
        </el-form-item>
    </sf-form-dialog>
</div>
<script>

    var msgTemplate = new Vue({
        el: '#msg-template',
        data: {
            currentRow: null,
            startDate:'',
            endDate:'',
            name:'',
            id:'',
            appId:'',
            content:'',
            msgTableColumns: [
                {
                    title: '模板编码',
                    key: 'id'
                     },
                {
                    title: '应用Id',
                    key: 'appID'
                },
                {
                    title: '模板创建时间',
                    key: 'createTime'
                },
                {
                    title: '模板名',
                    key: 'name'
                },
                {
                    title: '模板内容',
                    key: 'content'
                }
            ],
            showmsgModal: false,
            msgEditMode: false,
            msgForm: {
                id: -1,
                id: '',
                appId:'',
                name: '',
                content: ""
            },
            msgValidate: {
                id: [{required: true, message: '模板ID不能为空', trigger: 'blur'}],
                appId: [{required: true, message: '应用ID不能为空', trigger: 'blur'}],
                content: [{required: true, message: '模板内容不能为空', trigger: 'blur'}],
                name: [{required: true, message: '模板名称不能为空', trigger: 'blur'}]
            },
        },
        computed: {
            queryCondition: function () {
                return {
                    name: this.name,
                    id:this.id,
                    appId:this.appId,
                    content:this.content,
                    startTime:new Date(this.startDate).getTime(),
                    endTime:new Date(this.endDate).getTime()
                }
            }
        },
        methods: {
        	 resetSearchCondition: function () {
         		this.id='',
         		this.appId='',
         		this.name='',
         		this.content='',
         		this.startDate='',
         		this.endDate='';
         	   },
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            addmsg: function () {
                this.msgForm.id = null;
                this.msgEditMode = false;
                this.showmsgModal = true;
            },
            editmsg: function () {
                for(var key in this.msgForm){
                    if(this.currentRow[key])
                        this.msgForm[key] = this.currentRow[key];
                }
                this.msgEditMode = true;
                this.showmsgModal = true;
            },
            onmsgModalSuccess: function () {
                this.$refs['msgTable'].reload();
            },
            deletemsg: function () {
            	 if(this.selection.length === 0){
                     return this.$message.warning('请至少选择一个模板！');
                 }
                var self = this;
                this.$confirm("确定删除模板?",'提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('server/message/msgMng/deleteTemplate.do', {
                            	msgTemplateIds: self.selection.map(function (msgTemplate) {
                                    return msgTemplate.id;
                                })
                            }, function () {
                                self.$message.success('删除模板成功！');
                                self.$refs['msgTable'].reload();
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
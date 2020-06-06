<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>任务维护页面</title>
    <style>
		.inline-toolbar div{
        	display:inline-block;
        }

		.el-dialog--tiny{
			width:50%;
		}

		.el-upload-list{
			width:30%;
		}

		.upload-demo{
			margin-bottom:20px;
		}
	</style>

</head>
<st:jspId value="oms_order_main"></st:jspId>
<%
	String defaultActive = "";
	defaultActive= request.getParameter("defaultActive");
	if (defaultActive == null)
	    defaultActive = "1";
%>
<body>
<div id="vue_oms_order_main">
    <sf-panel title="任务管理" v-cloak>
        <el-row>
			<el-col :span="4">
				<div class="layout-content-sidebar" style="padding-right: 10px;">
					<el-menu :default-active="defaultActive" @select="onNavMenuClick" style="height:612px;background-color: #fff;border:1px solid #eef1f6">
<!--                         <el-menu-item index="1" >所有任务</el-menu-item> -->
						<el-menu-item index="2" v-if="!isHidden" >我建立的任务</el-menu-item>
						<el-menu-item index="3">我的未解决任务</el-menu-item>
						<el-menu-item index="4">我的解决中任务</el-menu-item>
						<el-menu-item index="5">我的已解决任务</el-menu-item>
						<el-menu-item index="6">我的已关闭任务</el-menu-item>
					</el-menu>
				</div>
			</el-col>

			<el-col :span="20">
				<div class="oms_order_main-div">
					<sf-toolbar>
						<div slot="searcher">
							<el-input placeholder="任务主题" v-model.trim="queryCondition.topic" icon="search" style="width: 200px;"></el-input>
							<el-input placeholder="客户姓名" v-model.trim="queryCondition.customerName" icon="search" style="width:200px;"></el-input>
							<el-select placeholder="优先级" v-model="queryCondition.priority" icon="search" style="width:200px;">
								<el-option label="所有" value=null></el-option>
								<el-option label="高" value=3></el-option>
								<el-option label="中" value=2></el-option>
								<el-option label="低" value=1></el-option>
							</el-select>
							<el-button type="primary" icon="fa-recycle" @click="reset">重置</el-button>
						</div>
						<el-button type="success" icon="plus" @click="addOmsOrderMain">添加</el-button>
						<el-button type="info" icon="edit" @click="editOmsOrderMain" :disabled="!currentRow">编辑</el-button>
						<el-button type="primary" icon="setting" @click="deployOmsOrderMain" :disabled="!currentRow">处理</el-button>
						<el-button type="danger" icon="delete" @click="deleteOmsOrderMain" :disabled="!currentRow">删除</el-button>
					</sf-toolbar>
					<sf-table ref="omsOrderMainTable"
							  highlight-current-row
							  :height="500"
							  :export-columns="omsOrderMainTableColumns"
							  url="si/order/orderMng/list.do"
							  import-url="/importFile.do"
							  @current-change="onCurrentChange"
							  @selection-change="onSelectionChange"
							  :query-condition="queryCondition"
							  :default-sort = "{prop: 'id', order: 'ascending'}">
						<el-table-column type="selection" width="50" align="center"></el-table-column>
						<%--<el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>--%>
						<el-table-column label="任务编号" prop="id" width="100"></el-table-column>
						<el-table-column label="主题" prop="topic"></el-table-column>
						<%--<el-table-column label="受理内容" prop="content"></el-table-column>--%>
						<el-table-column label="客户" prop="name"></el-table-column>
						<%--<el-table-column label="受理人" prop="respUser"></el-table-column>--%>
						<el-table-column label="状态" prop="status" width="200">
							<template scope="scope">
								<el-tag :type="onStatusTagType(scope)">{{onStatusTagText(scope)}}</el-tag>
							</template>
						</el-table-column>
						<el-table-column label="优先级" prop="priority" width="150">
							<template scope="scope">
								<el-tag :type="onPriorityTagType(scope)">{{onPriorityTagText(scope)}}</el-tag>
							</template>
						</el-table-column>
						<%--<el-table-column label="受理时间" prop="createTime"></el-table-column>--%>
						<%--<el-table-column label="模板流程实例编号" prop="instanceId"></el-table-column>--%>

					</sf-table>
				</div>
			</el-col>

        </el-row>
    </sf-panel>
    <sf-form-dialog ref="omsOrderMainModal"
                    title="任务"
                    v-model="showOmsOrderMainModal"
                    :edit-mode="omsOrderMainEditMode"
                    url="si/order/orderMng/save.do"
                    :model="omsOrderMainForm"
                    :rules="omsOrderMainValidate"
                    @on-success="onOmsOrderMainModalSuccess">

					<el-row>
						<el-form-item label="任务ID" prop="id" style="display: none;">
							<el-input v-model.trim="omsOrderMainForm.id" placeholder="任务ID" ></el-input>
						</el-form-item>
					</el-row>
					<el-row :gutter="10">
						<el-col :span="12">
							<el-form-item label="主题" prop="topic">
								<el-input v-model.trim="omsOrderMainForm.topic" placeholder="主题" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="客户" prop="customerName">
								<el-autocomplete v-model="omsOrderMainForm.customerName" :fetch-suggestions="querySearchCustomer" placeholder="请输入客户名称" @select="handleSelect" style="width:100%;">
								</el-autocomplete>
							</el-form-item>
						</el-col>

					</el-row>
					<el-row>
						<el-form-item label="备注" prop="content">
							<sf-text-editor ref="textEditor" v-model="omsOrderMainForm.content" images-upload-url="text/upload" :images-upload-handler="onImagesHandler" :height=150></sf-text-editor>
						</el-form-item>
					</el-row>
					<el-row>
						<el-upload ref="uploadEditor" class="upload-demo" action="utility/fileManager/upload.do" :data="{delWhenExist:false}" :file-list="myFileList" :multiple="true"
								   :before-upload="beforeAvatarUpload" :on-preview="handlePreview" :on-success="uploadSuccess" :on-error="uploadError" :on-remove="uploadRemove" :on-change="handleChange">
							<el-button size="small" type="primary">上传附件</el-button>
							<div slot="tip" class="el-upload__tip">单个文件不能超过10M</div>
						</el-upload>
					</el-row>

					<el-row :gutter="10">
						<el-col :span="12">
							<el-form-item label="状态" prop="status">
								<el-select v-model="omsOrderMainForm.status" placeholder="状态" style="width:100%;">
									<el-option label="新建" value="1"></el-option>
									<el-option label="解决中" value="2"></el-option>
									<el-option label="已解决" value="3"></el-option>
									<el-option label="已关闭" value="4"></el-option>
								</el-select>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="优先级" prop="priority">
								<el-select v-model= "omsOrderMainForm.priority" placeholder="优先级" style="width:100%;">
									<el-option label="高" value="3"></el-option>
									<el-option label="中" value="2"></el-option>
									<el-option label="低" value="1"></el-option>
								</el-select>
							</el-form-item>
						</el-col>
					</el-row>
					<el-row>
						<el-form-item label="标签" prop="orderTagIds" style="width:100%;">
							<el-select v-model="omsOrderMainForm.orderTagIds" multiple filterable default-first-option placeholder="标签"  style="width:100%;">
								<el-option v-for="item in tags" :key="item.value" :label="item.label" :value="item.value"></el-option>
							</el-select>
						</el-form-item>
					</el-row>

					 <%--<el-form-item label="受理时间" prop="createTime">
					 	<el-date-picker v-model="omsOrderMainForm.createTime" @change="setFormatCreateTime" format="yyyy-MM-dd HH:mm:ss" type="datetime" placeholder="选择时间" style="width: 200px;"></el-date-picker>
					 </el-form-item>--%>
					<el-row>
						<el-col :span="12">
							<el-form-item label="模板" prop="instanceId">
								<%-- <el-input v-model.trim="omsOrderMainForm.instanceId" placeholder="模板任务的流程实例ID" ></el-input>--%>
								<el-select v-model.trim = "omsOrderMainForm.instanceId" placeholder="模板" style="width:100%;">
									<el-option label="默认" value="-1"></el-option>
								</el-select>
							</el-form-item>
						</el-col>
					</el-row>

    </sf-form-dialog>
</div>
<script>


	var mapStatusTagType={1:"primary",2:"warning",3:"success",4:"gray"};
	var mapStatusTagText = {1:"新建",2:"解决中",3:"已解决",4:"已关闭"};
	var mapPriorityTagText={1:"低",2:"中",3:"高"};
	var mapPriorityTagType={1:"gray",2:"success",3:"danger"};

	var defaultActive = String(<%=defaultActive%>);
    var omsOrderMainManagement = new Vue({
        el: '#vue_oms_order_main',
        data: {
        	//根据需要填写查询字段
            queryCondition: {
                topic: null,
                customerName:null,
				priority:null,
				respUser:null,
				status:null
            },
            isHidden:false,
            currentRow: null,
			selection:[],
            omsOrderMainTableColumns: [
                {
                    title: '任务ID',
                    key: 'id'
                },
                {
                    title: '主题',
                    key: 'topic'
                },
                {
                    title: '受理内容',
                    key: 'content'
                },
                {
                    title: '客户编号',
                    key: 'customerId'
                },
                {
                    title: '受理人',
                    key: 'respUser'
                },
                {
                    title: '状态（新建、解决中、已解决、已关闭）',
                    key: 'status'
                },
                {
                    title: '优先级',
                    key: 'priority'
                },
                {
                    title: '受理时间',
                    key: 'createTime'
                },
                {
                    title: '模板任务的流程实例ID',
                    key: 'instanceId'
                }
            ],
            showOmsOrderMainModal: false,
            omsOrderMainEditMode: false,
            omsOrderMainForm: {
                id: null ,
                topic: null ,
                content: '' ,
                customerId: null ,
                respUser: null ,
                status: null ,
                priority: null ,
                createTime: null ,
                instanceId: "-1",
                mapFileNameId:null,
                orderTagIds:null,
				customerName:null,
				deleteFileIds:null,
            },
            omsOrderMainValidate: {
            	//此处添加字段数据合理性验证
                //id: [{required: true, message: '任务ID不能为空', trigger: 'blur'}],
				topic:[{required:true, message:'主题不能为空',trigger:'blur'}],
                customerName:[{required:true,message:'客户不能为空',trigger:'blur'}],
				status:[{required:true,message:'状态不能为空',trigger:'change'}],
				priority:[{required:true,message:'优先级不能为空',trigger:'change'}]
            },
            buttonLoading: false,
			customers:[],			//客户列表
			//customerName:null,	//客户姓名
			mapCustomerId:{},
            myFileList:[],			//附件列表
			tags:[],				//标签列表
            defaultActive:"1"
        },
		computed:{

		},
		methods: {
            reset:function(){
              	for (var key in this.queryCondition){
              	    this.queryCondition[key] = null;
				}
              	this.queryCondition.respUser = ${UserObject.id };
			},
            isHiddenFun:function(){
                //根据当前角色显示或隐藏某些功能按钮
                var self = this;
                this.$post("si/order/orderMng/loadUserRole.do",function (success) {
                    self.isHidden = success.data;
                });
            },
            onNavMenuClick:function(index,path){
                for(var key in this.queryCondition){
                    this.queryCondition[key] = null;
                };
                this.queryCondition.respUser = ${UserObject.id };
				switch(index){
					case "1":{
                        break;
					}
					case "2":{
                        this.queryCondition.respUser = ${UserObject.id };
                        break;
					}
					case "3":{
						if(!this.isHidden) this.queryCondition.respUser=${UserObject.id};
						this.queryCondition.status=1;
						break;
                    }
					case "4":{
                        if(!this.isHidden) this.queryCondition.respUser=${UserObject.id};
					    this.queryCondition.status=2;
					    break;
                    }
					case "5" :{
                        if(!this.isHidden) this.queryCondition.respUser=${UserObject.id};
					    this.queryCondition.status=3;
					    break;
                    }
					case "6":{
                        if(!this.isHidden) this.queryCondition.respUser=${UserObject.id};
					    this.queryCondition.status=4;
					    break;
                    }
				}
				return;
			},
        	setFormatCreateTime:function(val){
        		//设置受理时间为格式化时间字符串
        		this.omsOrderTaskForm.createTime = val;
        	},
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            onStatusTagType:function(scope){
                var status = Number(scope.row.status);
                return mapStatusTagType[status];
			},
            onStatusTagText:function(scope){
                var status = Number(scope.row.status);
                return mapStatusTagText[status];
			},
            onPriorityTagType:function(scope){
                var priority=Number(scope.row.priority);
                return mapPriorityTagType[priority];
			},
            onPriorityTagText:function (scope) {
                var priority=Number(scope.row.priority);
                return mapPriorityTagText[priority];
            },
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            addOmsOrderMain: function () {
                this.omsOrderMainForm.id = null;
                this.omsOrderMainEditMode = false;
                this.showOmsOrderMainModal = true;
                this.omsOrderMainForm.content='';
                this.omsOrderMainForm.mapFileNameId={};
                this.omsOrderMainForm.orderTagIds=[];
                this.myFileList=[];
            },
            editOmsOrderMain: function () {
                for(var key in this.omsOrderMainForm){
                    if(this.currentRow[key])
                        this.omsOrderMainForm[key] = this.currentRow[key]+'';
                }

				//初始化显示
                this.omsOrderMainEditMode = true;
                this.showOmsOrderMainModal = true;
                //初始化数据
                //this.omsOrderMainForm.customerName = this.mapCustomerId[this.currentRow.customerId];
				this.omsOrderMainForm.customerName = this.currentRow.name;
                this.omsOrderMainForm.mapFileNameId={};
                this.omsOrderMainForm.orderTagIds=[];
				this.omsOrderMainForm.deleteFileIds=[];
                this.myFileList=[];

				this.$refs['uploadEditor'].clearFiles();
                //初始化任务附件列表
				this.omsOrderMainFiles();
				//初始化任务标签列表
				this.omsOrderMainTags();
            },
            onOmsOrderMainModalSuccess: function () {
                this.$refs['omsOrderMainTable'].reload();
            },
            deleteOmsOrderMain: function () {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个任务！');
                }
                //同时删除附件及其关联，及富文本中的上传图片
                var self = this;
                this.$confirm('确定删除所选任务？','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/order/orderMng/delete.do', {
                                ids: self.selection.map(function (order) {
                                    return order.id;
                                })},
								function () {
									self.$message.success('删除成功！');
									self.$refs['omsOrderMainTable'].reload();
                            	});
                        }
                    }
                });
            },
			//富文本相关
            onImagesHandler: function (blobInfo, success, failure) {
                var xhr, formData;
                xhr = new XMLHttpRequest();
                xhr.withCredentials = false;
                xhr.open('POST', 'utility/fileManager/upload.do',true);
                xhr.onload = function() {
                    var json;

                    if (xhr.status != 200) {
                        failure('HTTP Error: ' + xhr.status);
                        return;
                    }
                    json = JSON.parse(xhr.responseText);

					/* if (!json || typeof json.location != 'string') {
					 failure('Invalid JSON: ' + xhr.responseText);
					 return;
					 }*/
                    success(webRootPath+"utility/fileManager/previewFile.do?id="+json.data[0].fileId);
                };
                formData = new FormData();
                formData.append("delWhenExist",true);
                formData.append('file', blobInfo.blob(), blobInfo.filename());
                xhr.send(formData);
            },
			//获取客户列表
			loadCustomers:function(){
				var self=this;
				this.$post('si/customer/comCustomerInfo/list.do',{name:null,pageSize:-1,pageIndex:0,columns:null,method:null},
					function(success){
				    	success.data.map(function (t) {
							t.value = t.name;
							self.mapCustomerId[t.id] = t.name;
                        });
				    	self.customers = success.data;
					},
					function(error){
					    console.log(error);
					}
				)
			},
            querySearchCustomer:function(queryString, cb) {
                var customers = this.customers;
                var results = queryString ? customers.filter(this.createFilter(queryString)) : customers;
                // 调用 callback 返回建议列表的数据
                cb(results);
            },
            createFilter:function(queryString) {
                return (customer) => {
                    return (customer.name.indexOf(queryString.toLowerCase()) === 0);
                };
            },
            handleSelect:function(item) {
                this.omsOrderMainForm.customerId = item.id;
                //this.customerName=item.name;
            },
			//附件上传相关
            omsOrderMainFiles:function(){
                var self=this;
                this.$post('si/order/orderMng/loadLinkFiles.do',{orderId:self.currentRow.id},
                    function(success){
                        if(success.data.length > 0){
                            success.data.map(function(t){
                                self.omsOrderMainForm.mapFileNameId[t.name] = t.id;
                                self.myFileList.push({name:t.name,fileId:t.id});
							});
						}
                    });
            },
			beforeAvatarUpload:function(file) {
                const isLt10M = file.size / 1024 / 1024 < 10;
                if (!isLt10M) {
                    this.$message.error('上传附件不能超过10MB!');
                }
                return isLt10M;
            },
            handlePreview:function(file) {
                window.open(webRootPath+"utility/fileManager/previewFile.do?fileId="+this.omsOrderMainForm.mapFileNameId[file.name]);
            },
            handleChange:function(file, fileList) {
            },
            uploadSuccess:function(success,file,fileList){
                //重复上传时的上传列表显示,暂不实现
                //后台smartview回调，用uploadStatus（“success” or “error”）判断上传结果
                if(success.data[0].uploadStatus == "success"){
                    this.omsOrderMainForm.mapFileNameId[success.data[0].originalFileName] = success.data[0].fileId;
                }else{
                    this.$message.error(success.data[0].errorMessage);
                    //this.myFileList = fileList.pop();
					fileList.pop();
					this.myFileList = fileList;
				}

            },
            //http上传等错误回调
            uploadError:function(error){
            },
            //删除同时删库及关联
            uploadRemove:function(file,fileList){
				var fileId = -1;
                if(this.omsOrderMainForm.mapFileNameId.hasOwnProperty(file.name))
					fileId = this.omsOrderMainForm.mapFileNameId[file.name];
				var self = this;
				if(this.omsOrderMainEditMode){
                    /*self.$post("si/order/orderMng/deleteFileAndLink.do",{fileId:fileId,orderId:this.currentRow.id},
                        function (success) {
                            delete self.omsOrderMainForm.mapFileNameId[file.name];
                        },
                        function(error){
                            self.$(message).error("删除附件失败");
                        }
                    )*/
                    delete self.omsOrderMainForm.mapFileNameId[file.name];
                    self.omsOrderMainForm.deleteFileIds.push(fileId);
				}else{
                    self.$post("si/order/orderMng/deleteFile.do",{fileId:fileId},
                        function (success) {
                            delete self.omsOrderMainForm.mapFileNameId[file.name];
                        },
                        function(error){
                            self.$(message).error("删除附件失败");
                        }
                    )
				}

            },
			//加载标签列表
			loadTags:function () {
                var self=this;
                this.$post('si/config/sysManager/listTags.do',{name:null,pageSize:-1,pageIndex:0,columns:null,method:null},
                    function(success){
                        console.log(success);
                        success.data.map(function (t) {
                        	t.value = t.id;
                            t.label = t.name;
                        });
                        self.tags = success.data;
                    },
                    function(error){
                        console.log(error);
                    }
                )
            },
            omsOrderMainTags:function(){
                var self=this;
                this.$post('si/order/orderMng/loadLinkTags.do',{orderId:this.currentRow.id},
                    function(success){
                        if(success.data.length > 0){
                            success.data.map(function(t){
                               self.omsOrderMainForm.orderTagIds.push(t.id);
                            });
                        }
                    });
			},
			//任务处理
            deployOmsOrderMain:function () {
                window.parent.systemManagement.activeTab = this.currentRow.id+"";
				var menu={};
				menu.id = this.currentRow.id+"";
				menu.name = this.currentRow.id+"";
				//var para = this.currentRow;
                if(window.parent.systemManagement.getMenuByName(menu.name, window.parent.systemManagement.tabs)) {
                    return;
                }
				menu.url="jsp/si/oms_order_main_deploy.jsp?orderId=" + this.currentRow.id;
                window.parent.systemManagement.tabs.push(menu);
            },
        },
    	mounted:function(){
			//获取登陆用户角色
			this.isHiddenFun();
            //获取客户列表
            this.loadCustomers();
            //get tags
            this.loadTags();

           	this.defaultActive = defaultActive;
            this.onNavMenuClick(defaultActive,"");
		}
    });



</script>
</body>
</html>
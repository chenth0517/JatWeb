<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/common-rss.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>工单维护页面</title>
	<style>
		.inline-toolbar div{
			display:inline-block;
		}

		.oms_order_main-div > div,
		.div-content{
			padding:0;
			margin:10px 0;
			border:1px solid #e6e6e6;
		}

		.oms_order_main-div > div > p,
		.div-content > p
		{
			border-bottom: 1px solid #e6e6e6;
			background-color: #FBFBFD;
			margin:0;
			padding:10px;
		}


		#orderBaseInfo, #customerBaseInfo{
			margin: 10px;
			width:100%;
		}

	</style>

</head>
<st:jspId value="oms_order_main"></st:jspId>
<%
	Integer orderId = Integer.parseInt(request.getParameter("orderId"));
%>
<body>
<div id="vue_oms_order_main">
	<sf-panel title="工单处理" v-cloak>
		<el-row>
			<sf-toolbar>
				<div slot="toolbar">
					<el-button v-show="btnDisplay.addBtnShow" size="mini" type="success" icon="plus" @click="addTask">分配</el-button>
					<el-button v-show="btnDisplay.solvedBtnShow" size="mini" type="info" icon="check" @click="solvedOrder">解决</el-button>
					<el-button v-show="btnDisplay.closedBtnShow" size="mini" type="primary" icon="close" @click="closedOrder">关闭</el-button>
				</div>
			</sf-toolbar>
		</el-row>
		<el-row :gutter="20">
			<el-col :span="12">
					<div class="oms_order_main-div">
						<div>
							<p>主题：{{omsOrderMainForm.topic}}</p>
						</div>
						<div>
							<p>备注</p>
							<%--<sf-text-editor ref="textEditor" :setting="editorSettings" v-model="omsOrderMainForm.content" images-upload-url="text/upload"  :height=150 @inited="onEditorInited"
								style="border: none;"></sf-text-editor>--%>
							<div v-html="omsOrderMainForm.content" style="height: 150px;overflow: auto;margin-left:10px;"></div>
						</div>
						<div>
							<p>附件</p>
							<div v-for="(file,index) in orderLinkFileList" style="display: inline-block;margin: 10px;">{{file.name}}<br>
								<img v-if="file.imgsrc != null" :src="file.imgsrc" width="50" height="50" @click="onPreviewFile(index)" style="cursor: pointer;"></img>
							</div>
						</div>
						<div>
							<p>属性</p>
							<table id="orderBaseInfo">
								<tr><td width="30%">编号</td><td>{{omsOrderMainForm.id}}</td></tr>
								<tr><td>状态</td><td><el-tag :type="onStatusTagType(omsOrderMainForm.status)">{{onStatusTagText(omsOrderMainForm.status)}}</el-tag></td></tr>
								<tr><td>优先级</td><td><el-tag :type="onPriorityTagType(omsOrderMainForm.priority)">{{onPriorityTagText(omsOrderMainForm.priority)}}</el-tag></td></tr>
								<tr><td>创建时间</td><td>{{omsOrderMainForm.createTime}}</td></tr>
								<tr><td>创建人</td><td>{{omsOrderMainForm.respname}}</td></tr>
							</table>
						</div>

						<div>
							<p>客户详情</p>
							<table id="customerBaseInfo">
								<tr><td width="30%">姓名</td><td>{{comCustomerForm.name}}</td></tr>
							</table>
						</div>
					</div>
			</el-col>
			<el-col :span="12">
				<div class="div-content">
					<p>任务列表</p>
					<sf-table ref="taskTable" url="si/order/omsOrderTask/list.do" :query-condition="queryCondition" style="width:100%;" :show-page="false" max-height="500" :show-import="false">
						<%--<el-table-column label="编号" prop="__index" width="80" align="center"></el-table-column>--%>
						<el-table-column label="任务编号"	prop="id" width="100"></el-table-column>
						<el-table-column label="任务名称" prop="name" ></el-table-column>
						<el-table-column label="受理人" prop="realName">
							<%--<template scope="scope">{{onUserNameText(scope)}}</template>--%>
						</el-table-column>
						<el-table-column label="状态" width="100" prop="result_t_description">
							<template scope="scope">
								{{scope.row["result_t_description"] == null? "未处理":scope.row["result_t_description"]}}
							</template>
						</el-table-column>
						<el-table-column label="操作" align="center" width="200">
							<template scope="scope">
								<el-tooltip class="item" effect="light" content="编辑" placement="bottom">
									<el-button size="mini" type="info" icon="edit" @click="onEditTask(scope)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="删除" placement="bottom">
									<el-button size="mini" type="danger" icon="delete" @click="onDeleteTask(scope)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="处理" placement="bottom">
									<el-button size="mini" type="primary" icon="circle-check" @click="onProcessTask(scope)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="查看处理结果" placement="bottom">
									<el-button size="mini" type="success" icon="circle-check" @click="onViewTaskResult(scope)"></el-button>
								</el-tooltip>
							</template>
						</el-table-column>
					</sf-table>
				</div>
				<div class="div-content">
					<p>操作列表</p>
					<el-collapse v-model="activeNames">
						<el-collapse-item v-for="(op,index) in orderOpHistory" :title="op.realName+'&emsp;&emsp;'+op.opTime" :name="index" :key="op.id">
							<p style="margin-top: 0;">{{op.opType_t_description}}</p>
							<p v-html="op.remark" style="max-height: 100px;overflow: auto;background: #FFFAF0;padding-left: 20px;"></p>
						</el-collapse-item>
					</el-collapse>
				</div>

			</el-col>
		</el-row>
	</sf-panel>

	<el-dialog :visible.sync="dialogTableVisible">
		<template>
			<el-carousel indicator-position="none" :interval="0" arrow="always">
				<el-carousel-item v-for="item in orderLinkImgList" :key="item.name">
					<img :src="item.imgsrc"></img>
				</el-carousel-item>
			</el-carousel>
		</template>
	</el-dialog>

	<sf-form-dialog ref="omsOrderTaskModal"
					title="任务"
					v-model="showOmsOrderTaskModal"
					:edit-mode="omsOrderTaskEditMode"
					url="si/order/omsOrderTask/save.do"
					:model="omsOrderTaskForm"
					:rules="omsOrderTaskValidate"
					@on-success="onOmsOrderTaskSuccess">
		<el-form-item label="任务名称" prop="name"><el-input v-model.trim="omsOrderTaskForm.name"></el-input></el-form-item>
		<el-form-item label="受理人" prop="selectedUserOption">
			<el-cascader style="width:100%;"
				placeholder="可输入员工名称查询"
				:options="teamUserList"
				filterable @change="onUserPicked" v-model="omsOrderTaskForm.selectedUserOption">
			</el-cascader>
		</el-form-item>
		<el-form-item label="任务时间" prop="">
			<el-date-picker style="width:100%;"
				v-model="dateTimeRange"
				type="datetimerange"
				:picker-options="pickerOptions"
				placeholder="选择时间范围" @change="onTimePicked" range-separator="--">
			</el-date-picker>
		</el-form-item>
		<el-form-item label="备注" prop="content">
			<el-input type="textarea" :rows="4" v-model.trim="omsOrderTaskForm.content"></el-input>
		</el-form-item>
	</sf-form-dialog>

	<div>
		<task-process v-model="taskProcessdialogVisible" :task-id="taskId" @refreshtable="onRefreshTaskTable"></task-process>
	</div>

	<el-dialog :visible.sync="showTaskOpResultForm">
		<div class="div-content">
			<p>任务名称：{{omsTaskOpResultForm.name}}</p>
		</div>
		<div class="div-content">
			<p>任务状态：{{omsTaskOpResultForm.result_t_description}}</p>
		</div>
		<div class="div-content">
			<p>备注</p>
			<div v-html="omsTaskOpResultForm.remark" style="height: 150px;overflow: auto;"></div>
		</div>
		<div class="div-content">
			<p>附件</p>
			<div v-for="(file,index) in omsTaskOpResultForm.opFileList" style="display: inline-block;margin: 10px;"><a :href="file.url">{{file.name}}</a><br>
				<img v-if="file.imgsrc != null" :src="file.imgsrc" width="50" height="50" style="cursor: pointer;"></img>
			</div>
		</div>
	</el-dialog>
</div>
<%--<%@include file="./oms_order_task_process.jsp"%>--%>
<script>

    var mapStatusTagType={1:"primary",2:"warning",3:"success",4:"gray"};
    var mapStatusTagText = {1:"新建",2:"解决中",3:"已解决",4:"已关闭"};
    var mapPriorityTagText={1:"低",2:"中",3:"高"};
    var mapPriorityTagType={1:"gray",2:"success",3:"danger"};
	var orderId = <%=orderId%>;



    var omsOrderMainManagement = new Vue({
        el: '#vue_oms_order_main',
		components:{
            'task-process': loadComponent(webRootPath + 'jsp/components/oms_order_task_process.vue'),
		},
        data: {
            //根据需要填写查询字段
			omsOrderMainForm: {
                id: null ,
                topic: null ,
                content: null ,
                customerId: null ,
                respUser: null ,
                respname:null,
                status: null ,
                priority: null ,
                createTime: null ,
                instanceId: "-1",
            },
			comCustomerForm:{
			    name:null,
			},
			omsOrderReply:{
			  	id:null,
				taskId:null,
			  	remark:null,
			},
			omsOrderTaskForm:{
			    id:null,
				name:null,
				holderUserId:null,
				createTime:null,
				beginTime:null,
				dueDate:null,
				content:null,
				ordeId:orderId,
                selectedUserOption:[]
			},
			omsOrderTaskValidate:{
                //此处添加字段数据合理性验证
                name:[{required:true, message:'任务名称不能为空',trigger:'blur'}],
                selectedUserOption:[{type: 'array',required:true,message:'受理人不能为空',trigger:'change'}],
			},
            showOmsOrderTaskModal:false,
            taskProcessdialogVisible:false,
            omsOrderTaskEditMode:false,
            buttonLoading: false,
            orderLinkFileList:[],			//附件列表
			orderLinkImgList:[],			//能够预览的img
            orderLinkTagList:[],				//标签列表
            activeNames:[0],				//操作列表显示
			editor:null,
			editorSettings:{menu:{},readonly:true,toolbar:false,statusbar:false},
            dialogTableVisible:false,
			dateTimeRange:[new Date(), new Date()],
            pickerOptions: {
                shortcuts: [{
                    text: '最近一周',
                    onClick:function(picker) {
                        const end = new Date();
                        const start = new Date();
                        end.setTime(end.getTime() + 3600 * 1000 * 24 * 7);
                        picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近一个月',
                    onClick:function(picker) {
                        const end = new Date();
                        const start = new Date();
                        end.setTime(end.getTime() + 3600 * 1000 * 24 * 30);
                        picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近三个月',
                    onClick:function(picker) {
                        const end = new Date();
                        const start = new Date();
                        end.setTime(end.getTime() + 3600 * 1000 * 24 * 90);
                        picker.$emit('pick', [start, end]);
                    }
                }]
            },
			//任务处理人选择
			mapIdUser:{},
			mapIdTeam:{},
            mapTeamUser:{},
            teamUserLink:[],
			teamUserList:[],
			//任务处理人初始化
			//selectedUserOption:[],
			//任务起止时间初始化
			//taskTimeRange:[],
			//操作列表
			orderOpHistory:[],
			//任务处理对话框传参
			taskProcessDialogSrc:null,
			btnDisplay:{
                addBtnShow:false,
				closedBtnShow:false,
				solvedBtnShow:false
			},
			taskId:null,
			//处理结果查看
            omsTaskOpResultForm: {
                id: null ,
				name:'',
                remark:'',
                result:null,
				result_t_description:'',
                opFileList:{}
            },
            showTaskOpResultForm:false,
        },
		computed:{
            queryCondition:function(){
                return {
                    ordeId:orderId,
				}
			},
		},
        methods: {
            onRefreshTaskTable: function (test) {
				this.$refs["taskTable"].reload();
				this.loadOpHistory();
            },
            //获取工单及任务基本信息begin
			onOrderInfo:function () {
			    var self=this;
			    this.$post('si/order/orderMng/loadOne.do',{id:orderId},
					function (success) {
                        for(var key in self.omsOrderMainForm){
                            self.omsOrderMainForm[key] = success.data[key];
                        }
						//获取用户信息
                        self.$post('si/customer/comCustomerInfo/loadOne.do',{id:self.omsOrderMainForm.customerId},
                            function(success){
                            	if(success.data == null){
                                    self.$message.warning('获取客户信息失败！');
								}else{
                                    for(var key in self.comCustomerForm){
                                        if(success.data[key])
                                            self.comCustomerForm[key] = success.data[key];
                                    }
								}

                            }
                        )
						//初始化工单处理功能按钮
						self.initBtnDisplay();
                    },
					function (error) {
						self.$message.warning("获取工单信息失败");
                    }
				)
            },
            onEditorInited:function (editor) {
				this.editor = editor;
            },
			loadLinkFiles:function () {
                var self=this;
                this.$post('si/order/orderMng/loadLinkFiles.do',{orderId:orderId},
                    function(success){
						if(success.data==null){ return;}
                        self.orderLinkFileList=success.data;
                        var imgType=['png','jpg','jpeg'];
						self.orderLinkImgList = self.orderLinkFileList.filter(function (t) {return imgType.indexOf(t.name.split('.')[1]) > -1}).map(
							function (file) {
								file.imgsrc = webRootPath+"utility/fileManager/previewFile.do?fileId="+file.id;
								return file;
                            }
						)
                    });
            },
			loadLinkTags:function () {
				
            },
			loadOpHistory:function () {
			    this.orderOpHistory = [];
				var self = this;
				this.$post("si/order/orderMng/loadOrderOpHistory.do",{orderId:orderId,pageSize:-1,pageIndex:-1},
					function (success) {
						if(success.data != null){
						    self.orderOpHistory = success.data;
						}
                    },
					function(error){
				    	self.$message.warning("获取操作记录失败");
					}
				)
            },
			//获取工单及任务基本信息end
			loadTeamUser:function(){
			  	var self=this;
			  	var teams=null;
			  	var users=null;

			  	this.$post("si/config/employee/listTeamGroup.do",{pageSize:-1,pageIndex:-1},
					function(success) {
                        teams = success.data;
                        //console.log(teams);
                        for (var i = 0; i < teams.length; i++) {
                            self.mapIdTeam[teams[i].id] = teams[i];
                        }

                        self.$post("si/config/employee/listEmployeeInfo.do",
                            function(success){
                                console.log(success.data);
                                users=success.data;
                                for(var i=0;i<users.length;i++){
                                    self.mapIdUser[users[i].id] = users[i];
                                }

                                self.$post("si/config/employee/listTeamUserLink.do",
                                    function (success) {
                                        self.teamUserLink=success.data;
                                        self.teamUserList = self.getTeamUserList();
                                    },
                                    function (error) {
                                        self.$message.warning("获取员工组关联失败");
                                    }
                                );
                            },
                            function () {
                                self.$message.warning("获取员工信息失败");
                            });
                    },
			  	    function(error){
			  	      	self.$message.warning('获取员工组失败！');
					}
				);
			},
			onPreviewFile:function (index) {
				this.dialogTableVisible= true;
            },
			onTimePicked:function (value) {
				this.omsOrderTaskForm.beginTime=value.split('--')[0].trim();
				this.omsOrderTaskForm.dueDate=value.split('--')[1].trim();
            },
			//工单处理begin
			addTask:function () {
                this.omsOrderTaskForm.id = null;
                this.omsOrderTaskEditMode = false;
                this.showOmsOrderTaskModal = true;
                this.dateTimeRange=[new Date(),new Date()];
            },
            solvedOrder:function(){
				//将工单状态置成已解决
				var self = this;
				self.$post("si/order/orderMng/updateOrderStatus.do",{orderId:orderId,status:3},
					function(success){
						//隐藏解决按钮
						self.btnDisplay.solvedBtnShow = false;
						self.btnDisplay.addBtnShow = false;
						self.omsOrderMainForm.status = 3;
					},
					function (error) {
						self.$message.warning("修改工单状态失败");
                    }
				);
			},
			closedOrder:function(e){
				var self = this;
				self.$post("si/order/orderMng/updateOrderStatus.do",{orderId:orderId,status:4},
					function(success){
						//隐藏解决按钮
						self.btnDisplay.addBtnShow = false;
						self.btnDisplay.solvedBtnShow = false;
						self.btnDisplay.closedBtnShow = false;
						self.omsOrderMainForm.status = 4;
					},
					function (error) {
						self.$message.warning("修改工单状态失败");
                    }
				);
			},
            onOmsOrderTaskSuccess:function () {
                this.$refs['taskTable'].reload();
                this.loadOpHistory();
            },
            //工单处理end
            onUserPicked:function(val){
			    this.omsOrderTaskForm.holderUserId=val[1];
			},
            /*onStatusTagText:function(scope){
                var status = 3;
                this.$post("si/order/omsOrderTask/loadOneTaskOpHistory.do",{taskId:scope.row.id},
                    function (success){
                        var list=success.data;
                        if(list==null || list.length == 0){
                            status = 3;
                        }
                        else status = list[0].result;

                    }
                )
				return taskStatusText[status];
			},*/
			//任务处理begin
			onEditTask:function(scope){
                for(var key in this.omsOrderTaskForm){
                    if(scope.row[key])
                        this.omsOrderTaskForm[key] = scope.row[key];
                }

                this.omsOrderTaskEditMode = true;
                this.showOmsOrderTaskModal = true;
                this.omsOrderTaskForm.selectedUserOption=[];
                this.dateTimeRange=[];

                for(var link in this.teamUserLink){
                    if(this.teamUserLink[link].userId == this.omsOrderTaskForm.holderUserId){

                        this.omsOrderTaskForm.selectedUserOption.push(this.teamUserLink[link].teamId);
                        this.omsOrderTaskForm.selectedUserOption.push(this.omsOrderTaskForm.holderUserId);
                        break;
                    }
                }
                this.dateTimeRange.push(new Date(this.omsOrderTaskForm.beginTime));
				this.dateTimeRange.push(new Date(this.omsOrderTaskForm.dueDate));
			},
            onProcessTask:function (scope) {
				this.taskProcessdialogVisible=true;
				this.taskId = scope.row.id;
                //this.taskProcessDialogSrc = "jsp/si/oms_order_task_process.jsp?taskId="+scope.row.id;
            },
			onDeleteTask:function(scope){
                var self = this;
                this.$confirm('确定删除所选任务?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/order/omsOrderTask/delete.do',{ids:[scope.row.id]},
								function(){
                                    self.$message.success('删除任务成功！');
                                    self.$refs['taskTable'].reload();
                                    self.loadOpHistory();
								}
							)
                        }
                    }
                });
			},
            //任务处理end
			//其他功能性方法
            initBtnDisplay:function(){
				if(this.omsOrderMainForm.status == 3){
				    this.btnDisplay.closedBtnShow = true;
				}else if(this.omsOrderMainForm.status < 3){
				    this.btnDisplay.closedBtnShow=true;
				    this.btnDisplay.solvedBtnShow=true;
				    this.btnDisplay.addBtnShow=true;
				}
			},
            onTaskStatusTagType:function(scope){
                var status = "";
                var self = this;
                this.$post("si/order/omsOrderTask/loadOneTaskOpHistory.do",{taskId:scope.row.id},
                    function (success){
                        var list=success.data;
                        if(list==null || list.length == 0){
                            status = "未处理";
                        }
                        else
						{
						    status = list[0]["result_t_description"];
                        }
                        return status;
                    },
					function (error) {
                        self.$message.success('删除任务成功！');
                    }
                )
            },
            onStatusTagType:function(scope){
                return mapStatusTagType[scope];
            },
            onStatusTagText:function(scope){
                return mapStatusTagText[scope];
            },
            onPriorityTagType:function(priority){
                return mapPriorityTagType[priority];
            },
            onPriorityTagText:function (priority) {
                return mapPriorityTagText[priority];
            },
            getTeamUserList:function() {
                var tList = [];
                if(Object.keys(this.mapIdUser).length == 0 || Object.keys(this.mapIdTeam).length == 0)
                    return tList;
                var mapTeamUser = {};
                for (var link in this.teamUserLink) {
                    var teamId = this.teamUserLink[link].teamId;
                    //后台数据错误，组关系存在但组或者用户不存在
                    var team = this.mapIdTeam[teamId];
                    if(team==undefined){
                        continue;
                    }
                    var userId = this.teamUserLink[link].userId;
                    if(userId==null){
                        continue;
                    }
                    if (mapTeamUser.hasOwnProperty(teamId)) {
                        var tmp = {};
                        tmp.value = userId;
                        tmp.label = this.mapIdUser[userId].realName;
                        mapTeamUser[teamId].children.push(tmp);
                    } else {
                        var tmp = {};
                        tmp.value = teamId;
                        tmp.label = team.name;
                        var child = {};
                        child.value = userId;
                        child.label = this.mapIdUser[userId].realName;
                        tmp.children = [];
                        tmp.children.push(child);
                        mapTeamUser[teamId] = tmp;
                    }
                }

                for (var key in mapTeamUser) {
                    tList.push(mapTeamUser[key]);
                }
                return tList;
            },
            onViewTaskResult:function(scope){
                this.showTaskOpResultForm = true;

                var self = this;
                this.$post("si/order/omsOrderTask/loadOneTaskOpHistory.do",{taskId:scope.row.id},
                    function (success) {
                        if(success.data != null){
                            for(var key in self.omsTaskOpResultForm){
                                self.omsTaskOpResultForm[key] = success.data[0][key];
                            }
                            self.omsTaskOpResultForm.name = scope.row.name;

                            self.loadOphFileLinks();
                        }
                    }
                )

			},
            loadOphFileLinks:function(){
                //this.omsTaskOpForm.mapFileNameId={};
                this.omsTaskOpResultForm.opFileList = [];
                var self = this;
                this.$post("si/order/omsOrderTask/loadOphFileInfos.do",{historyId:self.omsTaskOpResultForm.id},
                    function (success) {
                        if(success.data != null){
                            success.data.map(function(t){
                                self.omsTaskOpResultForm.opFileList.push({name:t.name,fileId:t.id,url:webRootPath+"utility/fileManager/previewFile.do?fileId="+t.id});
                                var imgType=['png','jpg','jpeg'];
                                self.omsTaskOpResultForm.opFileList.filter(function (t) {return imgType.indexOf(t.name.split('.')[1]) > -1}).map(
                                    function (file) {
                                        file.imgsrc = webRootPath+"utility/fileManager/previewFile.do?fileId="+file.fileId;
                                        return file;
                                    })
                            });
                        }
                    }
                );
            },
        },
        mounted:function(){
			this.onOrderInfo();
            this.loadLinkFiles();
            this.loadLinkTags();
            this.loadTeamUser();
            this.loadOpHistory();

        }
    });

</script>
</body>
</html>
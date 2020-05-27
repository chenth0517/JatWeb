<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/common-rss.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>com_customer_info-维护页面</title>
	<style>
		.inline-toolbar div{
			display:inline-block;
		}
 		.el-dialog--tiny {
 			width: 40%;
 		}
		.el-row {
			margin-bottom: 0;
		}
	</style>
</head>
<st:jspId value="com_customer_info"></st:jspId>
<body>
<div id="vue_com_customer_info" v-cloak>
	<sf-panel title="所有客户">
		<el-row>
			<div class="com_customer_info-div">
				<sf-toolbar>
					<div slot="searcher">
						<el-input placeholder="客户名称" v-model.trim="customerQueryCondition.name" icon="search" style="width: 120px;"></el-input>
						<el-input placeholder="客户手机号" v-model.trim="customerQueryCondition.phone" icon="search" style="width: 150px;"></el-input>
<!-- 						<el-input placeholder="客户邮箱" v-model.trim="customerQueryCondition.email" icon="search" style="width: 190px;"></el-input> -->
						<el-input placeholder="年龄大于" v-model.trim="customerQueryCondition.agegt" icon="search" style="width: 105px;"></el-input>
						<el-input placeholder="年龄小于" v-model.trim="customerQueryCondition.agelt" icon="search" style="width: 105px;"></el-input>
						<el-button type="primary" icon="fa-recycle" @click="reset">重置</el-button>
						<el-button type="primary" icon="fa-filter" @click="onFastFilter">{{fastFilterText}}</el-button>
					</div>
					<el-button type="success" icon="plus" @click="addComCustomerInfo">添加</el-button>
					<el-button type="info" icon="edit" @click="editComCustomerInfo" :disabled="!currentRow">编辑</el-button>
					<el-button type="danger" icon="delete" @click="deleteComCustomerInfo"  :disabled="selection.length==0">删除</el-button>
				</sf-toolbar>
				<sf-table ref="comCustomerInfoTable"
						  highlight-current-row
						  :height="500"
						  :export-columns="comCustomerInfoTableColumns"
						  url="si/customer/comCustomerInfo/list.do" 
						  import-url="si/customer/comCustomerInfo/importFile.do"
						  @current-change="onCurrentChange"
						  @selection-change="onSelectionChange"
						  :query-condition="customerQueryCondition">
						<el-table-column type="selection" width="80" align="center"></el-table-column>
						<!-- el-table-column fixed label="#" prop="__index" width="85" align="center"></el-table-column--!>
						<!-- el-table-column fixed width="85" label="客户ID" prop="id"></el-table-column -->
						<el-table-column fixed width="95" label="客户名称" prop="name"></el-table-column>
						<el-table-column width="65" label="性别" prop="gender_t_description"></el-table-column>
						<el-table-column width="120" label="生日" prop="birthday" :formatter="dateFormat"></el-table-column>
						<el-table-column width="140" label="手机号" prop="phone"></el-table-column>
						<el-table-column width="140" label="项目" prop="project_t_description"></el-table-column>
						<el-table-column width="140" label="进度" prop="progress_t_description">
							<template scope="scope">
								<el-tag type="success">{{onProgressTagText(scope)}}</el-tag>
							</template>
						</el-table-column>
<!-- 						<el-table-column label="责任项目组" prop="teamName"></el-table-column> -->
<!-- 						<el-table-column label="负责人" prop="realName"></el-table-column> -->
						<el-table-column width="150" label="备注" prop="comment"></el-table-column>
						<el-table-column width="95" label="客服" prop="serviceManager_t_description"></el-table-column>
						<el-table-column width="95" label="顾问" prop="adviseManager_t_description"></el-table-column>
						<el-table-column width="95" label="文案" prop="technicalManager_t_description"></el-table-column>
						<el-table-column width="120" label="最近拜访" prop="lastVisitDate" :formatter="dateFormat"></el-table-column>
<!-- 						<el-table-column width="180" label="职业" prop="job_t_description"></el-table-column> -->
						<el-table-column width="100" label="兴趣爱好" prop="interest_t_description"></el-table-column>
						<el-table-column width="150" label="家庭住址" prop="homeAddr"></el-table-column>
						<el-table-column width="150" label="邮寄地址" prop="officeAddr"></el-table-column>
						<el-table-column width="120" label="登记时间" prop="registerDate" :formatter="dateFormat"></el-table-column>
						<el-table-column width="120" label="纪念日" prop="specialDay" :formatter="dateFormat"></el-table-column>
<!-- 						<el-table-column width="150" label="拜访笔记" prop="visitNote"></el-table-column> -->
<!-- 						<el-table-column width="190" label="邮箱" prop="email"></el-table-column> -->
<!-- 						<el-table-column width="150" label="其他号码" prop="tel"></el-table-column> -->
						<el-table-column width="140" fixed="right" label="操作">
							<template scope="scope">
								<el-tooltip class="item" effect="light" content="今日拜访" placement="bottom">
									<el-button size="mini" type="warning" icon="fa-check" @click="visitToday(scope.row)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="添加成员" placement="bottom">
									<el-button size="mini" type="info" icon="fa-user-plus" @click="addComFamilyInfo(scope.row)"></el-button>
								</el-tooltip>
								<el-tooltip class="item" effect="light" content="查看成员" placement="bottom">
									<el-button size="mini" type="success" icon="fa-users" @click="editComFamilyInfo(scope.row)"></el-button>
								</el-tooltip>
								
							</template>
						</el-table-column>
				</sf-table>
			</div>
		</el-row>
	</sf-panel>
	
	<sf-form-dialog ref="comCustomerInfoModal"
					title="客户信息"
					v-model="showComCustomerInfoModal"
					:mode="comCustomerInfoEditMode"
					url="si/customer/comCustomerInfo/save.do" 
					:model="comCustomerInfoForm"
					:rules="comCustomerInfoValidate"
					@on-success="onComCustomerInfoModalSuccess">
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="客户名称" prop="name">
					<el-input v-model.trim="comCustomerInfoForm.name" placeholder="客户名称" ></el-input>
				</el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="登记时间" prop="registerDate">
				 	<el-date-picker style="width:100%" v-model="comCustomerInfoForm.registerDate" @change="setFormatRegisterDate" format="yyyy-MM-dd HH:mm:ss" type="datetime" placeholder="选择时间" style="width: 200px;"></el-date-picker>
				</el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="性别" prop="gender">
		            <sf-select width="100%" label="" v-model="comCustomerInfoForm.gender" placeholder="性别" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_GENDER" value-field="id" text-field="displayValue"></sf-select>
		        </el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="生日" prop="birthday">
				 	<el-date-picker style="width:100%" v-model="comCustomerInfoForm.birthday" @change="setFormatBirthday" format="yyyy-MM-dd HH:mm:ss" type="date" placeholder="选择日期" style="width: 200px;"></el-date-picker>
				</el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="手机号" prop="phone">
					<el-input v-model.trim="comCustomerInfoForm.phone" placeholder="手机号" ></el-input>
				</el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="兴趣爱好" prop="interest">
		            <sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.interest" placeholder="兴趣爱好" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_INTERESTS" value-field="id" text-field="displayValue" :multiple="true"></sf-select>
		        </el-form-item>
		    </el-col>
<!-- 			<el-col :span="12"> -->
<!-- 				<el-form-item label="邮箱" prop="email"> -->
<!-- 					<el-input v-model.trim="comCustomerInfoForm.email" placeholder="邮箱" ></el-input> -->
<!-- 				</el-form-item> -->
<!-- 			</el-col> -->
		</el-row>
		<el-row :gutter="10">
			<el-col :span="8">
				<el-form-item label="客服" prop="serviceManager">
					<sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.serviceManager"
							   placeholder="责任客服" url="si/config/employee/listEmployeeInfoByGroup.do?grpId=1" 
							   value-field="id" text-field="realName">
					</sf-select>
				</el-form-item>
			</el-col>
			<el-col :span="8">
				<el-form-item label="文案" prop="technicalManager">
					<sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.technicalManager"
							   placeholder="责任文案" url="si/config/employee/listEmployeeInfoByGroup.do?grpId=2" 
							   value-field="id" text-field="realName">
					</sf-select>
				</el-form-item>
			</el-col>
			<el-col :span="8">
				<el-form-item label="顾问" prop="adviseManager">
					<sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.adviseManager"
							   placeholder="责任顾问" url="si/config/employee/listEmployeeInfoByGroup.do?grpId=3" 
							   value-field="id" text-field="realName">
					</sf-select>
				</el-form-item>
			</el-col>
		</el-row>
		
		<el-row :gutter="10">
			<el-col :span="12">
				<el-form-item label="所属项目" prop="project">
		            <sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.project" placeholder="所属项目" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_PROJECT" value-field="id" text-field="displayValue"></sf-select>
		        </el-form-item>
		    </el-col>
			<el-col :span="12">
				<el-form-item label="项目进展" prop="progress">
		            <sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.progress" placeholder="项目进展" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_PROGRESS" value-field="id" text-field="displayValue"></sf-select>
		        </el-form-item>
		    </el-col>
		</el-row>
		
<!-- 		<el-row :gutter="10"> -->
<!-- 			<el-col :span="12"> -->
<!-- 				<el-form-item label="职业" prop="job"> -->
<!-- 		            <sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.job" placeholder="职业" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_OCCUPATION" value-field="id" text-field="displayValue"></sf-select> -->
<!-- 		        </el-form-item> -->
<!-- 		    </el-col> -->
<!-- 			<el-col :span="12"> -->
<!-- 				<el-form-item label="兴趣爱好" prop="interest"> -->
<!-- 		            <sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.interest" placeholder="兴趣爱好" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_INTERESTS" value-field="id" text-field="displayValue" :multiple="true"></sf-select> -->
<!-- 		        </el-form-item> -->
<!-- 		    </el-col> -->
<!-- 		</el-row> -->
		
		<el-row :gutter="10">
			<el-col :span="20">
				<el-form-item label="家庭住址" prop="homeAddr">
					<el-input v-model.trim="comCustomerInfoForm.homeAddr" placeholder="家庭住址" ></el-input>
				</el-form-item>
			</el-col>
			<el-col :span="4">
				<el-form-item label="更多信息">
					<el-button style="width:100%" @click="showOrHide">{{btnText}}</el-button>
				</el-form-item>
			</el-col>
		</el-row>
		<el-row :gutter="10" v-show="visibleFlag">
			<el-col :span="24">
				<el-form-item label="邮寄地址" prop="officeAddr">
					<el-input v-model.trim="comCustomerInfoForm.officeAddr" placeholder="邮寄地址" ></el-input>
				</el-form-item>
			</el-col>
		</el-row>
<!-- 		<el-row :gutter="10" v-show="visibleFlag"> -->
<!-- 			<el-col :span="24"> -->
<!-- 				<el-form-item label="备注" prop="comment"> -->
<!-- 					<el-input v-model.trim="comCustomerInfoForm.comment" placeholder="备注" ></el-input> -->
<!-- 				</el-form-item> -->
<!-- 			</el-col> -->
<!-- 		</el-row> -->
		
		<el-row :gutter="10" v-show="visibleFlag">
			<el-col :span="12">
				<el-form-item label="备注" prop="comment">
					<el-input v-model.trim="comCustomerInfoForm.comment" placeholder="备注" ></el-input>
				</el-form-item>
			</el-col>
			<el-col :span="12">
				<el-form-item label="纪念日" prop="specialDay">
				 	<el-date-picker style="width:100%" v-model="comCustomerInfoForm.specialDay" @change="setFormatSpecialDay" format="yyyy-MM-dd HH:mm:ss" type="date" placeholder="选择时间" style="width: 200px;"></el-date-picker>
				</el-form-item>
			</el-col>
<!-- 			<el-col :span="12"> -->
<!-- 				<el-form-item label="其他号码" prop="tel"> -->
<!-- 					<el-input v-model.trim="comCustomerInfoForm.tel" placeholder="其他号码" ></el-input> -->
<!-- 				</el-form-item> -->
<!-- 			</el-col> -->
<!-- 			<el-col :span="12"> -->
<!-- 				<el-form-item label="责任组" prop="respGroup"> -->
<!-- 					<sf-select width="100%" label="" v-model.trim="comCustomerInfoForm.respGroup" -->
<!-- 							   placeholder="责任项目组" url="si/config/employee/listTeamGroup.do"  -->
<!-- 							   value-field="id" text-field="name"> -->
<!-- 					</sf-select> -->
<!-- 				</el-form-item> -->
<!-- 			</el-col> -->
		</el-row>
	</sf-form-dialog>
	
	<sf-form-dialog ref="visitNoteModal"
				title="拜访笔记"
				v-model="showVisitNoteModal"
				:mode="visitNoteEditMode"
				url="si/customer/comCustomerInfo/save.do" 
				:model="comCustomerInfoForm"
				@on-success="onComCustomerInfoModalSuccess">
		<el-form-item label="历史笔记" prop="project">
			<el-input width="100%" label="" v-model.trim="comCustomerInfoForm.visitNote" type="textarea" :readonly=true :autosize="{ minRows: 8, maxRows: 12}" ></el-input>
		</el-form-item>
		<el-form-item label="新笔记" prop="project">
			<el-input width="100%" label="" v-model.trim="comCustomerInfoForm.visitNoteNew" type="textarea" :autosize="{ minRows: 4, maxRows: 8}"
			placeholder="如果需要，可以在此处编写拜访笔记。如果无需编写则也可以直接点击确定。" ></el-input>
		</el-form-item>
	</sf-form-dialog>
	
	<el-dialog title="家庭成员信息" :visible.sync="dialogTableVisible">
		<sf-table ref="comFamilyInfoTable"
                          highlight-current-row
                          :height="500"
                          :show-import="false"
                          url="si/customer/comFamilyInfo/list.do" 
                          @current-change="onCurrentChange"
                          :query-condition="familyQueryCondition">
            <el-table-column width="90" label="姓名" prop="name"></el-table-column>
        	<el-table-column width="95" label="关系" prop="membership_t_description"></el-table-column>
        	<el-table-column width="130" label="联系电话" prop="phone"></el-table-column>
        	<el-table-column width="120" label="生日" prop="birthday" :formatter="dateFormat"></el-table-column>
            <el-table-column label="职业" prop="job_t_description"></el-table-column>
        	<el-table-column width="130" label="兴趣爱好" prop="interest_t_description"></el-table-column>
        	<el-table-column width="90" label="操作">
				<template scope="scope">
					<el-button size="mini" type="danger" icon="delete" @click="deleteComFamilyInfo(scope.row)">删除</el-button>
				</template>
			</el-table-column>
        </sf-table>
		<span slot="footer" class="dialog-footer">
			<el-button @click="dialogTableVisible=false">取 消</el-button>
			<el-button type="primary" @click="dialogTableVisible=false">确 定</el-button>
		</span>
	</el-dialog>
	
	<sf-form-dialog ref="comFamilyInfoModal"
                    title="成员"
                    v-model="showComFamilyInfoModal"
                    :mode="comFamilyInfoEditMode"
                    url="si/customer/comFamilyInfo/save.do" 
                    :model="comFamilyInfoForm"
                    :rules="comFamilyInfoValidate">
<!--                     @on-success="onComFamilyInfoModalSuccess"> -->
		<el-form-item label="姓名" prop="name">
            <el-input v-model.trim="comFamilyInfoForm.name" placeholder="姓名" ></el-input>
        </el-form-item>
		<el-form-item label="关系" prop="membership">
			<sf-select width="100%" label="" v-model.trim="comFamilyInfoForm.membership" placeholder="成员关系" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_RELATIONSHIP" value-field="id" text-field="displayValue"></sf-select>
        </el-form-item>
		<el-form-item label="联系电话" prop="phone">
            <el-input v-model.trim="comFamilyInfoForm.phone" placeholder="联系电话" ></el-input>
        </el-form-item>
		<el-form-item label="生日" prop="birthday">
		 	<el-date-picker style="width:100%" v-model="comFamilyInfoForm.birthday" @change="setFormatBirthday" format="yyyy-MM-dd HH:mm:ss" type="date" placeholder="选择日期" style="width: 200px;"></el-date-picker>
		</el-form-item>
		<el-form-item label="职业" prop="job">
            <sf-select width="100%" label="" v-model.trim="comFamilyInfoForm.job" placeholder="职业" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_OCCUPATION" value-field="id" text-field="displayValue"></sf-select>
        </el-form-item>
		<el-form-item label="兴趣爱好" prop="interest">
            <sf-select width="100%" label="" v-model.trim="comFamilyInfoForm.interest" placeholder="兴趣爱好" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_INTERESTS" value-field="id" text-field="displayValue" :multiple="true"></sf-select>
        </el-form-item>
		<el-form-item label="关联客户" prop="customerId">
            <sf-select width="100%" label="" v-model="comFamilyInfoForm.customerId"
				   placeholder="关联客户" url="si/customer/comCustomerInfo/list.do" 
				   value-field="id" text-field="name">
			</sf-select>
        </el-form-item>
    </sf-form-dialog>
    
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ajax.js"></script>
<script>
	var comCustomerInfoManagement = new Vue({
		el: '#vue_com_customer_info',
		data: {
			visibleFlag: false,
			btnText: "显示",
			//根据需要填写查询字段
			customerQueryCondition: {
				name: '',
				phone: '',
				email: '',
				agegt: '',
				agelt: '',
				fastFilter: 0	//快速过滤：只显示当前客服相关客户
			},
			fastFilterText: "全部",
			currentRow: null,
			selection: [],
			comCustomerInfoTableColumns: [
				{
					title: '客户ID',
					key: 'id'
				},
				{
					title: '客户名称',
					key: 'name'
				},
				{
					title: '性别',
					key: 'gender'
				},
				{
					title: '手机号',
					key: 'phone'
				},
				{
					title: '邮箱',
					key: 'email'
				},
				{
					title: '其他号码',
					key: 'tel'
				},
				{
					title: '登记时间',
					key: 'registerDate'
				},
				{
					title: '性别',
					key: 'gender'
				},
				{
					title: '顾问',
					key: 'adviseManager'
				},
				{
					title: '客服',
					key: 'serviceManager'
				},
				{
					title: '技术',
					key: 'technicalManager'
				},
				{
					title: '生日',
					key: 'birthday'
				},
				{
					title: '纪念日',
					key: 'specialDay'
				},
				{
					title: '家庭住址',
					key: 'homeAddr'
				},
				{
					title: '邮寄地址',
					key: 'officeAddr'
				},
				{
					title: '备注',
					key: 'comment'
				},
				{
					title: '职业',
					key: 'job'
				},
				{
					title: '兴趣爱好',
					key: 'interest'
				},
				{
					title: '项目',
					key: 'project'
				},
				{
					title: '项目进度',
					key: 'progress'
				},
				{
					title: '历史笔记',
					key: 'visitNote'
				},
				{
					title: '新笔记',
					key: 'visitNoteNew'
				}
			],
			showComCustomerInfoModal: false,
			comCustomerInfoEditMode: 'add',
			comCustomerInfoForm: {
				id: null ,
				name: null ,
				phone: null ,
				email: null ,
				tel: null ,
				respGroup: null,
				respManager: null,
				registerDate: null ,
				gender: null,
				adviseManager: null,
				serviceManager: null,
				technicalManager: null,
				birthday: null,
				specialDay: null,
				homeAddr: null,
				officeAddr: null,
				comment: null,
				job: null,
				interest: null,
				project: null,
				progress: null,
				visitNote: null,
				visitNoteNew: null
			},
			comCustomerInfoValidate: {
				//此处添加字段数据合理性验证
				name: [{required: true, message: '客户名称不能为空', trigger: 'blur'}],
				registerDate: [{required: true, message: '登记时间不能为空', trigger: 'blur'}],
				gender: [{required: true, type: 'number', message: '客户性别不能为空', trigger: 'blur'}],
				phone: [{required: true, message: '客户手机号不能为空', trigger: 'blur'}],
				email: [{type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur'}]
			},
			
			showVisitNoteModal: false,
			visitNoteEditMode: 'edit',
			
			buttonLoading: false,
			
			dialogTableVisible: false,
			familyQueryCondition: {
				customerId: null
			},
			
			comFamilyInfoTableColumns: [
				{
					title: '成员编号',
					key: 'id'
				},
				{
					title: '成员关系（1-夫妻，2-子女，3-父母，4-兄弟姐妹，5-其他）',
					key: 'membership'
				},
				{
					title: '姓名',
					key: 'name'
				},
				{
					title: '联系电话',
					key: 'phone'
				},
				{
					title: '生日',
					key: 'birthday'
				},
				{
					title: '职业',
					key: 'job'
				},
				{
					title: '兴趣爱好',
					key: 'interest'
				},
				{
					title: '客户编号',
					key: 'customerId'
				}
			],
			showComFamilyInfoModal: false,
			comFamilyInfoEditMode: 'add',
			comFamilyInfoForm: {
				id: null,
				membership: null,
				name: null,
				phone: null,
				birthday: null,
				job: null,
				interest: null,
				customerId: null
			},
			comFamilyInfoValidate: {
				//此处添加字段数据合理性验证
				//id: [{required: true, message: '成员编号不能为空', trigger: 'blur'}],
			},
			
			dynamicValidateForm: {
		          domains: [{
		            value: ''
		          }],
			}
		},
		methods: {
			onProgressTagText:function(scope){
				return scope.row.progress_t_description;
			},
			showOrHide:function() {
				if(this.visibleFlag) {
					this.visibleFlag = false;
					this.btnText = "显示";
				}
				else {
					this.visibleFlag = true;
					this.btnText = "隐藏";
				}
			},
			handleClick:function(row) {
				console.log(row);
				this.currentRow = row;
			},
			onSelectionChange: function (selection) {
	            this.selection = selection;
	        },
	        dateFormat:function(row, column) {
				var date = row[column.property];
				if (date == undefined) {  
					return "";
				}
				return date.substr(0,10);
			},
	        setFormatBirthday:function(val){
				//设置生日为格式化时间字符串
				this.comCustomerInfoForm.birthday = val;
				this.comFamilyInfoForm.birthday = val;
			},
			setFormatSpecialDay:function(val){
				//设置纪念日为格式化时间字符串
				this.comCustomerInfoForm.specialDay = val;
			},
			setFormatRegisterDate:function(val){
				//设置登记时间为格式化时间字符串
				this.comCustomerInfoForm.registerDate = val;
			},
			onCurrentChange: function(currentRow){
				this.currentRow = currentRow;
			},
			reset: function() {
				this.customerQueryCondition.name = '';
				this.customerQueryCondition.phone = '';
				this.customerQueryCondition.email = '';
				this.customerQueryCondition.agegt = '';
				this.customerQueryCondition.agelt = '';
				this.customerQueryCondition.fastFilter = 0;
				this.fastFilterText = "全部";
			},
			onFastFilter: function() {
				if (this.customerQueryCondition.fastFilter == 1)
				{
					this.customerQueryCondition.fastFilter = 0;
					this.fastFilterText = "全部";
				}
				else
				{
					this.customerQueryCondition.fastFilter = 1;
					this.fastFilterText = "我的";
				}
			},
			search: function() {
				this.$refs['comCustomerInfoTable'].reload();
			},
			addComCustomerInfo: function () {
				this.comCustomerInfoForm.id = null;
				this.comCustomerInfoEditMode = 'add';
				this.showComCustomerInfoModal = true;
			},
			editComCustomerInfo: function () {
				for(var key in this.comCustomerInfoForm){
					if(this.currentRow[key]){
						if (key == "interest") {
                    		this.comCustomerInfoForm[key] = this.currentRow["interest"].split(",").map(function(id){return parseInt(id);});
                    	}
                    	else {
							this.comCustomerInfoForm[key] = this.currentRow[key];
                    	}
					}
				}
				this.comCustomerInfoEditMode = 'edit';
				this.showComCustomerInfoModal = true;
			},
			onComCustomerInfoModalSuccess: function () {
				this.$refs['comCustomerInfoTable'].reload();
			},
			deleteComCustomerInfo: function () {
				var self = this;
				this.$confirm("确定删除所选客户及其相关成员?",'提示',{
					type: 'warning',
					callback: function(action){
						if(action === 'confirm'){
							self.$post('si/customer/comCustomerInfo/delete.do', 
								{ids: self.selection.map(function (user) {
                                    return user.id;
                                })},
								function () {
									self.$message.success('删除成功！');
									self.$refs['comCustomerInfoTable'].reload();
								}
							);
						}
					}
				});
			},
			editVisitNote: function (row) {
				this.comCustomerInfoForm["id"] = row["id"];
				this.comCustomerInfoForm["visitNote"] = row["visitNote"];
				this.comCustomerInfoForm["visitNoteNew"] = null;
				this.visitNoteEditMode = 'edit';
				this.showVisitNoteModal = true;
			},
			visitToday: function (row) {
				/* this.comCustomerInfoForm.id = row.id; */
				this.editVisitNote(row);
				var self = this;
				self.$post('si/customer/comCustomerInfo/visit.do', {ids: [row.id]}, function () {
					self.$message.success('已拜访该客户');
					self.$refs['comCustomerInfoTable'].reload();
				});
			},
			addComFamilyInfo: function (row) {
				this.comFamilyInfoForm.customerId = row.id;
				this.comFamilyInfoEditMode = 'add';
				this.showComFamilyInfoModal = true;
			},
			editComFamilyInfo: function (row) {
				this.familyQueryCondition.customerId = row.id;
				this.dialogTableVisible = true;
			},
// 			
// 			removeFMember: function (item) {
// 				var index = this.comFamilyInfoForms.indexOf(item)
// 		        if (index !== -1) {
// 		          this.comFamilyInfoForms.splice(index, 1)
// 		        }
// 			},
// 			addFMember: function () {
// 				this.comFamilyInfoForms.push({id: null});
// 			},
// 			onComFamilyInfoModalSuccess: function () {
// 				this.$refs['comFamilyInfoTable'].reload();
// 			},
			deleteComFamilyInfo: function (row) {
				var self = this;
				this.$confirm("确定删除[" + row.name + ']?','提示',{
					type: 'warning',
					callback: function(action){
						if(action === 'confirm'){
							self.$post('si/customer/comFamilyInfo/delete.do', {ids: [row.id]}, function () {
								self.$message.success('删除成功！');
								self.$refs['comFamilyInfoTable'].reload();
							});
						}
					}
				});
			}
		},
// 		created: function () {
// 			AjaxUtils.commitAction('si/customer/comFamilyInfo/listMembers.do', {
// 			}, function(json) {
// 				var sqlData = json.data;
// 				for (var i = 0; i < sqlData.length; i++) {
// 					this.comCustomerInfoManagement.comFamilyInfoForms.push({
// 						id: sqlData[i].id ,
// 						membership: sqlData[i].membership ,
// 						name: sqlData[i].name ,
// 						phone: sqlData[i].phone ,
// 						job: sqlData[i].job ,
// 						interest: sqlData[i].interest ,
// 						customerId: sqlData[i].customerId
// 					});
// 				}
// 			});
// 		}
	})

</script>
</body>
</html>
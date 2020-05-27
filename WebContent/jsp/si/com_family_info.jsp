<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>com_family_info-维护页面</title>
    <style>
		.inline-toolbar div{
        	display:inline-block;
        }
	</style>
</head>
<st:jspId value="com_family_info"></st:jspId>
<body>
<div id="vue_com_family_info">
    <sf-panel title="所有成员" v-cloak>
        <el-row>
            <div class="com_family_info-div">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="姓名" v-model.trim="queryCondition.name" icon="search" style="width: 120px;"></el-input>
                        <el-input placeholder="电话" v-model.trim="queryCondition.phone" icon="search" style="width: 150px;"></el-input>
                        <el-input placeholder="年龄大于" v-model.trim="queryCondition.agegt" icon="search" style="width: 105px;"></el-input>
						<el-input placeholder="年龄小于" v-model.trim="queryCondition.agelt" icon="search" style="width: 105px;"></el-input>
                        <el-button type="primary" icon="fa-recycle" @click="reset">重置</el-button>
                    </div>
                    <el-button type="success" icon="plus" @click="addComFamilyInfo">添加</el-button>
                    <el-button type="info" icon="edit" @click="editComFamilyInfo" :disabled="!currentRow">编辑</el-button>
                    <el-button type="danger" icon="delete" @click="deleteComFamilyInfo" :disabled="selection.length==0">删除</el-button>
                </sf-toolbar>
                <sf-table ref="comFamilyInfoTable"
                          highlight-current-row
                          :height="500"
                          :export-columns="comFamilyInfoTableColumns"
                          url="si/customer/comFamilyInfo/list.do" 
                          import-url="si/customer/comFamilyInfo/importFile.do"
                          @current-change="onCurrentChange"
                          @selection-change="onSelectionChange"
                          :query-condition="queryCondition">
                        <el-table-column type="selection" width="50" align="center"></el-table-column>
                    	<el-table-column width="120" label="姓名" prop="name"></el-table-column>
                    	<el-table-column width="120" label="关系" prop="membership_t_description"></el-table-column>
                    	<el-table-column width="150" label="联系电话" prop="phone"></el-table-column>
                    	<el-table-column width="120" label="生日" prop="birthday" :formatter="dateFormat"></el-table-column>
                    	<el-table-column label="职业" prop="job_t_description"></el-table-column>
                    	<el-table-column label="兴趣爱好" prop="interest_t_description"></el-table-column>
                    	<el-table-column width="120" label="关联客户" prop="cusName"></el-table-column>
<!--                     	<el-table-column label="证件文件扫描件" prop="photoFile"></el-table-column> -->
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="comFamilyInfoModal"
                    title="成员"
                    v-model="showComFamilyInfoModal"
                    :mode="comFamilyInfoEditMode"
                    url="si/customer/comFamilyInfo/save.do" 
                    :model="comFamilyInfoForm"
                    :rules="comFamilyInfoValidate"
                    @on-success="onComFamilyInfoModalSuccess">
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
<script>

    var comFamilyInfoManagement = new Vue({
        el: '#vue_com_family_info',
        data: {
        	//根据需要填写查询字段
            queryCondition: {
                name: '',
                phone: '',
                agegt: '',
                agelt: ''
            },
            currentRow: null,
            selection: [],
            comFamilyInfoTableColumns: [
                {
                    title: '成员编号',
                    key: 'id'
                },
                {
                    title: '成员关系（1-户主，2-夫妻，3-子女，4-兄妹，5-父母）',
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
                },
                {
                    title: '证件文件扫描件',
                    key: 'photoFile'
                }
            ],
            showComFamilyInfoModal: false,
            comFamilyInfoEditMode: 'add',
            comFamilyInfoForm: {
                id: null ,
                membership: null ,
                name: null ,
                phone: null ,
                birthday: null,
				job: null ,
                interest: null ,
                customerId: null ,
                photoFile: null 
            },
            comFamilyInfoValidate: {
            	//此处添加字段数据合理性验证
                //id: [{required: true, message: '成员编号不能为空', trigger: 'blur'}],
            },
            buttonLoading: false,
        },
        methods: {
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
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
				this.comFamilyInfoForm.birthday = val;
			},
			reset: function() {
				this.queryCondition.name = '';
				this.queryCondition.phone = '';
				this.queryCondition.agegt = '';
				this.queryCondition.agelt = '';
			},
			search: function() {
            	this.$refs['comFamilyInfoTable'].reload();
            },
            addComFamilyInfo: function () {
                this.comFamilyInfoForm.id = null;
                this.comFamilyInfoEditMode = 'add';
                this.showComFamilyInfoModal = true;
            },
            editComFamilyInfo: function () {
                for(var key in this.comFamilyInfoForm){
                    if(this.currentRow[key]) {
                    	if (key == "interest") {
                    		this.comFamilyInfoForm[key] = this.currentRow["interest"].split(",").map(function(id){return parseInt(id);});
                    	}
                    	else {
                    		this.comFamilyInfoForm[key] = this.currentRow[key];
                    	}
                    }
                }
                this.comFamilyInfoEditMode = 'edit';
                this.showComFamilyInfoModal = true;
            },
            onComFamilyInfoModalSuccess: function () {
                this.$refs['comFamilyInfoTable'].reload();
            },
            deleteComFamilyInfo: function () {
                var self = this;
                this.$confirm("确定删除所选成员?",'提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('si/customer/comFamilyInfo/delete.do', 
                            	{ids: self.selection.map(function (user) {
                                	return user.id;
                            	})},
                            	function () {
                                	self.$message.success('删除成功！');
                                	self.$refs['comFamilyInfoTable'].reload();
                            	}
                            );
                        }
                    }
                });
            }
        }
    })
</script>
</body>
</html>
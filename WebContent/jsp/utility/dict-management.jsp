<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>字典管理</title>
	<%@include file="../include/common-rss.jsp"%>
    <style>
        .dict-left{
            float: left;
            width: 600px;
        }

        .dict-right{
            margin-left: 620px;
            min-width: 700px;
        }

    </style>
</head>
<body>
<div id="dict-management">
    <sf-panel title="字典管理" v-cloak>
        <el-row>
            <div class="dict-left">
                <sf-toolbar>
                    <div slot="searcher">
                        <el-input placeholder="输入字典名称" v-model="dictQueryCondition.dictName" icon="search" style="width: 250px;"></el-input>
                    </div>
                    <el-button type="success" icon="fa-plus" @click="addDict">添加</el-button>
                    <el-tooltip placement="top" content="请先选择字典" :disabled="!!currentDict">
                        <span><el-button type="info" icon="fa-pencil" :disabled="!currentDict" @click="editDict">编辑</el-button></span>
                    </el-tooltip>
                    <el-tooltip placement="top" content="请先选择字典" :disabled="!!currentDict">
                        <span><el-button type="danger" icon="fa-trash" :disabled="!currentDict" @click="deleteDict">删除</el-button></span>
                    </el-tooltip>
                </sf-toolbar>
                <sf-table ref="dicTable"
                          highlight-current-row
                          :height="500"
                          url="utility/dictionary/list.do"
                          import-url="utility/dictionary/importDict.do"
                          :query-condition="dictQueryCondition"
                          @current-change="onCurrentDictChange">
                    <el-table-column label="#" prop="__index" width="100" align="center"></el-table-column>
                    <el-table-column label="字典编码" prop="name"></el-table-column>
                    <el-table-column label="字典名称" prop="description"></el-table-column>
                </sf-table>
            </div>
            <div class="dict-right">
                <sf-toolbar>
                    <el-tooltip placement="top" content="请先选择字典" :disabled="!!currentDict">
                        <span><el-button type="success" icon="fa-plus" :disabled="!currentDict" @click="addDictItem">添加</el-button></span>
                    </el-tooltip>
                    <el-button type="info" icon="fa-pencil" @click="editDictItem">编辑</el-button>
                    <el-button type="danger" icon="fa-trash" @click="deleteDictItem">删除</el-button>
                </sf-toolbar>
                <sf-table ref="dicItemTable"
                          highlight-current-row
                          :show-page="false"
                          :height="500"
                          url="utility/dictionary/loadDictItems.do"
                          import-url="utility/dictionary/importDictItem.do"
                          :query-condition="dictItemsQueryCondition"
                          @selection-change="onSelectionChange">
                    <el-table-column type="selection" width="50" align="center"></el-table-column>
                    <el-table-column label="#" prop="__index" width="50" align="center"></el-table-column>
                    <el-table-column label="编码" prop="code"></el-table-column>
                    <el-table-column label="实际值" prop="value"></el-table-column>
                    <el-table-column label="显示值" prop="displayValue"></el-table-column>
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
    <sf-form-dialog ref="dictModal"
                    title="字典"
                    submit-on-enter
                    v-model="showDictModal"
                    :mode="dictEditMode"
                    url="utility/dictionary/save.do"
                    :model="dictForm"
                    :rules="dictValidate"
                    @on-success="onDictModalSuccess">
        <el-form-item label="字典编码" prop="name">
            <el-input v-model.trim="dictForm.name" placeholder="输入字典编码"></el-input>
        </el-form-item>
        <el-form-item label="字典名称" prop="description">
            <el-input v-model.trim="dictForm.description" placeholder="输入字典名称"></el-input>
        </el-form-item>
    </sf-form-dialog>

    <sf-form-dialog ref="dicItemModal"
                    title="字典项"
                    submit-on-enter
                    v-model="showDicItemModal"
                    :mode="dicItemEditMode"
                    url="utility/dictionary/saveItem.do"
                    :model="dicItemForm"
                    :rules="dicItemValidate"
                    @on-success="onDicItemModalSuccess">
        <el-form-item label="编码" prop="code">
            <el-input v-model.trim="dicItemForm.code" placeholder="输入字典项编码,同一个字典内唯一"></el-input>
        </el-form-item>
        <el-form-item label="实际值" prop="value">
            <el-input v-model.trim.number="dicItemForm.value" placeholder="实际值不能为空 0-9,同一个字典内唯一"></el-input>
        </el-form-item>
        <el-form-item label="显示值" prop="displayValue">
            <el-input v-model.trim="dicItemForm.displayValue" placeholder="输入字典项描述"></el-input>
        </el-form-item>
    </sf-form-dialog>
</div>
<script>
    var dictManagement = new Vue({
        el: '#dict-management',
        data: {
            currentDict: null,
            dictQueryCondition: {
                dictName: ''
            },
            showDictModal: false,
            dictEditMode: 'add',
            dictForm: {
                id: null,
                name: '',
                description: ""
            },
            dictValidate: {
                name: [{required: true, message: '字典编码不能为空', trigger: 'blur'}],
                description: [{required: true, message: '字典名称不能为空', trigger: 'blur'}]
            },
            selection: [],
            showDicItemModal: false,
            dicItemEditMode: 'add',
            dicItemForm: {
                id: null,
                dictId: -1,
                code: '',
                value: '',
                displayValue: ''
            },
            dicItemValidate: {
                code: [
                    {required: true, message: '编码不能为空,同一个字典内唯一', trigger: 'blur'}
                ],
                value: [
                    {type: 'number',required: true, message: '实际值不能为空 0-9,同一个字典内唯一', trigger: 'blur'}
                ],
                displayValue: [
                    {required: true, message: '显示值不能为空', trigger: 'blur'}
                ]
            }
        },
        computed: {
            dictItemsQueryCondition: function () {
                return {
                    dictId: this.currentDict ? this.currentDict.id : 0
                }
            }
        },
        methods: {
            onCurrentDictChange: function(currentRow){
                this.currentDict = currentRow;
            },
            addDict: function () {
                this.dictForm.id = null;
                this.dictEditMode = 'add';
                this.showDictModal = true;
            },
            editDict: function () {
                for(var key in this.dictForm){
                    if(this.currentDict[key])
                        this.dictForm[key] = this.currentDict[key];
                }
                this.dictEditMode = 'edit';
                this.showDictModal = true;
            },
            onDictModalSuccess: function(json){
                this.$refs['dicTable'].reload();
            },
            deleteDict: function () {
                var self = this;
                this.$confirm("确定删除字典（" + self.currentDict.description + '）?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('utility/dictionary/deletePermanently.do', {
                                ids: [self.currentDict.id]
                            }, function () {
                                self.$message.success('删除字典成功！');
                                self.$refs['dicTable'].reload();
                            });
                        }
                    }
                });
            },
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            addDictItem: function () {
                this.dicItemForm.id = null;
                this.dicItemForm.dictId = this.currentDict.id;

                this.dicItemEditMode = 'add';
                this.showDicItemModal = true;
            },
            editDictItem: function () {
                if(this.selection.length !== 1){
                    return this.$message.warning('只允许选择一个字典项!');
                }

                for(var key in this.dicItemForm){
                    if(this.selection[0][key])
                        this.dicItemForm[key] = this.selection[0][key];
                }

                this.dicItemEditMode = 'edit';
                this.showDicItemModal = true;
            },
            onDicItemModalSuccess: function () {
                this.$refs['dicItemTable'].reload();
            },
            deleteDictItem: function () {
                if(this.selection.length === 0){
                    return this.$message.warning('请至少选择一个字典项！');
                }
                //批量删除接口

                var self = this;
                this.$confirm('确定删除所选字典项?','提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('utility/dictionary/deleteItemPermanently.do', {
                                ids: self.selection.map(function (item) {
                                    return item.id;
                                })
                            }, function () {
                                self.$message.success('删除字典项成功！');
                                self.$refs['dicItemTable'].reload();
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
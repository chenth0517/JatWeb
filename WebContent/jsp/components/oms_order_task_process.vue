<!--suppress ALL -->
<style>
    .omsTaskOp .el-dialog--tiny{
        width:50%;
    }

    .omsTaskOp .el-upload-list{
        display: flex;
        width:30%;
        flex-wrap: wrap;
    }
</style>
<template>
    <sf-form-dialog ref="omsTaskOpModal"
                    title="任务处理"
                    v-model="showOmsTaskOpModal"
                    :edit-mode="omsTaskOpEditMode"
                    url="si/order/omsOrderTask/saveOpHistory.do"
                    :model="omsTaskOpForm"
                    :rules="omsTaskOpValidate"
                    @on-success="onOmsTaskOpModalSuccess" class="omsTaskOp">
        <el-form-item label="任务名称" prop="name">
            <el-input v-model.trim="omsTaskOrderForm.name" placeholder="任务名称" readonly></el-input>
        </el-form-item>
        <el-form-item label="记录" prop="remark">
            <sf-text-editor ref="textEditor" v-model="omsTaskOpForm.remark" images-upload-url="text/upload" :images-upload-handler="onImagesHandler" :height=150></sf-text-editor>
        </el-form-item>
        <el-form-item>
            <el-upload ref="uploadTaskOpEditor" action="utility/fileManager/upload.do" :data="{delWhenExist:false}" :file-list="opFileList" :multiple="true" list-type="picture"
                       :on-success="uploadTaskOpFileSuccess" :on-remove="uploadTaskOpFileRemove">
                <el-button size="small" type="primary">上传附件</el-button>
                <div slot="tip" class="el-upload__tip">单个文件不能超过10M</div>
            </el-upload>
        </el-form-item>
        <el-form-item label="状态" prop="status">
            <!--<sf-select width="100%" label="" v-model.trim="omsTaskOpForm.result" placeholder="状态" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_TASKSTATUS" value-field="id" text-field="displayValue"></sf-select>-->
            <sf-radio-group v-model = "omsTaskOpForm.result" url="utility/dictionary/loadDictItemsByName.do?name=SMART_INFO_DIC_TASKSTATUS" value-field="id" text-field="displayValue" size="small"></sf-radio-group>
        </el-form-item>
    </sf-form-dialog>
</template>
<script>
    //import SfRadioGroup from './sf_radio_group.vue';

    export default{
        components:{
            'sf-radio-group': loadComponent(webRootPath + 'jsp/components/sf_radio_group.vue'),
        },
        props:{
            value:Boolean,
            taskId:Number,
        },
        data:function () {
            return {
                omsTaskOpEditMode: false,
                omsTaskOrderForm:{
                    name:null,
                },

                omsTaskOpValidate: {
                    //此处添加字段数据合理性验证
                    //id: [{required: true, message: '工单ID不能为空', trigger: 'blur'}],

                },
                buttonLoading: false,
                opFileList:[],
                omsTaskOpForm: {
                    id: null ,
                    orderId:null,
                    remark:'',
                    result:null,
                    userId:null,
                    taskId:this.taskId,
                    mapFileNameId:{}
                } ,
            }
        },
        computed: {
            showOmsTaskOpModal: {
                get:function() {
                    return this.value;
                },
                set:function(val) {
                    this.$emit('input', val);
                }
            }
        },
        watch: {
            taskId: function (val) {
                this.omsTaskOpForm.taskId = val;
                this.loadTaskInfo();
                this.loadOpInfo();
                this.loadOphFileLinks();
            }
        },
        methods: {
            loadOpInfo:function () {
                var self = this;
                this.$post("si/order/omsOrderTask/loadOneTaskOpHistory.do",{taskId:self.taskId},
                    function (success) {
                        if(success.data != null){
                            for(var key in self.omsTaskOpForm){
                                self.omsTaskOpForm[key] = success.data[0][key];
                            }
                            self.loadOphFileLinks();
                        }
                    }
                )
            },
            loadTaskInfo:function () {
                var self = this;
                this.$post("si/order/omsOrderTask/loadOne.do",{id:self.taskId},
                    function (success) {
                        if(success.data != null)
                            self.omsTaskOpForm.orderId = success.data.ordeId;
                        self.omsTaskOrderForm.name=success.data.name;
                    }
                )
            },
            loadOphFileLinks:function(){
                this.omsTaskOpForm.mapFileNameId={};
                this.opFileList = [];
                var self = this;
                this.$post("si/order/omsOrderTask/loadOphFileInfos.do",{historyId:self.omsTaskOpForm.id},
                    function (success) {
                        if(success.data != null){
                            success.data.map(function(t){
                                self.omsTaskOpForm.mapFileNameId[t.name] = t.id;
                                self.opFileList.push({name:t.name,fileId:t.id,url:webRootPath+"utility/fileManager/previewFile.do?fileId="+t.id});
                            });
                        }
                    }
                );
            },
            uploadTaskOpFileSuccess:function(success,file,fileList){
                //重复上传时的上传列表显示,暂不实现
                //后台smartview回调，用uploadStatus（“success” or “error”）判断上传结果
                if(success.data[0].uploadStatus == "success"){
                    this.omsTaskOpForm.mapFileNameId[success.data[0].originalFileName] = success.data[0].fileId;
                }else{
                    this.$message.error(success.data[0].errorMessage);
                    //this.opFileList = fileList.pop();
                    fileList.pop();
                    this.opFileList = fileList;
                }

            },
            //删除同时删库及关联
            uploadTaskOpFileRemove:function(file,fileList){
                var fileId = -1;
                if(this.omsTaskOpForm.mapFileNameId.hasOwnProperty(file.name))
                    fileId = this.omsTaskOpForm.mapFileNameId[file.name];
                var self = this;

                self.$post("si/order/omsOrderTask/deleteFileAndLink.do",{fileId:fileId,orderId:self.omsTaskOpForm.orderId},
                    function (success) {
                        delete self.omsTaskOpForm.mapFileNameId[file.name];
                    },
                    function(error){
                        self.$(message).error("删除附件失败");
                    }
                )
            },
            onImagesHandler:function () {

            },
            onOmsTaskOpModalSuccess:function () {
                this.$emit('refreshtable');
            },
            onProcessDialogClose:function(){
                this.showOmsOrderTaskModal = true;
            }
        }
    }
</script>
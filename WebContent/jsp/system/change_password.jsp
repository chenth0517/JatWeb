<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="../include/common-rss.jsp"%>
</head>
<body>
    <div id="changePasswordForm" width="300px">
        <el-form ref="changePasswordForm" :model="changePwdForm" :rules="pwdValidate" label-width="100px">
            <el-form-item label="用户名">
                <el-input type="text" v-model="changePwdForm.userName" readonly="readonly"></el-input>
            </el-form-item>
            <el-form-item label="原密码" prop="oldPassword">
                <el-input type="password" v-model="changePwdForm.oldPassword" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="新密码" prop="newPassword">
                <el-input type="password" v-model="changePwdForm.newPassword" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="重复新密码" prop="confirmNewPassword" required>
                <el-input type="password" v-model="changePwdForm.confirmNewPassword" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('changePasswordForm')">提交</el-button>
            </el-form-item>
        </el-form>
    </div>
	<script type="text/javascript" src="./resources/js/encryptor.js"></script>
	<script type="text/javascript">
        const validateConfirmPwd = function(rule, value, callback){
            if (typeof value === "undefined" || value === ''){
                callback(new Error('请再次输入密码'));
            }
            else if (value !== changePasswordForm.changePwdForm.newPassword){
                callback(new Error('两次输入密码不一致'));
            }
            else{
                callback();
            }
        };
        var changePasswordForm = new Vue({
            el:'#changePasswordForm',
            data:{
                changePwdForm:{
                    userId: '',
                    userName: '',
                    oldPassword: '',
                    newPassword: '',
                    confirmNewPassword: ''
                },
                pwdValidate:{
                    oldPassword:{required:true, message:'请输入原密码', trigger:'blur'},
                    newPassword:{required:true, message:'请输入新密码', trigger:'blur'},
                    confirmNewPassword:{validator: validateConfirmPwd, trigger:'blur'}
                }
            },
            created:function(){
                var self = this;
                self.$post("checkLogin.do", null, function(json){
                    self.changePwdForm.userId = json.data.id;
                    self.changePwdForm.userName = json.data.userName;
                });
            },
            methods:{
                submitForm:function(name){
                    var self = this;
                    self.$refs[name].validate(function(valid){
                        if (valid){
							var _data = {};
							_data.oldPassword = SmartParaEncrytor.encode(self.changePwdForm.oldPassword);
							_data.newPassword = SmartParaEncrytor.encode(self.changePwdForm.newPassword);
							_data.confirmNewPassword = SmartParaEncrytor.encode(self.changePwdForm.confirmNewPassword);
							
                            self.$post("user/changePassword.do", _data, function(json){
                                window.location.href= 'dashboard.do';
                            });
                        }
                    });
                }
            }
        });
	</script>
</body>
</html>

/**
 * 参数加密算法
 */
document.write('<script type="text/javascript" src="./resources/js/base64.min.js"></script>');
document.write('<script type="text/javascript" src="./resources/js/md5.min.js"></script>');

SmartParaEncrytor = {};
SmartParaEncrytor.encode=function(value){
	return Base64.encode(value);
}
SmartParaEncrytor.passwordEncode = function(value){
	var pwd = Base64.encode(value); //这里的加密算法是由业务自定义的
	pwd = md5(pwd).toUpperCase() + pwd;
	return SmartParaEncrytor.encode(pwd);
}
/**************************************************************************************/
/*************************************数字的验证*****************************************/
/**************************************************************************************/

//added by hsl - 2015-11-21 15:21
/* 是否数字*/
function isNumber(str) {
    var e = {isValid: true, value: str,errorText:'必须输入整数数字'};
    if (e.isValid) {
        if (e.value.length == 0) {
            return e;
        }
        var pattern = /^\d+$/;
        if (pattern.test(e.value)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/* 是否实数*/
function isRealNum(str) {
	var e = {isValid: true, value: str,errorText:'必须输入实数数字'};
    if (e.isValid) {
        if (e.value.length == 0) {
            return e;
        }
        var pattern = /^-?\d+\.?\d*$/;
        if (pattern.test(e.value)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*是否GPS_INFO*/
function isGpsInfo(str) {
	var e = {isValid: true, value: str,errorText:'GPS信息格式有误'};
    if (e.isValid) {
        if (e.value.length == 0) {
            return e;
        }
        var pattern0 = /^-?(?:(?:180(?:\.0{1,9})?)|(?:(?:(?:1[0-7]\d)|(?:[1-9]?\d))(?:\.\d{1,9})?))$/;
        var pattern1 = /^-?(?:90(?:\.0{1,9})?|(?:[1-8]?\d(?:\.\d{1,9})?))$/;
        var gpsStr = (e.value).split(",");
        var gpsInfo0 = gpsStr[0];
        var gpsInfo1 = gpsStr[1];
        if (pattern0.test(gpsInfo0) && pattern1.test(gpsInfo1)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*IP地址格式是否正确*/
function ipCheck(str) {
	var e = {isValid: true, value: str,errorText:'IP地址格式错误'};
    if (e.isValid) {
        var pattern = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        if (e.value.length == 0) {
            return e;
        }
        if (pattern.test(e.value) && (RegExp.$1 < 256 && RegExp.$2 < 256 && RegExp.$3 < 256 && RegExp.$4 < 256)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*端口号格式验证*/
function portCheck(str) {
    var e = {isValid: true, value: str,errorText:'端口号格式错误'};
    if (e.isValid) {
        var pattern = /^[1-9]$|(^[1-9][0-9]$)|(^[1-9][0-9][0-9]$)|(^[1-9][0-9][0-9][0-9]$)|(^[1-9][0-9][0-9][0-9][0-9]$)|(^[1-9][0-9][0-9][0-9][0-9][0-9]$)|(^[1-6][0-5][0-5][0-3][0-5]$)/;
        if (e.value.length == 0) {
            return e;
        }
        if (pattern.test(e.value)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*验证手机号格式是否正确*/
function mobileCheck(str) {
    var e = {isValid: true, value: str,errorText:'手机号格式错误'};
    if (e.isValid) {
        var pattern = /^((13[0-9])|(15[^4,\D])|(18[0,2-9]))\d{8}$/;
        if (e.value.length == 0) {
            return e;
        }
        if (pattern.test(e.value) && e.value.length == 11) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*验证密码安全性*/
function pwSecurityCheck(str) {
    var e = {isValid: true, value: str,errorText:'密码需要至少9位的字母、数字、特殊符号线组成'};
    if (e.isValid) {
        var pattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+`\-={}\[\]:";'<>?,.\/]).{9,}$/;
        if (e.value.length == 0) {
            return e;
        }
        if (pattern.test(e.value)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/*字符验证-用户名*/
function strCheck(str) {
	 var e = {isValid: true, value: str,errorText:'只能包括中文、英文、数字和下划线'};
    if (e.isValid) {
        var pattern = /^[\u0391-\uFFE5\w]+$/;
        if (e.value.length == 0) {
            return e;
        }
        if (pattern.test(e.value)) {
            return e;
        } else {
            e.isValid = false;
            return e;
        }
    }
}

/**
 * 检查输入的一串字符是否全部是数字
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为数字
 */
function checkNum(str) {
	var e = {isValid: true, value: str,errorText:'只能填数字'};
    if( str.match(/\D/) == null) return e;
    e.isValid = false;
    return e;
}


/**
 * 检查输入的一串字符是否为小数
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为小数
 */
function checkDecimal(str) {
	var e = {isValid: true, value: str,errorText:'必须包含小数'};
    if (str.match(/^-?\d+(\.\d+)?$/g) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查输入的一串字符是否为整型数据
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为小数
 */
function checkInteger(str) {
	var e = {isValid: true, value: str,errorText:'只能为整数'};
    if (str.match(/^[-+]?\d*$/) == null) {
    	e.isValid = false;
    }
    return e;
}

/**************************************************************************************/
/*************************************字符的验证*****************************************/
/**************************************************************************************/


/**
 * 检查输入的一串字符是否是字符
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为全部为字符 不包含汉字
 */
function checkStr(str) {
	var e = {isValid: true, value: str,errorText:'只能为字符串'};
    if (/[^\x00-\xff]/g.test(str)) {
        return e;
    }
    e.isValid = false;
    return e;
}


/**
 * 检查输入的一串字符是否包含汉字
 * 输入:str  字符串
 * 返回:true 或 flase; true表示包含汉字
 */
function checkChinese(str) {
	var e = {isValid: true, value: str,errorText:'必须包含汉字'};
    if (escape(str).indexOf("%u") != -1) {
    	e.isValid = false;
    }
    return e;
}


/**
 * 检查输入的邮箱格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkEmail(str) {
	var e = {isValid: true, value: str,errorText:'邮箱格式不正确'};
    if (str.match(/[A-Za-z0-9_-]+[@](\S*)(net|com|cn|org|cc|tv|[0-9]{1,3})(\S*)/g) == null) {
    	e.isValid = false;
    }
    return e;
}


/**
 * 检查输入的手机号码格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkMobilePhone(str) {
	var e = {isValid: true, value: str,errorText:'手机号码格式不正确'};
    if (str.match(/^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/) == null) {
    	e.isValid = false;
    }
    return e;
}


/**
 * 检查输入的固定电话号码是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkTelephone(str) {
	var e = {isValid: true, value: str,errorText:'固定电话号码格式不正确'};
    if (str.match(/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查QQ的格式是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkQQ(str) {
	var e = {isValid: true, value: str,errorText:'QQ号码格式不正确'};
    if (str.match(/^\d{5,10}$/) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查输入的身份证号是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkCard(str) {
	var e = {isValid: true, value: str,errorText:'身份证号不正确'};
    //15位数身份证正则表达式
    var arg1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
    //18位数身份证正则表达式
    var arg2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z])$/;
    if (str.match(arg1) == null && str.match(arg2) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查输入的IP地址是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkIP(str) {
	var e = {isValid: true, value: str,errorText:'IP地址不正确'};
    var arg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
    if (str.match(arg) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查输入的URL地址是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkURL(str) {
	var e = {isValid: true, value: str,errorText:'URL地址不正确'};
    if (str.match(/(http[s]?|ftp):\/\/[^\/\.]+?\..+\w$/i) == null) {
    	e.isValid = false;
    }
    return e;
}

/**
 * 检查输入的字符是否具有特殊字符
 * 输入:str  字符串
 * 返回:true 或 flase; true表示包含特殊字符
 * 主要用于注册信息的时候验证
 */
function checkQuote(str) {
	var e = {isValid: true, value: str,errorText:'没有特殊字符'};
    var items = new Array("~", "`", "!", "@", "#", "$", "%", "^", "&", "*", "{", "}", "[", "]", "(", ")");
    items.push(":", ";", "'", "|", "\\", "<", ">", "?", "/", "<<", ">>", "||", "//");
    items.push("admin", "administrators", "administrator", "管理员", "系统管理员");
    items.push("select", "delete", "update", "insert", "create", "drop", "alter", "trancate");
    str = str.toLowerCase();
    for (var i = 0; i < items.length; i++) {
        if (str.indexOf(items[i]) >= 0) {
            return e;
        }
    }
    e.isValid = false;
    return e;
}


/**************************************************************************************/
/*************************************时间的验证*****************************************/
/**************************************************************************************/

/**
 * 检查日期格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * 注意：此处不能验证中文日期格式
 * 验证短日期（2007-06-05）
 */
function checkDate(str) {
	var e = {isValid: true, value: str,errorText:'日期格式不正确'};
    //var value=str.match(/((^((1[8-9]\d{2})|([2-9]\d{3}))(-)(10|12|0?[13578])(-)(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(11|0?[469])(-)(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(0?2)(-)(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)(-)(0?2)(-)(29)$)|(^([3579][26]00)(-)(0?2)(-)(29)$)|(^([1][89][0][48])(-)(0?2)(-)(29)$)|(^([2-9][0-9][0][48])(-)(0?2)(-)(29)$)|(^([1][89][2468][048])(-)(0?2)(-)(29)$)|(^([2-9][0-9][2468][048])(-)(0?2)(-)(29)$)|(^([1][89][13579][26])(-)(0?2)(-)(29)$)|(^([2-9][0-9][13579][26])(-)(0?2)(-)(29)$))/);
    var value = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
    if (value == null) {
    	e.isValid = false;
    	return e;
    }
    else {
        var date = new Date(value[1], value[3] - 1, value[4]);
        if (date.getFullYear() == value[1] && (date.getMonth() + 1) == value[3] && date.getDate() == value[4]) return e;
        e.isValid = false;
    	return e;
    }
}

/**
 * 检查时间格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * 验证时间(10:57:10)
 */
function checkTime(str) {
	var e = {isValid: true, value: str,errorText:'时间格式不正确'};
    var value = str.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/)
    if (value == null) {
    	e.isValid = false;
    	return e;
    }
    else {
        if (value[1] > 24 || value[3] > 60 || value[4] > 60) {
        	e.isValid = false;
        	return e;
        }
        else {
            return e;
        }
    }
}

/**
 * 检查全日期时间格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * (2007-06-05 10:57:10)
 */
function checkFullTime(str) {
	var e = {isValid: true, value: str,errorText:'全日期时间格式'};
    //var value = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
    var value = str.match(/^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/);
    if (value == null) {
    	e.isValid = false;
    	return e;
    }
    else {
        //var date = new Date(checkFullTime[1], checkFullTime[3] - 1, checkFullTime[4], checkFullTime[5], checkFullTime[6], checkFullTime[7]);
        //return (date.getFullYear() == value[1] && (date.getMonth() + 1) == value[3] && date.getDate() == value[4] && date.getHours() == value[5] && date.getMinutes() == value[6] && date.getSeconds() == value[7]);
        return true;
    }

}


/**************************************************************************************/
/************************************身份证号码的验证*************************************/
/**************************************************************************************/

/**
 * 身份证15位编码规则：dddddd yymmdd xx p
 * dddddd：地区码
 * yymmdd: 出生年月日
 * xx: 顺序类编码，无法确定
 * p: 性别，奇数为男，偶数为女
 * <p />
 * 身份证18位编码规则：dddddd yyyymmdd xxx y
 * dddddd：地区码
 * yyyymmdd: 出生年月日
 * xxx:顺序类编码，无法确定，奇数为男，偶数为女
 * y: 校验码，该位数值可通过前17位计算获得
 * <p />
 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]
 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置
 *
 */
var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];// 加权因子   
var ValideCode = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2];// 身份证验证位值.10代表X   
function IdCardValidate(idCard) {
    idCard = trim(idCard.replace(/ /g, ""));
    if (idCard.length == 15) {
        return isValidityBrithBy15IdCard(idCard);
    }
    else if (idCard.length == 18) {
        var a_idCard = idCard.split("");// 得到身份证数组
        if (isValidityBrithBy18IdCard(idCard) && isTrueValidateCodeBy18IdCard(a_idCard)) {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}

/**
 * 判断身份证号码为18位时最后的验证位是否正确
 * @param a_idCard 身份证号码数组
 * @return
 */
function isTrueValidateCodeBy18IdCard(a_idCard) {
    var sum = 0; // 声明加权求和变量   
    if (a_idCard[17].toLowerCase() == 'x') {
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
    }
    for (var i = 0; i < 17; i++) {
        sum += Wi[i] * a_idCard[i];// 加权求和   
    }
    valCodePosition = sum % 11;// 得到验证码所位置   
    if (a_idCard[17] == ValideCode[valCodePosition]) {
        return true;
    }
    else {
        return false;
    }
}

/**
 * 通过身份证判断是男是女
 * @param idCard 15/18位身份证号码
 * @return 'female'-女、'male'-男
 */
function maleOrFemalByIdCard(idCard) {
    idCard = trim(idCard.replace(/ /g, ""));// 对身份证号码做处理。包括字符间有空格。   
    if (idCard.length == 15) {
        if (idCard.substring(14, 15) % 2 == 0) {
            return 'female';
        }
        else {
            return 'male';
        }
    }
    else if (idCard.length == 18) {
        if (idCard.substring(14, 17) % 2 == 0) {
            return 'female';
        }
        else {
            return 'male';
        }
    }
    else {
        return null;
    }
}

/**
 * 验证18位数身份证号码中的生日是否是有效生日
 * @param idCard 18位书身份证字符串
 * @return
 */
function isValidityBrithBy18IdCard(idCard18) {
    var year = idCard18.substring(6, 10);
    var month = idCard18.substring(10, 12);
    var day = idCard18.substring(12, 14);
    var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
    // 这里用getFullYear()获取年份，避免千年虫问题   
    if (temp_date.getFullYear() != parseFloat(year) ||
        temp_date.getMonth() != parseFloat(month) - 1 ||
        temp_date.getDate() != parseFloat(day)) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 验证15位数身份证号码中的生日是否是有效生日
 * @param idCard15 15位书身份证字符串
 * @return
 */
function isValidityBrithBy15IdCard(idCard15) {
    var year = idCard15.substring(6, 8);
    var month = idCard15.substring(8, 10);
    var day = idCard15.substring(10, 12);
    var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
    // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
    if (temp_date.getYear() != parseFloat(year) ||
        temp_date.getMonth() != parseFloat(month) - 1 ||
        temp_date.getDate() != parseFloat(day)) {
        return false;
    }
    else {
        return true;
    }
}

//去掉字符串头尾空格   
function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}
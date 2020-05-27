<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

	String resourcesPath = contextPath + "resources/";
	String subModuleJspFolderPrefix=contextPath+"jsp/";
	
 	//设置售电业务名称(模块名），便于统一修改
    request.getSession().setAttribute("sepModule","sep");
    //静态资源发布目录(js,css等平台公共组件)
	request.setAttribute("resourceServer","http://192.168.51.7/Resources/static");
    request.getSession().setAttribute("lcoalServer",contextPath  + "resources");
    
%>
<%@include file="tag-libs.jsp" %>
<base href="<%=contextPath%>">
<script type="text/javascript">
	var webRootPath = "<%=contextPath%>";
	
</script>
	<% //	common-js	%>
	<link rel="stylesheet" type="text/css" href="${lcoalServer}/static/sf-ui/sf-ui.min.css">

    
   	<% //	common-js	%>
	<script type="text/javascript" src="${lcoalServer}/static/vue/vue.js"></script>
    <script type="text/javascript" src="${lcoalServer}/static/sf-ui/sf-ui.js"></script>
    <script type="text/javascript" src="${lcoalServer}/js/jquery-3.2.1.min.js"></script>
    <%--<script type="text/javascript" src="${resourceServer}/js/echarts.min.js"></script>--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

  <head>
  	<script type="text/javascript">
  	  function checkPost(){
	 	var ps1=document.sign.psw1.value;
	 	var ps2=document.sign.psw2.value;
	 	if(user==""){
	  		alert("请填写用户名");
	        return false;
	  	}
	  	if(ps1==""){
	  		 alert("请填写密码");
	         document.sign.psw1.focus();
	         return false;
	  	}
	  	
	  	if(ps1!=ps2){
	  		 alert("密码不一致");
	         document.sign.psw2.focus();
	         return false;
	  	}
	  }
  	</script>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="./css/login.css">
    <title>My jsp 'login.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
    <div id="div_main">
      <div id="div_form">
        <div id="div_mid">
          <img class="logo" src="./img/logob.png" >
          <form action="./jsp/Dsign.jsp" method="get" name="sign" onsubmit="return checkPost()"">
            <input class="main" type="text" name="user" placeholder="请输入用户名"/>
            <input class="main" type="text" name="psw1" placeholder="请输入密码"/>
            <input class="main" type="text" name="psw2" placeholder="请确认密码"/>
            <div id="div_sign"><p><a href="./jsp/loginShow.jsp ">已有账号？立即登录</a> </p></div>
            <input class="sub" type="submit" value="注册"/>
          </form>
        </div>
      </div>
    </div>
</body>
</html>
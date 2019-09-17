<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
 <script type="text/javascript">

    // checkCode.js
    
var code; //在全局定义验证码    
//产生验证码   
window.onload = function() {
    createCode();
}

function createCode() {
    code = "";
    var codeLength = 4; //验证码的长度   
    var checkCode = document.getElementById("checkCode");
    var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
        'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //随机数   
    for (var i = 0; i < codeLength; i++) { //循环操作   
        var charIndex = Math.floor(Math.random() * 36); //取得随机数的索引   
        code += random[charIndex]; //根据索引取得随机数加到code上   
    }
    checkCode.value = code; //把code值赋给验证码   
}
//校验验证码   
function validate() {
    var inputCode = document.getElementById("input").value.toUpperCase(); //取得输入的验证码并转化为大写         
    if (inputCode.length <= 0) { //若输入的验证码长度为0   
        alert("请输入验证码！"); //则弹出请输入验证码   
    } else if (inputCode != code) { //若输入的验证码与产生的验证码不一致时   
        alert("验证码输入错误！"); //则弹出验证码输入错误   
        createCode(); //刷新验证码   
    } 
}  
</script>
  <head>
  	
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
          <img class="logo" src="./img/logob.png">
          <form action="jsp/Dlogin.jsp" method="get">
            <input class="main" type="text" name="user" placeholder="请输入用户名"/>
            <input class="main" type="password" name="psw" placeholder="请输入密码"/>
			 <input type="button" id="checkCode" onclick="createCode()" />
      		 <input type="text" id="input" style="width:230px;" placeholder="请输入验证码"/>
            <div id="div_sign"><p><a href="./jsp/sign.jsp ">没有账号？立即注册</a> </p></div>
            <input class="sub" type="submit" value="登录"/>
          </form>

        </div>
      </div>
    </div>
</body>
</html>

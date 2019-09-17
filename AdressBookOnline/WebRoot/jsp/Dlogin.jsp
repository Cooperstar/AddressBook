<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Dlogin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
     <%
		String username = request.getParameter("user");
		String psw = request.getParameter("psw");
	   	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	    String url="jdbc:sqlserver://localhost:1433;databasename=AddressBook";
	    Connection conn = DriverManager.getConnection(url,"sa", "123456");
		String sql = "select * from [AddressBook].[dbo].[User] where UserName=? and UserPwd=?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1,username);
		pstm.setString(2,psw);
		ResultSet rs = pstm.executeQuery();
		if(rs.next()){
			session.setAttribute("username", username);
			response.sendRedirect("AdressMainUI.jsp");
		}
		else{
		%>
		<script>alert("账号或者密码错误！")</script>
		<%	
			response.sendRedirect("loginShow.jsp");	
		}  
	rs.close();
	conn.close() ;
    %>
  </body>
</html>

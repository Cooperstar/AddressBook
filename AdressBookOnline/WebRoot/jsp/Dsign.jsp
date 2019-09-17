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
    Statement stm = null; 
    ResultSet rs = null;
	String username = request.getParameter("user");
	String pwd = request.getParameter("psw1");
	session.setAttribute("user", username );
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    String url="jdbc:sqlserver://localhost:1433;databasename=AddressBook";
    Connection conn = DriverManager.getConnection(url,"sa", "123456");
	String sql = "select * from [AddressBook].[dbo].[User] where UserName=?";
	PreparedStatement pstm = conn.prepareStatement(sql);
	pstm.setString(1,username);
	rs = pstm.executeQuery();
	if(rs.next()){%>
	<script>alert("该账号已被注册！")</script>
	<%
		response.sendRedirect("sign.jsp");
	}
	else{
		PreparedStatement Pstmt=conn.prepareStatement("insert into Users (UserName,UserPwd) values(?,?)");
		Pstmt.setString(1,username);
		Pstmt.setString(2,pwd);
		Pstmt.executeUpdate();
		conn.close();
		response.sendRedirect("loginShow.jsp");
	}
    %>
    <script>alert("注册成功")</script>
  </body>
</html>

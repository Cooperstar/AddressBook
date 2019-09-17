<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>编辑....</title>
    
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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		if(session.getAttribute("username")==null){
			response.sendRedirect("loginShow.jsp");
		}
		String id = request.getParameter("GroupID");
		String name = request.getParameter("editgroup");
		String GroupID = request.getParameter("GroupID");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		Connection conn = DriverManager.getConnection(url,"cjw","19990117");
		
		Statement stm = conn.createStatement();
		String sql = "UPDATE [AddressBook].[dbo].[Group] SET GroupName = '"+name+"' WHERE GroupID = "+id;
		stm.executeUpdate(sql);	
		response.sendRedirect("GroupUI.jsp?GroupID="+id);	
%> 
  </body>
</html>

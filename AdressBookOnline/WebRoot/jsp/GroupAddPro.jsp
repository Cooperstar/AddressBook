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
    
    <title>My JSP 'GroupAddPro.jsp' starting page</title>
    
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
		String GroupName = request.getParameter("GroupName");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		Connection conn = DriverManager.getConnection(url,"cjw","19990117");
		Statement stm0 = conn.createStatement();
		String sql0 = "select * from [AddressBook].[dbo].[User] where UserName='"+session.getAttribute("username")+"'";
		ResultSet rs0 = stm0.executeQuery(sql0);
		rs0.next(); 
		int UserID = rs0.getInt("UserID");
        Statement stm =conn.createStatement();
		String sql = "INSERT INTO [AddressBook].[dbo].[Group]([GroupName],[GroupUser]) VALUES('"+GroupName+"','"+UserID+"')";
		stm.executeUpdate(sql);	
		
		Statement stm1 =conn.createStatement();
		String sql1 = "select * from [AddressBook].[dbo].[Group] where GroupName='"+GroupName+"'";
		ResultSet rs1= stm1.executeQuery(sql1);	
		rs1.next();
		
		response.sendRedirect("GroupUI.jsp?GroupID="+rs1.getInt("GroupID"));

%>
  </body>
</html>

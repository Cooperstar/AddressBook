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
    
    <title>删除验证</title>
    
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
		String GroupID = request.getParameter("GroupID");
		System.out.println("aaa"+GroupID);
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		Connection conn = DriverManager.getConnection(url,"cjw","19990117");
		Statement stm0 =conn.createStatement();
		String sql0 = "SELECT COUNT(RelateID) as RID FROM [AddressBook].[dbo].[Relate] where RGroup = '"+GroupID+"' ";
		ResultSet rs0 = stm0.executeQuery(sql0);
		rs0.next();
		int count = rs0.getInt("RID");
		if(count > 0)
		{
			System.out.println("ccc"+GroupID);
			int x = Integer.parseInt(GroupID);
			response.sendRedirect("GroupUI.jsp?GroupID="+x+"&DelFlag=f");
		}
		else{		
		System.out.println("ddd"+GroupID);
		Statement stm =conn.createStatement();
		String sql = "DELETE FROM [AddressBook].[dbo].[Group] where GroupID = '"+GroupID+"'";
		stm.executeUpdate(sql);
		response.sendRedirect("AdressMainUI.jsp?DelFlag=t");
		}
%>
  </body>
</html>

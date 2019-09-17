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
    
    <title>My JSP 'ContactImport.jsp' starting page</title>
    
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
		String [] ss = request.getParameterValues("ContactID");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		Connection conn = DriverManager.getConnection(url,"cjw","19990117");
		if(ss!=null){
			int size = java.lang.reflect.Array.getLength(ss);
            for (int i = 0; i < size; i++) {
                Statement stm =conn.createStatement();
                System.out.println("assss"+ss[i]+"     ddddd"+GroupID);
				String sql = "INSERT INTO [AddressBook].[dbo].[Relate]([RContact],[RGroup]) VALUES('"+ss[i]+"','"+GroupID+"')";
				stm.executeUpdate(sql);	
            }	
		}
		else{
			response.sendRedirect("GroupUI.jsp?GroupID="+GroupID);
		}
		response.sendRedirect("GroupUI.jsp?GroupID="+GroupID);
%>
  </body>
</html>

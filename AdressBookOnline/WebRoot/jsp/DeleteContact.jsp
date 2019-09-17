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
    
    <title>My JSP 'Delete.jsp' starting page</title>
    
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
    	    String id=request.getParameter("ContactID");
    	    String GroupID = request.getParameter("GroupID");
    	   if(session.getAttribute("username")==null){
			response.sendRedirect("loginShow.jsp");
		}
    	    System.out.print("Groupidididdi="+GroupID);
		    PreparedStatement pstm = null;
		    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		    String url="jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		    Connection conn = DriverManager.getConnection(url,"sa", "123456");
		    
		   if(GroupID==null){
		    PreparedStatement pstm1=conn.prepareStatement("delete from Relate where RContact=?");
		    pstm1.setString(1,id);
		    pstm1.executeUpdate();
		    pstm=conn.prepareStatement("delete from Contact where ContactID=?");
		    pstm.setString(1,id);
		    pstm.executeUpdate();
		    pstm.close();
		    conn.close();
		    response.sendRedirect("AdressMainUI.jsp?DelFlag=C");
		    }
		    
		    else {
		    	String sql2 = "delete from Relate where RContact=? and RGroup=?";
		    	PreparedStatement pstm2 = conn.prepareStatement(sql2);
		    	pstm2.setString(1, id);
		    	pstm2.setString(2, GroupID);
		     	pstm2.executeUpdate();
		     	int xxxx=Integer.parseInt(GroupID);
		     	response.sendRedirect("GroupUI.jsp?GroupID="+xxxx+"&DelFlag=W");
		    }
     %>
    %>
  </body>
</html>

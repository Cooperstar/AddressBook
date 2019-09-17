<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <script type="text/javascript" src="./js/myJavaScript.js"></script>
  	<script>
	function aa(obj,td_name)
	{
		var select_value=document.getElementById("where");
		var td_value = document.getElementById(td_name);
		if(obj.checked == true){
			if(select_value.value.length>0){
				select_value.value+="," + td_value.innerText;
			}else{
				select_value.value+=td_value.innerText;
			}
		}else{
			if(select_value.value.indexOf("," + td_value.innerText + ",") != -1){
				select_value.value = select_value.value.replace("," +
				td_value.innerText,'');
			}else if(select_value.value.indexOf("," + td_value.innerText) != -1){
				select_value.value = select_value.value.replace("," +
				
				td_value.innerText,'');
			}else if(select_value.value.indexOf(td_value.innerText + ",") != -1){
				select_value.value = select_value.value.replace(td_value.innerText + ",",'');
			}else if(select_value.value.indexOf(td_value.innerText) != -1){
				select_value.value = select_value.value.replace(td_value.innerText,'');
			}
		}
	}
	function bb(){
		var obj = document.getElementById("ds");
		if(obj.style.display==""){
			obj.style.display="block";
		}else if(obj.style.display=="none"){
			obj.style.display="block";
		}else if(obj.style.display=="block"){
			obj.style.display="none";
		}
	}
	
	function inDaohang(divname,obj){
		var f = false;
		while(obj.parentNode){
			if(obj.name==divname){
				return true;
			}
			obj = obj.parentNode;
		}
		return false;
	}
	function closeDaohang(e,divname,aname){
		if(e.id!=aname && e.id!='where' && e.id.indexOf("td") ==-1&& e.id.indexOf("check") ==-1)
			if(!inDaohang(divname,e)){
				var a = document.getElementsByName(divname);
				for(var i=0;i<a.length;i++){
					a[i].style.display='none';
				}
			}
	}

</script>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="./css/ContactMsgStyle.css">
  </head>
  <body>
   <% 
   		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		if(session.getAttribute("username")==null){
			response.sendRedirect("loginShow.jsp");
		}
    	String user =session.getAttribute("username").toString();
  		String id = request.getParameter("ContactID");
  		String GroupID = request.getParameter("GroupID");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
		Connection conn = DriverManager.getConnection(url,"sa","123456");
		Statement stm0 =conn.createStatement();
		String sql0 = "select count(ContactID) as Cid from Contact join [AddressBook].[dbo].[User] as U on U.UserID=ContactUser where UserName='"+user+"'";
		ResultSet rs0 = stm0.executeQuery(sql0);
		rs0.next();
		Statement stm21 =conn.createStatement();
		String sql21="";
		System.out.println(sql21);
		
		String GroupName="";
		int count = rs0.getInt("Cid");
		Statement stm =conn.createStatement();
		String sql="";
		if(GroupID==null){
		
		sql = "SELECT * FROM [AddressBook].[dbo].[Contact] join [AddressBook].[dbo].[User] on UserID=ContactUser where UserName='"+user+"'";
		
		}else{
		
		sql = "SELECT [ContactIcon],[RelateID],[RContact],[RGroup],[ContactID],[ContactName],[ContactWork],[ContactTel],[ContactEmail],[ContactUser],[sex] FROM [AddressBook].[dbo].[Contact] as  C join [AddressBook].[dbo].[Relate] AS R on R.RContact = C.ContactID where RGroup = '"+GroupID+"'";
		sql21 = "SELECT [GroupName]  FROM [AddressBook].[dbo].[Group] WHERE [GroupID]= '"+Integer.parseInt(GroupID)+"' ";
		ResultSet rs21 = stm21.executeQuery(sql21);
		rs21.next();
		GroupName=rs21.getString("GroupName");
		}
		ResultSet rs = stm.executeQuery(sql);
		Statement stm1 =conn.createStatement();
		String sql1 = "SELECT [GroupID],[GroupName],[GroupUser] FROM [AddressBook].[dbo].[Group]";
		ResultSet rs1 = stm1.executeQuery(sql1);
		
		String sql3 = "select * from Contact where ContactID=?";
		PreparedStatement pstm3 = conn.prepareStatement(sql3);
		pstm3.setString(1,id);		
		ResultSet rs3 = pstm3.executeQuery();
		String name="",work ="",tel ="",email="",sex="";
		String Icon="";
		while(rs3.next()){
			Icon = rs3.getString("ContactIcon");
			name = rs3.getString("ContactName");
			work = rs3.getString("ContactWork");
			tel =rs3.getString("ContactTel");
			email = rs3.getString("ContactEmail");
			sex = rs3.getString("sex");
		}
		String [] group= new String[10];
			String [] Cgroup=new String[10];
			String [] zz=new String[10];
		    String Sql="select [GroupName],[GroupID] from [AddressBook].[dbo].[Group] join [AddressBook].[dbo].[User] on [User].UserName=?";	
			PreparedStatement pstm1 = conn.prepareStatement(Sql);
			pstm1.setString(1,user);
			ResultSet rs4 = pstm1.executeQuery();
		    int i=0;
		    while(rs4.next()){
		    	group[i]=rs4.getString("GroupName");
		    	zz[i] = rs4.getString("GroupID");
		    	i++;
		    }
			int lenth=i;
			int j=0;
    		String Sql2="select [GroupName] from [AddressBook].[dbo].[Group] join [AddressBook].dbo.Relate on Relate.RContact=? and Relate.RGroup=[Group].GroupID";	
			PreparedStatement pstm2 = conn.prepareStatement(Sql2);
			pstm2.setString(1,id);
			ResultSet rs2 = pstm2.executeQuery();
			while(rs2.next()){     
				Cgroup[j]=rs2.getString("GroupName");
				j++;
			}
			j=0;
			
		
%>
  <div id="top">
  	<div class="container">
  		<div class="topleft left">
  			<p>THE FOEN </p>
  		</div>
  		
  		<div class="topright right">
  			<a href="jsp/exit.jsp"> 
  			<img src="./img/turn_off_22.56px_1189867_easyicon.net.png">
  			</a>
  		</div>
  	</div>
  </div>
  
  
  <div id="main">
  	<div class="container">
  		
  		<div id="FlowContactDiv" >
    		<img class="right" id="flowImg" src="./img/circle_arrow_left_48px_1223167_easyicon.net.png"><br>
    			<div>
    				<div id="ContactDiv" class="test test-1">
    					<div id="ContactMessageDiv">
        					<ul id="ContactUL">
        					<%while(rs.next()) {%>
         	 					<li id="ContactLi">
         	   						<img src="/imgUrl/<%=rs.getString("ContactIcon")%>" id="ContactIcon" class="left">
         	   						<p id="ContactIDp"><a href=""><%=rs.getString("ContactName") %></a></p>
         	   						<a href=""><img src="./img/delete_dustbin_garbage_recycle_bin_trash_can_24px_1225501_easyicon.net.png" class="right DelContact"></a>
         	   						<p id="ContactTelp"><%=rs.getString("ContactTel") %></p>	
         		 				</li>
         		 				
         		 			<%} %>
         					</ul>
						</div>
    				</div>
   				</div>
 			</div>
 			
  		<div id="MainLeft" class="left">
  		
  			<div id="MainLeftTop">
  				<div class="AdminMessage">
  					<img class="left AdmIcon" src="./img/b23bdd94e9a097772b84563c622a1049.jpeg">
  					<p class="right Admp1" id="OpenLi">Admin</p>
  					<p class="right Admp2" >在线</p>
  				</div>
  			</div>
  			
  			<div id="MainLeftBottom">
  				<div class="LBTop">
  					<p id="LBTA1" class="left"><a href="javascript:void(0)" onclick = "document.getElementById('light1').style.display='block';document.getElementById('fade1').style.display='block';" style="height:20px;font-size: 12px;color: #466589;font-weight:bold;">新建组</a></p>			
  					<p id="LBTA2" class="right"><a href="jsp/ContactAddUI.jsp" style="height:20px;font-size: 12px;color: #466589;font-weight:bold;"><img src="./img/add_create_new_plus_positive_16px_1225528_easyicon.net.png" style="width:12px;height:12px;vertical-align: -2px;">新建联系人</a></p>
  				</div>
  				
  				<div id="GroupDiv">
  					<ul id="GroupUL">
  					 <%
  					  		if(GroupID==null){  
  					  		
  					    %>
  						<li id="GroupLi" ><a href="jsp/AdressMainUI.jsp" style="color:#07090B;" >所有人</a>
  						<img class="right" id="OpenP" src="./img/chevron_right_square_32px_1187824_easyicon.net.png" style="margin-right: 10px;width: 10px;height:10px; margin-top: 3px;">
  						</li>
						<%}else{ %>	
						<li id="GroupLi" ><a href="jsp/AdressMainUI.jsp" >所有人</a>
  						</li>
						<%} %>
						
  						
  						
  					    <%while(rs1.next()){ 
  					  		if(rs1.getString("GroupID").equals(GroupID)){  
  					  		
  					    %>
  						<li id="GroupLi" ><a href="jsp/GroupUI.jsp?GroupID=<%=rs1.getString("GroupID")%>" style="color:#07090B;"><%=rs1.getString("GroupName")%></a> 
  						<img class="right" id="OpenP" src="./img/chevron_right_square_32px_1187824_easyicon.net.png" style="margin-right: 10px;width: 10px;height:10px; margin-top: 3px;">
  						</li>
  						
  						<%} else{%>
  						<li id="GroupLi"><a href="jsp/GroupUI.jsp?GroupID=<%=rs1.getString("GroupID")%>"><%=rs1.getString("GroupName")%></a> </li>
  						<%} %>
  						
  						<%} %>
  						
  					</ul>
  				</div>	
  			</div>		
  		
  		</div>

  		<div id="MainRight" class="right">
  		<div id="light1" class="white_content">
  						<form action="jsp/GroupAddPro.jsp" method="post">
  						<div id="newformhead"> 
  						<div id="left">新建分组
  						</div>
  						<div id="right">
  						<a href = "javascript:void(0)" onclick = "document.getElementById('light1').style.display='none';
						document.getElementById('fade1').style.display='none'"><img id="exitimg" src="./img/arrows_square_remove_24px_1182573_easyicon.net.png"></a>
  						</div>
  						</div>
  						<input id="newforminput" type="text"  name="GroupName" placeholder="请输入组名">
  						<input id="newformsubmit" type="submit" value="" style="width:20px;height:17px;background-image: url(./img/upload_26.189473684211px_1200703_easyicon.net.png);background-size:100% 100%;">
  						</form>
						</div>
						<div id="fade1" class="black_overlay">
					</div>
  		
  			<div id="MainRightTop">
  				<div class="right ContactSearchDiv">
  					<form action="jsp/ContactSearchUI.jsp">
  						<input type="text" name="search" style="width: 100px;height: 18px; border: 1px solid #DCE0E3;border-radius: 25px;"> 
  						<input type="submit" value="" style="width:20px;height:17px;background-image: url(./img/search_24px_517145_easyicon.net.png);background-size:100% 100%;ve">
  					</form>
  				</div>
  			</div>
  			
  			<div id="MainRightHeader">
  				<div class="left RHLDiv">
  					<ul id="RHLUl">
  						<%if(GroupID==null) {%>
  						<li class="left" id="RHLli"><a href="jsp/AdressMainUI.jsp">返回主页</a></li>
  						<%} else{ %>
  						
  						
  						
  						<li class="left" id="RHLli"><a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">修改分组</a></li>
  						<li>
  						<div id="light" class="white_content">
  						<form action="jsp/GroupEditPro.jsp?GroupID=<%=GroupID%>" method="post">
  						<div id="newformhead"> 
  						<div id="left">修改组名
  						</div>
  						<div id="right">
  						<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';
						document.getElementById('fade').style.display='none'"><img id="exitimg" src="./img/arrows_square_remove_24px_1182573_easyicon.net.png"></a>
  						</div>
  						</div>
  						<input id="newforminput" type="text" value=<%=GroupName %> name="editgroup">
  						<input id="newformsubmit" type="submit" value="" style="width:20px;height:17px;background-image: url(./img/upload_26.189473684211px_1200703_easyicon.net.png);background-size:100% 100%;">
  						</form>
						</div>
						<div id="fade" class="black_overlay"></div>
						</li>
  						<li class="left" id="RHLli"><a href="">删除此组</a></li>
  						<li class="left" id="RHLli"><a href="jsp/ContactsImportUI.jsp?GroupID=<%=GroupID%>">导入联系人</a></li>
  						<%} %>
  					</ul>
  				</div>
  			</div>
  			<form name="myForm" id="contactform" action="EditServlet?ContactID=<%=id %>" method="post" enctype="multipart/form-data" onsubmit="return checkForm();">
  			<div id="MainRightMain">
  					<div id="contactTop">
  						<div id="contactIcon" >
  						
  						<img id="IconImg" src="/imgUrl/<%=Icon%>">
  						</div>
  						<div id="contactName"><input id="inputName"  type="text" name="name" value=<%=name %>></div>
  					</div>
  					<div id="inputfileIcon">
  						<input type="file"  name="Icon" style="width:64px;height:22px;float:right;font-size: 12px;">
						</div>
  					<div id="contactMid">
  						<div id="contactMain">
  							<ul id="box">
  								<li id="left">手机号码</li>
  								<li id="right"><input id="input" type="text" name="tel" value=<%=tel %>><span id="tipun1" style="color:red"></span></li>
  							</ul>
  							<ul id="box">
  								<li id="left">电子邮箱</li>
  								<li id="right"><input id="input" type="email"  name="email" value=<%=email %>></li>
  							</ul>
  							<ul id="box">
  								<li id="left">工作单位</li>
  								<li id="right"><input id="input" type="text" name="work" value=<%=work %>></li>
  							</ul>
  							<ul id="box">
  								<li id="left">性别</li>
  								<li id="right">
  								<%if(sex.equals("female")) {%>
  								<select id="select" name="sex">
									<option value="female" selected="selected">女</option>
									<option value="male">男</option>
								</select>
								<% }else{%>
								<select id="select" name="sex">
									<option value="female" >女</option>
									<option value="male" selected="selected">男</option>
								</select>
								<%} %>
  								</li>
  							</ul>
  							<ul id="groupbox">
  								<li class="gp">分组</li>
  								<li id="right">
  								<%	for(i=0;i<lenth;i++){
	   		 	  				if (group[i].equals(Cgroup[j])) {
			   		 	  			out.print("<input type='checkbox' checked='1' class='input_group' id="+ i + " name='group' value="+ zz[i]+">");
									out.print("<label for="+ i +">"+group[i]+"</label>");
			   		 	  			j++; 
			   		 	  		} 
			   		 	  		else {
				   		 	  		out.print("<input type='checkbox'  class='input_group' id="+ i + " name='group' value="+ zz[i]+">");
									out.print("<label for="+ i +">"+group[i]+"</label>");
			   		 	  		} 
			   		 	  	}
						%>
  								
  								</li>
  							</ul>
  						</div>
  					</div>
  			</div>
  			
  			<div id="MainRightBottom">
  				<div id="bottombox">
	  				<input id="bottominput" type="submit" value=保存>
	  				<input id="bottominput" type="reset" value="重置"> 
  				</div>
  			</div>
  		</form>
  		
  		
  		</div>
  		
  		
  		
  	</div>
  </div>
  
  <div id="bottom">
  	<div class="container">
  		<p>这是你从未玩过的船新版本！ThePhoneBook 1.0.0正式发布</p>
  	</div>
  </div>
  
  
  
<script>
    window.onload = function () {
    	var jli = document.getElementById('OpenP');
        var CloseImg = document.getElementById("flowImg");
        var oDiv = document.getElementById('FlowContactDiv');
        oDiv.style.left = '246px';
        jli.onclick = function () {
            startMove(1);
        };
         jli.ondblclick = function () {
            startMove(0);
        };
        CloseImg.onclick = function () {
            startMove(0);
        }
    };
    var timer = null;
    function startMove(iTarget) {
        var oDiv = document.getElementById('FlowContactDiv');
        var speed = 2;
        var speeds = 20;
        
        clearInterval(timer);
        timer = setInterval(function () {
            if(iTarget){
                oDiv.style.left = parseFloat(oDiv.style.left) + speeds + 'px';
                if(parseFloat(oDiv.style.left) >= 270){
                    oDiv.style.display="inline";
                    speeds=2;
                    if(parseFloat(oDiv.style.left) > 410){
                    oDiv.style.left = '410px';
                    window.clearInterval(timer);
                }
                }
                
            }else {
                oDiv.style.left = parseFloat(oDiv.style.left) - speed + 'px';
                 if(parseFloat(oDiv.style.left) <= 280){
                	 oDiv.style.display="none";
                	 speed=500;
                	if(parseFloat(oDiv.style.left) <= 246){
                    oDiv.style.left = '246px';
                    window.clearInterval(timer);
                }
                }
            }
        }, 10);
    }
</script> 
 </body>
 
 
</html>

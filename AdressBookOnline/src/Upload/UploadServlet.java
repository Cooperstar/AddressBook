package Upload;

import java.sql.*;
import java.util.*;
import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String username = request.getParameter("username");
		String TEL = null;
		String Name = null;
		String Sex =null;
		String [] Group = new String[10];
		int G = 0;
		try {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart) {//判断前台的form是够有ismutipart属性
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
			Connection conn = DriverManager.getConnection(url,"cjw","19990117");
			Statement stm0 = conn.createStatement();
			String sql0 = "select * from [AddressBook].[dbo].[User] where UserName='"+username+"'";
			ResultSet rs0 = stm0.executeQuery(sql0);
			rs0.next(); 
			System.out.println("\n\naaaaaaa\n"+username);
			String UserID = rs0.getString("UserID");
			System.out.println("\n\nbbbb\n"+UserID);
			String sql = "insert into [AddressBook].[dbo].[Contact]([ContactUser],[ContactName],[ContactWork],[ContactTel],[ContactEmail],[sex],[ContactIcon]) values(?,?,?,?,?,?,?)";
			PreparedStatement pstm = conn.prepareStatement(sql);
			
			pstm.setString(1, UserID);
			
			
			/*String sql1 = "Insert into [AddressBook].[dbo].[Relate]([RContact],[RGroup]) values(?,?)";
			PreparedStatement pstm1 = conn.prepareStatement(sql1);
			int xxx = 1;*/
			
			
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			//解析
			List<FileItem> items = upload.parseRequest(request);
			
			//迭代器遍历
			Iterator<FileItem> iter = items.iterator();
			while(iter.hasNext()) {
				System.out.println("\n\naaaaaaa\n11111111111");
				FileItem item = iter.next();
				String itemName = item.getFieldName();	
				String[] zz = new String[10];
			if(item.isFormField()) {
				System.out.println("\n\naaaaaaa\n2222221");
				if( itemName.contentEquals("name")) {
					
					String name = null;
					name = item.getString("utf-8");
					System.out.println("\n\naaaaaaa\n13333"+name);
					Name = name;
					pstm.setString(2,name);
					
				}else if( itemName.contentEquals("work")) {
					
					String work = item.getString("utf-8");
					System.out.println("\n\naaaaaaa\n111144441"+work);
					pstm.setString(3,work);
					
				}else if( itemName.contentEquals("tel")) {
					System.out.println("\n\naaaaaaa\n111555511");
					String tel = item.getString("utf-8");
					TEL = tel;
					pstm.setString(4,tel);
					
				}else if( itemName.contentEquals("sex")) {
					System.out.println("\n\naaaaaaa\n11111666611");
					String sex = item.getString("utf-8");
					Sex = sex;
					pstm.setString(6,sex);
					System.out.println("\n\naaaaaaa\n11111666611"+sex+sex+"\n");
				}else if( itemName.contentEquals("email")) {
					System.out.println("\n\naaaaaaa\n1177711");
					String email = item.getString("utf-8");
					pstm.setString(5,email);
					
				}
				else {
					System.out.println("\n\naaaaaaa\n1117777111");
					System.out.print("其它字段....");
					String group = item.getString("utf-8");
					System.out.println("\n\n没问题！"+group);
					Group[G] = group;
					System.out.println("\n\n没问题1！"+Group[G]);
					G++;
				}
			}else {//Inco头像上传
				System.out.println("\n\naaaaaaa\n1118888811");
				//文件上传
				String fileName = item.getName();
				//获取内容并上传
				//指定路径
				
				String path = "D:\\cjw\\upload";
				File file = new File(path,fileName);
				
				item.write(file);//上传							
				pstm.setString(7,fileName);
			
				
				System.out.print(fileName+"成功上传！");}	
			
			}
			System.out.println(sql+"\n");
			pstm.executeUpdate();
			System.out.println("好了\n");
			String sql2 = "select ContactID from Contact where ContactName=? and ContactTel=? and sex=?";
			PreparedStatement pstm2 = conn.prepareStatement(sql2);
			pstm2.setString(1,Name);
			pstm2.setString(2,TEL);
			pstm2.setString(3,Sex);
			ResultSet rs2 = pstm2.executeQuery(); 
			rs2.next();
			String Cid = rs2.getString("ContactID");
			System.out.println("CID="+Cid);
			
			if(Group!=null){
				for(int i = 0;i<G;i++){
				System.out.println(Group[i]);
				System.out.println(G);
				Statement stm1 = conn.createStatement();
				String sql4 = "Insert into Relate(RContact,RGroup) values('"+Cid+"','"+Group[i]+"')";
				stm1.executeUpdate(sql4);
				}
			}
			
			response.sendRedirect("jsp/AdressMainUI.jsp");
			
			}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

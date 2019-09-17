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
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
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
		String id = request.getParameter("ContactID");
		System.out.println("\n"+id);
		String [] Group = new String[10];
		int G = 0;
		
		try {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart) {//判断前台的form是够有mutipart属性
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url = "jdbc:sqlserver://localhost:1433;databasename=AddressBook";
			Connection conn = DriverManager.getConnection(url,"cjw","19990117");
			
			String sql = "  UPDATE [AddressBook].[dbo].[Contact] SET [ContactName]=?,[ContactWork]=?,[ContactTel]=?,[ContactEmail]=?,[sex]=?,[ContactIcon]=? WHERE [ContactID]=?";
			PreparedStatement pstm = conn.prepareStatement(sql);
			
			pstm.setString(7, id);
			
			
			/*String sql1 = "Insert into [AddressBook].[dbo].[Relate]([RContact],[RGroup]) values(?,?)";
			PreparedStatement pstm1 = conn.prepareStatement(sql1);
			int xxx = 1;*/
			
			
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			//解析
			List<FileItem> items = upload.parseRequest(request);
			
			//遍历
			Iterator<FileItem> iter = items.iterator();
			while(iter.hasNext()) {
				System.out.println("\n\naaaaaaa\n11111111111");
				FileItem item = iter.next();
				String itemName = item.getFieldName();	
			if(item.isFormField()) {
				System.out.println("\n\naaaaaaa\n2222221");
				if( itemName.contentEquals("name")) {
					System.out.println("\n\naaaaaaa\n13333");
					String name = null;
					name = item.getString("utf-8");
					pstm.setString(1,name);
					
				}else if( itemName.contentEquals("work")) {
					System.out.println("\n\naaaaaaa\n111144441");
					String work = item.getString("utf-8");
					pstm.setString(2,work);
					
				}else if( itemName.contentEquals("tel")) {
					System.out.println("\n\naaaaaaa\n111555511");
					String tel = item.getString("utf-8");
					pstm.setString(3,tel);
					
				}else if( itemName.contentEquals("sex")) {
					System.out.println("\n\naaaaaaa\n11111666611");
					String sex = item.getString("utf-8");
					pstm.setString(5,sex);
					System.out.println("\n\naaaaaaa\n11111666611"+sex+sex+"\n");
				}else if( itemName.contentEquals("email")) {
					System.out.println("\n\naaaaaaa\n1177711");
					String email = item.getString("utf-8");
					pstm.setString(4,email);
					
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
				
				pstm.setString(6,fileName);
			
				
				System.out.print(fileName+"成功上传！");}
			
				
				/*String sql2 = "select ContactID from Contact where ContactUser=? and ContactTel=? and sex=?";
				PreparedStatement pstm2 = conn.prepareStatement(sql2);
				pstm2.setString(xxx,username);
				xxx++;
				List<FileItem> items1 = upload.parseRequest(request);
				if(item.isFormField()) {
					if( itemName.contentEquals("tel")) {
						String tel = item.getString("utf-8");
						pstm2.setString(sss,tel);
						xxx++;
					}else if( itemName.contentEquals("sex")) {
						String sex = item.getString("utf-8");
						pstm2.setString(sss,sex);
						xxx++;
					}else {
						System.out.print("其它字段....");
					}
				}
				ResultSet rs2 = pstm2.executeQuery(); 
				rs2.next();
				String Cid = rs2.getString("ContactID");
				
				
				String sql3 = "INSERT INTO [AddressBook].[dbo].[Relate]([RContact],[RGroup]) VALUES(?,?)";
				PreparedStatement pstm3 = conn.prepareStatement(sql3);
				int ccc = 1;
				pstm3.setString(ccc,);
				
				if(item.isFormField()) {
					if( itemName.contentEquals("group")) {
						String [] group = item.getContentType()("utf-8");
						String tel = item.getString("utf-8");
						pstm2.setString(sss,tel);
						xxx++;
					}else {
						System.out.print("其它字段....");
					}
				}*/
				
				
				
				
				
				
				
			
			}
			System.out.println(sql+"\n");
			pstm.executeUpdate();
			
			
			Statement stm6 = conn.createStatement();
			String sql6 = "delete from Relate where RContact='"+id+"'";
			stm6.executeUpdate(sql6);
			
			if(Group!=null){
				for(int i = 0;i<G;i++){
				System.out.println(Group[i]);
				System.out.println(G);
				Statement stm1 = conn.createStatement();
				String sql4 = "Insert into Relate(RContact,RGroup) values('"+id+"','"+Group[i]+"')";
				stm1.executeUpdate(sql4);
				}
			}
			response.sendRedirect("jsp/AdressMainUI.jsp？");
			
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

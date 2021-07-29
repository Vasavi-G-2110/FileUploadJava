package com.demo;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.opencsv.CSVReader;
import com.utils.DBConnect;

@MultipartConfig
public class UploadCSV extends HttpServlet {
    
	private static final String CONTENT_DISPOSITION_KEY = "content-disposition";
	private static final String FILE_NAME_KEY = "filename";
	private static final int BUFFER_SIZE = 2048;
    
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    		
		String dsname="";
		try {
    			
			//to get the content type information from JSP Request Header
            String contentType = req.getContentType();
            HttpSession session = req.getSession();
			int id =(int) session.getAttribute("userid");
			String role=(String) session.getAttribute("role");
			//String dsname=req.getParameter("dsname");
			String username=(String) session.getAttribute("username");
         
            //here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or equal to 0
            if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                DataInputStream in = new DataInputStream(req.getInputStream());
                //we are taking the length of Content type data
                int formDataLength = req.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                //this loop converting the uploaded file into byte code
                while (totalBytesRead < formDataLength) {
                    byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                    totalBytesRead += byteRead;
                    }

                String file = new String(dataBytes);

                //for saving the file name
                String saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));

                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1,contentType.length());
                int pos,pos1;
    
                //extracting the index of file 
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                
                

                pos1 = file.indexOf("name=\"");
                pos1 = file.indexOf("\n", pos1) + 1;
                pos1 = file.indexOf("\n", pos1) + 1;
                dsname=file.substring(pos1,pos1+9);
                dsname=dsname.replace("\n", "").replace("\r", "").replace("-", "");
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
               System.out.println(saveFile);
                if(saveFile.endsWith(".txt") || saveFile.endsWith(".csv")){
                    // creating a new file with the same name and writing the content in new file
                    FileOutputStream fileOut = new FileOutputStream(new File("E:\\zoho_Book\\uploads\\"+String.valueOf(id)+dsname+saveFile));
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();
                    //System.out.println(saveFile);
                   
                }else{
                    req.setAttribute("error", "Unsupported file format");
                } 
                
			
			
			Connection conn = DBConnect.getConnection();
			Statement stmt=conn.createStatement();
			String sql = "INSERT INTO UserData (userid, dataname, country, companies)" + "VALUES (?, ?, ?, ?)";

			LocalDateTime myDateObj = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd yyyy");
			String currdate=myDateObj.format(formatter);
			//System.out.println("Curr Date : " + currdate);
			String csvFile = "E:\\zoho_Book\\uploads\\"+String.valueOf(id)+dsname+saveFile;
			System.out.println(csvFile);
			CSVReader reader = null;
			PreparedStatement ps = conn.prepareStatement(sql);

			
			// parsing a CSV file into CSVReader class constructor
			reader = new CSVReader(new FileReader(csvFile));
			String[] nextLine;
			// reads one line at a time
			

			int i;
			List<String> colList = new ArrayList<>();
			// for column
			while ((nextLine = reader.readNext()) != null) {

				//ps.setString(i, id);
				for (String token : nextLine) {
					colList.add(token);

				}
				break;
			}
			alterTable(colList);
			
			int j=1;
			while ((nextLine = reader.readNext()) != null) {
				i=0;
				String insertstr="Insert into UserData (userid,dataname,addedon,";
				String valuestr=" values ("+id+",'"+dsname+"','"+currdate+"','";
				for (String token : nextLine) {
					
						insertstr=insertstr+colList.get(i)+",";
						valuestr=valuestr+token+"','";
						i+=1;
					
				}
				
				insertstr=insertstr.substring(0, insertstr.length() - 1)+")"; 
				valuestr=valuestr.substring(0, valuestr.length() - 2)+")"; 
				System.out.println(insertstr+valuestr);
				sql=insertstr+valuestr;
				stmt.executeUpdate(sql);
				
				
				j+=1;
			}
			updateTable(id,currdate);
			addDataSummary(id, currdate, role, dsname,username);
			resp.sendRedirect("AddData.jsp");
			conn.close();
			ps.close();
		}
		}catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void alterTable(List<String> col) throws ClassNotFoundException, SQLException {
		Connection conn = DBConnect.getConnection();
		Statement stmt = conn.createStatement();
		DatabaseMetaData md = conn.getMetaData();
		
		for (String li : col) {
			ResultSet rs = md.getColumns(null, null, "UserData", li);
			if (rs.next()) {
				continue;
			
			}
			String sql = "ALTER TABLE UserData " + "ADD COLUMN " + li + " VARCHAR(30)";

			stmt.execute(sql);

		}

	}

	
	
	
	public void updateTable(int id,String currdate) throws ClassNotFoundException, SQLException {
		Connection conn = DBConnect.getConnection();
		int totcount=0;
		Statement stmt=conn.createStatement();
		String sql="select * from Users where userid = "+id+";";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			totcount=rs.getInt("totaldatasources");
		}
		String sql1="update Users set totaldatasources = "+(totcount+1)+",lastadded = '"+currdate+"' where userid = "+id+";"; 
		System.out.println(sql1);
		stmt.executeUpdate(sql1);
	}
	
	public void addDataSummary(int id,String currdate,String role,String dsname,String username) throws ClassNotFoundException, SQLException {
		Connection conn = DBConnect.getConnection();
		Statement stmt=conn.createStatement();
		String sql;
		if(role.equals("Admin")) {
			sql="Insert into DataSummary values("+id+",'"+dsname+"','"+currdate+"','"+role+"',0,'"+username+"');";
		}
		else {
			sql="Insert into DataSummary values("+id+",'"+dsname+"','"+currdate+"','"+role+"',1,'"+username+"');";
		}
		stmt.executeUpdate(sql);
		
		
	}
	private String getFileName(Part part) {
		for (String contentDisposition : part.getHeader(CONTENT_DISPOSITION_KEY).split(";")) {
			if (contentDisposition.trim().startsWith(FILE_NAME_KEY)) {
				return contentDisposition.substring(contentDisposition.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

	private String getTextFromPart(Part part, int id) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
		StringBuilder value = new StringBuilder();
		char[] buffer = new char[BUFFER_SIZE];
		for (int length = 0; (length = reader.read(buffer)) > 0;) {
			value.append(buffer, 0, length);

		}
		return value.toString();
	}
		
}

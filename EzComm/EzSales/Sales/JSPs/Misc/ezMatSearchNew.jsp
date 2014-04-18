<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Statement,java.sql.Connection,java.sql.DriverManager,java.sql.ResultSet,java.sql.SQLException" %>
<%@page import="java.util.*"%>

 <% 
	try{      
		 String s[]=null;
		 
		 String url 	= "jdbc:sqlserver://localhost:1433;DatabaseName=ezamstandev;SelectMethod=cursor";	
		 
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 

        	Connection con =DriverManager.getConnection(url,"ezamstandev", "ezamstandev");
		Statement st=con.createStatement(); 
		ResultSet rs = st.executeQuery("select * from ezc_products");
		
	    	List li = new ArrayList();
	    
			while(rs.next()) 
 			{ 			    
 			    li.add(rs.getString(1));
 			}  
			
			String[] str = new String[li.size()];			
			Iterator it = li.iterator();
			
			int i = 0;
			while(it.hasNext())
			{
				String p = (String)it.next();	
				str[i] = p;
				i++;
			}
		
			//jQuery related start		
			String query = (String)request.getParameter("q");

			int cnt=1;
			for(int j=0;j<str.length;j++)
			{
				if(str[j].toUpperCase().startsWith(query.toUpperCase()))
				{
					out.print(str[j]+"\n");
					if(cnt>=15)
						break;
					cnt++;
				}
			}
			//jQuery related end	
		
			
 		rs.close(); 
 		st.close(); 
		con.close();

		    } 
		catch(Exception e)
		{ 
 			e.printStackTrace(); 
 		}


 %>
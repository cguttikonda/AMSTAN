<%@page import="java.sql.*" %>
<%

		Connection con = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement prepareStmt = null;
		ResultSet rs = null;
		int PRItemCnt  = 0;
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con 	= DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezlife;SelectMethod=cursor", "ezlife1", "ezlife1");
			stmt 	= con.createStatement();
			ezc.ezcommon.EzLog4j.log(":::ResultSet:ezListOfVendors::","I");
			String queryStr = "SELECT * FROM EZC_VENDOR_REG_DETAILS";
			rs = stmt.executeQuery(queryStr);
			
			ezc.ezcommon.EzLog4j.log(queryStr+":::ResultSet after:ezListOfVendors::"+rs.getRow(),"I");
			
			while(rs.next())
			{
				ezc.ezcommon.EzLog4j.log(":::ResultSet::list of vendor:","I");
							
			}
			out.println("rs.getRow()=="+rs.getRow());
			if(rs.getRow()>0)
			{
			
			
		%>
			<Table  id="tabHead"  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			  <Tr align="center" valign="middle">
			 	 
     				<Th width="25%"> Number</Th>
    				<Th width="20%"> Created By</Th>
    				<Th width="20%"> Created Date</Th>
				<Th width="25%"> Status</Th>
			</Tr>
			
<%				while(rs.next())
				{
				String link = "ezVendorDetails.jsp?id="+rs.getInt(1);

%>				<TR>
				<td><a href="<%=link%>"><%=rs.getInt(1)%></</td>
				<td><%=rs.getInt(1)%></td>
				<td><%=rs.getInt(1)%></td>
				<td><%=rs.getInt(1)%></td>
				</Tr>
<%				}
%>
				
			</Tr>
			</Table>

<%			}
			else
			{
			
				out.println("<center><table>NO Vendors to the list </table></center>");
			}
		}	
		catch(Exception e)
		{
			System.out.println("Exception Occured While Inserting vendor details "+e);
		}
		finally
		{
		
			if(con!=null)	
			con.close();
			if(prepareStmt!=null)
			prepareStmt.close();
		}		
		
%>
			
			
	
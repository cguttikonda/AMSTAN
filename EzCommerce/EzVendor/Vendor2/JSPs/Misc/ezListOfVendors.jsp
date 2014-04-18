<%@page import="java.sql.*" %>
<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Html>
<Head>
<Script>
	var tabHeadWidth = 98;
	var tabHeight="65%";
</Script>
</Head>
<Body>

<%	
	String display_header = "List Of Vendors To Be Approved";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%

		String statusFlag = request.getParameter("statusFlag");
		//out.println("statusFlag=="+statusFlag);
		String selectedStatus = "";
		if("SUBMITTED".equals(statusFlag))
			selectedStatus = "SUBMITTED";//Submitted by vendor
		else if("APPROVED".equals(statusFlag))
			selectedStatus = "APPROVED";
		//out.println("selectedStatus=="+selectedStatus);	
		ReturnObjFromRetrieve reportRet = new ReturnObjFromRetrieve(new String[]{"VENDID","CREATED_ON","STATUS"});
		String statusStr = "",submittedBy = "";
		
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
			ezc.ezcommon.EzLog4j.log(":::ResultSet:ezListOfVendors::"+selectedStatus,"I");
			
			rs = stmt.executeQuery("SELECT EVRD_ID,EVRD_CREATED_ON,EVRD_STATUS,EVRD_EXT1 FROM EZC_VENDOR_REG_DETAILS WHERE EVRD_STATUS='"+selectedStatus+"' ORDER BY EVRD_ID DESC");
			ezc.ezcommon.EzLog4j.log(":::ResultSet after:ezListOfVendors::"+rs.getRow(),"I");
			ezc.ezcommon.EzLog4j.log("SELECT EVRD_ID,EVRD_CREATED_ON,EVRD_STATUS,EVRD_EXT1 FROM EZC_VENDOR_REG_DETAILS WHERE EVRD_STATUS='"+selectedStatus+"'","I");
			
			
			
		%>
			<br>
			<Table  id="tabHead"  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr align="center" valign="middle">
			 	 
     				<Th width="10%"> Vendor Id</Th>
    				<Th width="10%" align="center"> Created Date</Th>
				<Th width="10%"> Status</Th>
				<Th width="15%"> Action Taken By</Th>
			</Tr>
			
<%				while(rs.next()) 
				{
					String link = "ezvendordisplay.jsp?id="+rs.getInt("EVRD_ID");
					
					
					if("SUBMITTED".equals(rs.getString("EVRD_STATUS"))) statusStr = "Submitted";
					else if ("APPROVED".equals(rs.getString("EVRD_STATUS"))) statusStr = "Approved";
					
					if("VEN".equals(rs.getString("EVRD_EXT1"))) submittedBy = "Vendor";
					else if ("PP".equals(rs.getString("EVRD_EXT1"))) submittedBy = "PURPERSON";
					else if ("PH".equals(rs.getString("EVRD_EXT1"))) submittedBy = "PURHEAD";
%>					
					<Tr>
						<td><a href="<%=link%>"><%=rs.getInt("EVRD_ID")%></</td>   
						<td><%=rs.getString("EVRD_CREATED_ON")%>&nbsp;</td>
						<td align=center><%=statusStr%>&nbsp;</td>
						<td align=center><%=submittedBy%>&nbsp;</td>
					</Tr>
				
<%				

}
%>
				
			</Tr>
			</Table>

<%			
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
			
<Div id="MenuSol"></Div>			
</Body>
</Html>
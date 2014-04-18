<%@page import="java.sql.*" %>
<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Html>
<Head>
<Script>
	var tabHeadWidth = 98;
	var tabHeight="65%";
	
	function Reject()
	{
		document.myForm.action = "ezListOfVendors.jsp";
		document.myForm.submit();
	}
</Script>
</Head>
<Body>

<%	
	String display_header = "List Of Vendors To Be Approved";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%

		int vendId = Integer.parseInt((request.getParameter("vendId")));
		ezc.ezcommon.EzLog4j.log(":::vendId:ezApproveRejectVendors::"+vendId,"I");
		String statusFlag = request.getParameter("statusFlag");
		String selectedStatus = "";
		if("SUBMITTED".equals(statusFlag))
			selectedStatus = "SUBMITTED";//Submitted by vendor
		else if("APPROVED".equals(statusFlag))
			selectedStatus = "APPROVED";
		ReturnObjFromRetrieve reportRet = new ReturnObjFromRetrieve(new String[]{"VENDID","CREATED_ON","STATUS"});
		String statusStr = "",submittedBy = "";
		
		Connection con = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement prepareStmt = null;
		ResultSet rs = null;
		String qry = "";
		int PRItemCnt  = 0;
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con 	= DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezlife;SelectMethod=cursor", "ezlife1", "ezlife1");
			stmt 	= con.createStatement();
			ezc.ezcommon.EzLog4j.log(":::ResultSet:ezListOfVendors::"+selectedStatus,"I");
			
			qry = "UPDATE EZC_VENDOR_REG_DETAILS SET EVRD_STATUS='APPROVED' AND EVRD_EXT1='PP' WHERE EVRD_ID="+vendId;
			ezc.ezcommon.EzLog4j.log(":::qryr:ezApproveRejectVendors::"+qry,"I");
			stmt.executeUpdate(qry);
			
				
%>
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
		
		
		<br>
		<Table  id="tabHead"  width="50%" align=center border=1 borderColorDark="#ffffff" borderColorLight="#006666" cellPadding=2 cellSpacing=0 >
		<Tr align="center" valign="middle">

			<Td>Vendor Approved</Td>


		</Tr>
		</Table>

<%
		buttonName.add("OK");
		buttonMethod.add("funOk()");
%>		

			
<Div id="MenuSol"></Div>			
</Body>
</Html>
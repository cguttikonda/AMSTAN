<%@page import="java.sql.*" %>
<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%//@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<html>
<head>
<script>
function viewAttachments()
{
	var pathName=document.myForm.pathName.value;
	newWindow = window.open("ezViewAttachments.jsp?pathName="+pathName,"MyWindow","center=yes,height=450,left=100,top=50,width=550,titlebar=no,status=no,resizable,scrollbars")
}
</script>
</head>
<body>
<form name="myForm">
<%

		
		String statusStr = "";
		
		Connection con = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement prepareStmt = null;
		ResultSet rs = null;
		int PRItemCnt  = 0;
		int id = 0;
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con 	= DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezlife;SelectMethod=cursor", "ezlife1", "ezlife1");
			stmt 	= con.createStatement();
			id 	= Integer.parseInt(request.getParameter("id"));
			
			rs = stmt.executeQuery("SELECT * FROM EZC_VENDOR_REG_DETAILS WHERE EVRD_ID="+id);
			
			
			
		%>
			<Table  id="tabHead"  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			  <Tr align="center" valign="middle">
			 	 
     				
    				
				
			</Tr>
			
<%				while(rs.next()) 
				{
				String link = "ezvendordisplay.jsp?id="+rs.getInt("EVRD_ID");
				

%>				<Tr><Th>Number<Th><%=rs.getInt("EVRD_ID")%>
					<input type="hidden" name="pathName" value="<%=rs.getInt("EVRD_ID")%>"> </td></Tr>   
				<Tr><Th>Name<Th><%=rs.getString("EVRD_NAME")%>&nbsp;</td></Tr>
				<Tr><Th>Street/House No:<Th><%=rs.getString("EVRD_HOUSE_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Postal Code:<Th><%=rs.getString("EVRD_POSTAL_CODE")%>&nbsp;</td></Tr>
				<Tr><Th>Country<Th><%=rs.getString("EVRD_ADDRESS_COUNTRY")%>&nbsp;</td></Tr>
				<Tr><Th>Region<Th><%=rs.getString("EVRD_REGION")%>&nbsp;</td></Tr>
				<Tr><Th>Telephone No:<Th><%=rs.getString("EVRD_TEL_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Mobile No:<Th><%=rs.getString("EVRD_MOBILE_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Fax<Th><%=rs.getString("EVRD_FAX")%>&nbsp;</td></Tr>
				<Tr><Th>E-mail<Th><%=rs.getString("EVRD_EMAIL")%>&nbsp;</td></Tr>
				<Tr><Th>Excise No:<Th><%=rs.getString("EVRD_ECC_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Excise Reg No:<Th><%=rs.getString("EVRD_EXCISE_REG_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Excise Range:<Th><%=rs.getString("EVRD_EXCISE_RANGE")%>&nbsp;</td></Tr>
				<Tr><Th>Excise Division :<Th><%=rs.getString("EVRD_EXCISE_DIV")%>&nbsp;</td></Tr>
				<Tr><Th>PAN No:<Th><%=rs.getString("EVRD_PAN_NO")%>&nbsp;</td></Tr>
				<Tr><Th>VAT Reg No:<Th><%=rs.getString("EVRD_VAT_REG_NO")%>&nbsp;</td></Tr>
				<Tr><Th>Country<Th><%=rs.getString("EVRD_BANK_COUNTRY")%>&nbsp;</td></Tr>
				<Tr><Th>Bank Key<Th><%=rs.getString("EVRD_BANK_KEY")%>&nbsp;</td></Tr>
				<Tr><Th>Bank Account<Th><%=rs.getString("EVRD_BANK_ACCOUNT_NO")%>&nbsp;</td></Tr>
				<Tr><Th>A/C holder<Th><%=rs.getString("EVRD_ACCOUNT_HOLDER")%>&nbsp;</td></Tr>
				<Tr><Th>First Name:<Th><%=rs.getString("EVRD_FIRST_NAME")%>&nbsp;</td></Tr>
				<Tr><Th>Last Name:<Th><%=rs.getString("EVRD_SECOND_NAME")%>&nbsp;</td></Tr>
				<Tr><Th>Telephone No:<Th><%=rs.getString("EVRD_PERSONAL_TEL_NO")%>&nbsp;</td></Tr>
		<!--		<Tr><Th><Th><%=rs.getString("EVRD_STATUS")%>&nbsp;</td></Tr>
				<Tr><Th><Th><%=rs.getString("EVRD_CREATED_ON")%>&nbsp;</td></Tr>
				<Tr><Th><Th><%=rs.getString("EVRD_MODIFED_ON")%>&nbsp;</td></Tr>
				<Tr><Th><Th><%=rs.getString("EVRD_MODIFED_BY")%>&nbsp;</td></Tr>
				
		-->				
				
				
				</Tr>
				
<%				

}
%>
				
			</Tr>
			</Table>
			<center>
			<input type="button" value="View Attachments" onClick="viewAttachments()">
			</center>

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
			
			
</form>
</body>	
</html>
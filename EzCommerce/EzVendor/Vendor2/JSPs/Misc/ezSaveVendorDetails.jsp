<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*,java.io.File,java.io.IOException,java.util.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>


<%@page import="java.sql.*" %>
<%

String 	name	=request.getParameter("name");
String 	shno	=request.getParameter("shno");
String 	pcode	=request.getParameter("pcode");
String 	country	=request.getParameter("country");
String 	region 	=request.getParameter("region");
String 	teleno	=request.getParameter("teleno");
String 	mobno	=request.getParameter("mobno");
String 	fax	=request.getParameter("fax");
String 	email	=request.getParameter("email");
String 	exciseno	=request.getParameter("exciseno");
String 	exciseregno	=request.getParameter("exciseregno");
String 	exciserange	=request.getParameter("exciserange");
String 	excisediv	=request.getParameter("excisediv");
String 	PANno	=request.getParameter("PANno");
String 	VATRno	=request.getParameter("VATRno");
String 	bcountry	=request.getParameter("bcountry");
String 	bankkey	=request.getParameter("bankkey");
String 	baccount	=request.getParameter("baccount");
String 	acholder	=request.getParameter("acholder");
String 	firstname	=request.getParameter("firstname");
String 	lastname	=request.getParameter("lastname");
String 	perteleno		=request.getParameter("tele");

int maxVendId = 0;
String dummyLoginUser	= "ezcadmin";
String dummyLoginPasswd	= "myindia";
String dummyLoginSite	= "200";

ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();

logs.setUserId(dummyLoginUser);
logs.setPassWd(dummyLoginPasswd);
logs.setConnGroup(dummyLoginSite);

ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);

ezc.ezcommon.EzLog4j.log(":::LogonStatus:::"+LogonStatus.IsSuccess(),"I");	
if(LogonStatus.IsSuccess())
{
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
			
			rs = stmt.executeQuery("SELECT MAX(EVRD_ID) FROM EZC_VENDOR_REG_DETAILS");
			ezc.ezcommon.EzLog4j.log(":::ResultSet:::"+rs,"I");
			
			while(rs.next())
			{
				ezc.ezcommon.EzLog4j.log(":::ResultSet:::"+rs.getInt(1),"I");
				maxVendId = rs.getInt(1);
				
			}
			if(maxVendId<=0)
			{
				maxVendId = 1000;
			}
			else
			{
				ezc.ezcommon.EzLog4j.log(":::ResultSet::in while:"+maxVendId,"I");
				maxVendId = maxVendId+1;
			}
			ezc.ezcommon.EzLog4j.log(":::ResultSet:::"+maxVendId,"I");
			
			//String querytStr = "INSERT INTO EZC_VENDOR_REG_DETAILS VALUES('"+maxVendId+"','"+shno+"','"+pcode+"','"+country+"','"+region+"','"+teleno+"','"+mobno+"','"+fax+"','"+email+"','"+exciseno+"','"+exciseregno+"','"+exciserange+"','"+excisediv+"','"+PANno+"','"+VATRno+"','"+bcountry+"','"+bankkey+"','"+baccount+"','"+acholder+"','"+firstname+"','"+lastname+"','"+perteleno+"','SUBMITTED','',getdate(),getdate(),'','VEN','','')";
			String querytStr = "INSERT INTO EZC_VENDOR_REG_DETAILS VALUES('"+maxVendId+"','"+name+"','"+shno+"','"+pcode+"','"+country+"','"+region+"','"+teleno+"','"+mobno+"','"+fax+"','"+email+"','"+exciseno+"','"+exciseregno+"','"+exciserange+"','"+excisediv+"','"+PANno+"','"+VATRno+"','"+bcountry+"','"+bankkey+"','"+baccount+"','"+acholder+"','"+firstname+"','"+lastname+"','"+perteleno+"','SUBMITTED',getdate(),getdate(),'','VEN','','')";
			ezc.ezcommon.EzLog4j.log(querytStr+":::QUERY:::","I");
			stmt.executeUpdate(querytStr);
			
			con.commit();

			
			ezc.ezcommon.EzLog4j.log(querytStr+":::Rows Inserted:::","I");

		
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured While Inserting vendor details "+e);
		}
		finally
		{
		
			if(con!=null)	
			con.close();
			if(stmt!=null)
			stmt.close();
		}
	
}

%>
<%@ include file="../Misc/ezSave.jsp" %>   

<br><br><br><br><br><br><br>
<table align="center">
	<tr><td><font color='red'>Registration completed Successfully</font></td></tr>
	<tr><td><font color='red'>Your reference vendor Id is : </font><font color='blue'><%=maxVendId%></font></td></tr>
	<tr><td align="center"><input type="button" value="close" onClick="window.close();"></td></tr>
</table>
 
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String attCode[]	= request.getParameterValues("attrCodes");
	String attDesc[]	= request.getParameterValues("attrDesc");
	String attValue[]	= request.getParameterValues("attrValue");
	String proCode		= request.getParameter("productCode");
		
	out.print("****"+attCode.length);
	
	/*boolean exeSuc = true;
	String ConnGroup = (String)session.getValue("Site");
	Connection con = null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con = DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
	java.sql.Statement stmt= null;
	try {
		con.setAutoCommit(false);
		stmt= con.createStatement();
		stmt.addBatch("DELETE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE = '"+proCode+"'");
		for(int k=0;k<attCode.length;k++)
		{
			stmt.addBatch("INSERT INTO EZC_PRODUCT_ATTRIBUTES(EPA_ATTR_CODE,EPA_ATTR_VALUE,EPA_PRODUCT_CODE,EPA_SYS_KEY) VALUES('"+attCode[k]+"','"+attValue[k]+"','"+proCode+"','999101') ");
		}
		int[] updCnt = stmt.executeBatch();
		con.commit();
	} 
	catch (java.sql.BatchUpdateException be)
	{
		int[] counts = be.getUpdateCounts();
		for (int i=0; i<counts.length; i++) {
				ezc.ezcommon.EzLog4j.log("Statement["+i+"] :"+counts[i],"D");
		}
		con.rollback();
		exeSuc = false;
	}
	catch (java.sql.SQLException e) 
	{
			//handle SQL exception
			con.rollback();
			exeSuc = false;
			ezc.ezcommon.EzLog4j.log("handle SQL exception::::::::::::"+e,"I");
	}
	finally
	{
		if(stmt!=null)
		{
			stmt.close();
			con.close();
		}
		response.sendRedirect("ezProductAttributes.jsp");
	}*/
	
%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreasByDefaults.jsp"%>

<%@ page import="java.sql.*" %>
<%
	java.util.TreeMap myDefHash = new java.util.TreeMap();
	Connection con=null;
	ResultSet rs=null;
	String ConnGroup = (String)session.getValue("ConnGroup");
	try
	{
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
		con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

		Statement stmt=con.createStatement();
		String sqlStmt="SELECT DISTINCT(EUDD_KEY) DEFKEY,EUDD_DEFAULTS_DESC DEFDESC FROM EZC_DEFAULTS_DESC,EZC_SYSTEM_TYPE_DEFAULTS WHERE EUDD_KEY = ESTD_DEFAULT_KEY AND ESTD_SUPP_CUST_FLAG = 'V'";
		rs=stmt.executeQuery(sqlStmt);

		if(rs != null)
		{
			while(rs.next())
			{
				myDefHash.put(rs.getString("DEFKEY"),rs.getString("DEFDESC"));
			}
			rs.close();
		}
		stmt.close();
		con.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	java.util.Set mySet = myDefHash.keySet();
	java.util.Iterator myItr = mySet.iterator();
	while(myItr.hasNext())
	{
		out.println(myDefHash.get((String)myItr.next()));
	}
	
%>
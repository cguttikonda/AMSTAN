<%@ page import = "java.sql.*" %>

<%
	String ConnGroup = (String)session.getValue("Site");
	Connection con=null;
	java.sql.Statement st = null;
	ResultSet rs = null;
	
	String userId=request.getParameter("UserID");
	String status=request.getParameter("Status");
			ezc.ezcommon.EzLog4j.log(":::userId::::"+"UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+status+"' WHERE EUD_USER_ID='"+userId+"' AND EUD_KEY='STATUS'","I"); 

	if(userId!=null)
		userId = userId.trim();
	
	try
	{
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
		con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
		
		st=con.createStatement();
		
		ezc.ezcommon.EzLog4j.log(":::userStatusUpdate::::"+"UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+status+"' WHERE EUD_USER_ID='"+userId+"' AND EUD_KEY='STATUS'","I"); 
		int updateCount = st.executeUpdate("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+status+"' WHERE EUD_USER_ID='"+userId+"' AND EUD_KEY='STATUS'");
		ezc.ezcommon.EzLog4j.log(":::updateCount::::"+updateCount,"I"); 
	}catch(Exception e)
	{
	}
	finally
	{
		if(st!=null)
			st.close();
		if(rs!=null)
			rs.close();
		if(con!=null)
			con.close();
	}
	out.print(status);
%>	
	
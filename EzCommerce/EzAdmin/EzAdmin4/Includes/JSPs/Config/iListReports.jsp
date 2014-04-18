 <%@ page import = "java.util.*,java.sql.*" %>
  <%@ page import = "ezc.ezparam.*" %>



<%

	ReturnObjFromRetrieve listRet = new ReturnObjFromRetrieve(new String[]{"EARH_REPORT_ID","EARH_REPORT_DESC","EARH_REPORT_TYPE","EARH_BUSINESS_AREA"
	,"EARH_ASSIGN_TO","EARH_AUTH_KEY","EARH_X_AXIS","EARH_X_AXIS_DESC","EARH_Y_AXIS","EARH_Y_AXIS_DESC","EARH_PROD_GROUP","EARH_STATE","EARH_QUERY_NAME","EARH_QUERY_TEXT","EARH_DEFAULT_GRAPH","EARH_GADGET_DESC"});	


 	Connection con = null;	
 	java.sql.Statement stmt=null;
 	ResultSet rs=null;
 	String click="";
 	
 
 	try
 	{
 		 click="SELECT * FROM EZC_ANALYTICAL_REPORT_HEADER";
 
 		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
 		con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");
 
 		stmt = con.createStatement();
 		rs=stmt.executeQuery(click);
 		
 		while (rs.next()) {
		
			listRet.setFieldValue("EARH_REPORT_ID",rs.getString("EARH_REPORT_ID"));
			listRet.setFieldValue("EARH_REPORT_DESC",rs.getString("EARH_REPORT_DESC"));
			listRet.setFieldValue("EARH_REPORT_TYPE",rs.getString("EARH_REPORT_TYPE"));
			listRet.setFieldValue("EARH_BUSINESS_AREA",rs.getString("EARH_BUSINESS_AREA"));
			listRet.setFieldValue("EARH_ASSIGN_TO",rs.getString("EARH_ASSIGN_TO"));
			listRet.setFieldValue("EARH_AUTH_KEY",rs.getString("EARH_AUTH_KEY"));
			listRet.setFieldValue("EARH_X_AXIS",rs.getString("EARH_X_AXIS"));
			listRet.setFieldValue("EARH_X_AXIS_DESC",rs.getString("EARH_X_AXIS_DESC"));
			listRet.setFieldValue("EARH_Y_AXIS",rs.getString("EARH_Y_AXIS"));
			listRet.setFieldValue("EARH_Y_AXIS_DESC",rs.getString("EARH_Y_AXIS_DESC"));
			listRet.setFieldValue("EARH_PROD_GROUP",rs.getString("EARH_PROD_GROUP"));
			listRet.setFieldValue("EARH_STATE",rs.getString("EARH_STATE"));
			listRet.setFieldValue("EARH_QUERY_NAME",rs.getString("EARH_QUERY_NAME"));
			listRet.setFieldValue("EARH_QUERY_TEXT",rs.getString("EARH_QUERY_TEXT"));
			listRet.setFieldValue("EARH_DEFAULT_GRAPH",rs.getString("EARH_DEFAULT_GRAPH"));
			listRet.setFieldValue("EARH_GADGET_DESC",rs.getString("EARH_GADGET_DESC"));
			listRet.addRow();
                }
 		
 		
 		
 	}
 	catch(Exception e) 
 	{
 		
 		e.printStackTrace();
 	}
 	finally
 	{
 		stmt.close();
 		con.close();
 		rs.close();
 	}
 	
 	//out.println("listRet"+listRet.toEzcString());
 	
%>
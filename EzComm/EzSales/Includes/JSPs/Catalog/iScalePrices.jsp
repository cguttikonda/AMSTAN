<%@ page import="java.sql.CallableStatement,java.sql.Connection,java.sql.DriverManager,java.sql.ResultSet,java.sql.SQLException" %>
<%@ page import="ezc.ezparam.*" %>

<%
	
	ReturnObjFromRetrieve CustPriceGrpRetObj   = null;
	String sesAgentCode=(String)session.getValue("AgentCode");
	String sesShipCode=(String)session.getValue("ShipCode");
	String sesSalesArea=(String)session.getValue("SalesAreaCode");
	
	/*out.println("sesAgentCode"+sesAgentCode);
	out.println("sesShipCode"+sesShipCode);
	out.println("sesSalesArea"+sesSalesArea);*/

	EzcParams prodParamsMiscPRI = new EzcParams(false);
	EziMiscParams prodParamsPRI = new EziMiscParams();	

	prodParamsPRI.setIdenKey("MISC_SELECT");
	String queryPRI="SELECT EC_ERP_CUST_NO,EC_PARTNER_NO,ECA_EXT1 CUSTGROUP,EC_SYS_KEY FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR  WHERE ECA_NO=EC_NO AND  EC_ERP_CUST_NO ='"+sesAgentCode+"' AND EC_PARTNER_NO='"+sesShipCode+"' AND EC_SYS_KEY='"+sesSalesArea+"'";
	//out.println(queryPRI);
	prodParamsPRI.setQuery(queryPRI);
	prodParamsMiscPRI.setLocalStore("Y");
	prodParamsMiscPRI.setObject(prodParamsPRI);
	Session.prepareParams(prodParamsMiscPRI);	
								
	try { 
		CustPriceGrpRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscPRI);
	}	
	catch(Exception e){}
	String custGroup="";			
	if(CustPriceGrpRetObj!=null && CustPriceGrpRetObj.getRowCount()>0)
	{		
		custGroup=CustPriceGrpRetObj.getFieldValueString(0,"CUSTGROUP");
	}
	//out.println("CustPriceGrpRetObj:::"+CustPriceGrpRetObj.toEzcString());
	//out.println("custGroup:::"+custGroup);
	if(custGroup==null || "null".equals(custGroup))
		custGroup="";
			
	String url 	= "jdbc:sqlserver://localhost:1433;DatabaseName=ezamstandev;SelectMethod=cursor";	

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
	Connection conn=null;
	
	try
	{
		conn = DriverManager.getConnection(url, "ezamstandev", "ezamstandev");
	}
	catch (Exception e1) { e1.printStackTrace();}	

	String scalePriceProc = "{ call GetBestPriceAndScales(?, ?, ?, ?, ?) }";

	CallableStatement cs =null;
	ResultSet rs=null;
	
	String scaleColRRet[]={"PRODUCT","CUSTOMER","CUSTGRP","SCALE","SCALEUOM","CONDVAL","PRODLINE","SHORTDESC","LONGDESC"};
	ReturnObjFromRetrieve scaleResultRet = new ReturnObjFromRetrieve(scaleColRRet);	
	
	
	try
	{
		sesAgentCode = (Long.parseLong(sesAgentCode))+"";
	}
	catch(Exception e)
	{
		sesAgentCode = sesAgentCode;
	}
	//out.println("custGroup::::custGroup    "+custGroup+"   custGroup::::custGroup");
	try 
        {
		cs = conn.prepareCall(scalePriceProc);

		cs.setString(1,prodCode);//2391202.011
		cs.setString(2,sesAgentCode);
		cs.setString(3,custGroup); //A1
		cs.setString(4,"NULL");
		cs.setDate(5,java.sql.Date.valueOf("2012-10-17"));
		rs = cs.executeQuery();
						
		if (rs != null ) 
		{
			while (rs.next())
			{
				scaleResultRet.setFieldValue("PRODUCT",rs.getString(1));
				scaleResultRet.setFieldValue("CUSTOMER",rs.getString(2));
				scaleResultRet.setFieldValue("CUSTGRP",rs.getString(3));
				scaleResultRet.setFieldValue("SCALE",rs.getString(4));												
				scaleResultRet.setFieldValue("SCALEUOM",rs.getString(5));											
				scaleResultRet.setFieldValue("CONDVAL",rs.getString(6));
				scaleResultRet.setFieldValue("PRODLINE",rs.getString(7));
				scaleResultRet.setFieldValue("SHORTDESC",rs.getString(8));
				scaleResultRet.setFieldValue("LONGDESC",rs.getString(9));
					
				scaleResultRet.addRow(); 
				
			//out.println(rs.getString(1) + "  " + rs.getString(2) + "   " + rs.getString(3) + "      " + rs.getString(4) +"       "+rs.getString(5)+"    "+rs.getString(6));
			}			
		} 
			
	}
	catch (SQLException e) 
	{
	    e.printStackTrace();
        }        
        finally 
        {
		// Closing connection
		conn.close();
		cs.close();
		rs.close();
	}
%>	
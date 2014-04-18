<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/JSPs/SelfService/iReadProcess.jsp" %> 
<%
	//out.print("dataObj:::::"+dataObj.toEzcString());
%>
<%
	String UserId = (String)session.getValue("UserId");
	Vector custVec = new Vector();
	if(dataObj!=null && dataObj.getRowCount()>0)
	{
		for(int sc=1;sc<dataObj.getRowCount();sc++)
		{
			String custCode = dataObj.getFieldValueString(sc,"Ship Codes");

			if(custCode!=null && !"null".equalsIgnoreCase(custCode) && !"".equals(custCode))
			{
				custCode = "0000000000"+custCode;
				custCode = custCode.substring(custCode.length()-10,custCode.length());
				custVec.addElement(custCode);
			}
		}

		String bussPart = (String)session.getValue("BussPart");
		String custCodes = "";
		String erpCodes = "";

		for(int i=0;i<custVec.size();i++)
		{
			if("".equals(custCodes))
				custCodes = (String)custVec.get(i);
			else
				custCodes = custCodes+"','"+(String)custVec.get(i);
		}
		ezc.ezcommon.EzLog4j.log("custCodes::::::"+custCodes,"I");

		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT * FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND ECA_EXT1!='BL' AND EC_BUSINESS_PARTNER='"+bussPart+"' AND EC_PARTNER_FUNCTION='WE' AND EC_PARTNER_NO IN ('"+custCodes+"')");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		ReturnObjFromRetrieve retObjShipTos = (ReturnObjFromRetrieve)MiscManager.ezSelect(miscMainParams);

		for(int i=0;i<=retObjShipTos.getRowCount();i++)
		{
			String partNumCust = retObjShipTos.getFieldValueString(i,"EC_PARTNER_NO");
			custVec.removeElement(partNumCust);
		}
		out.println("Customers Not Synch in portal::::"+custVec);

		ArrayList retshipto_AL = new ArrayList();
		for(int i=0;i<retObjShipTos.getRowCount();i++)
		{
			String shipErpCust = retObjShipTos.getFieldValueString(i,"EC_ERP_CUST_NO");

			if(!retshipto_AL.contains(shipErpCust))
			{
				retshipto_AL.add(shipErpCust);

				if("".equals(erpCodes))
					erpCodes = shipErpCust;
				else
					erpCodes = erpCodes+"','"+shipErpCust;
			}
			else
				retObjShipTos.deleteRow(i);
		}
		//out.println("retObjShipTos:::::"+retObjShipTos.toEzcString());

		miscParams = new ezc.ezmisc.params.EziMiscParams();
		miscMainParams = new EzcParams(true);

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT * FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND ECA_EXT1!='BL' AND EC_BUSINESS_PARTNER='"+bussPart+"' AND EC_PARTNER_FUNCTION='AG' AND EC_ERP_CUST_NO IN ('"+erpCodes+"')");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		ReturnObjFromRetrieve retObjSoldTos = (ReturnObjFromRetrieve)MiscManager.ezSelect(miscMainParams);

		/******************* Update Ship Tos - Start *************************/
		String ConnGroup = (String)session.getValue("Site");
		java.sql.Connection con=null;

		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
		con=java.sql.DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

		if(retObjSoldTos.getRowCount()>0 && retObjShipTos.getRowCount()>0)
		{
			miscParams = new ezc.ezmisc.params.EziMiscParams();
			miscMainParams = new EzcParams(true);
			miscParams.setIdenKey("MISC_DELETE");
			miscParams.setQuery("DELETE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+UserId.toUpperCase()+"' AND EUD_KEY IN('SOLDTOPARTY','SHIPTOPARTY')");
			miscMainParams.setObject(miscParams);
			miscMainParams.setLocalStore("Y");

			Session.prepareParams(miscMainParams);
			MiscManager.ezDelete(miscMainParams);

			java.sql.Statement stmt= null;
			java.sql.Statement stmt1= null;

			try
			{
				con.setAutoCommit(false);
				stmt= con.createStatement();
				stmt1= con.createStatement();

				for(int i=0;i<retObjShipTos.getRowCount();i++)
				{
					String shipSysKey = retObjShipTos.getFieldValueString(i,"EC_SYS_KEY");
					String shipPartNo = retObjShipTos.getFieldValueString(i,"EC_PARTNER_NO");

					try
					{
						stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+UserId.toUpperCase()+"','"+shipSysKey+"','NULL','SHIPTOPARTY','"+shipPartNo+"','N','')");
					}
					catch(Exception e)
					{
						ezc.ezcommon.EzLog4j.log("Exception in Batch Query::retObjShipTos:::::::::::"+e,"I");
					}
				}
				for(int i=0;i<retObjSoldTos.getRowCount();i++)
				{
					String soldSysKey = retObjSoldTos.getFieldValueString(i,"EC_SYS_KEY");
					String soldPartNo = retObjSoldTos.getFieldValueString(i,"EC_PARTNER_NO");

					try
					{
						stmt1.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+UserId.toUpperCase()+"','"+soldSysKey+"','NULL','SOLDTOPARTY','"+soldPartNo+"','N','')");
					}
					catch(Exception e)
					{
						ezc.ezcommon.EzLog4j.log("Exception in Batch Query::retObjSoldTos:::::::::::"+e,"I");	
					}
				}

				int[] updCnt = stmt.executeBatch();
				int[] updCnt1 = stmt1.executeBatch();
				con.commit();
				ezc.ezcommon.EzLog4j.log("updCnt::::::::::::"+updCnt.length,"D");
				ezc.ezcommon.EzLog4j.log("updCnt1::::::::::::"+updCnt1.length,"D");
			}
			catch (java.sql.BatchUpdateException be)
			{
				ezc.ezcommon.EzLog4j.log("BatchUpdateException::::::::::::"+be,"I");
				//handle batch update exception
				int[] counts = be.getUpdateCounts();
				for (int i=0; i<counts.length; i++)
				{
					ezc.ezcommon.EzLog4j.log("Statement["+i+"] :"+counts[i],"D");
				}
				con.rollback();
			}
			catch (java.sql.SQLException e)
			{
				//handle SQL exception
				con.rollback();
				ezc.ezcommon.EzLog4j.log("handle SQL exception::::::::::::"+e,"I");
			}
			finally
			{
				if(stmt!=null  || stmt1!=null)
				{
					stmt.close();
					stmt1.close();
					con.close();
				}
			}
		}
	}
	ezc.ezcommon.EzLog4j.log("R E A D E X C E L","I");
	int custVecSize = custVec.size();
%>
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script>
function closePouUp()
{
	parent.$.fancybox.close();
}
</script>
<img src="../../Library/images/icon-success-message.png"/>&nbsp;<font color=green size=4></font>&nbsp;<font size=4> Ship Codes are synchronized.</font>
<br><br>
<img src="../../Library/images/icon-error-message.png"/>&nbsp;<a href="JavaScript:downloadErr()"><font color=red size=4>Click Here</font></a><font size=4> to check the items (<%=custVecSize%>) which are not Synchronized.</font>
<br><br>
<center><input type="button" class="button" value="Close" onClick="closePouUp();"></center>
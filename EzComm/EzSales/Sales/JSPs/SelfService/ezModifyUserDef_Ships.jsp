<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%

	String UserId = "";
	Vector modCust = new Vector();
	
	modCust.addElement("TESTREP1");
	   	
	for(int mC=0;mC<modCust.size();mC++)
	{

		Vector custVec = new Vector();

		custVec.addElement("0102400001");

		UserId = (String)modCust.elementAt(mC);
		String bussPart = "22394";
		String custCodes = "";
		String erpCodes = "";
		
		for(int i=0;i<custVec.size();i++)
		{
			String partCode = (String)custVec.get(i);
			partCode = "0000000000"+partCode;
			partCode = partCode.substring(partCode.length()-10,partCode.length());

			if("".equals(custCodes))
				custCodes = partCode;
			else
				custCodes = custCodes+"','"+partCode;
		}
		//ezc.ezcommon.EzLog4j.log("custCodes::::::"+custCodes,"I");

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
		//out.println("Customers Not Synch in portal::::"+custVec);

		ArrayList retshipto_AL = new ArrayList();
		for(int i=retObjShipTos.getRowCount()-1;i>=0;i--)
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
		}
		
		/************************* Start For All Ship TOs Sync **********************************/
		
		ezc.ezmisc.params.EziMiscParams miscParams1 = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams1 = new EzcParams(true);

		miscParams1.setIdenKey("MISC_SELECT");
		miscParams1.setQuery("SELECT * FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND ECA_EXT1!='BL' AND EC_BUSINESS_PARTNER='"+bussPart+"' AND EC_PARTNER_FUNCTION='WE' AND EC_ERP_CUST_NO IN ('"+erpCodes+"')");
		miscMainParams1.setObject(miscParams1);
		miscMainParams1.setLocalStore("Y");

		Session.prepareParams(miscMainParams1);
		ReturnObjFromRetrieve retObjShipTos1 = (ReturnObjFromRetrieve)MiscManager.ezSelect(miscMainParams1);

		for(int i=0;i<=retObjShipTos1.getRowCount();i++)
		{
			String partNumCust = retObjShipTos1.getFieldValueString(i,"EC_PARTNER_NO");
			custVec.removeElement(partNumCust);
		}
		//out.println("Customers Not Synch in portal::::"+custVec);

		String erpCodes1 = "";
		ArrayList retshipto_All = new ArrayList();
		for(int i=retObjShipTos1.getRowCount()-1;i>=0;i--)
		{
			String shipErpCust = retObjShipTos1.getFieldValueString(i,"EC_ERP_CUST_NO");

			if(!retshipto_All.contains(shipErpCust))
			{
				retshipto_All.add(shipErpCust);

				if("".equals(erpCodes1))
					erpCodes1 = shipErpCust;
				else
					erpCodes1 = erpCodes1+"','"+shipErpCust;
			}
		}
		
		/*************************End For All Ship TOs Sync **********************************/
		
		miscParams = new ezc.ezmisc.params.EziMiscParams();
		miscMainParams = new EzcParams(true);

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT * FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND ECA_EXT1!='BL' AND EC_BUSINESS_PARTNER='"+bussPart+"' AND EC_PARTNER_FUNCTION='AG' AND EC_ERP_CUST_NO IN ('"+erpCodes1+"')");
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

		if(retObjSoldTos.getRowCount()>0 && retObjShipTos1.getRowCount()>0)
		{

			java.sql.Statement stmt= null;
			java.sql.Statement stmt1= null;

			try
			{
				con.setAutoCommit(false);
				stmt= con.createStatement();
				stmt1= con.createStatement();

				for(int i=0;i<retObjShipTos1.getRowCount();i++)
				{
					String shipSysKey = retObjShipTos1.getFieldValueString(i,"EC_SYS_KEY");
					String shipPartNo = retObjShipTos1.getFieldValueString(i,"EC_PARTNER_NO");

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
	/******************* Update Ship Tos - End *************************/
%>
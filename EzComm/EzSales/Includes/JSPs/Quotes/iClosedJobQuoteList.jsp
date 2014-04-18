<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
		if(soldToQT==null || "null".equals(soldToQT) || "".equals(soldToQT))
		soldToQT   = (String)session.getValue("AgentCode");

		DateFormat formatter1;
		Date DateFrom = new Date();
		Date DateTo = new Date();
		formatter1 = new SimpleDateFormat("MM/dd/yyyy");
		DateFrom = (Date)formatter1.parse(fromDate); 
		DateTo = (Date)formatter1.parse(toDate);
		Date valFromDate = (Date)formatter1.parse(valFrom); 
		Date valToDate = (Date)formatter1.parse(valTo); 

		JCO.Client client=null;
		JCO.Function functionEx = null;

		String site_S = (String)session.getValue("Site");
		String skey_S = "999";

		int SalExQCnt=0;

		String colExSQ[]={"SALESDOC","ITEMNO","MATERIAL","MATDESC","VALIDFROM","VALIDTO","REQQTY","NETPRICE","NETVALUE","DOCDATE","SOLDTO","SOLDTONAME","POJOBNAME","DOCSTATUS"};
		ReturnObjFromRetrieve retObjExSQ = new ReturnObjFromRetrieve(colExSQ);

		try
		{
			functionEx= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_S+"~"+skey_S);
			JCO.ParameterList sapProc = functionEx.getImportParameterList();
			//JCO.Table salesTable = functionEx.getTableParameterList().getTable("SALES_ORDERS");

			sapProc.setValue(soldToQT,"CUSTOMER_NUMBER");
			sapProc.setValue(DateFrom,"DOCUMENT_DATE"); 
			sapProc.setValue(DateTo,"DOCUMENT_DATE_TO");
			sapProc.setValue("2","TRANSACTION_GROUP");
			sapProc.setValue("C","WITHOPENCLOSEDESTATUS");

			try
			{
				client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
				client.execute(functionEx);
			}
			catch(Exception ec)
			{
				out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
			}

			JCO.Table headerTable 	= functionEx.getTableParameterList().getTable("SALES_ORDERS");

			if(headerTable!=null)
			{
				SalExQCnt = headerTable.getNumRows();
				//out.println("headerTable:::::::::::::::::::"+SalExQCnt);
				if (headerTable.getNumRows() > 0)
				{
					do
					{
						String sdDoc=(String)headerTable.getValue("SD_DOC");
						Date validFrom	=   (Date)headerTable.getValue("VALID_FROM");

						Date validTo	=	(Date)headerTable.getValue("VALID_TO");
						Date sqDateTo = new Date();

						int dateComp = validTo.compareTo(sqDateTo);

						if(dateComp<0)
						  continue;

						String tempSdDoc="";
						try
						{
							tempSdDoc = (Long.parseLong(sdDoc))+"";
						}
						catch(Exception e)
						{	
							tempSdDoc = sdDoc;
						}
						String tempQDoc="";
						try
						{
							tempQDoc = (Long.parseLong(quoteNum))+"";
						}
						catch(Exception e)
						{	
							tempQDoc = quoteNum;
						}

						if(tempQDoc!=null && !"null".equals(tempQDoc) && !"".equals(tempQDoc) && !tempQDoc.equals(tempSdDoc))
							continue;								  								

						int valFromComp = validFrom.compareTo(valFromDate);
						if(valFromComp<0)
							continue;

						int valToComp = validTo.compareTo(valToDate);
						if(valToComp>0)
							continue;  
						retObjExSQ.setFieldValue("VALIDFROM",validFrom);
						retObjExSQ.setFieldValue("VALIDTO",validTo);
						retObjExSQ.setFieldValue("SALESDOC",headerTable.getValue("SD_DOC"));
						//retObjExSQ.setFieldValue("ITEMNO",headerTable.getValue("ITM_NUMBER"));
						//retObjExSQ.setFieldValue("MATERIAL",headerTable.getValue("MATERIAL"));
						//retObjExSQ.setFieldValue("MATDESC",headerTable.getValue("SHORT_TEXT"));
						//retObjExSQ.setFieldValue("REQQTY",headerTable.getValue("REQ_QTY"));
						//retObjExSQ.setFieldValue("NETPRICE",headerTable.getValue("NET_PRICE"));
						retObjExSQ.setFieldValue("NETVALUE",headerTable.getValue("NET_VAL_HD"));
						retObjExSQ.setFieldValue("DOCDATE",headerTable.getValue("DOC_DATE"));
						retObjExSQ.setFieldValue("SOLDTO",headerTable.getValue("SOLD_TO"));
						retObjExSQ.setFieldValue("SOLDTONAME",headerTable.getValue("NAME"));
						retObjExSQ.setFieldValue("POJOBNAME",headerTable.getValue("PURCH_NO"));
						retObjExSQ.setFieldValue("DOCSTATUS",headerTable.getValue("DOC_STATUS"));

						retObjExSQ.addRow();
					}
					while(headerTable.nextRow());
				}
			}
		}
		catch(Exception e)
		{
			out.println("EXCEPTION>>>>>>"+e);
		}
		finally
		{
			if (client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				functionEx=null;
			}
		}



		//out.println(retObjExSQ.toEzcString());

%>
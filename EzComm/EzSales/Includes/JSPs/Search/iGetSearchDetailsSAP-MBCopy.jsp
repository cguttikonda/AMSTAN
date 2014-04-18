<%@ page import ="ezc.ezparam.*,ezc.ezsap.*,ezc.ezmisc.params.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="ezMiscManager_O" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>

<%
	String [] myHeaderCols = {"BACKEND_ORNO","PO_NO","DOC_DATE","VALID_FROM","DOC_TYPE","SOLD_TO","SOLD_TO_NAME","NET_VALUE","DOC_STATUS","PURCH_NO_C"};
 	
 	ReturnObjFromRetrieve retHeader 	= new ReturnObjFromRetrieve(myHeaderCols);
	
	String SAPSO 	= request.getParameter("SAPSO");
  	String PONO 	= request.getParameter("PONO");
	String soldto	= (String) session.getValue("AgentCode");
	String salesOrg	= "1001";//(String) session.getValue("SalesOffice");
	String division	= (String) session.getValue("division");
	String distrCha = (String) session.getValue("dc");
	String fromDate	= request.getParameter("fromDate");
	String toDate 	= request.getParameter("toDate");
	String prdCODE  = request.getParameter("prdCODE");
	String UPC 	= request.getParameter("UPC");
	String orderType= request.getParameter("orderType");
	String selParent= request.getParameter("parentSol");
	String selSoldTo= request.getParameter("selSoldTo");
	String selShipTo= request.getParameter("shipTo");
	if(selSoldTo==null || "".equals(selSoldTo) || "null".equals(selSoldTo))selSoldTo=request.getParameter("tempSoldTo");
	if(selSoldTo==null || "".equals(selSoldTo) || "null".equals(selSoldTo))selSoldTo = (String) session.getValue("AgentCode");
	StringBuffer searchRslt = new StringBuffer();
	searchRslt = searchRslt.append("Your Search for  ");
	if(PONO!=null && !"".equals(PONO))searchRslt = searchRslt.append("<B>PO </B> "+PONO);
	if(SAPSO!=null && !"".equals(SAPSO))searchRslt = searchRslt.append("<B>Sales Order </B> "+SAPSO);
	if(prdCODE!=null && !"".equals(prdCODE))searchRslt = searchRslt.append("<B>Product </B>  "+prdCODE);
	if(selParent!=null && !"".equals(selParent))searchRslt = searchRslt.append("<B>Parent </B>  "+selParent);
	if(selSoldTo!=null && !"".equals(selSoldTo))searchRslt = searchRslt.append("<B>SoldTo </B>  "+selSoldTo);
	if(selShipTo!=null && !"".equals(selShipTo))searchRslt = searchRslt.append("<B>shipTo </B>  "+selShipTo);
	//out.println("searchRslt:::::::"+searchRslt.toString());
	
	
	int matSearchCnt=0;
	java.util.Vector prodVec = new java.util.Vector();
	
	/********To Log START*****/
	ezc.ezcommon.EzLog4j.log(">>>>>>>selParent>>>>>>>>>>>>>>>>>>>>>>"+selSoldTo,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>selShipTo>>>>>>>>>>>>>>>>>>>>>>"+selShipTo,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>selSoldTo>>>>>>>>>>>>>>>>>>>>>>"+selSoldTo,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>orderType>>>>>>>>>>>>>>>>>>>>>>"+orderType,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>salesOrg>>>>>>>>>>>>>>>>>>>>>>"+salesOrg,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>division>>>>>>>>>>>>>>>>>>>>>>"+division,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>distrCha>>>>>>>>>>>>>>>>>>>>>>"+distrCha,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>fromDate>>>>>>>>>>>>>>>>>>>>>>"+fromDate,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>toDate>>>>>>>>>>>>>>>>>>>>>>"+toDate,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>SAPSO>>>>>>>>>>>>>>>>>>>>>>"+SAPSO,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>PONO>>>>>>>>>>>>>>>>>>>>>>"+PONO,"D");
	ezc.ezcommon.EzLog4j.log(">>>>>>>soldto>>>>>>>>>>>>>>>>>>>>>>"+soldto,"D");
	/********To Log END*****/
	
	String refQuery="";
	if(prdCODE!=null && !"null".equals(prdCODE) && !"".equals(prdCODE))
		refQuery = "SELECT EZP_PRODUCT_CODE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DESCRIPTION' AND (EZP_PRODUCT_CODE LIKE '"+prdCODE+"%' OR EPA_ATTR_VALUE LIKE '"+prdCODE+"%')";
	if(UPC!=null && !"null".equals(UPC) && !"".equals(UPC))	
		refQuery = "SELECT  EZP_PRODUCT_CODE FROM EZC_PRODUCTS WHERE EZP_UPC_CODE LIKE '"+UPC+"%'";
		
	int month=0, date=0, year=0;
	
	month = Integer.parseInt(fromDate.substring(0,2));
	date  = Integer.parseInt(fromDate.substring(3,5));
	year  = Integer.parseInt(fromDate.substring(6,10));	
	java.util.GregorianCalendar DateFrom = new java.util.GregorianCalendar(year,month-1,date);
	
	month = Integer.parseInt(toDate.substring(0,2));
	date  = Integer.parseInt(toDate.substring(3,5));
	year  = Integer.parseInt(toDate.substring(6,10));	
	java.util.GregorianCalendar DateTo = new java.util.GregorianCalendar(year,month-1,date);
		
		
	try
	{
		if(refQuery!=null && !"".equals(refQuery))
		{
			EzcParams matSearchParamsMisc = new EzcParams(false);
			EziMiscParams matSearchParams = new EziMiscParams();
			ReturnObjFromRetrieve matSearchRetObj = null;
			matSearchParams.setIdenKey("MISC_SELECT");
			matSearchParams.setQuery(refQuery);
			matSearchParamsMisc.setLocalStore("Y");
			matSearchParamsMisc.setObject(matSearchParams);
			Session.prepareParams(matSearchParamsMisc);	

			matSearchRetObj = (ReturnObjFromRetrieve)ezMiscManager_O.ezSelect(matSearchParamsMisc);
			if(matSearchRetObj!=null)
				matSearchCnt=matSearchRetObj.getRowCount();
			for(int mc=0;mc<matSearchCnt;mc++)
			{
				String prodRslt = matSearchRetObj.getFieldValueString(mc,"EZP_PRODUCT_CODE");
				prodVec.add(prodRslt);
			
			}
			ezc.ezcommon.EzLog4j.log(">>>>>>>prodVec>>>>>>>>>>>>>>>>>>>>>>"+prodVec,"D");
				
		}
	}
	catch(Exception e)
	{
		out.println("Ezception in Product LookUp"+e);
	}
	
	JCO.Client client2=null;
	JCO.Function function1 = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";
		
	if(prodVec.size()>0)
	{
		int count=0;
		for(int i=0;i<prodVec.size();i++)
		{
			ezc.ezcommon.EzLog4j.log(">>>>>>>Entered FOR>>>>>>>>>>>>>>>>>>>>>>"+count,"D");
			try
			{
				function1 = EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_S+"~"+skey_S);
				JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
				if(selSoldTo.lastIndexOf("$$")!=-1)
					selSoldTo = selSoldTo.split("$$")[0];
				ezc.ezcommon.EzLog4j.log("selSoldTo::::::::::::::::::::"+selSoldTo,"D");	
				sapProc.setValue(selSoldTo,"CUSTOMER_NUMBER");
				if(salesOrg!=null && !"".equals(salesOrg))
					//sapProc.setValue(salesOrg,"SALES_ORGANIZATION");
				if(division!=null && !"".equals(division))	
					//sapProc.setValue(division,"DIVISON");
				if(distrCha!=null && !"".equals(distrCha))	
					//sapProc.setValue(distrCha,"DISTR_CHANNEL");
				if(fromDate!=null && !"".equals(fromDate))	
					sapProc.setValue(DateFrom.getTime(),"DOCUMENT_DATE");
				if(toDate!=null && !"".equals(toDate))		
					sapProc.setValue(DateTo.getTime(),"DOCUMENT_DATE_TO");

				if(PONO!=null && !"".equals(PONO))
				{
					String tempPo=PONO+"*";
					sapProc.setValue(tempPo,"PURCHASE_ORDER");
				}	

				if(SAPSO!=null && !"".equals(SAPSO))		
				{
					String tempSo = SAPSO;
					if(tempSo.length()==8)
					{
						tempSo = "00"+tempSo;
						sapProc.setValue(tempSo,"SALES_ORDER");
					}	
					else
					{
						tempSo = "00"+tempSo;
						tempSo = tempSo+"*";
						sapProc.setValue(tempSo,"SALES_ORDER");
					}	
				}
				if(prodVec!=null && !"".equals(prodVec))
					sapProc.setValue(prodVec.get(i),"MATERIAL");
				
				sapProc.setValue("0","TRANSACTION_GROUP");
				if(orderType!=null && !"".equals(orderType))
					sapProc.setValue(orderType,"WITHOPENCLOSEDESTATUS");

				sapProc.setValue("X","ADV_SEARCH");	
				JCO.Table custSelectionTable = function1.getTableParameterList().getTable("CUSTOMER_SELECTION");
				if(selShipTo != null && !"".equals(selShipTo))
				{
					custSelectionTable.appendRow();
					custSelectionTable.setValue(selShipTo, "CUSTOMER");
					custSelectionTable.setValue("X", "ISSHIPTO");
				}
				else if(selSoldTo!=null && !"".equals(selSoldTo))
				{
					if(selSoldTo.indexOf("$$")!=-1)
					{
						java.util.StringTokenizer allsoldTo = new java.util.StringTokenizer(selSoldTo,"$$");
						while(allsoldTo.hasMoreTokens())
						{
							String soldToStr = allsoldTo.nextToken()+"";
							custSelectionTable.appendRow();
							custSelectionTable.setValue(soldToStr, "CUSTOMER");
							ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+soldToStr,"D");
						}
					}
					else
					{
						custSelectionTable.appendRow();
						custSelectionTable.setValue(selSoldTo, "CUSTOMER");
						ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+selSoldTo,"D");
					}				
				}
								
								
				

				try
				{
					client2 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
					client2.execute(function1);
				}
				catch(Exception ec)
				{
					ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+ec,"E");
				}
				JCO.Table salesOrderTable 	= function1.getTableParameterList().getTable("SALES_ORDERS");

				if ( salesOrderTable != null )
				{
					if (salesOrderTable.getNumRows() > 0)
					{
						do
						{
							retHeader.setFieldValue("BACKEND_ORNO",salesOrderTable.getValue("SD_DOC"));
							retHeader.setFieldValue("PO_NO",salesOrderTable.getValue("PURCH_NO"));
							retHeader.setFieldValue("DOC_DATE", salesOrderTable.getValue("DOC_DATE"));
							retHeader.setFieldValue("VALID_FROM",salesOrderTable.getValue("VALID_FROM"));
							retHeader.setFieldValue("DOC_TYPE", salesOrderTable.getValue("DOC_TYPE"));		
							retHeader.setFieldValue("SOLD_TO", salesOrderTable.getValue("SOLD_TO"));
							retHeader.setFieldValue("SOLD_TO_NAME", salesOrderTable.getValue("NAME"));		
							retHeader.setFieldValue("NET_VALUE",salesOrderTable.getValue("NET_VAL_HD"));
							retHeader.setFieldValue("DOC_STATUS", salesOrderTable.getValue("DOC_STATUS"));			
							retHeader.setFieldValue("PURCH_NO_C", salesOrderTable.getValue("PURCH_NO_C"));					

							retHeader.addRow();



						}while(salesOrderTable.nextRow());
					}	
				}			
			}
			catch(Exception e){
				ezc.ezcommon.EzLog4j.log("Exception in last try of loop"+e,"E");
			}
			finally
			{
				if (client2!=null)
				{
					JCO.releaseClient(client2);
					client2 = null;
					function1=null;
				}
			}
			count++;
		}
	}
	else
	{
	
		try
		{
			function1 = EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_S+"~"+skey_S);
			JCO.ParameterList 	sapProc 	= function1.getImportParameterList();
			JCO.Table custSelectionTable = function1.getTableParameterList().getTable("CUSTOMER_SELECTION");
			
			if(selSoldTo.indexOf("$$")!=-1)
				selSoldTo = selSoldTo.split("$$")[0];
				
			sapProc.setValue(selSoldTo,"CUSTOMER_NUMBER");
			if(salesOrg!=null && !"".equals(salesOrg))
				//sapProc.setValue(salesOrg,"SALES_ORGANIZATION");
			if(division!=null && !"".equals(division))	
				//sapProc.setValue(division,"DIVISON");
			if(distrCha!=null && !"".equals(distrCha))	
				//sapProc.setValue(distrCha,"DISTR_CHANNEL");
			if(fromDate!=null && !"".equals(fromDate))	
				sapProc.setValue(DateFrom.getTime(),"DOCUMENT_DATE");
			if(toDate!=null && !"".equals(toDate))		
				sapProc.setValue(DateTo.getTime(),"DOCUMENT_DATE_TO");

			if(PONO!=null && !"".equals(PONO))
			{
				String tempPO = PONO;
				tempPO = tempPO+"*";
				sapProc.setValue(tempPO,"PURCHASE_ORDER");
			}	

			if(SAPSO!=null && !"".equals(SAPSO))		
			{
				String tempSo = SAPSO;
				if(tempSo.length()==8)
				{
					tempSo = "00"+tempSo;
					sapProc.setValue(tempSo,"SALES_ORDER");
				}	
				else
				{
					tempSo = "00"+tempSo;
					tempSo = tempSo+"*";
					sapProc.setValue(tempSo,"SALES_ORDER");
				}	
			}	

			sapProc.setValue("0","TRANSACTION_GROUP");
			if(orderType!=null && !"".equals(orderType))
				sapProc.setValue(orderType,"WITHOPENCLOSEDESTATUS");

			sapProc.setValue("X","ADV_SEARCH");
			
			if(selShipTo != null && !"".equals(selShipTo))
			{
				custSelectionTable.appendRow();
				custSelectionTable.setValue(selShipTo, "CUSTOMER");
				custSelectionTable.setValue("X", "ISSHIPTO");
			}
			else if(selSoldTo!=null && !"".equals(selSoldTo))
			{
				ezc.ezcommon.EzLog4j.log(":::::::::::::::::::selSoldToindexOf::::::::::::::::::::"+selSoldTo.indexOf("$$"),"D");
				if(selSoldTo.indexOf("$$")!=-1)
				{
					java.util.StringTokenizer allsoldTo = new java.util.StringTokenizer(selSoldTo,"$$");
					while(allsoldTo.hasMoreTokens())
					{
						String soldToStr = allsoldTo.nextToken()+"";
						custSelectionTable.appendRow();
						custSelectionTable.setValue(soldToStr, "CUSTOMER");
						ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+soldToStr,"D");
					}
				}
				else
				{
					custSelectionTable.appendRow();
					custSelectionTable.setValue(selSoldTo, "CUSTOMER");
					ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+selSoldTo,"D");
				}				
			}			

			try
			{
				client2 = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
				client2.execute(function1);
			}
			catch(Exception ec)
			{
				ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+ec,"E");
			}
			JCO.Table salesOrderTable 	= function1.getTableParameterList().getTable("SALES_ORDERS");

			if ( salesOrderTable != null )
			{
				if (salesOrderTable.getNumRows() > 0)
				{
					do
					{
						retHeader.setFieldValue("BACKEND_ORNO",salesOrderTable.getValue("SD_DOC"));
						retHeader.setFieldValue("PO_NO",salesOrderTable.getValue("PURCH_NO"));
						retHeader.setFieldValue("DOC_DATE", salesOrderTable.getValue("DOC_DATE"));
						retHeader.setFieldValue("VALID_FROM",salesOrderTable.getValue("VALID_FROM"));
						retHeader.setFieldValue("DOC_TYPE", salesOrderTable.getValue("DOC_TYPE"));		
						retHeader.setFieldValue("SOLD_TO", salesOrderTable.getValue("SOLD_TO"));
						retHeader.setFieldValue("SOLD_TO_NAME", salesOrderTable.getValue("NAME"));		
						retHeader.setFieldValue("NET_VALUE",salesOrderTable.getValue("NET_VAL_HD"));
						retHeader.setFieldValue("DOC_STATUS", salesOrderTable.getValue("DOC_STATUS"));			
						retHeader.setFieldValue("PURCH_NO_C", salesOrderTable.getValue("PURCH_NO_C"));					

						retHeader.addRow();



					}while(salesOrderTable.nextRow());
				}	
			}			
		}
		catch(Exception e){
			ezc.ezcommon.EzLog4j.log("Exception in last try of loop"+e,"E");
		}	
		finally
		{
			if (client2!=null)
			{
				JCO.releaseClient(client2);
				client2 = null;
				function1=null;
			}
		}		
		
	}
	
	//ezc.ezcommon.EzLog4j.log("retHeadertoEzcString::::::::"+retHeader.toEzcString(),"D");	
	
%>
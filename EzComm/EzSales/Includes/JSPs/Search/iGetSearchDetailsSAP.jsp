<%@ page import ="ezc.ezparam.*,ezc.ezsap.*,ezc.ezmisc.params.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="ezMiscManager_O" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>

<%
	String [] myHeaderCols = {"BACKEND_ORNO","TEMPLATE_NAME","PO_NO","WEB_ORNO","DOC_DATE","VALID_FROM","DOC_TYPE","SOLD_TO","SOLD_TO_NAME","NET_VALUE","DOC_STATUS","PURCH_NO_C","SHIP_TO","SHIP_TO_NAME","CREATED_BY","CANCEL_ID","SYSKEY"};
 	
 	ReturnObjFromRetrieve retHeader 	= new ReturnObjFromRetrieve(myHeaderCols);
 	String refOrdNo = request.getParameter("refOrdNo");
 	String tempName = request.getParameter("tempName");
 	String soldToCode= request.getParameter("soldToCode"); 
 	
	String SAPSO 	= "";
	String PONO 	= "";
	String soldto	= "";
	String salesOrg	= "";	
	String division	= ""; 	
	String distrCha = ""; 	
	String fromDate	= ""; 	
	String toDate 	= ""; 	
	String prdCODE  = ""; 	
	String UPC 	= ""; 	
	String orderType  = request.getParameter("orderType");	
	String selOrds    = request.getParameter("orderinforadio");
	String selParent= ""; 	
	String selSoldTo= ""; 	
	String selShipTo= ""; 	
	String ordStat = request.getParameter("ordStat");
	String ordTypeSel ="";
	//out.println("ordStat:::::::::::::"+ordStat+"::::orderType::::"+orderType+":::selOrds::::"+selOrds);
 	if(!"null".equals(refOrdNo) && !"".equals(refOrdNo) && refOrdNo!=null)
 	{
		EzcParams mainParamsRef= new EzcParams(false);
		EziMiscParams miscParamsRef = new EziMiscParams();
		ReturnObjFromRetrieve orderRefRet = null;		
		miscParamsRef.setIdenKey("MISC_SELECT");
		miscParamsRef.setQuery("SELECT * FROM EZC_SALES_DOC_HEADER WHERE ESDH_STATUS='TRANSFERED' AND ESDH_SAVE_FLAG='"+refOrdNo+"'");

		mainParamsRef.setLocalStore("Y");
		mainParamsRef.setObject(miscParamsRef);
		Session.prepareParams(mainParamsRef);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			orderRefRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsRef);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		} 
		
		for ( int saveCnt=0;saveCnt<orderRefRet.getRowCount();saveCnt++)
		{
			retHeader.setFieldValue("BACKEND_ORNO",orderRefRet.getFieldValueString(saveCnt,"ESDH_BACK_END_ORDER"));
			retHeader.setFieldValue("PO_NO",orderRefRet.getFieldValueString(saveCnt,"ESDH_PO_NO"));
			
			retHeader.setFieldValue("DOC_DATE", orderRefRet.getFieldValue(saveCnt,"ESDH_ORDER_DATE"));
			retHeader.setFieldValue("VALID_FROM",orderRefRet.getFieldValue(saveCnt,"ESDH_ORDER_DATE"));
			retHeader.setFieldValue("DOC_TYPE", orderRefRet.getFieldValueString(saveCnt,"ESDH_DOC_TYPE"));		
			retHeader.setFieldValue("SOLD_TO", orderRefRet.getFieldValueString(saveCnt,"ESDH_SOLD_TO"));
			retHeader.setFieldValue("SOLD_TO_NAME", orderRefRet.getFieldValueString(saveCnt,"ESDH_SOLDTO_ADDR_1"));		
			retHeader.setFieldValue("NET_VALUE",orderRefRet.getFieldValueString(saveCnt,"ESDH_NET_VALUE"));
			retHeader.setFieldValue("DOC_STATUS", orderRefRet.getFieldValueString(saveCnt,"ESDH_STATUS"));			
			retHeader.setFieldValue("PURCH_NO_C", orderRefRet.getFieldValueString(saveCnt,"ESDH_PO_NO"));					
			retHeader.setFieldValue("SHIP_TO", orderRefRet.getFieldValueString(saveCnt,"ESDH_SHIP_TO"));		
			retHeader.setFieldValue("SHIP_TO_NAME", orderRefRet.getFieldValueString(saveCnt,"ESDH_SHIPTO_ADDR_1"));					
			retHeader.setFieldValue("SYSKEY", orderRefRet.getFieldValueString(saveCnt,"ESDH_SYS_KEY"));
			retHeader.addRow();
		}		
		
 	
 	}
 	else if(("SAS".equalsIgnoreCase(ordStat) || "A".equalsIgnoreCase(ordStat)) && !"RETURNS".equalsIgnoreCase(selOrds) && !"CANCEL".equalsIgnoreCase(selOrds))
 	{
	
	SAPSO 	= request.getParameter("SAPSO");
  	PONO 	= request.getParameter("PONO");
	soldto	= (String) session.getValue("AgentCode");
	salesOrg= "1001";//(String) session.getValue("SalesOffice");
	division= (String) session.getValue("division");
	distrCha=  (String) session.getValue("dc");
	fromDate= request.getParameter("fromDate");
	toDate 	= request.getParameter("toDate");
	prdCODE = request.getParameter("prdCODE");
	UPC 	= request.getParameter("UPC");
		
	selParent= request.getParameter("parentSol");
	selSoldTo= request.getParameter("selSoldTo");
	selShipTo= request.getParameter("shipTo");
	//if("CU".equals((String)session.getValue("UserRole")))
	selSoldTo = request.getParameter("tempSoldTo");
	if(selSoldTo==null || "".equals(selSoldTo) || "null".equals(selSoldTo))selSoldTo=request.getParameter("tempSoldTo");
	if(selSoldTo==null || "".equals(selSoldTo) || "null".equals(selSoldTo))selSoldTo = (String) session.getValue("AgentCode");
	/*StringBuffer searchRslt = new StringBuffer();
	searchRslt = searchRslt.append("Your Search for  ");
	if(PONO!=null && !"".equals(PONO))searchRslt = searchRslt.append("<B>PO </B> "+PONO);
	if(SAPSO!=null && !"".equals(SAPSO))searchRslt = searchRslt.append("<B>Sales Order </B> "+SAPSO);
	if(prdCODE!=null && !"".equals(prdCODE))searchRslt = searchRslt.append("<B>Product </B>  "+prdCODE);
	if(selParent!=null && !"".equals(selParent))searchRslt = searchRslt.append("<B>Parent </B>  "+selParent);
	if(selSoldTo!=null && !"".equals(selSoldTo))searchRslt = searchRslt.append("<B>SoldTo </B>  "+selSoldTo);
	if(selShipTo!=null && !"".equals(selShipTo))searchRslt = searchRslt.append("<B>shipTo </B>  "+selShipTo);*/
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
		refQuery = "SELECT EZP_PRODUCT_CODE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND (EZP_PRODUCT_CODE LIKE '"+prdCODE+"%' OR EPD_PRODUCT_DESC LIKE '"+prdCODE+"%')";
	if(UPC!=null && !"null".equals(UPC) && !"".equals(UPC))	
		refQuery = "SELECT EZP_PRODUCT_CODE FROM EZC_PRODUCTS WHERE EZP_UPC_CODE LIKE '"+UPC+"%'";
		
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

				if(!prodVec.contains(prodRslt))
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

				String custNo_S = selSoldTo;
				if(selSoldTo.indexOf("$$")!=-1)
					custNo_S = selSoldTo.split("$$")[0];

				//if(selSoldTo.lastIndexOf("¥ ")!=-1)
				//	selSoldTo = selSoldTo.split("¥")[0];

				ezc.ezcommon.EzLog4j.log("selSoldTo::::::::::::::::::::"+selSoldTo,"D");	
				sapProc.setValue(custNo_S,"CUSTOMER_NUMBER");
				//if(salesOrg!=null && !"".equals(salesOrg))
					//sapProc.setValue(salesOrg,"SALES_ORGANIZATION");
				//if(division!=null && !"".equals(division))	
					//sapProc.setValue(division,"DIVISON");
				//if(distrCha!=null && !"".equals(distrCha))	
					//sapProc.setValue(distrCha,"DISTR_CHANNEL");
				if(fromDate!=null && !"".equals(fromDate))	
					sapProc.setValue(DateFrom.getTime(),"DOCUMENT_DATE");
				if(toDate!=null && !"".equals(toDate))		
					sapProc.setValue(DateTo.getTime(),"DOCUMENT_DATE_TO");

				if(PONO!=null && !"".equals(PONO))
				{
					String tempPo=PONO;//+"*";
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
						//tempSo = tempSo+"*";
						sapProc.setValue(tempSo,"SALES_ORDER");
					}	
				}
				if(prodVec!=null && !"".equals(prodVec))
					sapProc.setValue(prodVec.get(i),"MATERIAL");
				
				sapProc.setValue("0","TRANSACTION_GROUP");
				if("A".equals(ordStat))orderType="A";
				//if(orderType!=null && !"".equals(orderType))
					//sapProc.setValue(orderType,"WITHOPENCLOSEDESTATUS");

				sapProc.setValue("A","WITHOPENCLOSEDESTATUS");
				sapProc.setValue("X","ADV_SEARCH");	
				JCO.Table custSelectionTable = function1.getTableParameterList().getTable("CUSTOMER_SELECTION");

				boolean selSoldAll = false;
				if(selShipTo != null && !"".equals(selShipTo) && !"A".equalsIgnoreCase(selShipTo))
				{
					custSelectionTable.appendRow();
					custSelectionTable.setValue(selShipTo, "CUSTOMER");
					custSelectionTable.setValue("X", "ISSHIPTO");
				}
				else if((selShipTo != null && !"".equals(selShipTo) && "A".equalsIgnoreCase(selShipTo)) || (request.getParameter("selSoldTo")!=null && "A".equals(request.getParameter("selSoldTo"))))
				{
					String selShipTo_N = request.getParameter("tempShipTo");
					if(selShipTo_N!=null && !"".equals(selShipTo_N) && !"A".equals(selShipTo_N))
					{
						if(selShipTo_N!=null && selShipTo_N.indexOf("$$")!=-1)
						{
							java.util.StringTokenizer allshipTo = new java.util.StringTokenizer(selShipTo_N,"$$");
							while(allshipTo.hasMoreTokens())
							{
								String shipToStr = allshipTo.nextToken()+"";
								custSelectionTable.appendRow();
								custSelectionTable.setValue(shipToStr, "CUSTOMER");
								custSelectionTable.setValue("X", "ISSHIPTO");
							}
						}
						else
						{
							custSelectionTable.appendRow();
							custSelectionTable.setValue(selShipTo_N, "CUSTOMER");
							custSelectionTable.setValue("X", "ISSHIPTO");
						}
					}
					else
						selSoldAll = true;
				}
				if(selSoldTo!=null && !"".equals(selSoldTo) && selSoldAll)
				{
					if(selSoldTo.indexOf("$$")!=-1)
					{
						java.util.StringTokenizer allsoldTo = new java.util.StringTokenizer(selSoldTo,"$$");
						while(allsoldTo.hasMoreTokens())
						{
							String soldToStr = allsoldTo.nextToken()+"";
							custSelectionTable.appendRow();
							custSelectionTable.setValue(soldToStr, "CUSTOMER");
							//ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+soldToStr,"D");
						}
					}
					else
					{
						custSelectionTable.appendRow();
						custSelectionTable.setValue(selSoldTo, "CUSTOMER");
						ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+selSoldTo,"D");
					}				
				}
								
				// Exclude Returns, Debits and Credits from output
				JCO.Table auartExclusionTable = function1.getTableParameterList().getTable("ZAUART");
				
				auartExclusionTable.appendRow();
				auartExclusionTable.setValue("CR", "AUART");
				auartExclusionTable.appendRow();
				auartExclusionTable.setValue("DR", "AUART");
				auartExclusionTable.appendRow();
				auartExclusionTable.setValue("ZRET", "AUART");
				auartExclusionTable.appendRow();
				auartExclusionTable.setValue("G2", "AUART");
				auartExclusionTable.appendRow();
				auartExclusionTable.setValue("RE", "AUART");
								
				

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
				//out.println("retHeadertoEzcString11111::::::::"+retHeader.toEzcString());	
				if ( salesOrderTable != null )
				{
					if (salesOrderTable.getNumRows() > 0)
					{
						do
						{
							String docStatus = (String)salesOrderTable.getValue("ASB_STATUS");
							if("".equals(docStatus))
								docStatus = (String)salesOrderTable.getValue("DOC_STATUS");

							boolean docEnt_A = false;
							if("A".equals(orderType))
							{
								docEnt_A = true;
							}
							else if("O".equals(orderType))
							{
								if(docStatus!=null && !("C".equals(docStatus.trim()) || "".equals(docStatus.trim())))
									docEnt_A = true;
							}
							else if("C".equals(orderType))
							{
								if(docStatus!=null && ("C".equals(docStatus.trim()) || "".equals(docStatus.trim())))
									docEnt_A = true;
							}

							if(docEnt_A)
							{
								retHeader.setFieldValue("BACKEND_ORNO",salesOrderTable.getValue("SD_DOC"));
								retHeader.setFieldValue("PO_NO",salesOrderTable.getValue("PURCH_NO"));

								retHeader.setFieldValue("DOC_DATE", salesOrderTable.getValue("DOC_DATE"));
								retHeader.setFieldValue("VALID_FROM",salesOrderTable.getValue("VALID_FROM"));
								retHeader.setFieldValue("DOC_TYPE", salesOrderTable.getValue("DOC_TYPE"));		
								retHeader.setFieldValue("SOLD_TO", salesOrderTable.getValue("SOLD_TO"));
								retHeader.setFieldValue("SOLD_TO_NAME", salesOrderTable.getValue("NAME"));		
								retHeader.setFieldValue("NET_VALUE",salesOrderTable.getValue("NET_VAL_HD"));
								retHeader.setFieldValue("DOC_STATUS", docStatus);
								retHeader.setFieldValue("CREATED_BY", salesOrderTable.getValue("EZ_CREATED_BY"));
								retHeader.setFieldValue("PURCH_NO_C", salesOrderTable.getValue("PURCH_NO_C"));					
								retHeader.setFieldValue("SHIP_TO", salesOrderTable.getValue("SHIP_TO"));		

								retHeader.setFieldValue("SHIP_TO_NAME", salesOrderTable.getValue("SHIP_TO_NAME"));					

								retHeader.addRow();
							}



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
			
			String custNo_S = selSoldTo;
			if(selSoldTo.indexOf("$$")!=-1)
				custNo_S = selSoldTo.split("$$")[0];
				
				
			ezc.ezcommon.EzLog4j.log(":::::::::::::::::::selSoldTo::::::::::::::::::::"+selSoldTo,"D");	
			sapProc.setValue(custNo_S,"CUSTOMER_NUMBER");
			//if(salesOrg!=null && !"".equals(salesOrg))
				//sapProc.setValue(salesOrg,"SALES_ORGANIZATION");
			//if(division!=null && !"".equals(division))	
				//sapProc.setValue(division,"DIVISON");
			//if(distrCha!=null && !"".equals(distrCha))	
				//sapProc.setValue(distrCha,"DISTR_CHANNEL");
			if(fromDate!=null && !"".equals(fromDate))	
				sapProc.setValue(DateFrom.getTime(),"DOCUMENT_DATE");
			if(toDate!=null && !"".equals(toDate))		
				sapProc.setValue(DateTo.getTime(),"DOCUMENT_DATE_TO");

			if(PONO!=null && !"".equals(PONO))
			{
				String tempPO = PONO;
				//tempPO = tempPO+"*";
				sapProc.setValue(tempPO,"PURCHASE_ORDER");
				ezc.ezcommon.EzLog4j.log(":::::::::::::::::::tempPO::::::::::::::::::::"+tempPO,"D");	
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
					//tempSo = tempSo+"*";
					sapProc.setValue(tempSo,"SALES_ORDER");
				}	
			}	

			sapProc.setValue("0","TRANSACTION_GROUP");
			ezc.ezcommon.EzLog4j.log(":::::::::::::::::::orderType::::::::::::::::::::"+orderType,"D");
			if("A".equals(ordStat))orderType="A";
			//if(orderType!=null && !"".equals(orderType))
				//sapProc.setValue(orderType,"WITHOPENCLOSEDESTATUS");

			sapProc.setValue("A","WITHOPENCLOSEDESTATUS");
			sapProc.setValue("X","ADV_SEARCH");
			
			String fromPage_W = request.getParameter("fromPage");
			if(fromPage_W == null || "null".equalsIgnoreCase(fromPage_W) || "".equals(fromPage_W))
				fromPage_W = "NotWelcome";

			boolean selSoldAll = false;
			if(selShipTo != null && !"".equals(selShipTo) && !"A".equalsIgnoreCase(selShipTo) && !"A".equalsIgnoreCase(request.getParameter("selSoldTo")) && !"Welcome".equals(fromPage_W))
			{
				custSelectionTable.appendRow();
				custSelectionTable.setValue(selShipTo, "CUSTOMER");
				custSelectionTable.setValue("X", "ISSHIPTO");
			}
			else if((selShipTo != null && !"".equals(selShipTo) && "A".equalsIgnoreCase(selShipTo)) || (request.getParameter("selSoldTo")!=null && "A".equals(request.getParameter("selSoldTo"))))
			{
				selShipTo = request.getParameter("tempShipTo");
				if(selShipTo!=null && !"A".equals(selShipTo))
				{
					if(selShipTo!=null && selShipTo.indexOf("$$")!=-1)
					{
						java.util.StringTokenizer allshipTo = new java.util.StringTokenizer(selShipTo,"$$");
						while(allshipTo.hasMoreTokens())
						{
							String shipToStr = allshipTo.nextToken()+"";
							custSelectionTable.appendRow();
							custSelectionTable.setValue(shipToStr, "CUSTOMER");
							custSelectionTable.setValue("X", "ISSHIPTO");
						}
					}
					else
					{
						custSelectionTable.appendRow();
						custSelectionTable.setValue(selShipTo, "CUSTOMER");
						custSelectionTable.setValue("X", "ISSHIPTO");
					}
				}
				else
					selSoldAll = true;
			}
			if(selSoldTo!=null && !"".equals(selSoldTo) && selSoldAll)
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
						//ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+soldToStr,"D");
					}
				}
				else
				{
					custSelectionTable.appendRow();
					custSelectionTable.setValue(selSoldTo, "CUSTOMER");
					ezc.ezcommon.EzLog4j.log(":::::::::::::::::::ec::::::::::::::::::::"+selSoldTo,"D");
				}				
			}			
			// Exclude Returns, Debits and Credits from output
			JCO.Table auartExclusionTable = function1.getTableParameterList().getTable("ZAUART");

			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("L2", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("TR", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("ZRET", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("G2", "AUART");
			auartExclusionTable.appendRow();
			auartExclusionTable.setValue("RE", "AUART");
			
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
			//ezc.ezcommon.EzLog4j.log(":::::::::::::::::::salesOrderTable::::::::::::::::::::"+salesOrderTable.getNumRows(),"E");
			//out.println("retHeadertoEzcString22222::::::::"+salesOrderTable.getNumRows());
			String sapDocStat ="";
			if ( salesOrderTable != null )
			{
				if (salesOrderTable.getNumRows() > 0)
				{
					do
					{
						String docStatus = (String)salesOrderTable.getValue("ASB_STATUS");
						if("".equals(docStatus))
							docStatus = (String)salesOrderTable.getValue("DOC_STATUS");

						boolean docEnt_A = false;
						if("A".equals(orderType))
						{
							docEnt_A = true;
						}
						else if("O".equals(orderType))
						{
							if(docStatus!=null && !("C".equals(docStatus.trim()) || "".equals(docStatus.trim())))
								docEnt_A = true;
						}
						else if("C".equals(orderType))
						{
							if(docStatus!=null && ("C".equals(docStatus.trim()) || "".equals(docStatus.trim())))
								docEnt_A = true;
						}

						if(docEnt_A)
						{

							retHeader.setFieldValue("BACKEND_ORNO",salesOrderTable.getValue("SD_DOC"));
							retHeader.setFieldValue("PO_NO",salesOrderTable.getValue("PURCH_NO"));
							retHeader.setFieldValue("DOC_DATE", salesOrderTable.getValue("DOC_DATE"));
							retHeader.setFieldValue("VALID_FROM",salesOrderTable.getValue("VALID_FROM"));
							retHeader.setFieldValue("DOC_TYPE", salesOrderTable.getValue("DOC_TYPE"));		
							retHeader.setFieldValue("SOLD_TO", salesOrderTable.getValue("SOLD_TO"));
							retHeader.setFieldValue("SOLD_TO_NAME", salesOrderTable.getValue("NAME"));		
							retHeader.setFieldValue("NET_VALUE",salesOrderTable.getValue("NET_VAL_HD"));
							//sapDocStat = (String)salesOrderTable.getValue("ASB_STATUS");
							//if("".equals(sapDocStat)) sapDocStat = (String)salesOrderTable.getValue("DOC_STATUS");
							retHeader.setFieldValue("DOC_STATUS", docStatus);
							retHeader.setFieldValue("CREATED_BY", salesOrderTable.getValue("EZ_CREATED_BY"));			
							retHeader.setFieldValue("PURCH_NO_C", salesOrderTable.getValue("PURCH_NO_C"));					
							retHeader.setFieldValue("SHIP_TO", salesOrderTable.getValue("SHIP_TO"));		
							retHeader.setFieldValue("SHIP_TO_NAME", salesOrderTable.getValue("SHIP_TO_NAME"));					
							retHeader.addRow();
							//ezc.ezcommon.EzLog4j.log(":::::::::::::::::::DOC_DATE::::::::::::::::::::"+salesOrderTable.getValue("DOC_DATE"),"D");
						}



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
	
	//out.println("retHeadertoEzcString22222::::::::"+retHeader.getRowCount());
	//ezc.ezcommon.EzLog4j.log("retHeadertoEzcString::::::::"+retHeader.toEzcString(),"D");	
}		
if("null".equals(refOrdNo) || "".equals(refOrdNo) || refOrdNo==null && !"SAS".equalsIgnoreCase(ordStat))	
{
	
%>
	<%@ include file="iGetWebOrders.jsp"%>
<% 	
	//out.println(ordTypeSel);
	//out.println("retHeadertoEzcString333333::::::::"+webOrdsRet.toEzcString());	
	if(webOrdsRet!=null && webOrdsRet.getRowCount()>0)
	{
		for ( int ordCnt=0;ordCnt<webOrdsRet.getRowCount();ordCnt++)
		{
			retHeader.setFieldValue("BACKEND_ORNO",webOrdsRet.getFieldValueString(ordCnt,"BACKEND_ORNO"));
			retHeader.setFieldValue("TEMPLATE_NAME",webOrdsRet.getFieldValueString(ordCnt,"TEMPLATE_NAME"));
			retHeader.setFieldValue("PO_NO",webOrdsRet.getFieldValueString(ordCnt,"PO_NO"));
			retHeader.setFieldValue("WEB_ORNO",webOrdsRet.getFieldValueString(ordCnt,"WEB_ORNO"));
			retHeader.setFieldValue("DOC_DATE", webOrdsRet.getFieldValue(ordCnt,"ORDER_DATE"));
			retHeader.setFieldValue("VALID_FROM",webOrdsRet.getFieldValue(ordCnt,"ORDER_DATE"));
			retHeader.setFieldValue("CREATED_BY", webOrdsRet.getFieldValue(ordCnt,"CREATED_BY"));		
			retHeader.setFieldValue("SOLD_TO", webOrdsRet.getFieldValueString(ordCnt,"SOLD_TO_CODE"));
			retHeader.setFieldValue("SOLD_TO_NAME", webOrdsRet.getFieldValueString(ordCnt,"SOTO_ADDR1"));		
			retHeader.setFieldValue("NET_VALUE",webOrdsRet.getFieldValueString(ordCnt,"NET_VALUE"));
			retHeader.setFieldValue("DOC_STATUS", webOrdsRet.getFieldValueString(ordCnt,"STATUS"));			
			retHeader.setFieldValue("PURCH_NO_C", webOrdsRet.getFieldValueString(ordCnt,"PO_NO"));					
			retHeader.setFieldValue("SHIP_TO", webOrdsRet.getFieldValueString(ordCnt,"SHIP_TO_CODE"));		
			retHeader.setFieldValue("SHIP_TO_NAME", webOrdsRet.getFieldValueString(ordCnt,"SHTO_ADDR1"));
			retHeader.setFieldValue("SYSKEY", webOrdsRet.getFieldValueString(ordCnt,"SYSKEY"));
			if("RETURNS".equalsIgnoreCase(ordTypeSel) || "CANCEL".equalsIgnoreCase(ordTypeSel) )
				retHeader.setFieldValue("CANCEL_ID", webOrdsRet.getFieldValueString(ordCnt,"CANCEL_ID"));	
			retHeader.addRow();
		}
	}
	//out.println("retHeadertoEzcString333333::::::::"+retHeader.toEzcString());
	//retHeader.sort(new String[]{"DOC_DATE"},true);
}	
%>
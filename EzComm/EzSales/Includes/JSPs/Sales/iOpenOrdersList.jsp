
<% 
	String agtCode		= (String)session.getValue("AgentCode");
	String allSoldTos_O 	= "";
	if(soldToQT==null || "null".equals(soldToQT) || "".equals(soldToQT))
		soldToQT=agtCode;
	if(request.getParameter("selSoldTo")==null || "".equals(request.getParameter("selSoldTo")) || "null".equals(request.getParameter("selSoldTo")))		
	{
		allSoldTos_O = (String)session.getValue("SOLDTO_SUPER");	
		tobeSelected = "selected";	
	}	
	
	String UserRole 	= (String)session.getValue("UserRole");	
	

	
	ReturnObjFromRetrieve returnStruct	= null;

	EzcSalesOrderParams  	     ezcSalesOrderParams= new EzcSalesOrderParams();
	EziSalesOrderSearchParams    iParams 		= new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams iExtParams 	= new EziExtSalesOrderSearchParams();
	EzBapicustselectTable 	     custtable		= new EzBapicustselectTable();
	EzBapicustselectTableRow     custtableRow 	= null;
	
	iParams.setStatusFlag("A");	//'O' for Open
	iParams.setSalesArea("N");

	int month=0, date=0, year=0;
	
	month = Integer.parseInt(fromDate.substring(0,2));
	date  = Integer.parseInt(fromDate.substring(3,5));
	year  = Integer.parseInt(fromDate.substring(6,10));	
	java.util.GregorianCalendar DateFrom = new java.util.GregorianCalendar(year,month-1,date);
	
	month = Integer.parseInt(toDate.substring(0,2));
	date  = Integer.parseInt(toDate.substring(3,5));
	year  = Integer.parseInt(toDate.substring(6,10));	
	java.util.GregorianCalendar DateTo = new java.util.GregorianCalendar(year,month-1,date);

	iParams.setDocumentDate(DateFrom.getTime());
	iParams.setDocumentDateTo(DateTo.getTime());
	
	//out.println("EzDocTypes::::::"+iParams.getDocumentDate());
	//out.println("EzDocTypes::::::"+iParams.getDocumentDateTo());

	EzBapiordersTable ordtable= new EzBapiordersTable();
	EzBapiordersTableRow ordtableRow =null;

	try
	{
		ReturnObjFromRetrieve retCatManager = null;
		EzCatalogParams ezcpparams1 = new EzCatalogParams();
		ezcpparams1.setLanguage("EN");
		ezcpparams1.setSysKey((String)session.getValue("SalesAreaCode"));
		ezcpparams1.setCatalogNumber((String)session.getValue("CatalogCode"));

		Session.prepareParams(ezcpparams1);
		retCatManager = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogSelected(ezcpparams1);

		java.util.ResourceBundle EzGetSalesList = java.util.ResourceBundle.getBundle("EzGetSalesList");
		int retCatCount = retCatManager.getRowCount();
		ArrayList duplicate = new ArrayList();

		for(int i=0;i<retCatCount;i++)
		{
			//out.println("EzDocTypes::::::"+retCatManager.getFieldValueString(i,"ISCHECKED"));
			if("Y".equals(retCatManager.getFieldValueString(i,"ISCHECKED")))
 	   		{
				String grp = retCatManager.getFieldValueString(i,"EPG_NO");
				if(grp != null && !"null".equals(grp))
				{
					String EzDocTypes = EzGetSalesList.getString("ORD_"+grp);
					if(EzDocTypes != null)
					{
						EzStringTokenizer doctypesSt = new EzStringTokenizer(EzDocTypes,",");
						int doctypesCt =doctypesSt.getTokens().size();
						if(doctypesCt == 0)
						{
							if(!duplicate.contains(EzDocTypes))
							{
								duplicate.add(EzDocTypes);
								ordtableRow = new EzBapiordersTableRow();
								
								ordtableRow.setDocType(EzDocTypes);
								ordtable.appendRow(ordtableRow);
							}	
						}
						else
						{
							for(int linall=0;linall<doctypesCt;linall++)
							{
								String docT = (String)doctypesSt.getTokens().elementAt(linall);
								if(!duplicate.contains(docT))
								{
									duplicate.add(docT);
									ordtableRow = new EzBapiordersTableRow();
									ordtableRow.setDocType(docT);
									
									ordtable.appendRow(ordtableRow);
								}
							}	
						}
					}
				}
	   		}//end of if
		}
	}catch(Exception e){}

	iParams.setSalesOrders(ordtable);
	ezcSalesOrderParams.setObject(iParams);
	ezcSalesOrderParams.setObject(iExtParams);
	Session.prepareParams(ezcSalesOrderParams);

	
	if("CU".equals(userRole) && "ALL".equals(request.getParameter("all")))
	{
		String[] stoken=allSoldTos_O.split("¥");
		if(stoken.length>1)
		{
			for(int i=0;i<stoken.length;i++)
			{
				custtableRow = new EzBapicustselectTableRow();
				custtableRow.setCustomer(stoken[i]);
				custtable.appendRow(custtableRow);				
			}
		}
		else
		{
			custtableRow = new EzBapicustselectTableRow();
			custtableRow.setCustomer(soldToQT);
			custtable.appendRow(custtableRow);		
		}	
		
			
		
	}else{
		
		custtableRow = new EzBapicustselectTableRow();
		custtableRow.setCustomer(soldToQT);
		custtable.appendRow(custtableRow);
	}	
	
	iParams.setCustomerSelection(custtable);

	EzoSalesOrderList salesParams =(EzoSalesOrderList)EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);

	returnStruct = salesParams.getReturn();
	orderList = new ReturnObjFromRetrieve();
	if(returnStruct.getRowCount() > 0)
	{
		String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
		if(errType.equalsIgnoreCase("E"))
		{
			orderList = salesParams.getSalesOrders();
		}
	}
	else
	{
		orderList = salesParams.getSalesOrders();
	}

	if(orderList!=null && orderList.getRowCount()>0)
	{
		for(int i=orderList.getRowCount()-1;i>=0;i--)
		{
			String ordStatus = orderList.getFieldValueString(i,"EzDocStatus");
			if("".equals(ordStatus))
				ordStatus = orderList.getFieldValueString(i,"DocStatus");

			if(ordStatus!=null && ("C".equals(ordStatus.trim()) || "".equals(ordStatus.trim())))
				orderList.deleteRow(i);
		}
	}

	//out.println("ret::::::::::::::::::::::::"+orderList.toEzcString());

	if(orderList!=null) cnt = orderList.getRowCount();
	//out.println("Count is ::"+cnt);
	if(cnt>0)
	{
		String sortCols[]= new String[1];
		sortCols[0]="DocDate";
		orderList.sort(sortCols,false);

		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("");
		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		names.addElement("DocDate");
		names.addElement("ValidFrom");
		names.addElement("SdDoc");
		EzGlobal.setColNames(names);
		ret = EzGlobal.getGlobal(orderList);

	}
	//out.println("::in Ipage::::");
		
%>
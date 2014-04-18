<%
	
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	EziWFDocHistoryParams wfdochistoryparams= new ezc.ezworkflow.params.EziWFDocHistoryParams();

	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	Session.prepareParams(ezcSOParams);

	EziSalesOrderSearchParams soSearchParams 	= new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams inparams 		= new EziExtSalesOrderSearchParams();
	
	ezcSOParams.setObject(soSearchParams);
	ezcSOParams.setObject(inparams);

	inparams.setSoldTos(agentCode);
	inparams.setSalesAreas(salesAreaCode);
	inparams.setCreatedBy(user);
	inparams.setRefDocType("'P','S','R'");
	LAST_LOGIN_TIME="00:00:00";
	inparams.setLastLoginDate(LAST_LOGIN_DATE+" " + LAST_LOGIN_TIME);

	String orderStatus1="";

	String fDate = request.getParameter("FDATE");
	String tDate = request.getParameter("TDATE");
	
	for(int vlength=0;vlength<vec.size();vlength++)
	{
		if(vlength==0)
			orderStatus1=(String)(vec.get(vlength));
		else
			orderStatus1=orderStatus1+","+(String)(vec.get(vlength));
	}

	StringTokenizer stoken=new StringTokenizer(agentCode,",");
	String SoldTos ="";

	if (stoken.countTokens()>1)
	{
		while(stoken.hasMoreTokens())
		{
			if(SoldTos.trim().length() ==0)
			SoldTos="'"+stoken.nextToken()+"'";
			else
			SoldTos+=",'"+stoken.nextToken()+"'";
		}
	}
	else
		SoldTos=agentCode;


	String query ="";

	query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')";

	wfdochistoryparams.setAuthKey("'SQ_CREATE'");
	wfdochistoryparams.setSysKey("'"+salesAreaCode+"'");
	wfdochistoryparams.setTemplateCode((String)session.getValue("Templet"));
	wfdochistoryparams.setRef1("ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE,ESDH_SAP_SO SAP_SO");

	//and ESDH_ORDER_DATE between  convert(DATETIME,'08/01/2006',110)  and  convert(DATETIME,'08/18/2006',110)


	if(fDate!=null && tDate!=null && !"null".equals(fDate) && !"null".equals(tDate))
	{
		wfdochistoryparams.setRef2(query +"AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+fDate+"',110)  and  convert(DATETIME,'"+tDate+"',110)");
	}
	else
	{	
		wfdochistoryparams.setRef2(query);
	}

	if("CU".equals(userRole) )
	{
		wfdochistoryparams.setCreatedBy("'"+user+"','"+superiorsusers+"'");
		wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
		//wfdochistoryparams.setParticipant("'"+group+"'");
		mainParams1.setObject(wfdochistoryparams);
		Session.prepareParams(mainParams1);
		retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
	}
	else if("CM".equals(userRole))
	{
		for(int vlength=0;vlength<vec.size();vlength++)
		{
			orderStatus1=(String)(vec.get(vlength));
			orderStatus1=orderStatus1.toUpperCase();

			if(toAct!=null && "Y".equals(toAct))
			{
				wfdochistoryparams.setParticipant("'"+group+"'");
			}

			wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
			
			mainParams1.setObject(wfdochistoryparams);
			Session.prepareParams(mainParams1);
			if(vlength==0)
			{
				retobj=(ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
			}
			else
			{
				ReturnObjFromRetrieve soList = (ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
				retobj.append(soList);
			}
		}
	}
%>


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

	if(newFilter!=null & "Y".equalsIgnoreCase(newFilter))
	inparams.setNewFilter("Y");
	String orderStatus1="";

	String fDate = request.getParameter("FDATE");
	String tDate = request.getParameter("TDATE");
	
	
	if(orderByMaterial!=null)
	{
		inparams.setType("Material");
		EzoSalesOrderList soList = (EzoSalesOrderList)EzSalesOrderManager.ezSalesOrderList(ezcSOParams);
		retobj=soList.getReturn();
	}
	else
	{
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
		if("PRODUCT".equals(searchType))
		{
			String pdesc=request.getParameter("searchPatern"); 
			if(pdesc != null)
			{
				pdesc=pdesc.trim();
				pdesc=pdesc.replace('*','%');
			}
			SoldTos = SoldTos.trim();
 			query ="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')  and ESDH_DOC_NUMBER in (SELECT WEB_ORNO from DOC_DETAILS  WHERE upper(PROD_DESC) like upper('%"+pdesc+"%') ) and ESDH_DEL_FLAG='N' ORDER BY ESDH_MODIFIED_ON DESC";
		}else if("PRODUCTNO".equals(searchType))
		{
			String pno=request.getParameter("searchPatern");
			if(pno != null)
			{
				pno=pno.trim();
				pno=pno.replace('*','%');
			}
			SoldTos = SoldTos.trim();

			query ="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')  and ESDH_DOC_NUMBER in (SELECT WEB_ORNO from DOC_DETAILS  WHERE upper(PROD_CODE) like upper('%"+pno+"%') OR upper(CUSTOMER_MAT) like upper('%"+pno+"%')) and ESDH_DEL_FLAG='N' ORDER BY ESDH_MODIFIED_ON DESC";
		}
		else if("SAPSO".equals(searchType))
		{
			String pno=request.getParameter("searchPatern");
			if(pno != null)
			{
				pno=pno.trim();
				pno=pno.replace('*','%');
			}
			SoldTos = SoldTos.trim();

			query ="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')  and ESDH_BACK_END_ORDER LIKE '%"+pno+"%' and ESDH_DEL_FLAG='N' ORDER BY ESDH_MODIFIED_ON DESC";
		}
		else
		{
			 query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')";
		}
		wfdochistoryparams.setAuthKey("'SO_CREATE'");
		wfdochistoryparams.setSysKey("'"+salesAreaCode+"'");
		wfdochistoryparams.setTemplateCode((String)session.getValue("Templet"));
		wfdochistoryparams.setRef1("ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE");
		
		//and ESDH_ORDER_DATE between  convert(DATETIME,'08/01/2006',110)  and  convert(DATETIME,'08/18/2006',110)
		
		
		if(fDate!=null && tDate!=null && !"null".equals(fDate) && !"null".equals(tDate))
		{
			wfdochistoryparams.setRef2(query +"AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+fDate+"',110)  and  convert(DATETIME,'"+tDate+"',110)");
		}
		else
		{	
			wfdochistoryparams.setRef2(query);
		}

		if("Y".equalsIgnoreCase(newFilter))
		{
			Date dd=new Date();
			dd.setTime(dd.getTime()+10000000);
			SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy hh:mm:ss:SS a");
			String today=sdf.format(dd);

			wfdochistoryparams.setModifiedOn1(""+LAST_LOGIN_DATE+"'");
			wfdochistoryparams.setModifiedOn2(today+"'");
			
			
			//out.println(LAST_LOGIN_DATE);
		}
					//out.println("userRoleuserRoleuserRoleuserRole  "+userRole);

		if(searchType!=null && !"null".equals(searchType) && !"".equals(searchType))
		{
			if("CU".equals(userRole) )
				wfdochistoryparams.setCreatedBy("'"+user+"','"+superiorsusers+"'");
			else if("CM".equals(userRole) )
				wfdochistoryparams.setCreatedBy("'"+user+"','"+sabardinates+"'");
			
			wfdochistoryparams.setRef2(query);
			wfdochistoryparams.setStatus("'TRANSFERED'");
			mainParams1.setObject(wfdochistoryparams);
			Session.prepareParams(mainParams1);

			retobj=(ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
			
		}
		else if("CU".equals(userRole) )
		{
		
			if("'NEW'".equals(orderStatus1) || "'NEGOTIATED'".equalsIgnoreCase(orderStatus1))
			{
				wfdochistoryparams.setCreatedBy("'"+user+"','"+subuserIds+"','"+superiorsusers+"'");//superiorsusers
			}else
			{
				if("Y".equalsIgnoreCase(newFilter))
					wfdochistoryparams.setRef2(query+"and EWDHH_CREATED_BY NOT IN('"+(String)Session.getUserId()+"')");
				else
					wfdochistoryparams.setCreatedBy("'"+user+"','"+superiorsusers+"'");								
			}
			wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
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
				

				if("'NEW'".equalsIgnoreCase(orderStatus1) || "'NEGOTIATED'".equalsIgnoreCase(orderStatus1))
				{
					wfdochistoryparams.setCreatedBy("'"+user+"','"+SoldTos+"'");
					wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
				}
					
				else if("'TRANSFERED'".equals(orderStatus1))
				{
					wfdochistoryparams.setRef2(query);
					
					if("Y".equalsIgnoreCase(newFilter))
						wfdochistoryparams.setRef2(query+"and EWDHH_CREATED_BY NOT IN('"+(String)Session.getUserId()+"')");
					
					wfdochistoryparams.setStatus(orderStatus1.toUpperCase());

				}
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


	}
	if("WEB".equals(searchType))
	{


		String wsearch=request.getParameter("searchPatern");
		if(wsearch!=null)
		{
			mySearch.search(retobj,"WEB_ORNO",wsearch);
		}
	}
	/*
	if("SAPSO".equals(searchType))
	{


		String wsearch=request.getParameter("searchPatern");
		if(wsearch!=null)
		{
			mySearch.search(retobj,"BACKEND_ORNO",wsearch); 
		}
	}
	*/

	 if("PONO".equals(searchType))
	 {

		String wsearch=request.getParameter("searchPatern");
		
		if(wsearch!=null)
		{
			mySearch.search(retobj,"PO_NO",wsearch);
		}
	 }


	
%>


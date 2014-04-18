<%!	
	public Vector getSubUserShips(String user_id,ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		//String query="SELECT A.*, B.ECA_NO, B.ECA_NAME, B.ECA_COMPANY_NAME,B.ECA_ERP_UPDATE_FLAG, B.ECA_PHONE, B.ECA_ADDR_2,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_COUNTRY,B.ECA_TRANSORT_ZONE,B.ECA_JURISDICTION_CODE,B.ECA_LANG,B.ECA_EMAIL,B.ECA_WEB_ADDR FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE  A.EC_PARTNER_FUNCTION IN ('WE') AND A.EC_PARTNER_NO IN (SELECT DISTINCT(EECD_DEFAULTS_VALUE) FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE EECD_NO IN (SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+user_id+"' AND EUD_KEY='SOLDTOPARTY' ) AND EECD_DEFAULTS_KEY='SHIPTO' AND EECD_USER_ID='"+user_id+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO AND EC_SYS_KEY='"+sysKey+"' AND EC_BUSINESS_PARTNER='"+bussPart+"'";
		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY' ";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		Vector toDelShips = null;
		int retCnt = 0;
		if(retObjMisc!=null){
			retCnt = retObjMisc.getRowCount();
			toDelShips =new Vector();
		}	
		if(retCnt>0)	
		{
			for(int i=0;i<retCnt;i++)	
			{
				toDelShips.add(retObjMisc.getFieldValueString(i,"SHIPTO"));		

			}
		}

		return toDelShips;
	}
	public ReturnObjFromRetrieve getListOfShipTos(String selSol,String userType,String BussPart, String isSubUser, ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		
		miscParams.setIdenKey("MISC_SELECT");
		
		String appendQry = "";
		String soldToQry = "";
		if("3".equals(userType) && !"FD".equals(selSol))
			appendQry = "AND EC_BUSINESS_PARTNER='"+BussPart+"'";
		if(!"FD".equals(selSol))
			soldToQry = " EC_ERP_CUST_NO='"+selSol+"' AND "	;
			
		String query="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE "+soldToQry+" EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO ";
	
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::34566::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			if("Y".equals(isSubUser))
			{
				if(retObjMisc!=null)
				{
					Vector delShips = (Vector)getSubUserShips(Session.getUserId(),Session);
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String toBeDel = retObjMisc.getFieldValueString(i,"EC_PARTNER_NO");
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
						{
							retObjMisc.deleteRow(i);
						}
						else
						{
							if(!delShips.contains(toBeDel))
								retObjMisc.deleteRow(i);
						}
					}
				}
			}			
			else
			{
				if(retObjMisc!=null)
				{
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							retObjMisc.deleteRow(i);
					}
				}
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		

		return retObjMisc;
	}	
%>	

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
	orderStatus1="";
	
	String apprSel = request.getParameter("appSel");
 	String reqSel  = request.getParameter("reqSel");
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
 
	if(apprSel==null )
	{
		if(userAuth_R.containsKey("FOC_APPR")) 
		{
			reqSel 	= "AL";
			apprSel = "MYS";
		}
	}
	if(reqSel==null)
	{
		if(userAuth_R.containsKey("FOC_ORDER"))
		{
			reqSel 	= "MYS";	
			apprSel = "";
		}
	}	
 	
 	//if(reqSel==null || "null".equals(reqSel)) reqSel ="MYS";
 	//if(apprSel==null || "null".equals(apprSel)) apprSel ="AL";
	String poFDate = request.getParameter("fromDate");
	String poTDate = request.getParameter("toDate");
	String negotiateType = request.getParameter("negotiateType");
	String selSubUser = request.getParameter("subUser");
	if(selSubUser!=null && !"".equals(selSubUser) && !"null".equals(selSubUser))subuserIds=selSubUser;
		
	String ordSrch = request.getParameter("webSrch"); //To Get WebOrders from DB
			
	//out.println("poFDate::::::::::::::::::"+poFDate);
	//out.println("poTDate::::::::::::::::::"+poTDate);
	
	//out.println("negotiateType::::::::::::::::::"+negotiateType);
	//if(!"Y".equals(ordSrch))
	{


		if(orderByMaterial!=null)
		{
			inparams.setType("Material");
			EzoSalesOrderList soList = (EzoSalesOrderList)EzSalesOrderManager.ezSalesOrderList(ezcSOParams);
			retobj=soList.getReturn();
		}
		else
		{
			//out.println("vec.size()::::::::"+vec.size());
			for(int vlength=0;vlength<vec.size();vlength++)
			{
				if(vlength==0)
					orderStatus1=(String)(vec.get(vlength));
				else
					orderStatus1=orderStatus1+","+(String)(vec.get(vlength));
			}
			//out.println("vec.size()::::::::"+request.getParameter("selSoldTo"));
			if(request.getParameter("selSoldTo")==null || "".equals(request.getParameter("selSoldTo")) || "null".equals(request.getParameter("selSoldTo")))		
				if("CU".equals(userRole))
					agentCode = (String)session.getValue("SOLDTO_SUPER");	
				
			String[] stoken=agentCode.split("¥");
			SoldTos ="";
			if(stoken.length>1)
			{
				for(int i=0;i<stoken.length;i++)
				{
					if(i==0)
						SoldTos=stoken[i];	
					else
						SoldTos=SoldTos+"','"+stoken[i];
				}
			
			}
			else if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))
				SoldTos = request.getParameter("selSoldTo");
			else
				SoldTos=agentCode;			
						
			/*if (stoken.countTokens()>1)
			{
				while(stoken.hasMoreTokens())
				{
					out.println("::countTokens::2:"+SoldTos.trim().length());
					if(SoldTos.trim().length() ==0)
					{
						SoldTos="'"+stoken.nextToken()+"'";
						out.println("::SoldTos:::"+SoldTos);
					}	
					else
						SoldTos=SoldTos+",'"+stoken.nextToken()+"'";
				}
			}
			else
				SoldTos=agentCode;*/


			SoldTos = SoldTos.trim();
			String selectedSoldTo = request.getParameter("selSoldTo");
			//ezc.ezcommon.EzLog4j.log("selectedSoldTo:::::::"+selectedSoldTo,"D");
			if(selectedSoldTo!=null && !"null".equals(selectedSoldTo) && !"".equals(selectedSoldTo))
				SoldTos =selectedSoldTo;
			else
				SoldTos = SoldTos;

			String query ="";
			
			if("CM".equals(userRole))
			{
				if("N".equals(displayOrder))
					query = "EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_DOC_NUMBER IN (SELECT ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC NOT IN (SELECT ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_ORDER_TYPE IN ('ZDPO','ZIDP')))"; // and ESDH_SOLD_TO in('"+SoldTos+"')
				if("Y".equals(displayOrder))
					query = "EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_DOC_NUMBER IN (SELECT ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC IN (SELECT ESDI_SALES_DOC FROM EZC_SALES_DOC_ITEMS WHERE ESDI_ORDER_TYPE IN ('ZDPO','ZIDP')))"; // and ESDH_SOLD_TO in('"+SoldTos+"')				
				if("C".equals(displayOrder))
					query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER"; // and ESDH_SOLD_TO in('"+SoldTos+"')
			}
			else
			{
				query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER"; // and ESDH_SOLD_TO in('"+SoldTos+"')
			}
			String focColumns = "";
			if("FORAPPROVAL".equals(negotiateType) || "FOCAPPROVED".equals(negotiateType) || "FOCREJECTED".equals(negotiateType) || "ALL".equals(negotiateType))
			{
				query = "EZC_SALES_DOC_HEADER, EZC_ORDER_NEGOTIATE WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER AND EWDHH_DOC_ID=EON_ORDER_NO";
				focColumns = " ,EON_INDEX_NO,EON_CREATED_BY,EON_STATUS";
			}	
			
			//if("'SUBMITTED'".equalsIgnoreCase(orderStatus))
				//query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER ";

			String ref1 = "";
			wfdochistoryparams.setAuthKey("'SO_CREATE'");
			//wfdochistoryparams.setSysKey("'"+salesAreaCode+"'");
			//wfdochistoryparams.setTemplateCode((String)session.getValue("Templet"));
			wfdochistoryparams.setRef1("ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE,ESDH_NET_VALUE NET_VALUE,ESDH_TEMPLATE_NAME TEMPLATE_NAME,ESDH_SAVE_FLAG SAVE_FLAG,ESDH_FREIGHT_PRICE FREIGHT_PRICE"+focColumns);
			if(negotiateType!=null)
			{
				String apprQry = "";
				
				if("MYS".equals(reqSel))
				{
					if("MYS".equals(apprSel))
						apprQry = " AND EON_INDEX_NO in('"+user+"') AND EON_CREATED_BY in('"+user+"') ";
					else
						apprQry = " AND EON_CREATED_BY in('"+user+"') ";	
				}
				else
				{
					if("MYS".equals(apprSel))
						apprQry = " AND EON_INDEX_NO in('"+user+"') ";
				}
				
				if(!"".equals(request.getParameter("selSoldTo")) && "CU".equals(userRole) && request.getParameter("shipTo")!=null && !"null".equals(request.getParameter("shipTo")) && !"A".equals(request.getParameter("shipTo")) && !"Y".equals((String)session.getValue("IsSubUser")))
				{
					query = query + " AND ESDH_SHIP_TO = '"+request.getParameter("shipTo")+"'";
					wfdochistoryparams.setRef2(query);
					log4j.log("shipToQT query:"+query,"D");
				}
				else if(request.getParameter("shipTo")!=null && !"null".equals(request.getParameter("shipTo")) && !"A".equals(request.getParameter("shipTo")) && !"Y".equals((String)session.getValue("IsSubUser")))
				{
					query = query + " AND ESDH_SHIP_TO = '"+request.getParameter("shipTo")+"'";
					wfdochistoryparams.setRef2(query);
					log4j.log("shipToQT query:"+query,"D");				
				}
				else if("Y".equals((String)session.getValue("IsSubUser")) && !"Y".equals((String)session.getValue("REPAGENCY")) && "A".equals(request.getParameter("shipTo")))
				{
					Vector delShips = (Vector)getSubUserShips(Session.getUserId(),Session);
					String subShips = "";
					for(int i=0;i<delShips.size();i++)
					{
						if(subShips=="" || "".equals(subShips))
							subShips = (String)delShips.get(i);
						else
							subShips = subShips +"','"+(String)delShips.get(i);
					}
					query = query + " AND ESDH_SHIP_TO IN ('"+subShips+"')";
					wfdochistoryparams.setRef2(query);						

				}				
				if("INPROCESS".equals(negotiateType) || "NEGOTIATED".equals(negotiateType))
				{
					if("CU".equals(userRole))
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('"+negotiateType+"'))";
					else
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+negotiateType+"'))";//EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and 	
					query =query+" and ESDH_STATUS IN ('"+negotiateType+"','NEGOTIATED')";
					log4j.log("NEGO_INPROCESS query:"+query,"D");
				}
				else if("ACCEPTED".equals(negotiateType))
				{
					String subUsers_N = toPassUserId;
					/*if("CU".equals(userRole))
					{
						if(!"Y".equals((String)session.getValue("REPAGENCY")))
						{
							if(selSubUser!=null && !"".equals(selSubUser) && !"null".equals(selSubUser))
								subUsers_N = selSubUser;
							else
								subUsers_N = subuserIds;
						}
					}*/
					if("CU".equals(userRole))
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('"+negotiateType+"'))";
					else
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+negotiateType+"'))";
					query =query+" and ESDH_STATUS IN ('"+negotiateType+"','APPROVED')";
					log4j.log("NEGO_ACCEPTED query:"+query,"D");
				}
				else if("REJECTED".equals(negotiateType))
				{
					if("CU".equals(userRole))
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('"+negotiateType+"'))";
					else	
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+negotiateType+"'))";	
					log4j.log("NEGO_REJECTED query:"+query,"D");
				}
				else if("CLOSED".equals(negotiateType))
				{
					if("CU".equals(userRole))
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('"+negotiateType+"','REJECTED'))";
					else
						query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+negotiateType+"','REJECTED'))";
					
					query =query+" and ESDH_STATUS IN ('"+negotiateType+"','REJECTED')";
					log4j.log("NEGO_REJECTED query:"+query,"D");
				}
				else if("FORAPPROVAL".equals(negotiateType))
				{
					query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+negotiateType+"'))"+apprQry ;// AND EON_INDEX_NO in('"+user+"')
					log4j.log("NEGO_FORAPPROVAL query:"+query,"D");
				}
				else if("FOCAPPROVED".equals(negotiateType) || "FOCREJECTED".equals(negotiateType) || "ALL".equals(negotiateType))
				{
					String tempStat = negotiateType;
					if("ALL".equals(negotiateType)) tempStat = "FOCAPPROVED','FOCREJECTED','FOCACCEPTED";
					if("FOCAPPROVED".equals(negotiateType)) tempStat = "FOCAPPROVED','FOCACCEPTED";

					query =query+" and ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_STATUS in('"+tempStat+"'))"+apprQry;
					log4j.log("NEGO_ALL query:"+query,"D");
				}
			}
			if(selectedSoldTo!=null && !"null".equals(selectedSoldTo) && !"".equals(selectedSoldTo) && !"Welcome".equalsIgnoreCase(request.getParameter("fromPage")))
				query = query+" AND ESDH_SOLD_TO in('"+SoldTos+"')";			

			//out.println("userRoleuserRoleuserRoleuserRole  "+userRole);
			if(poFDate!=null && poTDate!=null && !"null".equals(poFDate) && !"null".equals(poTDate))
			{
				//wfdochistoryparams.setRef2(query+"AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+poFDate+"',110)  and  convert(DATETIME,'"+poTDate+"',110)");
				query=query+" AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+poFDate+"',110)  and  convert(DATETIME,'"+poTDate+"',110)";
				//out.println("query11111::::::::::::::::::::::"+wfdochistoryparams.getRef2());
			}	
			if(!"null".equals(strPOnumber) && !"".equals(strPOnumber) && strPOnumber!=null)
			{
				query=query+"AND ESDH_PO_NO LIKE '"+strPOnumber+"'";
			}
			if("CU".equals(userRole))
			{
				//out.println("orderStatus1>>>>>>>>  "+orderStatus1);
				if("'NEW'".equalsIgnoreCase(orderStatus1.trim()) || "'NEGOTIATED'".equalsIgnoreCase(orderStatus1.trim()) || "'SUBMITTED'".equalsIgnoreCase(orderStatus1.trim()))
				{
					//wfdochistoryparams.setCreatedBy("'"+user+"','"+subuserIds+"','"+superiorsusers+"'");//superiorsusers
					if(!"Y".equals((String)session.getValue("REPAGENCY")))
					{
					if(selSubUser!=null && !"".equals(selSubUser) && !"null".equals(selSubUser))
						//wfdochistoryparams.setCreatedBy("'"+user+"','"+toPassUserId+"','"+subuserIds+"'");//superiorsusers ,'"+superiorsusers+"' subuserIds--list of all subusers.
						wfdochistoryparams.setCreatedBy("'"+selSubUser+"','"+user+"'");	
						else 
							wfdochistoryparams.setCreatedBy("'"+user+"','"+subuserIds+"'");
					}
					wfdochistoryparams.setRef2(query);
					//log4j.log("query11111::::::::::::::::::::::"+wfdochistoryparams.getRef2(),"D");
				}else
				{
					if("Y".equalsIgnoreCase(newFilter))
						wfdochistoryparams.setRef2(query+"and EWDHH_CREATED_BY NOT IN('"+(String)Session.getUserId()+"')");
					else
						wfdochistoryparams.setCreatedBy("'"+user+"','"+superiorsusers+"'");

				}
				//if("'NEGOTIATED'".equalsIgnoreCase(orderStatus1.trim()))orderStatus1="'ACCEPTED','APPROVED'";
				if("CLOSED".equals(negotiateType))
				{
					wfdochistoryparams.setStatus("'CLOSED','NEGOTIATED'");
				}
				else
				{
					if("'SUBMITTED'".equalsIgnoreCase(orderStatus1.trim()))
						wfdochistoryparams.setStatus("'SUBMITTED','TRANSFERED'");
					else
						wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
				}
				mainParams1.setObject(wfdochistoryparams);
				Session.prepareParams(mainParams1);
				retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
			}
			if("CM".equals(userRole.trim()))
			{
				for(int vlength=0;vlength<vec.size();vlength++)
				{
					orderStatus1=(String)(vec.get(vlength));
					orderStatus1=orderStatus1.toUpperCase();
					ezc.ezcommon.EzLog4j.log("orderStatus1:::::::::::::::"+orderStatus1,"D");
					ezc.ezcommon.EzLog4j.log("vector:::::::::::::::"+vec,"D");


					if("'NEW'".equalsIgnoreCase(orderStatus1) || "'NEGOTIATED'".equalsIgnoreCase(orderStatus1.trim()) || "'SUBMITTED'".equalsIgnoreCase(orderStatus1.trim()))
					{
						//wfdochistoryparams.setCreatedBy("'"+user+"','"+SoldTos+"'");
						//wfdochistoryparams.setCreatedBy("'"+user+"','"+toPassUserId+"','"+SoldTos+"'"); //commented by chanakya to get the orders specific to the created user.
						//ezc.ezcommon.EzLog4j.log("SoldTos in CM LOOP:::::::::::::::"+SoldTos,"D");
						//if("N".equals(orderType_N))
							//wfdochistoryparams.setCreatedBy("'"+user+"','"+toPassUserId+"','"+SoldTos+"'");
						//else if("A".equals(orderType_N))
						{
							//wfdochistoryparams.setCreatedBy("'"+user+"'");
						}
						//else 
						if("'NEW'".equalsIgnoreCase(orderStatus1))
							wfdochistoryparams.setCreatedBy("'"+Session.getUserId()+"'");

						if("CLOSED".equals(negotiateType))
						{
							wfdochistoryparams.setStatus("'CLOSED','NEGOTIATED'");
						}
						else
						{
							if("'SUBMITTED'".equalsIgnoreCase(orderStatus1.trim()))
								wfdochistoryparams.setStatus("'SUBMITTED','TRANSFERED'");
							else
								wfdochistoryparams.setStatus(orderStatus1.toUpperCase());
						}
						wfdochistoryparams.setRef2(query);
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
					//ezc.ezcommon.EzLog4j.log("vlength>>>>>>>>>>>>1>>>>"+vlength,"D");
					if(vlength==0)
					{
						retobj=(ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
						//ezc.ezcommon.EzLog4j.log("vlength>>>>>>>>>>>>2>>>"+vlength,"D");
					}
					else
					{
						ReturnObjFromRetrieve soList = (ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);
						//ezc.ezcommon.EzLog4j.log("vlength>>>>>>>>>>>>3>>>>"+vlength,"D");
						retobj.append(soList);
					}


				}

			}
						retobj.sort(new String[]{"WEB_ORNO"},false);
		}
	}
		
%>
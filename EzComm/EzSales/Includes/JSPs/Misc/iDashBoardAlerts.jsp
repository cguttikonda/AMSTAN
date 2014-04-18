<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*,java.net.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />  
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/> 
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
	String computerName = null;
	String remoteAddress = request.getRemoteAddr();
	//out.println("remoteAddress: " + remoteAddress);
	try {
		InetAddress inetAddress = InetAddress.getByName(remoteAddress);
		computerName = inetAddress.getHostName();
		if (computerName.equalsIgnoreCase("localhost")) {
			computerName = java.net.InetAddress.getLocalHost().getCanonicalHostName();
		} 
		//out.println("computerName: " + computerName);
	}
	catch (UnknownHostException e) {}

	//session.setMaxInactiveInterval(120);
    	String fileName = request.getServletPath();
    	if(fileName!=null)
    	{
    		fileName = fileName.substring((fileName.lastIndexOf('/'))+1,fileName.length());
    	}
    	//out.println("fileName::::::"+fileName);
	cdObj.add(Calendar.DATE, -90);

	int fyear = cdObj.get(Calendar.YEAR);
	int fMonth = cdObj.get(Calendar.MONTH); 
	int fDate = cdObj.get(Calendar.DATE);

	cMonth = cMonth+1;
	fMonth = fMonth+1;

	String fDate_S = fDate+"";
	String fMonth_S = fMonth+"";
	String cDate_S = (cDate)+"";  
	String cMonth_S = cMonth+"";

	if(fDate<10) fDate_S = "0"+fDate;
	if(fMonth<10) fMonth_S = "0"+fMonth; 
	if(cDate<10) cDate_S = "0"+cDate;
	if(cMonth<10) cMonth_S = "0"+cMonth;

	// returning the first date
	Calendar calStart=Calendar.getInstance();
	calStart.set(Calendar.YEAR,cYear);
	calStart.set(Calendar.MONTH,0);
	calStart.set(Calendar.DAY_OF_MONTH,1);
	Date startDate=calStart.getTime();

	int vfYear  = calStart.get(Calendar.YEAR);
	int vfMonth = calStart.get(Calendar.MONTH); 
	int vfDate  = calStart.get(Calendar.DATE);

	// returning the last date
	Calendar calEnd=Calendar.getInstance();
	calEnd.set(Calendar.YEAR,cYear);
	calEnd.set(Calendar.MONTH,11);
	calEnd.set(Calendar.DAY_OF_MONTH,31);	
    	Date endDate=calEnd.getTime();

    	int vtYear  = calEnd.get(Calendar.YEAR);
	int vtMonth = calEnd.get(Calendar.MONTH); 
	int vtDate  = calEnd.get(Calendar.DATE);

	vfMonth = vfMonth+1;
	vtMonth = vtMonth+1;

	String vfDate_S = vfDate+"";
	String vfMonth_S = vfMonth+"";
	String vtDate_S = vtDate+"";  
	String vtMonth_S = vtMonth+"";

	if(vfDate<10) vfDate_S = "0"+vfDate;
	if(vfMonth<10) vfMonth_S = "0"+vfMonth; 
	if(vtDate<10) vtDate_S = "0"+vtDate;
	if(vtMonth<10) vtMonth_S = "0"+vtMonth;
	// open orders end

	String fromDate1 = fMonth_S+"/"+fDate_S+"/"+fyear;
	String toDate1 = cMonth_S+"/"+cDate_S+"/"+cYear;

	//out.println("hello");

	String agtCode_A	= (String)session.getValue("AgentCode");
	String UserRole_A 	= (String)session.getValue("UserRole");	
	//if("ezDashBoard.jsp".equalsIgnoreCase(fileName))

	// invoices start
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	FormatDate formatDate = new FormatDate();

	//out.println("inv::::::::::::::::::::::::"+rowno);

	//orders

	String user=Session.getUserId();	
	String userRole=(String)session.getValue("UserRole");	
	String LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	String LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME"); 
	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode");

	//igetwfsessusers

	String template		= (String)session.getValue("Templet");
	String group		= (String)session.getValue("UserGroup");
	String catalog_area	= (String)session.getValue("SalesAreaCode");
	//catalog_area="999001";

	String desiredStep	= "";
	String superiorsusers 	= "";
	String participant	= "";
	String sabardinates 	= "";

	ArrayList desireStepV 	= new ArrayList();
	ArrayList downStepV 	= new ArrayList();
	if(userRole.equals("CU"))
	{
		desireStepV.add("-1");
		desireStepV.add("-2");
		desireStepV.add("-3");

	}else if(userRole.equals("CM"))
	{
		downStepV.add("1");
		desireStepV.add("-1");
		desireStepV.add("-2");

	}else if(userRole.equals("LF"))
	{
		desireStepV.add("-1");
		downStepV.add("1");
		downStepV.add("2");

	}else if(userRole.equals("BP"))
	{
		downStepV.add("1");
		downStepV.add("2");
		downStepV.add("3");
	}

	ezc.ezparam.ReturnObjFromRetrieve retsoldto = null;
	ezc.ezparam.ReturnObjFromRetrieve retsoldtoDown = null;

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams wfparams= new ezc.ezworkflow.params.EziWFParams();
	wfparams.setTemplate(template);
	wfparams.setSyskey(catalog_area);
	wfparams.setParticipant((String)session.getValue("Participant"));
	wfparams.setDesiredSteps(desireStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	wfparams.setDesiredSteps(downStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldtoDown=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	if(retsoldto != null)
	{
		int wfcount = retsoldto.getRowCount();
		String[] superiors = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			superiors[i] = retsoldto.getFieldValueString(i,"EU_ID");
			if(superiorsusers.trim().length() == 0)
				superiorsusers = (superiors[i]).trim();
			else
				superiorsusers += "','"+(superiors[i]).trim();

		}
	}
	if(retsoldtoDown != null)
	{
		int wfcount = retsoldtoDown.getRowCount();
		String[] sabardinate = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			sabardinate[i] = retsoldtoDown.getFieldValueString(i,"EU_ID");
			if(sabardinates.trim().length() == 0)
				sabardinates = (sabardinate[i]).trim();
			else
				sabardinates += "','"+(sabardinate[i]).trim();
		}
	}

	ReturnObjFromRetrieve partnersRet = null;
	String soldTo = (String) session.getValue("AgentCode");
	//soldTo="0102400000";
	//out.println("soldTo::::::::::::::::::::::::"+soldTo);
	//out.println("ShipCode::::::::::::::::::::::::"+session.getValue("ShipCode"));
	if(catalog_area!=null && soldTo!=null)
	{
		soldTo = soldTo.trim();

		String mySoldTo = "";

		try
		{
			soldTo = Long.parseLong(soldTo)+"";
			mySoldTo = "0000000000"+soldTo;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}
		catch(Exception ex){mySoldTo = soldTo;}

		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(catalog_area);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}

	int partnersRetCnt = 0;
	String subuserIds="";

	if(partnersRet!=null)
	{
		for(int i=partnersRet.getRowCount()-1;i>=0;i--)
		{
			String tempuserId = partnersRet.getFieldValueString(i,"EU_ID");

			if("".equals(subuserIds))
			{
				subuserIds=(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
			else
			{
				subuserIds=subuserIds+"','"+(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
		}

		partnersRetCnt = partnersRet.getRowCount();
	}

	//out.println("subuserIds::::"+subuserIds);
	//out.println("sabardinates::::"+sabardinates); 
	//out.println("superiorsusers::::"+superiorsusers);

	//iwebsolist

	EzcParams mainParamsMisc= new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	ReturnObjFromRetrieve retObjMisc = null;
	int countMisc=0;

	EzcParams mainParamsMisc1= new EzcParams(false);
	EziMiscParams miscParams1 = new EziMiscParams();

	EzcParams mainParamsMisc_N= new EzcParams(false);
	ReturnObjFromRetrieve retObjMisc1 = null;
	int countMisc1=0;

	String orderStatus1="";
	String SoldTos ="";
	String allTempSoldTo = "";
	HashMap soldToNames = new HashMap();

	ReturnObjFromRetrieve partnersRet_L = null; 
	soldTo = "0000000000"+soldTo;
	soldTo = soldTo.substring((soldTo.length()-10),soldTo.length());
	String 	SoldTosTemp = "";;
	String	toPassUserId="";
	//if("ezDashBoard.jsp".equalsIgnoreCase(fileName))
	{
		if("CU".equals(userRole) )
		{				
			int tempSoldToCNt=0;
			ReturnObjFromRetrieve	rettempsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
			//ezc.ezcommon.EzLog4j.log("rettempsoldto:::::::::::::"+rettempsoldto.toEzcString() ,"I");
			if(rettempsoldto!=null)tempSoldToCNt=rettempsoldto.getRowCount();

			for(int k=0;k<tempSoldToCNt;k++)
			{
				if(k==0)
				{
					SoldTos	      = rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
					allTempSoldTo = rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
				}	
				else
				{
					SoldTos= SoldTos+"','"+rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
					allTempSoldTo = allTempSoldTo+"$$"+rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
				}
				soldToNames.put(rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO"),rettempsoldto.getFieldValueString(k,"ECA_NAME"));
			}

			if(soldToNames.size()>0)
				session.putValue("SOLDTONAMES",soldToNames);

			String[] stoken=((String)session.getValue("SOLDTO_SUPER")).split("¥");
			if(stoken.length>1)
			{
				for(int i=0;i<stoken.length;i++)
				{
					if(i==0)
						soldTo=stoken[i];	
					else
						soldTo=soldTo+"','"+stoken[i];
				}
			}

			if("Y".equals((String)session.getValue("IsSubUser")))
				subuserIds = "";								
			//out.println("soldToNames::::::::::::::::::"+soldToNames);
			miscParams.setIdenKey("MISC_SELECT");
			//String query="SELECT EWDHH_AUTH_KEY AUTHKEY,EWDHH_DOC_ID DOCID,EWDHH_SYSKEY SYSKEY,EWDHH_KEY DOCKEY,EWDHH_DOC_DATE DOCDATE,EWDHH_WF_STATUS STATUS,EWDHH_CREATED_ON CREATEDON,EWDHH_MODIFIED_ON MODIFIEDON,EWDHH_CREATED_BY CREATEDBY,EWDHH_MODIFIED_BY MODIFIEDBY,EWDHH_CURRENT_STEP CURRENTSTEP,EWDHH_NEXT_PARTICIPANT NEXTPARTICIPANT,EWDHH_PARTICIPANT_TYPE PARTICIPANTTYPE, EWDHH_NEXT_D_PARTICIPANT DELPARTICIPANT,EWDHH_D_PARTICIPANT_TYPE DELPARTICIPANTTYPE,EWDHH_REF1 REF1 ,ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE   FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_SYSKEY IN('999001') AND EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN('102400000','102400000','SGEORGE') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN('0102400000')AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'02/27/2012',110) ";
			//miscParams.setQuery("SELECT * FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_SYSKEY IN ('"+catalog_area+"') AND EWDHH_WF_STATUS IN ('NEGOTIATED') AND ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('INPROCESS')) AND EWDHH_CREATED_BY IN ('"+toPassUserId+"','"+user+"','"+subuserIds+"','"+superiorsusers+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+soldTo+"') AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110)");
			miscParams.setQuery("SELECT Count(distinct(EWDHH_DOC_ID)) Count FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_CREATED_BY IN ('"+user+"','"+subuserIds+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+soldTo+"') AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110) AND ESDH_STATUS IN ('ACCEPTED','APPROVED') AND EWDHH_WF_STATUS IN ('NEGOTIATED')") ;
			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	

			try
			{
				ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
				retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
				ezc.ezcommon.EzLog4j.log("query: in NEGO:::::::"+miscParams.getQuery() ,"I");
				countMisc=Integer.parseInt(retObjMisc.getFieldValueString(0,"Count"));
				if(countMisc>0)
					session.putValue("NEGCNT_CU",countMisc+"");									
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}

			miscParams1.setIdenKey("MISC_SELECT");
			miscParams1.setQuery("SELECT COUNT(*) SAVEDCNT FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN ('"+user+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+soldTo+"') AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110)"); //'"+toPassUserId+"',

			mainParamsMisc1.setLocalStore("Y");
			mainParamsMisc1.setObject(miscParams1);
			Session.prepareParams(mainParamsMisc1);	

			try
			{
				//ezc.ezcommon.EzLog4j.log("SoldTos::::::::::::::::::"+SoldTos,"D");
				retObjMisc1 = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc1);
				countMisc1=Integer.parseInt(retObjMisc1.getFieldValueString(0,"SAVEDCNT"));
				//out.println("countMisc1::::"+countMisc1+"");
				if(countMisc1>0)
					session.putValue("SAVEDCNT",countMisc1+"");									
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}							
		}
		else if("CM".equals(userRole))
		{
			String soldToUserId ="";
			int tempSoldToCNt=0;
			String tempSoldTo="";
			ReturnObjFromRetrieve	rettempsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
			//ezc.ezcommon.EzLog4j.log("rettempsoldto:::::::::::::"+rettempsoldto.toEzcString() ,"I");
			if(rettempsoldto!=null)tempSoldToCNt=rettempsoldto.getRowCount();
			for(int k=0;k<tempSoldToCNt;k++)
			{
				if(k==0)
				{
					SoldTos       = rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
				}	
				else
				{
					SoldTos= SoldTos+"','"+rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO");
				}
				soldToNames.put(rettempsoldto.getFieldValueString(k,"EC_ERP_CUST_NO"),rettempsoldto.getFieldValueString(k,"ECA_NAME"));
			}
			for(int l=0;l<tempSoldToCNt;l++)
			{
				if(l==0)
					soldToUserId = rettempsoldto.getFieldValueString(l,"EC_ERP_CUST_NO");
				else	
					soldToUserId= soldToUserId+","+rettempsoldto.getFieldValueString(l,"EC_ERP_CUST_NO");
			}							
			//out.println("soldToNames::::::::::::::::::"+soldToNames);
			if(soldToNames.size()>0)
				session.putValue("SOLDTONAMES",soldToNames);							
			SoldTosTemp = SoldTos;
			if(SoldTosTemp!=null && !"".equals(SoldTosTemp))
			{
				EziAdminUtilsParams adminUtilsParams_N = new EziAdminUtilsParams();
				adminUtilsParams_N.setSyskeys(catalog_area);
				adminUtilsParams_N.setPartnerValueBy(soldToUserId);

				mainParamsMisc1.setObject(adminUtilsParams_N);
				Session.prepareParams(mainParamsMisc1);

				partnersRet_L = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParamsMisc1);

				if(partnersRet_L!=null)
				{
					for(int i=partnersRet_L.getRowCount()-1;i>=0;i--)
					{
						String tempuserId = partnersRet_L.getFieldValueString(i,"EU_ID");

						if("".equals(toPassUserId))
						{
							toPassUserId=(partnersRet_L.getFieldValueString(i,"EU_ID")).trim();
						}
						else
						{
							toPassUserId=toPassUserId+"','"+(partnersRet_L.getFieldValueString(i,"EU_ID")).trim();
						}
					}
				}	
			}					
			//ezc.ezcommon.EzLog4j.log("toPassUserId:::::NEG::::::::"+toPassUserId ,"I");
			ezc.ezcommon.EzLog4j.log("SoldTos:::::NEG::::::::"+SoldTos ,"I");
			miscParams.setIdenKey("MISC_SELECT");
			//String query="SELECT EWDHH_AUTH_KEY AUTHKEY,EWDHH_DOC_ID DOCID,EWDHH_SYSKEY SYSKEY,EWDHH_KEY DOCKEY,EWDHH_DOC_DATE DOCDATE,EWDHH_WF_STATUS STATUS,EWDHH_CREATED_ON CREATEDON,EWDHH_MODIFIED_ON MODIFIEDON,EWDHH_CREATED_BY CREATEDBY,EWDHH_MODIFIED_BY MODIFIEDBY,EWDHH_CURRENT_STEP CURRENTSTEP,EWDHH_NEXT_PARTICIPANT NEXTPARTICIPANT,EWDHH_PARTICIPANT_TYPE PARTICIPANTTYPE, EWDHH_NEXT_D_PARTICIPANT DELPARTICIPANT,EWDHH_D_PARTICIPANT_TYPE DELPARTICIPANTTYPE,EWDHH_REF1 REF1 ,ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE   FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_SYSKEY IN('999001') AND EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN('102400000','102400000','SGEORGE') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN('0102400000')AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'02/27/2012',110) ";
			//miscParams.setQuery("SELECT * FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_WF_STATUS IN ('NEGOTIATED') AND ESDH_DOC_NUMBER in (SELECT DISTINCT(EON_ORDER_NO) from EZC_ORDER_NEGOTIATE WHERE EON_CREATED_BY in('"+user+"','"+toPassUserId+"') and EON_STATUS in('INPROCESS')) AND EWDHH_CREATED_BY IN ('"+toPassUserId+"','"+user+"','"+SoldTos+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2020',110)");
			miscParams.setQuery("SELECT COUNT(distinct(EWDHH_DOC_ID)) Count FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_WF_STATUS IN ('NEGOTIATED') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_STATUS IN ('INPROCESS','NEGOTIATED') AND EWDHH_CREATED_BY IN ('"+toPassUserId+"','"+user+"','"+SoldTos+"') AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110)");
			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	

			try
			{		
				retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
				//countMisc=retObjMisc.getRowCount();
				countMisc=Integer.parseInt(retObjMisc.getFieldValueString(0,"Count"));
				//out.println("countMisc::::"+countMisc);
				if(countMisc>0)
					session.putValue("NEGCNT_CM",countMisc+"");
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}

			//new

			miscParams1.setIdenKey("MISC_SELECT");
			miscParams1.setQuery("SELECT COUNT(*) SAVEDCNT FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN ('"+user+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110)"); //AND ESDH_SOLD_TO IN ('"+soldTo+"')
			//SELECT Count(*) COUNT FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_WF_STATUS IN ('NEW') AND EWDHH_CREATED_BY IN ('"+toPassUserId+"','"+user+"','"+SoldTos+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+soldTo+"') AND ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'12/31/2012',110)
			mainParamsMisc1.setLocalStore("Y");
			mainParamsMisc1.setObject(miscParams1);
			Session.prepareParams(mainParamsMisc1);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("SoldTos::::::::::::::::::"+SoldTos,"D");
				retObjMisc1 = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc1);
				countMisc1=Integer.parseInt(retObjMisc1.getFieldValueString(0,"SAVEDCNT"));
				if(countMisc1>0)
					session.putValue("SAVEDCNT",countMisc1+"");
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
		}
	}	

	//if(retObjMisc!=null);
	//out.println("countMisc:::"+countMisc);
	//out.println("countMisc1:::"+countMisc1);

	// SQ list

	JCO.Client client1=null;
	JCO.Function function = null;

	String site_SW = (String)session.getValue("Site");
	String skey_SW = "999";

	int SalQCnt=0;



	String colSQ[]={"SALESDOC","ITEMNO","MATERIAL","MATDESC","VALIDTO","REQQTY","NETPRICE","NETVALUE","DOCDATE","SOLDTO","SOLDTONAME","SHIPTO","SHIPTONAME","POJOBNAME","DOCSTATUS"};
	ReturnObjFromRetrieve retObjSQ = new ReturnObjFromRetrieve(colSQ);

	try
	{
		function= EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_LIST",site_SW+"~"+skey_SW);
		JCO.ParameterList sapProc = function.getImportParameterList();
		JCO.Table salesTable = function.getTableParameterList().getTable("SALES_ORDERS");

		//out.println("soldTo::::"+soldTo);
		String soldTo_QT = (String)session.getValue("AgentCode");
		if(soldTo_QT!=null && !"null".equalsIgnoreCase(soldTo_QT) && !"".equals(soldTo_QT))
		{
			soldTo_QT = "0000000000"+soldTo_QT;
			soldTo_QT = soldTo_QT.substring((soldTo_QT.length()-10),soldTo_QT.length());
		}
		else
			soldTo_QT = soldTo;

		sapProc.setValue(soldTo_QT,"CUSTOMER_NUMBER");
		sapProc.setValue("2","TRANSACTION_GROUP");
		sapProc.setValue("O","WITHOPENCLOSEDESTATUS");

		//valid from
		Date sqDateFrom = new Date();


		String strDateTo="12/31/9999";

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 60);
		Date ExsDateTo = cal.getTime();
		//out.println(ExsDateTo);

		DateFormat formatter;
		Date sqDateToo = new Date();
		formatter = new SimpleDateFormat("MM/dd/yyyy");
		sqDateToo = (Date)formatter.parse(strDateTo); 

		salesTable.appendRow();
		salesTable.setValue(sqDateFrom,"VALID_FROM");
		salesTable.setValue(ExsDateTo,"VALID_TO");

		try
		{
			client1 = EzSAPHandler.getSAPConnection(site_SW+"~"+skey_SW);
			client1.execute(function);
		}
		catch(Exception ec)
		{
			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
		}

		JCO.Table headerTable 	= function.getTableParameterList().getTable("SALES_ORDERS");
		//out.println("headerTable:::"+headerTable);
		if(headerTable!=null)
		{
			if (headerTable.getNumRows() > 0)
			{
				do
				{
					String sdDoc  =(String)headerTable.getValue("SD_DOC");
					Date validTo  = (Date)headerTable.getValue("VALID_TO");
					Date sqDateTo = new Date();

					int dateComp = validTo.compareTo(sqDateTo);																

					if(dateComp<0) 
					  continue;								  								

					int dateCompTo = validTo.compareTo(ExsDateTo);

					if(dateCompTo>0)
					  continue;	

					retObjSQ.setFieldValue("VALIDTO",validTo);
					retObjSQ.setFieldValue("SALESDOC",headerTable.getValue("SD_DOC"));
					//retObjSQ.setFieldValue("ITEMNO",headerTable.getValue("ITM_NUMBER"));
					//retObjSQ.setFieldValue("MATERIAL",headerTable.getValue("MATERIAL"));
					//retObjSQ.setFieldValue("MATDESC",headerTable.getValue("SHORT_TEXT"));
					//retObjSQ.setFieldValue("REQQTY",headerTable.getValue("REQ_QTY"));
					//retObjSQ.setFieldValue("NETPRICE",headerTable.getValue("NET_PRICE"));
					retObjSQ.setFieldValue("NETVALUE",headerTable.getValue("NET_VAL_HD"));
					retObjSQ.setFieldValue("DOCDATE",headerTable.getValue("DOC_DATE"));
					retObjSQ.setFieldValue("SOLDTO",headerTable.getValue("SOLD_TO"));
					retObjSQ.setFieldValue("SOLDTONAME",headerTable.getValue("NAME"));
					retObjSQ.setFieldValue("SHIPTO",headerTable.getValue("SHIP_TO"));
					retObjSQ.setFieldValue("SHIPTONAME",headerTable.getValue("SHIP_TO_NAME"));								 
					retObjSQ.setFieldValue("POJOBNAME",headerTable.getValue("PURCH_NO"));
					retObjSQ.setFieldValue("DOCSTATUS",headerTable.getValue("DOC_STATUS"));
					retObjSQ.addRow();
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
		if (client1!=null)
		{
			JCO.releaseClient(client1);
			client1 = null;
			function=null;
		}
	}
	//out.println(retObjSQ.toEzcString());
	if(retObjSQ!=null)
	{
		session.removeValue("retObjExSQSes"); 
	}
	if(retObjSQ!=null && retObjSQ.getRowCount() > 0)
	{
		session.putValue("retObjExSQSes",retObjSQ);
	}

	SalQCnt = retObjSQ.getRowCount();

	//out.println("retObjSQ:::"+retObjSQ.toEzcString());
	//out.println("Time:::"+cdObj.getTime());

	// News alerts

	int myNewsRetCnt_A =0;
	int myNewsTimeCnt_A=0;

	String userType_A  = (String)session.getValue("UserType");
	String userId_A	   = Session.getUserId();
	String newsFromDashCat 	   = "";
	String appendNewQry = " AND EZN_AUTH IN ('I','A')";
	if("3".equals(userType_A))
		appendNewQry = " AND EZN_AUTH IN ('E','A')";
	EziMiscParams timeParams_A = null;
	ezc.ezparam.EzcParams mainParams_A=null;
	ezc.eznews.client.EzNewsManager newsManager_A = null;
	ezc.eznews.params.EziNewsParams newsParam_A = null;
	ezc.ezparam.ReturnObjFromRetrieve timeStampRet_W=null;

	mainParams_A=new ezc.ezparam.EzcParams(true);
	timeParams_A = new EziMiscParams();

	timeParams_A.setIdenKey("MISC_SELECT");
	//String query_W="SELECT ENR_ID,ENR_SYSKEY,ENR_USER,ENR_VIEWED,ENR_VIEWED_DATE,ENR_CONFIRMATION,ENR_CONFIRMED_DATE FROM EZC_NEWS_READ_TIMESTAMP WHERE  ENR_USER='"+userId_A+"'";
	String query_W="SELECT EZN_NEWS_TEXT,EZN_CATEGORY FROM EZC_NEWS WHERE EZN_ID NOT IN (SELECT ENR_ID FROM EZC_NEWS_READ_TIMESTAMP WHERE ENR_USER='"+(String)Session.getUserId()+"') AND GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND EZN_ID IN (SELECT ENA_ID FROM EZC_NEWS_ASSIGNIES WHERE ENA_SOLDTO='"+(String)Session.getUserId()+"')"+appendNewQry; //AND EZN_NEWS_TYPE='TA'
	timeParams_A.setQuery(query_W);

	mainParams_A.setLocalStore("Y");
	mainParams_A.setObject(timeParams_A);
	Session.prepareParams(mainParams_A);	
	String tempid_W="";

	try
	{
		timeStampRet_W = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_A);
		if(timeStampRet_W!=null && timeStampRet_W.getRowCount()>0)
			newsFromDashCat = timeStampRet_W.getFieldValueString(0,"EZN_CATEGORY");
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}				

	int unreadNewsCnt=timeStampRet_W.getRowCount();
	//out.println("myNewsRetCnt::"+myNewsRetCnt_A+"myNewsTimeCnt:::"+myNewsTimeCnt_A);
	//out.println("unreadNewsCnt::"+unreadNewsCnt);				
%>				
	<%@ include file="../Inbox/iListPersMsgs.jsp"%>
<%
	/******** FOC Users and Doc Count Start ***********/

	ezc.ezparam.EzcParams focMainParams = null;
	ezc.eznews.client.EzNewsManager focManager = null;
	EziMiscParams focParams_W = null;
	ezc.ezparam.ReturnObjFromRetrieve focUsers=null;
	ezc.ezparam.ReturnObjFromRetrieve focOrdsCnt=null;
	ezc.ezparam.ReturnObjFromRetrieve focOrdsRjCnt=null;
	boolean isFOCUser = false;
	String focOrdCnt = "0";
	String focAccRjCnt = "0";

	if(Session.getUserId()!=null)
	{
		focMainParams=new ezc.ezparam.EzcParams(true);
		focParams_W = new EziMiscParams();

		focParams_W.setIdenKey("MISC_SELECT");
		String focQry="SELECT DISTINCT(VALUE2) FROM EZC_VALUE_MAPPING WHERE MAP_TYPE IN ('PURPTOAPPR') AND VALUE2='"+Session.getUserId()+"'";
		focParams_W.setQuery(focQry);

		focMainParams.setLocalStore("Y");
		focMainParams.setObject(focParams_W);
		Session.prepareParams(focMainParams);	

		try
		{
			//ezc.ezcommon.EzLog4j.log("focQry::::::::::::::::::::::::::::::::"+focQry,"D");
			focUsers = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focMainParams);
			if(focUsers!=null && focUsers.getRowCount()>0)
				isFOCUser = true;

			ezc.ezcommon.EzLog4j.log("isFOCUser::::::::::::::::::::::::::::::::"+isFOCUser,"D");
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		if(isFOCUser)
		{
			focMainParams=new ezc.ezparam.EzcParams(true);
			focParams_W = new EziMiscParams();

			focParams_W.setIdenKey("MISC_SELECT");
			String focDocQry="SELECT COUNT(*) FOCAPPRCNT FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_WF_STATUS IN ('SUBMITTED') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER  AND ESDH_DOC_NUMBER IN (SELECT DISTINCT(EON_ORDER_NO) FROM EZC_ORDER_NEGOTIATE WHERE EON_STATUS IN('FORAPPROVAL') AND EON_INDEX_NO='"+Session.getUserId()+"') ";
			focParams_W.setQuery(focDocQry);

			focMainParams.setLocalStore("Y");
			focMainParams.setObject(focParams_W);
			Session.prepareParams(focMainParams);	

			try
			{
				//ezc.ezcommon.EzLog4j.log("focParams_W.setQuery(focQry)::::::::::::::::::::::::::::::::"+focParams_W.getQuery(),"D");		
				focOrdsCnt = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focMainParams);
				if(focOrdsCnt!=null && focOrdsCnt.getRowCount()>0)
					focOrdCnt = focOrdsCnt.getFieldValueString(0,"FOCAPPRCNT");
				if(!"0".equals(focOrdCnt))	
					session.putValue("FOCAPPRCNT",focOrdCnt);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}

			String focRejQry="SELECT COUNT(*) FOCACCCNT FROM EZC_WF_DOC_HISTORY_HEADER, EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_WF_STATUS IN ('SUBMITTED') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER  AND ESDH_DOC_NUMBER IN (SELECT DISTINCT(EON_ORDER_NO) FROM EZC_ORDER_NEGOTIATE WHERE EON_STATUS IN('FOCACCEPTED','FOCREJECTED') AND EON_INDEX_NO='"+Session.getUserId()+"') "; //AND EWDHH_SYSKEY IN('"+(String)session.getValue("SalesAreaCode")+"')
			focParams_W.setQuery(focRejQry);

			focMainParams.setLocalStore("Y");
			focMainParams.setObject(focParams_W);
			Session.prepareParams(focMainParams);	

			try
			{
				//ezc.ezcommon.EzLog4j.log("focParams_W.setQuery(focQry)::::::::::::::::::::::::::::::::"+focParams_W.getQuery(),"D");		
				focOrdsRjCnt = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focMainParams);
				if(focOrdsRjCnt!=null && focOrdsRjCnt.getRowCount()>0)
					focAccRjCnt = focOrdsRjCnt.getFieldValueString(0,"FOCACCCNT");
				if(!"0".equals(focAccRjCnt))	
					session.putValue("FOCACCCNT",focAccRjCnt);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}						
		}
	}
	/******** FOC Users and Doc Count End ***********/

	/******** Cancellation Requests Count Start *******/

	ezc.ezparam.ReturnObjFromRetrieve canReqRet=null;	
	focMainParams=new ezc.ezparam.EzcParams(true);
	focParams_W = new EziMiscParams();
	int canReqCnt = 0; 
	focParams_W.setIdenKey("MISC_SELECT");
	String cancelStat="'P'";
	if("CU".equals(userRole))cancelStat = "'A','R'";
	String allSoldTo_W = "";
	if("CU".equals(userRole))
	{
		String[] stoken=((String)session.getValue("SOLDTO_SUPER")).split("¥");
		if(stoken.length>1)
		{
			for(int i=0;i<stoken.length;i++)
			{
				if(i==0)
					allSoldTo_W=stoken[i];	
				else
					allSoldTo_W=allSoldTo_W+"','"+stoken[i];
			}
		}
		else
			allSoldTo_W = (String)session.getValue("AgentCode");
	}
	else
		allSoldTo_W = (String)session.getValue("AgentCode");
	String canReqQry="SELECT COUNT(DISTINCT(ESCH_ID)) CANCELREQCNT,ESCH_STATUS STATUS FROM EZC_SO_CANCEL_HEADER,EZC_SO_CANCEL_ITEMS WHERE ESCH_ID=ESCI_ID AND ESCH_CREATED_ON BETWEEN  convert(DATETIME,'03/01/2012',110)  and  convert(DATETIME,'12/31/2015',110) AND ESCH_TYPE IN ('RC') AND ESCH_STATUS IN ("+cancelStat+")";
	if("CU".equals(userRole))
		canReqQry = canReqQry+" AND ESCH_SOLD_TO IN ('"+allSoldTo_W+"')";
	canReqQry = canReqQry +" GROUP BY ESCH_STATUS";
	focParams_W.setQuery(canReqQry);

	focMainParams.setLocalStore("Y");
	focMainParams.setObject(focParams_W);
	Session.prepareParams(focMainParams);	

	try
	{
		ezc.ezcommon.EzLog4j.log("focParams_W.setQuery(focQry)::::::::::::::::::::::::::::::::"+focParams_W.getQuery(),"D");		
		canReqRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focMainParams);
		if(canReqRet!=null && canReqRet.getRowCount()>0)
		{
			try{
				canReqCnt = Integer.parseInt(canReqRet.getFieldValueString(0,"CANCELREQCNT"));	
			}catch(Exception e){}
			if(canReqCnt>0 && "CU".equals(userRole)) 
			{
				session.putValue("CANCELREQ_CU",canReqCnt+"");
				int rowId = canReqRet.getRowId("STATUS","R");
				//out.println("rowId:::::"+rowId);
				//out.println("canReqRet::::"+canReqRet.getFieldValueString(rowId,"CANCELREQCNT"));
				if(rowId!=-1)
					session.putValue("REJECTREQ_CU",canReqRet.getFieldValueString(rowId,"CANCELREQCNT"));
			}	
			if(canReqCnt>0 && "CM".equals(userRole)) 
				session.putValue("CANCELREQ_CM",canReqCnt+"");	
		}	
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}				

	/******** Cancellation Requests Count End *******/	

	/************ RGA Count Start *************/

	ezc.record.util.EzOrderedDictionary userAuth_C = Session.getUserAuth();
	ezc.ezparam.ReturnObjFromRetrieve RgaReqRet=null;	
	focMainParams=new ezc.ezparam.EzcParams(true);
	focParams_W = new EziMiscParams();

	int rgaReqCnt = 0; 
	focParams_W.setIdenKey("MISC_SELECT");
	String RgaStat="'P'";
	if("CU".equals(userRole))RgaStat = "'A','R','CA'";
	String RgaReqQry="SELECT COUNT(DISTINCT(ESCH_ID)) RGAREQCNT,ESCH_STATUS STATUS FROM EZC_SO_CANCEL_HEADER,EZC_SO_CANCEL_ITEMS WHERE ESCH_ID=ESCI_ID AND ESCH_CREATED_ON BETWEEN  convert(DATETIME,'03/01/2012',110)  and  convert(DATETIME,'12/31/2015',110) AND ESCH_TYPE IN ('RGA') AND ESCH_STATUS IN ("+RgaStat+")";
	if("CU".equals(userRole))
		RgaReqQry = RgaReqQry+" AND ESCH_SOLD_TO IN ('"+allSoldTo_W+"')";
	RgaReqQry = RgaReqQry +" GROUP BY ESCH_STATUS";
	focParams_W.setQuery(RgaReqQry);

	focMainParams.setLocalStore("Y");
	focMainParams.setObject(focParams_W);
	Session.prepareParams(focMainParams);	

	try
	{
		ezc.ezcommon.EzLog4j.log("focParams_W.setQuery(focQry)::::::::::::::::::::::::::::::::"+focParams_W.getQuery(),"D");		
		RgaReqRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focMainParams);
		if(RgaReqRet!=null && RgaReqRet.getRowCount()>0)
		{
			try{
				rgaReqCnt = Integer.parseInt(RgaReqRet.getFieldValueString(0,"RGAREQCNT"));	
			}catch(Exception e){}
			if(rgaReqCnt>0 && "CU".equals(userRole)) 
			{
				session.putValue("RGAREQ_CU",rgaReqCnt+"");
				int rowId = RgaReqRet.getRowId("STATUS","R");
				int rowId1 = RgaReqRet.getRowId("STATUS","CA");
				String rjCNt = "";
				try{
					rjCNt = (Integer.parseInt(RgaReqRet.getFieldValueString(rowId,"RGAREQCNT"))+(Integer.parseInt(RgaReqRet.getFieldValueString(rowId1,"RGAREQCNT"))))+"";
				}catch(Exception e){ rjCNt="0";}
				//out.println("rjCNt:::::"+rjCNt);
				if(rowId!=-1)
					session.putValue("REJECTRGAREQ_CU",rjCNt);
			}	
			if(rgaReqCnt>0 && "CM".equals(userRole) && userAuth_C.containsKey("APPR_RGA")) 
				session.putValue("RGAREQ_CM",rgaReqCnt+"");	
		}	
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}				
	/************ RGA Count End *************/
%>
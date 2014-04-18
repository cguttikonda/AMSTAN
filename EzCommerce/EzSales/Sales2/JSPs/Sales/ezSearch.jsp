<%@ page import="ezc.ezparam.*"%>
<%@ page import = "ezc.ezsap.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>

<%
		String userRole=(String)session.getValue("UserRole");	

%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetWorkFlowSessionUsers.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>

<jsp:useBean id="Manager" class="ezc.sales.client.EzSalesOrderManager" />

<%
	FormatDate formatDate = new FormatDate();
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	ReturnObjFromRetrieve retobj = null;
	
	String strMaterial = request.getParameter("MATERIAL");
	//strMaterial=strMaterial.trim();
	String strPOnumber = request.getParameter("PONUMBER");
	if(strPOnumber != null)
	strPOnumber = strPOnumber.trim();
	String orderStatus=request.getParameter("orderStatus");


	String orderByMaterial=request.getParameter("orderByMaterial");
	String newFilter=request.getParameter("newFilter");
	String searchType=request.getParameter("SearchType");
	String refDocType = request.getParameter("RefDocType");
	
	String user=Session.getUserId();
	String LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	String LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME");
	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
	
	ArrayList statKeys=new ArrayList();
	
	if("CU".equals(userRole) || "AG".equals(userRole))
	{
		statKeys.add("'New'"); 														
		statKeys.add("'Transfered'");												
	}
	else if("CM".equals(userRole))
	{					
		statKeys.add("'New'"); 												
		statKeys.add("'Transfered'");											
	}
	
	refDocType=(refDocType==null)?"P": refDocType;
	orderStatus=(orderStatus==null)?(String)statKeys.get(0):orderStatus;
	ArrayList vec= new ArrayList();
	vec.add(orderStatus);
	vec=("All".equals(orderStatus))?statKeys:vec;

	
	
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager1 = new ezc.ezworkflow.client.EzWorkFlowManager();
	
	
		EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
		ezcSOParams.setLocalStore("Y");
		Session.prepareParams(ezcSOParams);
	
		EziSalesOrderSearchParams soSearchParams = new EziSalesOrderSearchParams();
		EziExtSalesOrderSearchParams inparams = new EziExtSalesOrderSearchParams();
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
	
		if(orderByMaterial!=null)
		{
			inparams.setType("Material");
			//ezcSOParams.setObject(inparams);
			//Session.prepareParams(ezcSOParams);
	
	
			EzoSalesOrderList soList = (EzoSalesOrderList)Manager.ezSalesOrderList(ezcSOParams);
			retobj=soList.getReturn();
	
	
			//retobj=(ReturnObjFromRetrieve)Manager.ezSalesOrderList(ezcSOParams);
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
	 			query ="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in("+SoldTos+")  and ESDH_DOC_NUMBER in (SELECT WEB_ORNO from DOC_DETAILS  WHERE upper(PROD_DESC) like upper('"+pdesc+"') ) and ESDH_DEL_FLAG='N' ORDER BY ESDH_MODIFIED_ON DESC";
			}else if("PRODUCTNO".equals(searchType))
			{
				String pno=request.getParameter("searchPatern");
				if(pno != null)
				{
					pno=pno.trim();
					pno=pno.replace('*','%');
				}
	
				query ="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in("+SoldTos+")  and ESDH_DOC_NUMBER in (SELECT WEB_ORNO from DOC_DETAILS  WHERE upper(PROD_CODE) like upper('"+pno+"') ) and ESDH_DEL_FLAG='N' ORDER BY ESDH_MODIFIED_ON DESC";
			}else
			{
				 query ="EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in("+SoldTos+")";
			}
			params.setAuthKey("'SO_CREATE'");
			params.setSysKey("'"+salesAreaCode+"'");
			params.setTemplateCode((String)session.getValue("Templet"));
			params.setRef1("ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE");
			params.setRef2(query);
	
			if("Y".equalsIgnoreCase(newFilter))
			{
				Date dd=new Date();
				dd.setTime(dd.getTime()+10000000);
				SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy hh:mm:ss:SS a");
				String today=sdf.format(dd);
	
				params.setModifiedOn1(""+LAST_LOGIN_DATE+"'");
				params.setModifiedOn2(today+"'");
			}
			
			if("CM".equals(userRole) || "CU".equals(userRole))
			{
				
					
					if(orderStatus.equals("All"))
					{
						params.setCreatedBy("'"+user+"'");
						params.setRef2(query);
						params.setStatus("'NEW','TRANSFERED'");

					}					
						mainParams1.setObject(params);
						Session.prepareParams(mainParams1);
					
						
						retobj=(ReturnObjFromRetrieve)EzWorkFlowManager1.getWFDocList(mainParams1);
			}
			
		}
			//	out.println("retobjretobjretobj  "+retobj.toEzcString());


		if("WEB".equals(searchType))
		{


			String wsearch=request.getParameter("searchPatern");
			if(wsearch!=null)
			{
				mySearch.search(retobj,"WEB_ORNO",wsearch);
			}
		}
		if("PONO".equals(searchType))
		{

			String wsearch=request.getParameter("searchPatern");
			if(wsearch!=null)
			{
				mySearch.search(retobj,"PO_NO",wsearch);
			}
	 	}
	 					
%>
<Div id="MenuSol"></Div>
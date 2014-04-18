
<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../Lib/ezSessionBean.jsp"%>
<%@ include file="../../Lib/ezSalesBean.jsp"%>
<%
String user		= Session.getUserId();
String userRole		= (String)session.getValue("UserRole");	
String agentCode	= (String)session.getValue("AgentCode");
String salesAreaCode	= (String)session.getValue("SalesAreaCode");

// This code is for iAcceptedOdersXML.jsp

	if("ACPORDERS".equals(urlPage))
	{
		agentCode = custStr;	
	}	
// Ends Here


StringTokenizer stoken=new StringTokenizer(agentCode,",");
String SoldTos ="",userIds="";

if (stoken.countTokens()>1)
{
	while(stoken.hasMoreTokens())
	{
		if(SoldTos.trim().length() ==0)
		{
			SoldTos="'"+stoken.nextToken()+"'";
		}	
		else
		{
			SoldTos+=",'"+stoken.nextToken()+"'";
		}	
	}
}
else
	SoldTos=agentCode;
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
	if(SoldTos!=null && !"null".equals(SoldTos))
		SoldTos = SoldTos.trim();

	String query = "EZC_SALES_DOC_HEADER where EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in('"+SoldTos+"')";
	params.setAuthKey("'SO_CREATE'");
	params.setSysKey("'"+salesAreaCode+"'");
	params.setTemplateCode((String)session.getValue("Templet"));
	params.setRef1("ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE");
	params.setRef2(query);
	/*
	if("CU".equals(userRole))
		params.setCreatedBy("'"+user+"'"); 
	else	
		params.setCreatedBy("'"+user+"','"+userIds+"'"); 
	*/	
	params.setStatus("'TRANSFERED'");
	//params.setStatus("'NEW'");
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
%>
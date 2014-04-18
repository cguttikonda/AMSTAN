<%@ page import="ezc.ezparam.*,ezc.client.*,ezc.ezpreprocurement.params.*"%>
<%@ page import="ezc.ezutil.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />

<%
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	EziPreProcurementParams paramsu= new EziPreProcurementParams();
	paramsu.setRelCode("SR");
	paramsu.setPlant("1000");
	paramsu.setMaterial("3000064");
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	try
	{
		ReturnObjFromRetrieve retWFobj = (ReturnObjFromRetrieve)Manager.ezGetInfoRecordList(mainParamsu);
	}
	catch(Exception e)
	{
		out.println(""+e);
		e.printStackTrace();		
	}

%>
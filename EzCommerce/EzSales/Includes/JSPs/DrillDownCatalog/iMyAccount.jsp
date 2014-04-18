<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import="java.util.*" %>
<%
		
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);	
	String sessionAgentCode		= (String)session.getValue("AgentCode");

	String defShipTo = UtilManager.getUserDefErpShipTo();
	String defSysKey = UtilManager.getCurrSysKey();
	String defSoldTo = UtilManager.getUserDefErpSoldTo();
	
	String Agent	 = request.getParameter("Agent");
	String SoldTo	 = request.getParameter("soldTo");
 	String ShipTo	 = request.getParameter("shipTo");
 	int rowId = -1;

	if(defSoldTo.indexOf(',') > 0)
		defSoldTo="";

	Agent=(Agent==null)?defSoldTo:Agent;
	
	
	SoldTo=sessionAgentCode;
	SoldTo=(SoldTo==null)?defSoldTo:SoldTo;
        ShipTo=(ShipTo==null)?defShipTo:ShipTo;
		
	ReturnObjFromRetrieve retsoldto   = null;
        ReturnObjFromRetrieve listShipTos = null;

	retsoldto   = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos(SoldTo);
	listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(SoldTo);
	
	
	int retSoldCount=0;
	int retShipCount=0;
	
	if(retsoldto!=null)
		retSoldCount = retsoldto.getRowCount();
		
	if(listShipTos!=null)
		retShipCount=listShipTos.getRowCount();
		
	
		
%>
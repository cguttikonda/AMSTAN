<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>
<%
	String userName = request.getParameter("username");
	String code	  = request.getParameter("compcode");
	String version	  = request.getParameter("version");	 		
	
	if("".equals(userName) || userName == null)
		userName = "ALL";

	ReturnObjFromRetrieve retComponentVersionHistoryList=null;
	int ComponentVersionHistoryListCount=0;
	ezc.ezparam.EzcParams ezcparams1 = new ezc.ezparam.EzcParams(false);
	EziComponentVersionHistoryParams ezicomponentversionhistoryparams= new EziComponentVersionHistoryParams();
	ezicomponentversionhistoryparams.setVersion(version);
	//ezicomponentversionhistoryparams.setHistoryNo(262+"");
	ezcparams1.setObject(ezicomponentversionhistoryparams);
	Session.prepareParams(ezcparams1);
	retComponentVersionHistoryList =(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentVersionHistoryDetails(ezcparams1);
	if(retComponentVersionHistoryList != null)
	ComponentVersionHistoryListCount = retComponentVersionHistoryList.getRowCount();
	System.out.println("PRINT OBJECT retComponentVersionHistoryList");
	//retComponentVersionHistoryList.toEzcString();

	String patchNo = retComponentVersionHistoryList.getFieldValueString("PATCH");
	String historyNo = retComponentVersionHistoryList.getFieldValueString("HISTORY_NO");
	String releasedOn = retComponentVersionHistoryList.getFieldValueString("RELEASED_ON");

%>
<%@ include file="ezPostPatch.jsp" %>

<%
	response.sendRedirect("ezComponentsVersionHistoryList.jsp");
%>

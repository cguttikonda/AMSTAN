<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>
<%
	String[] compIds = request.getParameterValues("chk1");
	String comps = "";
	comps = compIds[0];
	for(int i=1;i<compIds.length;i++)
		comps += "','"+compIds[i];
		
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ezicomponenentsparams.setCode(comps);
	mainParams.setObject(ezicomponenentsparams);
	Session.prepareParams(mainParams);
	cmanager.deleteComponents(mainParams);
	response.sendRedirect("ezComponentsList.jsp");
%>

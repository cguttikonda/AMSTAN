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
	String comp_Code = request.getParameter("cCode");
	String comps = "";
	comps = compIds[0];
	for(int i=1;i<compIds.length;i++)
		comps += "','"+compIds[i];
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziComponentsVersionsParams componentsversionsparams= new EziComponentsVersionsParams();
	componentsversionsparams.setCompNo(comps);
	componentsversionsparams.setComponent(comp_Code);
	mainParams.setObject(componentsversionsparams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retdeleteComponentsVersions=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.deleteComponentsVersions(mainParams);
	String delete="ezComponentsVersionList.jsp?cCode="+comp_Code;
	response.sendRedirect(delete);
%>

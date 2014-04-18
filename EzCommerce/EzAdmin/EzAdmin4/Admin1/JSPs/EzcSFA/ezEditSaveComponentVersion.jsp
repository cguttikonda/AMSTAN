<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>
<%
		
		String compvercode=request.getParameter("compVerCode");
		String client=request.getParameter("Client");
		String component=request.getParameter("Component");
		String version=request.getParameter("Version");
		String lastupon=request.getParameter("upDate");
		
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		EziComponentsVersionsParams componentsversionsparams= new EziComponentsVersionsParams();
		componentsversionsparams.setCompNo(compvercode);
		componentsversionsparams.setVersion(version);
		componentsversionsparams.setComponent(component);
		componentsversionsparams.setClient(client);
		componentsversionsparams.setLastUpdatedOn(lastupon);
		
		mainParams.setObject(componentsversionsparams);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve reteditComponentsversions=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.updateComponentsVersions(mainParams);
		String edit="ezComponentsVersionList.jsp?cCode="+component;
		response.sendRedirect(edit);

%>

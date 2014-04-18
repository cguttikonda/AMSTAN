<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>

<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>
<%
	String compCode = request.getParameter("compCode");
	String compVersion = request.getParameter("compVersion");
	String compDesc = request.getParameter("compDesc");
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();

	ezicomponenentsparams.setCode(compCode);
	ezicomponenentsparams.setVersion(compVersion);
	ezicomponenentsparams.setDescription(compDesc);
	mainParams.setObject(ezicomponenentsparams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retupdateComponents=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.updateComponents(mainParams);
	response.sendRedirect("ezComponentsList.jsp");
%>

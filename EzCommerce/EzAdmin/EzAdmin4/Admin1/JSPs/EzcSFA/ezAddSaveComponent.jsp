<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>

<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>
<%
	String versionId=request.getParameter("version");
	String description=request.getParameter("desc");
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams componentsparams= new EziComponentsParams();
	componentsparams.setVersion(versionId);
	componentsparams.setDescription(description);
	mainParams.setObject(componentsparams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retaddComponents=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.addComponents(mainParams);

	Date d=new Date();
	int m=d.getMonth()+1;
	String dMonth=(m)<10 ? "0"+m:""+m;
	String dDate=d.getDate()<10 ? "0"+d.getDate(): ""+d.getDate();
	int x=d.getYear()+1900;
	String dYear=""+x;
	String dStr=dMonth+"."+dDate+"."+dYear;

	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	//ezcparams.setLocalStore("Y");
	EziComponentVersionHistoryParams ezicomponentversionhistoryparams= new EziComponentVersionHistoryParams();
	ReturnObjFromRetrieve retComponentVersionHistory=null;
	ezicomponentversionhistoryparams.setPatch("0");
	ezicomponentversionhistoryparams.setReleasedOn(dStr);
	ezicomponentversionhistoryparams.setVersion(versionId);
	ezicomponentversionhistoryparams.setCode(retaddComponents.getFieldValueString(0,"CODE"));
	ezcparams.setObject(ezicomponentversionhistoryparams);
	Session.prepareParams(ezcparams);
	retComponentVersionHistory=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.addComponentVersionHistory(ezcparams);

	response.sendRedirect("ezComponentsList.jsp");
%>


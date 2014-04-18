<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/

       /* Author : AmmiReddy.B
	* Team   : Admin
	* Date   : 16-3-2003
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/iEzMain.jsp" %>
<%
	String[] userIds = request.getParameterValues("chk1");
	String users = "";
	users = userIds[0];
	for(int i=1;i<userIds.length;i++)
		users += "','"+userIds[i];
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");
	EziSFALogsParams ezisfalogsparams= new EziSFALogsParams();
	ezisfalogsparams.setlogNo(users);
	mainParams.setObject(ezisfalogsparams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retdeletesfalogs =(ezc.ezparam.ReturnObjFromRetrieve)cmanager1.deleteSFALogs(mainParams);
	response.sendRedirect("ezLogsList.jsp");
%>

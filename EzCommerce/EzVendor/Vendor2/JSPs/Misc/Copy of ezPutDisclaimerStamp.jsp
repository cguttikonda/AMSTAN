<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	ezc.ezshipment.client.EzShipmentManager shipManager= new ezc.ezshipment.client.EzShipmentManager();
	ezc.ezparam.EzcParams ezcparams= new ezc.ezparam.EzcParams(true);
	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	uparams.setUserId(Session.getUserId());
	ezcparams.setObject(uparams);
	Session.prepareParams(ezcparams);
	shipManager.ezPutDisclaimerStamp(ezcparams);
	response.sendRedirect("ezSelectSoldTo.jsp");
%>

<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezworkflow.params.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<%
  EzcParams ezcContainer= new EzcParams(false);
	EziRFQHeaderParams rfqHeaderParams =new EziRFQHeaderParams();
  rfqHeaderParams.setVendor("1100000044");
  ezcContainer.setObject(rfqHeaderParams);
  Session.prepareParams(ezcContainer);
  ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)PreProManager.ezGetVendorExchangeRate(ezcContainer);
  if(retObj!=null)
  
  
  
  
%>
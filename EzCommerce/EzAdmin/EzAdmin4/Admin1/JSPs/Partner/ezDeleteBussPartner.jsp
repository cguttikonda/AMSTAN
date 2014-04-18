
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="CM" class="ezc.client.CEzBussPartnerManager" scope="session" />
<%@ page import="ezc.ezadmin.busspartner.params.*,ezc.ezparam.*" %>

<%
	String partnerNumber=request.getParameter("chk1");

	EzcBussPartnerParams bparams 		= new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams 	= new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bnkparams.setPartnerNumber("'"+partnerNumber.trim()+"'");
	bparams.setObject(bnkparams);
	Session.prepareParams(bparams);
	CM.deleteBussPartners(bparams);


	String Area=request.getParameter("Area");
	String WebSysKey=request.getParameter("webSys");
	String searchcriteria=request.getParameter("searchcriteria");
	String from=request.getParameter("from");

	response.sendRedirect("ezListBPBySysKey.jsp?WebSysKey="+WebSysKey+"&searchcriteria="+searchcriteria+"&Area="+Area+"&from="+from);
%>
<%@ include file="../../Lib/MailGroupBean.jsp" %>
<%@ include file="../../../Admin1/Library/Globals/CacheControl.jsp"%>

<%
	

	EzcParams eParams = new EzcParams(false);
	EziMailGroupStructure  struct = new EziMailGroupStructure();
	
	//row.set
	
	eParams.setObject(struct);
	Session.prepareParams(eParams);
	ReturnObjFromRetrieve mailGroupObj = (ReturnObjFromRetrieve)Mail.ezListMailGroups(eParams);
%>	
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	/*EzShipmentManager shipManager= new EzShipmentManager();
	EzcParams ezcparams= new EzcParams(true);
	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(Session.getUserId());
	ezcparams.setObject(uparams);
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)shipManager.ezGetDisclaimerStamp(ezcparams);
	retObj.toEzcString();*/
	
	String  browser=request.getParameter("browser");
	if(browser!=null)
		session.putValue("BROWSER",browser);	
	
	EzShipmentManager shipManager= new EzShipmentManager();
	EzcParams ezcparams= new EzcParams(true);
	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
	ezcparams.setObject(uparams);
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve retDiscObj = (ReturnObjFromRetrieve)shipManager.ezGetDisclaimerStamp(ezcparams);
		
	if(retDiscObj==null || (retDiscObj!=null && retDiscObj.getRowCount()==0))
	{
		shipManager= new EzShipmentManager();
		EzcUserParams newParams = new EzcUserParams();
		uparams = new EzcUserParams();
		uparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
		newParams.setObject(uparams);
		Session.prepareParams(newParams);
		shipManager.ezPutDisclaimerStamp(newParams);		
	}
	
	/*if (retObj.getRowCount()>0)
	{
		shipManager.ezPutDisclaimerStamp(ezcparams);
	*/	
%>
	<script>
		top.location.replace("ezSelectSoldToFrameset.jsp")
	</script>
<%	/*}
	else{
		response.sendRedirect("../SelfService/ezPassword.jsp?Flag=X");
	}*/
%>

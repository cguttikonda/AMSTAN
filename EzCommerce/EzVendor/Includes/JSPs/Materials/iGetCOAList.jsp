<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShipManager" class="ezc.ezshipment.client.EzShipmentManager" />

<%	

	String shipId = request.getParameter("shipId");	

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");
	ezc.ezshipment.params.EziCOAParams iParams= new ezc.ezshipment.params.EziCOAParams();
	iParams.setDocumentNo(shipId);
	mainParams.setObject(iParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)ShipManager.ezListCOA(mainParams);

%>
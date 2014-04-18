<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.params.*,ezc.ezshipment.client.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	EzShipmentManager shManager = new EzShipmentManager();

	EzcParams ezcParams = new EzcParams(true);

	EziGetMaterialCharacteristics inParams = new EziGetMaterialCharacteristics();

	inParams.setMaterial(request.getParameter("material"));
	inParams.setPlant(request.getParameter("plant"));
	inParams.setStatus("4");
	inParams.setTasklisttype("Q");
	inParams.setUsage("5");

	ezcParams.setObject(inParams);
	Session.prepareParams(ezcParams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve) shManager.ezGetMaterialSpecifications(ezcParams);	

	EzoGetMaterialCharacteristics MatCharcs = null;
	ReturnObjFromRetrieve lTexts = null;
	
	if ( (retObj!=null) && (retObj.getRowCount() > 0 ) )
	{
		MatCharcs = (EzoGetMaterialCharacteristics) retObj.getFieldValue("MATCHARCS");
		lTexts = (ReturnObjFromRetrieve)retObj.getFieldValue("LTEXT");
	}


%>

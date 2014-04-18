<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%
	String matDescription = request.getParameter("matDesc");
	String myIndex = request.getParameter("myIndex");
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziGenericFMParams ezigenericfmparams     = new ezc.ezpreprocurement.params.EziGenericFMParams();
	
	ezc.ezparam.EzcParams ezcparamsunits  = new ezc.ezparam.EzcParams(true);
	
	ezigenericfmparams.setObjectId("MAT_DESC_SEARCH");
	ezigenericfmparams.setInput1(matDescription);
	
	ezcparamsunits.setObject(ezigenericfmparams);
	Session.prepareParams(ezcparamsunits);
	
	
	ezc.ezparam.ReturnObjFromRetrieve retMaterialsList =  (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezCallGenericFM(ezcparamsunits);

	int materialsCount = 0;
	if(retMaterialsList!=null)
	{
		materialsCount = retMaterialsList.getRowCount();
	}
%>	


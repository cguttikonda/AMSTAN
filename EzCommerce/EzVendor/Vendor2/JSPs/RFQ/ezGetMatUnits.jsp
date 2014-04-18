<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%
	//ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziGenericFMParams ezigenericfmparams     = new ezc.ezpreprocurement.params.EziGenericFMParams();
	
	ezc.ezparam.EzcParams ezcparamsunits  = new ezc.ezparam.EzcParams(true);
	
	ezigenericfmparams.setObjectId("MATERIAL_UNIT");
	ezigenericfmparams.setInput1(dtlXML.getFieldValueString(0,"ITEM"));
	
	ezcparamsunits.setObject(ezigenericfmparams);
	Session.prepareParams(ezcparamsunits);
	
	
	ezc.ezparam.ReturnObjFromRetrieve retMatUnits =  (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezCallGenericFM(ezcparamsunits);
	
	
	int retMatUnitsCnt = 0;
	if(retMatUnits!=null)
	{
		retMatUnitsCnt = retMatUnits.getRowCount();
	}	
	
%>	
	
	
	
	

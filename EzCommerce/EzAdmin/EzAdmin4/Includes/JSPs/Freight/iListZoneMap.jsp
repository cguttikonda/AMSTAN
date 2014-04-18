<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	
	int zmCnt = 0;
	EziZoneMapParams eziZoneMapParams = new EziZoneMapParams();
	EzcParams params = new EzcParams(false);
	
	eziZoneMapParams.setType("ZONES_BY_TYPE");
	eziZoneMapParams.setExt1("");
	params.setObject(eziZoneMapParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve zoneMapRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetZoneMap(params);
	
	if(zoneMapRet!=null)
		zmCnt = zoneMapRet.getRowCount();
%>
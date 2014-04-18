<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.client.*" %>
<%
	int Count = 0;
	String soldTo = (String)session.getValue("SOLDTO");
	String syskey = (String)session.getValue("SYSKEY");
	String soldToInStr = (String)session.getValue("SOLDTOS");
	EzPurchaseManager PoManager=new EzPurchaseManager();
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparamsrfq				     	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setStatus("N");
	ezirfqheaderparams.setExt1("LIST");
	ezirfqheaderparams.setSysKey(syskey);
	ezirfqheaderparams.setExt3("N");	
	ezirfqheaderparams.setSoldTo(soldToInStr);
	ezcparamsrfq.setObject(ezirfqheaderparams);
	ezcparamsrfq.setLocalStore("Y");
	Session.prepareParams(ezcparamsrfq);
	ezc.ezparam.ReturnObjFromRetrieve myRetrfq = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparamsrfq);
	if(myRetrfq != null)
		Count = myRetrfq.getRowCount();
	String  type="Invite";
	
	for(int i=Count-1;i>=0;i--)
	{
		if(!syskey.equals(myRetrfq.getFieldValueString(i,"SYS_KEY")))
		{
			myRetrfq.deleteRow(i);
		}
	}
	if(myRetrfq != null)
		Count = myRetrfq.getRowCount();
%>


<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.client.*" %>
<%
	String sysKey 		= (String)session.getValue("SYSKEY");
	java.util.Vector getVec = (java.util.Vector)session.getValue("CATAREAS");
	String syskeyStr	= "";
	if(getVec!= null && getVec.size()>0)
	{
		syskeyStr = (String)getVec.get(0);
		for(int i=1;i<getVec.size();i++)
		{
			syskeyStr +="','"+(String)getVec.get(i);
		}
	}
	
	 if(!"".equals(syskeyStr) )
	 	sysKey	= syskeyStr;
	 	
	 
	 	
	 	

	String type = request.getParameter("type");
	java.util.Vector quotedRfqs = new java.util.Vector();
	int hdrXMLCount = 0;
	int Count = 0;
	String soldTo = (String)session.getValue("SOLDTO");
	int RetrfqCount = 0;	
	EzPurchaseManager PoManager=new EzPurchaseManager();
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparamsrfq				     	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setStatus("N");
	ezirfqheaderparams.setSoldTo(soldTo);
	ezirfqheaderparams.setSysKey(sysKey);
	ezirfqheaderparams.setExt3("Y");
	ezcparamsrfq.setObject(ezirfqheaderparams);
	ezcparamsrfq.setLocalStore("Y");
	Session.prepareParams(ezcparamsrfq);
	ezc.ezparam.ReturnObjFromRetrieve myRetrfq = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparamsrfq);
	if(myRetrfq!=null)
		RetrfqCount=myRetrfq.getRowCount();
	if(RetrfqCount>0){
		myRetrfq.sort(new String[]{"RFQ_DATE"},false);
	}
	

	
%>


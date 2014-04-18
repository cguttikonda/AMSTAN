<%@ page import="ezc.ezshipment.params.*"%>
<%@ page import="ezc.ezparam.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShipmentManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />

<%

	String ErpVendor =(String) session.getValue("SOLDTO");

	ReturnObjFromRetrieve retGrs=null;
	if (session.getValue("OPENGRS")!=null)
	{
		retGrs = (ReturnObjFromRetrieve) session.getValue("OPENGRS");
	}
	else{
		EzcParams params =  new EzcParams(true);
		ezGetOpenGRsParams inParams = new ezGetOpenGRsParams();
		inParams.setVendorNo(ErpVendor);
		inParams.setShortText("700");	//Client-700
		params.setObject(inParams);
		Session.prepareParams(params);
		retGrs = (ReturnObjFromRetrieve)ShipmentManager.ezGetOpenGRList(params);
		//retGrs = (ReturnObjFromRetrieve) retobj.getFieldValue("GRLIST");
		session.putValue("OPENGRS",retGrs);
	}

	Hashtable GRNOs=new Hashtable();
	for(int i=0;i<retGrs.getRowCount();i++)
		GRNOs.put(retGrs.getFieldValueString(i,"GRNO"),retGrs.getFieldValueString(i,"QUANTITY"));		
	session.putValue("GRNOS",GRNOs);
	
	//out.println(retGrs.toEzcString());

%>



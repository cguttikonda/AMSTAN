<%@page import = "java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%@page import = "ezc.ezcommon.*" %>
<%@page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="shipManager" class="ezc.ezshipment.client.EzShipmentManager" />
<%	
	String orderBase        = request.getParameter("orderBase");
	String xmlrep		= "¥";
	
	String sysKey 		= (String) session.getValue("SYSKEY");
	String soldTo 		= (String) session.getValue("SOLDTO");
	String userType 	= (String) session.getValue("UserType");
	
	int rowCount = 0;
	ReturnObjFromRetrieve retObj = null;
	EziShipmentInfoParams eziShipmentInfoParams =new EziShipmentInfoParams();
	eziShipmentInfoParams.setSelection("H");
	eziShipmentInfoParams.setSysKey(sysKey);
	eziShipmentInfoParams.setSoldTo(soldTo);
	if("po".equals(orderBase)){
		eziShipmentInfoParams.setDocType("P");
	}else if("con".equals(orderBase)){
		eziShipmentInfoParams.setDocType("M");
	}

	if ("3".equals(userType))
		eziShipmentInfoParams.setStatus("N");
	else 
		eziShipmentInfoParams.setStatus("Y");
		
	EzcParams ezcParams = new EzcParams(true);
	ezcParams.setLocalStore("Y");
	ezcParams.setObject(eziShipmentInfoParams);	
	Session.prepareParams(ezcParams);
	ReturnObjFromRetrieve retx=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcParams);
		
	java.util.Vector shipPOs = new java.util.Vector();
	if ((retx!=null)&&(retx.getRowCount()>0))
	{
		retObj = (ReturnObjFromRetrieve)retx.getFieldValue("HEADER");
		if(retObj != null){
			rowCount = retObj.getRowCount();
			if(rowCount>0){
				retObj.sort(new String[] {"PO_NUM"},true);
			}
		}
		for(int i=0;i<rowCount;i++)
		{
			if(!shipPOs.contains(retObj.getFieldValueString(i,"PO_NUM")) ){
				
				if ("3".equals(userType) ){
					shipPOs.addElement(retObj.getFieldValueString(i,"PO_NUM"));
					xmlrep += retObj.getFieldValueString(i,"PO_NUM")+"¥";
				}else if("Y".equals(retObj.getFieldValueString(i,"STATUS"))){
					shipPOs.addElement(retObj.getFieldValueString(i,"PO_NUM"));
					xmlrep += retObj.getFieldValueString(i,"PO_NUM")+"¥";
				}
				
			}	
		}	
	}	
	
	out.println(xmlrep);
	
%>




	

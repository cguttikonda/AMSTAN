<%@page import = "java.util.*" %>
<%@page import = "ezc.ezcommon.*" %>
<%@page import = "ezc.ezparam.*" %>
<%@page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<jsp:useBean id="mainObj" class="ezc.ezshipment.client.EzShipmentManager" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page" />
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />

<%	
	String sysKey 		= (String) session.getValue("SYSKEY");
	String soldTo 		= (String) session.getValue("SOLDTO");
	String xmlrep 		= "¥";
	String selected 	= ""; 
	
	String orderBase        = request.getParameter("orderBase");
	
	Vector	  ackOrders = new java.util.Vector();
	Vector    toShipPos = new java.util.Vector();
	Hashtable shipDates = new java.util.Hashtable();
	
	int rowCount = 0;
	
	
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	
	if("po".equals(orderBase)){
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");	    
	EziPurchaseOrderParams iParams =  new EziPurchaseOrderParams();
	iParams.setSysKey(sysKey);
	iParams.setSoldTo(soldTo);
	mainParams.setObject(iParams);	
	Session.prepareParams(mainParams);
	
	ReturnObjFromRetrieve retAck = (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);
	if(retAck != null)
	{
		int retCount =  retAck.getRowCount(); 
		for(int j=0;j<retCount;j++)
		{
			if(retAck.getFieldValueString(j,"DOCSTATUS").equals("A") || retAck.getFieldValueString(j,"DOCSTATUS").equals("B")) 
				ackOrders.addElement(retAck.getFieldValueString(j,"DOCNO"));	
		}
	}
	
	ezc.ezpurchase.params.EziPurchaseInputParams testParams = new ezc.ezpurchase.params.EziPurchaseInputParams();
	newParams.setObject(testParams);
	newParams.setObject(iparams);
	Session.prepareParams(newParams);
	EzPurchHdrXML retObj = new EzPurchHdrXML();
	retObj = (EzPurchHdrXML)PoManager.ezGetOpenPurchaseOrderList(newParams);
	
	//ezc.ezcommon.EzLog4j.log("BEFOREEEE CHK ShIKSKSKJSKSKSKSKSSK>"+retObj.toEzcString(),"I");
	String tempOrd="";
	Date   tempDate = null;
	if(retObj != null)
	{
		if(retObj.getRowCount()>0)
		{
			
			retObj.sort(new String[] {"ORDER"},true);
		}
		for(int i=retObj.getRowCount()-1;i>=0;i--)
		{
			tempOrd 	= retObj.getFieldValueString(i,"ORDER");
			tempDate	= (Date)retObj.getFieldValue(i,"SHIPDATE");
			if(ackOrders.contains(tempOrd) )
			{
				retObj.deleteRow(i);
				
			}
			else
			{
				toShipPos.add(tempOrd);
				if(tempDate!=null)
					shipDates.put(tempOrd,tempDate);
			}	
		}
		session.putValue("toShipPos",toShipPos);
		session.putValue("shipDates",shipDates);
		
	}
	//ezc.ezcommon.EzLog4j.log("MY CHK ShiKSKSKJSKSKSKSKSSK>"+retObj.toEzcString(),"I");
	
	if(retObj!=null)
				rowCount = retObj.getRowCount(); //soldtoRows;
			
			for(int i=0;i<rowCount;i++)
			{
				//xmlrep += "<option value='"+retObj.getFieldValueString(i,"ORDER")+"' "+selected+">"+retObj.getFieldValueString(i,"ORDER")+"</option>";
				xmlrep += retObj.getFieldValueString(i,"ORDER")+"¥";	
		}
	
		
	}else{
	
		ezc.ezpurcontract.params.EziPurchaseInputParams testParams1 = new ezc.ezpurcontract.params.EziPurchaseInputParams();
		newParams.createContainer();
		newParams.setObject(testParams1);
		newParams.setObject(iparams);
		Session.prepareParams(newParams);
		EzPurchCtrHdrXML retObj =new EzPurchCtrHdrXML();
		retObj = (EzPurchCtrHdrXML)PcManager.ezOpenPurchaseContractList(newParams);
		
		if(retObj!=null)
			rowCount = retObj.getRowCount(); //soldtoRows;
			
		
		for(int i=0;i<rowCount;i++)
		{
			xmlrep += retObj.getFieldValueString(i,"CONTRACT")+"¥";	
			
			
			toShipPos.add(retObj.getFieldValueString(i,"CONTRACT"));
			if(retObj.getFieldValue(i,"SHIPDATE")!=null)
			shipDates.put(retObj.getFieldValueString(i,"CONTRACT"),(Date)retObj.getFieldValue(i,"SHIPDATE"));
		}
		
		session.putValue("toShipPos",toShipPos);
		session.putValue("shipDates",shipDates);
	}
	
	out.println(xmlrep);
	
%>




	

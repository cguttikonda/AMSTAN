<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*,ezc.ezvendorapp.params.*,ezc.ezpurchase.params.*" %>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<%
	String show 		= request.getParameter("SHOW");
	String orderType 	= request.getParameter("type");
	String sysKey 	 = (String) session.getValue("SYSKEY");
	String soldTo 	 = (String) session.getValue("SOLDTO");
	String userType	 = (String) session.getValue("UserType");
	
	String userRole	= (String) session.getValue("USERROLE");
	java.util.Vector assignedAreas = (java.util.Vector) session.getValue("CATAREAS");
	
	
	if(show != null && "ALL".equals(show))
	{
	
		if("PH".equals(userRole))
		{
			for(int i=0;i<assignedAreas.size();i++)
			{
				String tempArea  = (String)assignedAreas.get(i);
				if(i==0)
					sysKey=tempArea;
				else
					sysKey+="','"+tempArea;
			}

		}
		else
		{
			soldTo = (String) session.getValue("SOLDTOS");
		}	
	}
	else
	{
		soldTo = (String) session.getValue("SOLDTO");
	}
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");	    
	ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
	if(orderType.equals("Rejected"))
	{
		iParams.setDocStatus("R");
	}
	else if(orderType.equals("Acknowledged"))
	{
		iParams.setDocStatus("X");
	}
	else if(orderType.equals("NotAcknowledged"))
	{
		iParams.setDocStatus("A");
	}
	
	iParams.setSysKey(sysKey);
	if(!"PH".equals(userRole) ||  !"ALL".equals(show))
		iParams.setSoldTo(soldTo);
		
	mainParams.setObject(iParams);	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);
	int Count =0;
	if(ret != null)
	{
		Count=ret.getRowCount();
		if(Count > 0)
		{
			ret.sort(new String[]{"DOCDATE"},false);
		}
	}
	
	EzPurchHdrXML hdrXML = null;
	int hdrCount = 0;
	java.util.Hashtable poHash = new java.util.Hashtable();
	try
	{
		EzcPurchaseParams newParams 	  = new EzcPurchaseParams();	
		EzPSIInputParameters iparams 	  = new EzPSIInputParameters();
		EziPurchaseInputParams testParams = new EziPurchaseInputParams();
		testParams.setFromDate(new java.sql.Date(106,0,1));
		newParams.createContainer();
		newParams.setObject(iparams);
		newParams.setObject(testParams);
		Session.prepareParams(newParams);
		hdrXML = (EzPurchHdrXML)PoManager.ezGetAllPurchaseOrderList(newParams);			
		if(hdrXML != null)
		{
			hdrCount = hdrXML.getRowCount();
			for(int i=0;i<hdrCount;i++)
			{
				poHash.put(hdrXML.getFieldValueString(i,"ORDER"),(java.util.Date)hdrXML.getFieldValue(i,"SHIPDATE"));
			}
		}	
	}
	catch(Exception ex)
	{
		ezc.ezcommon.EzLog4j.log("CHECKOOOOOO>>>>","I");
	}
		
	
%>
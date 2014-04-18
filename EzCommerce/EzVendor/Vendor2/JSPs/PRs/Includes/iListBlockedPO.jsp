<%@ page import ="ezc.ezparam.*" %>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	String show = request.getParameter("SHOW");
	String orderType = request.getParameter("type");
	String sysKey = (String) session.getValue("SYSKEY");
	String soldTo = (String) session.getValue("SOLDTO");
	String userRole	= (String) session.getValue("USERROLE");
	java.util.Vector assignedAreas = (java.util.Vector) session.getValue("CATAREAS");
		
	if(show != null && "ALL".equals(show))
	{
		if("PH".equals(userRole)){
			for(int i=0;i<assignedAreas.size();i++)
			{
				String tempArea  = (String)assignedAreas.get(i);
				if(i==0)
					sysKey=tempArea;
				else
					sysKey+="','"+tempArea;
			}

		}
		else{
			soldTo 	= (String) session.getValue("SOLDTOS");
		}	
	}
	else
	{
		soldTo  = (String) session.getValue("SOLDTO");
	}
	ezc.ezcommon.EzLog4j.log("DESTPPPPPPPPOK"+sysKey,"I");	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");	    
	ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
	iParams.setSysKey(sysKey);
	if(!"PH".equals(userRole) ||  !"ALL".equals(show) )
		iParams.setSoldTo(soldTo);
	iParams.setDocStatus("B");
	mainParams.setObject(iParams);	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);
	int Count = ret.getRowCount();
%>


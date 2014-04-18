<%@ page import="ezc.ezparam.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />

<%
	String flag1 = request.getParameter("flag1");

	//Added By Nagesh passing A for Active Materials
		//					  S for InActive Materials	
		//					  A,S for All Materials
	
	String statusType=request.getParameter("statusType");
	
	String setStatusType="";
	String statusDisplay="";
	if(statusType==null || "".equals(statusType) || "null".equals(statusType) || statusType.equals("A"))
	{
		setStatusType="A";
		statusDisplay="Active";
	}
	else if(statusType.equals("IA"))
	{
		setStatusType="S";
		statusDisplay="InActive";
	}
	else if(statusType.equals("All"))
	{
		setStatusType="A','S";
		statusDisplay="";
	}
	
	//Ends

	String sysKey= (String)session.getValue("SYSKEY");
        String soldTo= (String)session.getValue("SOLDTO");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure struct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

        String type = request.getParameter("Type");
	String userType = (String)session.getValue("UserType");

	if(userType.equals("3"))
	{
		struct.setCurrentStatus("A");
		struct.setSoldTo(soldTo);
		if(flag1!=null)
                {
		  struct.setFlag("N");
                }
        }
	else
	{
		struct.setSysKey(sysKey);
	}

	struct.setRequestType(type);
	struct.setUserType(userType);
	
	//This is added by nagesh to get Active,InActive and All status materials
	struct.setCurrentStatus(setStatusType);
	//Ends
	
	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetAllMaterialRequests(mainParams);
	int retCount=ret.getRowCount();
	if(userType.equals("3"))
	{
		if(retCount>0)
	    	{
			for(int i=ret.getRowCount()-1;i>=0;i--)
			{
				if(!ret.getFieldValueString(i,"VISIBILITYLEVEL").equals("A"))
				{
					if(!ret.getFieldValueString(i,"SYSKEY").equals(sysKey))
					{
						ret.deleteRow(i);
					}
				}
			}
	    	}
	}

%>

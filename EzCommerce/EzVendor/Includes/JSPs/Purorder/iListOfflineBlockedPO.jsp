<%@ page import ="ezc.ezparam.*" %>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlow" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" /> 
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iCheckQuery.jsp" %>
	
<%	
	java.util.Hashtable remHash = new java.util.Hashtable();
	remHash.put("Q","Query Sent");
	remHash.put("R","Replied");
	remHash.put("N","No Queries");	
	
	java.util.Vector getVec = (java.util.Vector)session.getValue("CATAREAS");
	
	String syskeyStr="";
	if(getVec!= null && getVec.size()>0)
	{
		syskeyStr = (String)getVec.get(0);
		for(int i=1;i<getVec.size();i++)
		{
			syskeyStr +="','"+(String)getVec.get(i);
		}
	}
	
	 String orderType ="Amend";
	 String poNum = "";
	 String remCol = "";
	 String sysKey = (String) session.getValue("SYSKEY");
	 String soldTo = (String) session.getValue("SOLDTO");
	 
	 if(!"".equals(syskeyStr) )
	 	sysKey	= syskeyStr;
	 
	 int Count = 0;
	 
	
	 String participant	=(String)session.getValue("USERWORKGROUP");
	 String userRole 	=(String)session.getValue("USERROLE");
	 String userName 	=(String)Session.getUserId();
	 String checkName 	= participant+"','"+userRole+"','"+userName+"','"+(String)session.getValue("ROLE");
	
	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();

	
	params.setAuthKey("PO_RELEASE");
	params.setSysKey(sysKey);
	params.setKey("B");
	params.setStatus("Blocked','SUBMITTED','REJECTED");
	params.setParticipant(checkName);
	mainParams1.setObject(params);
	Session.prepareParams(mainParams1);
	ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.ezGetWFDocListByStatus(mainParams1);
	
	if(ret!=null)
	{	Count = ret.getRowCount();
		if(Count>0)
		{
			ret.sort(new String[]{"DOCDATE"},false);
			ret.addColumn("REMARKS");
			for(int i=0;i<Count;i++)
			{
				poNum = ret.getFieldValueString(i,"DOCNO");
				remCol = checkQueries(Session,poNum,Session.getUserId());
				if((remCol == null || "".equals(remCol)) && !remHash.contains(remCol))
					remCol = "N";				
				ret.setFieldValueAt("REMARKS",remHash.get(remCol)+"",i);	
			}
		}	
	}
%>


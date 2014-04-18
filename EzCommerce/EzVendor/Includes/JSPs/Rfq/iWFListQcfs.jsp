<%@page import="ezc.ezbasicutil.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%@ include file="../Misc/iGetUserName.jsp" %>
<%!
	private String modifyDate(String dateString)
	{
		String modDate = "";
		try{
			modDate = dateString.substring(0,10);
			java.util.StringTokenizer stoken = new java.util.StringTokenizer(modDate,"-");
			String token1 = stoken.nextToken();
			String token2 = stoken.nextToken();
			String token3 = stoken.nextToken();
			modDate = token3+"."+token2+"."+token1+" "+dateString.substring(11,dateString.lastIndexOf("."));
		}
		catch(Exception ex)
		{
			modDate = dateString;
		}
		return modDate;
	}	
	
	private String checkDetails(ezc.session.EzSession Session,String collNo,String syskey)
	{
		ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
		wfParams.setAuthKey("QCF_RELEASE");
		wfParams.setSysKey(syskey);
		wfParams.setDocId(collNo);
		wfParams.setSoldTo("0");
		wfMainParams.setObject(wfParams);
		Session.prepareParams(wfMainParams);
		ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);
		String user=(Session.getUserId()).trim();
		String status = "";
		if(wfDetailsRet != null)
		{	
			for(int i=wfDetailsRet.getRowCount()-1;i>=0;i--)
			{	
				if(user.equals(wfDetailsRet.getFieldValueString(i,"ACTIONBY").trim()))
				{
					status = wfDetailsRet.getFieldValueString(i,"STATUS");
					break;					
				}
			}
		}
		return status;
	}	
%>


<%
	java.util.Hashtable remHash = new java.util.Hashtable();
	remHash.put("Q","Sent Query");
	remHash.put("R","Reply Rcvd");
	remHash.put("N","No Queries");
	
	String catAreas = "";

	if(session.getValue("CATAREAS")!=null)
	{
		Vector catAreasVect = (Vector)session.getValue("CATAREAS");
		int vectSize  = catAreasVect.size();
		for(int c=0;c<vectSize;c++)
		{
			catAreas += "'"+(String)catAreasVect.get(c)+"',";
		}
		if(! "".equals(catAreas))
			catAreas = catAreas.substring(0,catAreas.length()-1);
	}
	
	String scrollInit = "";
	String loginType = (String)session.getValue("OFFLINE");
	if(loginType != null && "Y".equals(loginType))
		scrollInit="10";
	else
	scrollInit="100";
	
	String 	type 		= request.getParameter("Type");
	String 	editString 	= request.getParameter("EDIT");
	boolean editable	= true;
	if(!"N".equals(type))
	{
		if("T".equals(editString))
			editable = true;
		else	
			editable = false;
	}		
	String sysKey = (String)session.getValue("SYSKEY");
	String template=(String)session.getValue("TEMPLATE");
	
	String participant	= (String)session.getValue("USERGROUP");
	String userRole 	= (String)session.getValue("USERROLE");
	String wfRole 		= (String)session.getValue("ROLE");
	String userName 	= (String)Session.getUserId();
	
	String checkName = "'"+participant+"','"+userRole+"','"+userName+"','"+wfRole+"'";
	
	
	System.out.println("checkNamecheckNamecheckNamecheckNamecheckName:::"+checkName);
	
	String users = "";	
	String stats="";
	String delHead = "";
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setAuthKey("'QCF_RELEASE'");
	params.setSysKey("'"+sysKey+"'");
	//params.setSysKey(catAreas);
	params.setTemplateCode(template);
	if(!"A".equals(type))	
	{
		if("APPROVED".equals(type)) // This type will come only for PP
			params.setStatus("'APPROVED'");
		else
		{
			
			if("D".equals(type))
			{
				params.setDelParticipant(checkName);	
				delHead = "Delegated ";
			}	
			else
				params.setParticipant(checkName);
			params.setStatus("'SUBMITTED','REJECTED'");
		}
	}
	else if("S".equals(type))	
			params.setStatus("'APPROVED','SUBMITTED','REJECTED'");

	
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	
	ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
	int retObjCount=0;
	String authName = "";
	String authType = "";
	String delAuthType = "";
	String remCol = "";
	String chkPrvStatus = "";
	
	retObjCount = retobj.getRowCount();
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setExt1("CR");
	ezirfqheaderparams.setStatus("Y','N','R");
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	boolean flag = false;
	Hashtable nextParticipants = new Hashtable();
	Hashtable delParticipants = new Hashtable();
	myRet.addColumn("WFSTATUS");
	myRet.addColumn("WFDATE");
	myRet.addColumn("NEXTPARTICIPANT");
	myRet.addColumn("NEXTPARTICIPANTTYPE");
	myRet.addColumn("REMARKS");
	myRet.addColumn("ISESCALATE");
	myRet.addColumn("SENTBY");
	if("APPROVED".equals(type)) 
	{
		myRet.addColumn("APPROVEDON");
		myRet.addColumn("APPROVEDBY");
	}
	for(int i=myRet.getRowCount()-1;i>=0;i--)
	{
		flag = false;
		for(int j=0;j<retObjCount;j++)
		{	
		     if(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO").equals(retobj.getFieldValueString(j,"DOCID")))	
		     {
			remCol = checkQueries(Session,myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"),Session.getUserId());
			chkPrvStatus = checkDetails(Session,myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"),catAreas.substring(1,catAreas.length()-1));
			if("REJECTED".equals(chkPrvStatus.trim()))
				myRet.setFieldValueAt("WFSTATUS","RESUBMITTED",i);
			else
				myRet.setFieldValueAt("WFSTATUS",retobj.getFieldValueString(j,"STATUS"),i);
				
			
			if((remCol == null || "".equals(remCol)) && !remHash.contains(remCol))
				remCol = "N";
			flag = true;
			
			myRet.setFieldValueAt("WFDATE",retobj.getFieldValueString(j,"MODIFIEDON"),i);
			if(!"D".equals(type))
			{
				myRet.setFieldValueAt("NEXTPARTICIPANT",retobj.getFieldValueString(j,"NEXTPARTICIPANT"),i);
				myRet.setFieldValueAt("NEXTPARTICIPANTTYPE",retobj.getFieldValueString(j,"PARTICIPANTTYPE"),i);
			}
			else
			{
				myRet.setFieldValueAt("NEXTPARTICIPANT",retobj.getFieldValueString(j,"DELPARTICIPANT"),i);
				myRet.setFieldValueAt("NEXTPARTICIPANTTYPE","U",i);
			}
			myRet.setFieldValueAt("REMARKS",remHash.get(remCol)+"",i);
			myRet.setFieldValueAt("SENTBY",retobj.getFieldValueString(j,"MODIFIEDBY"),i);
			if("APPROVED".equals(type)) 
			{
				myRet.setFieldValueAt("APPROVEDON",retobj.getFieldValueString(j,"MODIFIEDON"),i);
				myRet.setFieldValueAt("APPROVEDBY",getUserName(Session,retobj.getFieldValueString(j,"MODIFIEDBY"),"U",(String)session.getValue("SYSKEY")),i);
			}

			if("E".equals((retobj.getFieldValueString(j,"REF1").trim()).toUpperCase()))
				myRet.setFieldValueAt("ISESCALATE","Y",i);
			else	
				myRet.setFieldValueAt("ISESCALATE","N",i);			
		     }
		     
		     if(!nextParticipants.containsKey(retobj.getFieldValueString(j,"DOCID")))
		     {
		     	nextParticipants.put(retobj.getFieldValueString(j,"DOCID"),retobj.getFieldValueString(j,"NEXTPARTICIPANT"));
		     }
		     if(!delParticipants.containsKey(retobj.getFieldValueString(j,"DOCID")))
		     {
		        delParticipants.put(retobj.getFieldValueString(j,"DOCID"),retobj.getFieldValueString(j,"DELPARTICIPANT"));
		     }
		}
		if(!flag)
		{
			myRet.deleteRow(i);
		}
	}
	int myRetCount = myRet.getRowCount();

%>



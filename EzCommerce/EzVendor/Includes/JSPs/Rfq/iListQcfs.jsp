<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iGetUserName.jsp" %>
<%@ page import="java.util.*" %>
<%

	String sysKey 		= (String)session.getValue("SYSKEY");
	String participant	= (String)session.getValue("USERGROUP");
	String template		= (String)session.getValue("TEMPLATE");
	String userRole    	= (String)session.getValue("USERROLE");
  	String wfCheckName 	= "'"+Session.getUserId()+"','"+participant+"','"+userRole+"'";	

	String collectiveRFQNo 	= request.getParameter("collectiveRFQNo");
	
	String type	= "";
	String status	= "";
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
	
	if(request.getParameter("status") != null)
		status= request.getParameter("status");
	if(request.getParameter("Type") != null)
		type= request.getParameter("Type");

  
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezirfqheaderparams.setExt1("CR");
	ezirfqheaderparams.setSysKey(sysKey);
	ezirfqheaderparams.setStatus("Y','N','R");
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	try
	{
		myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
		myRet.addColumn("WFSTATUS");
		myRet.addColumn("WFDATE");
		myRet.addColumn("NEXTPARTICIPANT");
		myRet.addColumn("NEXTPARTICIPANTTYPE");
		myRet.addColumn("DELPARTICIPANT");
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting QCFs List:"+e);
	}
	

  
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	ezc.ezparam.ReturnObjFromRetrieve retobj = null;
	params.setAuthKey("'QCF_RELEASE'");
	params.setSysKey("'"+sysKey+"'");
  	if("E".equals(type))
  	{
    		params.setParticipant(wfCheckName);
		params.setStatus("'SUBMITTED','REJECTED'");
  	}
	params.setTemplateCode(template);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	try
	{
		retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting WFDocList:"+e);
	}
	
	java.util.Hashtable htab = new 	java.util.Hashtable();
 	int retObjCount=retobj.getRowCount();	
 	boolean findDoc=false;
  	for(int i=myRet.getRowCount()-1;i>=0;i--)
	{
    		findDoc=false;
		for(int j=0;j<retObjCount;j++)
		{	
			if(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO").equals(retobj.getFieldValueString(j,"DOCID")))	
			{
				findDoc=true;
		     		if(!"A".equals(type) && !"E".equals(type))
		     		{
		     			myRet.deleteRow(i);
		     			break;
		     		}
		     		else
		     		{
            				myRet.setFieldValueAt("WFSTATUS",retobj.getFieldValueString(j,"STATUS"),i);
            				myRet.setFieldValueAt("WFDATE",retobj.getFieldValueString(j,"MODIFIEDON"),i);
					myRet.setFieldValueAt("NEXTPARTICIPANT",retobj.getFieldValueString(j,"NEXTPARTICIPANT"),i);
					myRet.setFieldValueAt("NEXTPARTICIPANTTYPE",retobj.getFieldValueString(j,"PARTICIPANTTYPE"),i);
					myRet.setFieldValueAt("DELPARTICIPANT",retobj.getFieldValueString(j,"DELPARTICIPANT"),i);
				}
			}
			else
		     	{
				if(!htab.contains(retobj.getFieldValueString(j,"DOCID")))
			     		htab.put(retobj.getFieldValueString(j,"DOCID"),retobj.getFieldValueString(j,"STATUS"));
			}
		}
    		java.util.Date chkDateObj	= new java.util.Date();
    		java.util.Date validUPTO 	= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
    		if( "E".equals(type) && ((!findDoc) || (findDoc && validUPTO!=null && chkDateObj.compareTo(validUPTO) < 0)))
    		    myRet.deleteRow(i);
	}
  	String isDelParticipant = "";
	if(retobj!=null)
		session.putValue("QCFLIST",retobj);
%>
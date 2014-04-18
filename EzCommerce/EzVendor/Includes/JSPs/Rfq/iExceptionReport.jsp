<%@page import="ezc.ezbasicutil.*,java.io.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%
	String syskey = (String)session.getValue("SYSKEY");
	int myRetCount=0;
	String qcfnums="";
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setExt1("CR");
	ezirfqheaderparams.setSysKey(syskey);
	ezirfqheaderparams.setStatus("C");
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	
	ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	myRet.toEzcString();
	System.out.println("ASDFASDF");
	myRetCount=myRet.getRowCount();
	String str="";
	for(int i=0;i<myRetCount;i++)
	{
		str= myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO");
		if(qcfnums.equals(""))
		{
			if(myRetCount<2)
				qcfnums=str;
			else
				qcfnums=str+"'";
			
		}	
		else
		{
			if(i==(myRetCount-1))
				qcfnums=qcfnums+","+" '"+str;
			else
				qcfnums=qcfnums+","+" '"+str+"'";
		}	
	}	
	
	
	
	String status = request.getParameter("status");
	int retTrailCount= 0;
	ezc.ezparam.ReturnObjFromRetrieve retTrailNos = null;
	ezc.ezpreprocurement.client.EzPreProcurementManager wfAuditTrailManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezpreprocurement.params.EziWFAuditTrailParams wfAuditTrailParams = new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
	myParams.setLocalStore("Y");
	wfAuditTrailParams.setEwhExt1("$$");
	if(status.equals("R"))
	wfAuditTrailParams.setEwhType("EXPIRED");
	else
	wfAuditTrailParams.setEwhType("CLOSED");
	wfAuditTrailParams.setEwhDocId(qcfnums);
	myParams.setObject(wfAuditTrailParams);
	Session.prepareParams(myParams);
	try
	{
		retTrailNos = (ezc.ezparam.ReturnObjFromRetrieve)wfAuditTrailManager.ezGetWFAuditTrailNo(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	if(retTrailNos!= null)
	{
		retTrailCount= retTrailNos.getRowCount();
	}
	String rid="";
	String reasons="";
	String reason="";
	String myRetId="";
	String retTrailId="";
	boolean flag=false;
	myRet.addColumn("REASON");
	myRet.addColumn("STATUS");
	
	for(int j=0;j<retTrailCount;j++)
	{
		reasons = retTrailNos.getFieldValueString(j,"EWAT_COMMENTS");
		retTrailId = retTrailNos.getFieldValueString(j,"EWAT_DOC_ID");
		java.util.StringTokenizer st = new java.util.StringTokenizer(reasons,"$");
		if(st.hasMoreElements())
			rid =  st.nextToken();
		if(st.hasMoreElements())
			reason=  st.nextToken();
			
		for(int i=0;i<myRetCount;i++)
		{
			myRetId=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO");
			
			if(myRetId.equals(retTrailId))
			{
				if(status.equals("S") && rid.equals("3") )
				{
				     myRet.setFieldValueAt("REASON",reason,i);
				     myRet.setFieldValueAt("STATUS","S",i);
				}     
				     
				else if(status.equals("W") && rid.equals("1") )
					myRet.setFieldValueAt("STATUS","W",i);
				else if(status.equals("R") && rid.equals("2") )	
					 myRet.setFieldValueAt("STATUS","R",i);	
			}
				
		}
			
		
		
	}
	String  check="";
	String  stat="";
	int retNewCount = 0;
		for(int i=myRet.getRowCount()-1;i>=0;i--)
		{
		    stat =  myRet.getFieldValueString(i,"STATUS");
		    if(stat.equals("null")||stat==null)
			 myRet.deleteRow(i);
		}
		
		for(int i=myRet.getRowCount()-1;i>=0;i--)
		{
			check = myRet.getFieldValueString(i,"REASON");
			stat =  myRet.getFieldValueString(i,"STATUS");
			
			if( status.equals("S") && ( check.equals("null")||(check==null) ) )
			{
				 myRet.deleteRow(i);
			}
			else if(status.equals("W") && (stat.equals("S") || stat.equals("R")))
			{
				
				myRet.deleteRow(i);
				
			}
			else if(status.equals("R") && (stat.equals("W") || stat.equals("S")))
			{
			
				myRet.deleteRow(i);
			}
		}
	retNewCount = myRet.getRowCount();
%>	
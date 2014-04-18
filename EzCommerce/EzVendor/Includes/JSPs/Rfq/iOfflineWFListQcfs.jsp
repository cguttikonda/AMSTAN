<%@page import="ezc.ezbasicutil.*,java.io.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iblockcontrol.jsp" %>
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%@ include file="../Misc/iGetUserName.jsp" %>
<%!
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
	
	private String millisecondsToString(String inTime)
	{
		if("0".equals(inTime))
			return "-";
		long time = Long.parseLong(inTime);
		String returnTime = ""; 
		int milliseconds = (int)(time % 1000);
		int seconds = (int)((time/1000) % 60);
		int minutes = (int)((time/60000) % 60);
		System.out.println("mionsmionsmionsmions"+minutes);
		int hours = (int)((time/3600000) % 24);
		int days = (int)((time/3600000)/24);
		hours += days*24;	    
		String millisecondsStr = (milliseconds<10 ? "00" : (milliseconds<100 ? "0" : ""))+milliseconds;
		String secondsStr = (seconds<10 ? "0" : "")+seconds;
		String minutesStr = (minutes<10 ? "0" : "")+minutes;
		String hoursStr = (hours<10 ? "0" : "")+hours;
		
		try{
		
			int hoursInt = Integer.parseInt(hoursStr);
			int dysTkn = hoursInt / 24;
			int hrsTkn = hoursInt % 24;
			if(dysTkn == 0)
				returnTime = hrsTkn+" Hrs "+minutesStr+" Mins";				
			else
				returnTime = dysTkn+"Day(s) ";//+hrsTkn+" Hrs";
				
				
		}catch(Exception ex){returnTime = hoursStr+" Hrs "+minutesStr+" Mins";}	
		return returnTime;
	}	
%>

<%
	Vector types = new Vector();
	types.addElement("date");
	types.addElement("date");
	types.addElement("date");
	EzGlobal.setColTypes(types);
	EzGlobal.setDateFormat("dd.MM.yyyy");

	Vector colNames = new Vector();
	colNames.addElement("RFQ_DATE");
	colNames.addElement("VALID_UPTO");
	colNames.addElement("WFDATE");
	EzGlobal.setColNames(colNames);


	ezc.ezparam.ReturnObjFromRetrieve globalActiveRet = null,globalExpiredRet = null;	
	
	java.util.Hashtable remHash = new java.util.Hashtable();
	remHash.put("Q","Query Sent");
	remHash.put("R","Replied");
	remHash.put("N","No");
	
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
	
	String 	type 		= request.getParameter("type");
	
	
	

	String sysKey 		= (String)session.getValue("SYSKEY");
	String template		= (String)session.getValue("TEMPLATE");
	String participant	= (String)session.getValue("USERWORKGROUP");
	String userRole 	= (String)session.getValue("USERROLE");
	String wfRole 		= (String)session.getValue("ROLE");
	String userName 	= (String)Session.getUserId();
	
	String checkName = "'"+participant+"','"+userRole+"','"+userName+"','"+wfRole+"'";
	
	
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziEscalationParams detailsParams= new ezc.ezworkflow.params.EziEscalationParams();
	detailsParams.setGroupId(participant);
	detailsParams.setTemplate(template);
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet= null;
	detailsRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getEscalationDetails(detailsMainParams);
	String duration = "0";
	if(detailsRet!=null && detailsRet.getRowCount()>0)
		duration = detailsRet.getFieldValueString(0,"DURATION");
	 
	
	String users = "";	
	String stats="";
	String delHead = "";
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setAuthKey("'QCF_RELEASE'");
	params.setSysKey(catAreas);
	params.setParticipant(checkName);
	params.setDelParticipant(checkName);
	params.setStatus("'SUBMITTED','REJECTED'");
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);

	java.util.Hashtable collSyskey=new java.util.Hashtable();
	int retObjCount=0;
	String authName = "";
	String authType = "";
	String delAuthType = "";
	String remCol = "";
	String chkPrvStatus = "";
	if(retobj!=null)
		retObjCount = retobj.getRowCount();
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setExt1("CR");
	ezirfqheaderparams.setSysKey(catAreas.substring(1,catAreas.length()-1));
	ezirfqheaderparams.setStatus("Y','N','R");
	ezirfqheaderparams.setExt2("DTGT");
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve activeRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	
	
	ezirfqheaderparams.setExt2("DTLT");
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve expiredRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
	
	ezc.ezparam.ReturnObjFromRetrieve myRet=new ezc.ezparam.ReturnObjFromRetrieve();
	Hashtable nextParticipants = new Hashtable();
	Hashtable delParticipants = new Hashtable();
	for(int a=1;a<3;a++)
	{
		if(a==1)
		{
			if(activeRet!=null  && activeRet.getRowCount()>0 )
				myRet=activeRet;
		}
		else
		{
			if(expiredRet!=null  && expiredRet.getRowCount()>0 )
				myRet=expiredRet;
		}
		
		if(myRet!=null&&myRet.getRowCount()>0)
		{
			boolean flag = false;
			
			myRet.addColumn("WFSTATUS");
			myRet.addColumn("WFDATE");
			myRet.addColumn("TIMELEFT");
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
					collSyskey.put((myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")).trim(),myRet.getFieldValueString(i,"ERH_SYS_KEY"));
					chkPrvStatus = checkDetails(Session,myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"),catAreas.substring(1,catAreas.length()-1));
					String delPart = (retobj.getFieldValueString(j,"DELPARTICIPANT")).trim();
					
					if(delPart.equals(userName) || delPart.equals(participant) || delPart.equals(userRole))
					{
						myRet.setFieldValueAt("WFSTATUS","DELEGATED",i);
					}
					else
					{
						if("REJECTED".equals(chkPrvStatus.trim()))
							myRet.setFieldValueAt("WFSTATUS","RESUBMITTED",i);
						else
							myRet.setFieldValueAt("WFSTATUS",retobj.getFieldValueString(j,"STATUS"),i);
					}		
						
					
					
					

					if((remCol == null || "".equals(remCol)) && !remHash.contains(remCol))
						remCol = "N";
					flag = true;

					myRet.setFieldValueAt("WFDATE",retobj.getFieldValue(j,"MODIFIEDON"),i);
					
					Date modDate = (java.util.Date)retobj.getFieldValue(j,"MODIFIEDON");
					
					java.util.Date timeDateObj = null;
					int intDuration = Integer.parseInt(duration);
					String diffTime = "";
					long timeInMillis =0;
					if(modDate!=null)
					{
				
						int day 	= modDate.getDate();
						int month 	= modDate.getMonth();
						int year 	= modDate.getYear();
						int hours 	= modDate.getHours();
						int mins 	= modDate.getMinutes();
						int scnds 	= modDate.getSeconds();
					
					
						timeDateObj 	= new java.util.Date(year,month,day,hours,mins,scnds);
						long fromTime	= timeDateObj.getTime();
						
						Date toDate = new java.util.Date();
						day 	= toDate.getDate();
						month 	= toDate.getMonth();
						year 	= toDate.getYear();
						hours 	= toDate.getHours();
						mins 	= toDate.getMinutes();
						scnds 	= toDate.getSeconds();
						
						java.util.Date toDateObj = new java.util.Date(year,month,day,hours,mins,scnds);
						long toTime = toDateObj.getTime();
						
						timeInMillis = toTime - fromTime;	
						
						if(timeInMillis<0)
							timeInMillis =0;
						
					}
					
					myRet.setFieldValueAt("TIMELEFT",new Long(timeInMillis),i);
					
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
			
			if(a==1)
				activeRet = myRet;
			else
				expiredRet= myRet;
		}
	}
	
	String lastLogin =(String)session.getValue("LAST_LOGIN_DATE");
	
	java.util.Date lastLogDate=null;
	if((!"".equals(lastLogin))&&(lastLogin.length()>7))
	{
		FormatDate fD = new FormatDate();
		int dateArray[] = fD.getMMDDYYYY(lastLogin,true);
		dateArray[0]=dateArray[0]-1;
		lastLogDate=new java.util.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
	}
	int activeRetCount = activeRet.getRowCount();
	
	String [] myRetCols = {"COLLETIVE_RFQ_NO","ERH_SYS_KEY","RFQ_DATE","VALID_UPTO","MATERIAL","MATERIAL_DESC","TOT_RFQ","TOT_QUOTED","TOT_NOT_QUOTED","TOT_REJECTED","TOT_PROPOSED","WFSTATUS","WFDATE","TIMELEFT","NEXTPARTICIPANT","NEXTPARTICIPANTTYPE","REMARKS","ISESCALATE","SENTBY"}; 
	ezc.ezparam.ReturnObjFromRetrieve actLastlogin= new ezc.ezparam.ReturnObjFromRetrieve(myRetCols);
	ezc.ezparam.ReturnObjFromRetrieve actRemain   = new ezc.ezparam.ReturnObjFromRetrieve(myRetCols);
	int colLength = myRetCols.length;
	for(int i=0;i<activeRetCount;i++)
	{
		java.util.Date wfdate	= (java.util.Date)activeRet.getFieldValue(i,"WFDATE");
		if(wfdate!=null && lastLogDate!=null)
		{
			if(lastLogDate.compareTo(wfdate)<=0)
			{
				
				for(int p=0;p<colLength;p++)
				{
				     actLastlogin.setFieldValue(myRetCols[p],activeRet.getFieldValue(i,myRetCols[p]));
				}
				actLastlogin.addRow();
			}	
			else
			{
				
				for(int p=0;p<colLength;p++)
				{
				     actRemain.setFieldValue(myRetCols[p],activeRet.getFieldValue(i,myRetCols[p]));
				}
				actRemain.addRow();
			}
		}	
	}


	String[] tl =new String[1];
	tl[0]="TIMELEFT";
	
	actLastlogin.sort(tl,false);
	actRemain.sort(tl,false);		
		
	ReturnObjFromRetrieve activeRetNew = new ezc.ezparam.ReturnObjFromRetrieve(myRetCols);
	int actLastloginCount = 0;
	if(actLastlogin!=null) actLastloginCount =actLastlogin.getRowCount();
	int actRemainCount = 0;
	if(actRemain!=null) actRemainCount =actRemain.getRowCount();
		
	for(int i=0;i<actLastloginCount;i++)
	{
		for(int p=0;p<colLength;p++)
		{
		     activeRetNew.setFieldValue(myRetCols[p],actLastlogin.getFieldValue(i,myRetCols[p]));
		}
		activeRetNew.addRow();
	}
	for(int i=0;i<actRemainCount;i++)
	{
		for(int p=0;p<colLength;p++)
		{
		     activeRetNew.setFieldValue(myRetCols[p],actRemain.getFieldValue(i,myRetCols[p]));
		}
		activeRetNew.addRow();
	}

	session.putValue("COLLSYSKEY",collSyskey);
	int myRetCount = activeRet.getRowCount()+expiredRet.getRowCount();
	
	globalActiveRet  = EzGlobal.getGlobal(activeRet);
	globalExpiredRet = EzGlobal.getGlobal(expiredRet);	
	
%>
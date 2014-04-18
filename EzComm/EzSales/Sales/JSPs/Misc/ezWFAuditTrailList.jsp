<%@ page import="ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%!
	private String calculateTime(java.util.Date fromDate, java.util.Date toDate)
	{
		int day 	= fromDate.getDate();
		int month 	= fromDate.getMonth();
		int year 	= fromDate.getYear();
		int hours 	= fromDate.getHours();
		int mins 	= fromDate.getMinutes();
		int scnds 	= fromDate.getSeconds();
		java.util.Date fromDateObj = new java.util.Date(year,month,day,hours,mins,scnds);
		long fromTime = fromDateObj.getTime();
		day 	= toDate.getDate();
		month 	= toDate.getMonth();
		year 	= toDate.getYear();
		hours 	= toDate.getHours();
		mins 	= toDate.getMinutes();
		scnds 	= toDate.getSeconds();
		java.util.Date toDateObj = new java.util.Date(year,month,day,hours,mins,scnds);
		long toTime = toDateObj.getTime();
		return millisecondsToString(toTime-fromTime);
	}
	private String millisecondsToString(long time)
	{
		String returnTime = ""; 
		int milliseconds = (int)(time % 1000);
		int seconds = (int)((time/1000) % 60);
		int minutes = (int)((time/60000) % 60);
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
			hoursStr = (hrsTkn<10 ? "0" : "")+hrsTkn;
			if(dysTkn == 0)
				returnTime = hoursStr+" Hrs "+minutesStr+" Mins";
			else
				returnTime = dysTkn+"Days "+hoursStr+" Hrs";
		}catch(Exception ex){returnTime = hoursStr+" Hrs "+minutesStr+" Mins";}	
		return returnTime;
	}	
%>
<%
	ezc.ezparam.ReturnObjFromRetrieve retGetWFAuditTrailNos = null;
	int retCount = 0;

	ezc.ezparam.ReturnObjFromRetrieve retGetNegAudit = null;
	int retNegCnt = 0;

	String docId = request.getParameter("webOrNo");

	if(docId!=null && !"null".equalsIgnoreCase(docId) && !"".equals(docId))
	{
		ezc.ezparam.EzcParams mainParamsMisc = new ezc.ezparam.EzcParams(false);
		EziMiscParams miscParams = new EziMiscParams();

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT  EWAT_AUDIT_NO, EWAT_DOC_ID, EWAT_TYPE, EWAT_SOURCE_PARTICIPANT, EWAT_SOURCE_PARTICIPANT_TYPE, EWAT_DEST_PARTICIPANT, EWAT_DEST_PARTICIPANT_TYPE,EWAT_COMMENTS,EWAT_DATE FROM EZC_WF_AUDIT_TRAIL WHERE EWAT_DOC_ID IN ('"+docId+"') ORDER BY CAST(EWAT_AUDIT_NO AS INT) DESC");

		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{
			retGetWFAuditTrailNos = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e){}

		if(retGetWFAuditTrailNos!= null)
		{
			retCount = retGetWFAuditTrailNos.getRowCount();
			String timeDiff = "";
			retGetWFAuditTrailNos.addColumn("TIME_DIFF");
			for(int i=retCount-1;i>=0;i--)
			{
				if(i < retCount-1)
				{
					timeDiff = calculateTime((java.util.Date)retGetWFAuditTrailNos.getFieldValue(i+1,"EWAT_DATE"),(java.util.Date)retGetWFAuditTrailNos.getFieldValue(i,"EWAT_DATE"));
				}
				else
				{
					timeDiff = "-";
				}
				retGetWFAuditTrailNos.setFieldValueAt("TIME_DIFF",timeDiff,i);
			}

			retGetWFAuditTrailNos.addColumn("AUDIT_TIME");
			for(int i=0;i<retCount;i++)
			{
				retGetWFAuditTrailNos.setFieldValueAt("AUDIT_TIME",(retGetWFAuditTrailNos.getFieldValueString(i,"EWAT_DATE")).substring(11,19),i);
				retGetWFAuditTrailNos.addRow();
			}
		}
		//out.println("retGetWFAuditTrailNos::"+retGetWFAuditTrailNos.toEzcString());
	}

	String retCols[] = new String[]{"AUDITNO","COMMENTS","AUDIT_TIME","TIME_DIFF"};
	ezc.ezparam.ReturnObjFromRetrieve retGetWFAudit = new ezc.ezparam.ReturnObjFromRetrieve(retCols);

	for(int i=0;i<retCount;i++)
	{
		String auditNo = retGetWFAuditTrailNos.getFieldValueString(i,"EWAT_AUDIT_NO");
		String comments = retGetWFAuditTrailNos.getFieldValueString(i,"EWAT_COMMENTS");
		String dateStr = ezc.ezutil.FormatDate.getStringFromDate((Date)retGetWFAuditTrailNos.getFieldValue(i,"EWAT_DATE"),".",ezc.ezutil.FormatDate.MMDDYYYY);
		String auditTime = dateStr+"&nbsp;&nbsp;"+retGetWFAuditTrailNos.getFieldValue(i,"AUDIT_TIME");
		String timeDiff = retGetWFAuditTrailNos.getFieldValueString(i,"TIME_DIFF");

		if(comments.indexOf("$") != -1)
		{
			comments = comments.substring(comments.indexOf("$")+1,comments.length());
		}

		if(comments.indexOf("On")>=0)
			comments = comments.substring(0,comments.indexOf("On")+2)+" "+dateStr+" "+comments.substring(comments.indexOf("On")+12,comments.length());

		retGetWFAudit.setFieldValue("AUDITNO",auditNo);
		retGetWFAudit.setFieldValue("COMMENTS",comments);
		retGetWFAudit.setFieldValue("AUDIT_TIME",auditTime);
		retGetWFAudit.setFieldValue("TIME_DIFF",timeDiff);
		retGetWFAudit.addRow();
	}

	if(retGetWFAudit!=null)
	{
%>
		<table class="data-table" id="quickatp">
		<thead>
		<tr>
			<Th width="10%" align="center">Audit</Th>
			<Th width="55%" align="center">Action</Th>
			<Th width="20%" align="center">Date </Th>
			<Th width="15%" align="center">Time Taken</Th>
		</tr>
		</thead>
		<tbody>
<%
		int wfCnt = retGetWFAudit.getRowCount();
		for(int i=0;i<wfCnt;i++)
		{
			String comments = retGetWFAudit.getFieldValueString(i,"COMMENTS");
			String auditNo = retGetWFAudit.getFieldValueString(i,"AUDITNO");
%>
		<Tr>
			<Td width="10%" align="center"><%=auditNo%>&nbsp;</Td>
			<Td width="55%" title='<%=comments%>'><%=comments%>&nbsp;</Td>
			<Td width="20%" align="center"><%=retGetWFAudit.getFieldValueString(i,"AUDIT_TIME")%></Td>
			<Td width="25%" align="center"><%=retGetWFAudit.getFieldValueString(i,"TIME_DIFF")%>&nbsp;</Td>
		</Tr>
<%
		}
	}
%>
	</tbody>
	</table>
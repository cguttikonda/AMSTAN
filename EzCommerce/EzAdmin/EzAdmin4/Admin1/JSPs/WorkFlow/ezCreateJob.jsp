<%@ page import="java.util.*"%>
<%
	String duration = request.getParameter("timeSpan");
	String jobName = request.getParameter("jobName");
	
	ezc.ezbasicutil.EzJobScheduler sched = new ezc.ezbasicutil.EzJobScheduler("");

	ezc.ezparam.ReturnObjFromRetrieve myRet=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"JOBNAME","DURATION"});
	myRet.setFieldValue("JOBNAME",jobName);  
	myRet.setFieldValue("DURATION",duration);
	myRet.addRow();

	sched.ezScheduleJob(myRet);
	
	response.sendRedirect("ezJobList.jsp");
%>
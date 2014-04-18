<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>


<%

// Get the input parameters from the User Entry screen
String client = request.getParameter("client");
String jobdesc = request.getParameter("jobdesc");
String jobtype = request.getParameter("jobtype");
String transaction = request.getParameter("transaction");
String inputfilepath = request.getParameter("inputfilepath");
String jobdate = request.getParameter("jobdate");
String jobtime = request.getParameter("jobtime");
String timeintreval = request.getParameter("timeintreval");
String timeunit = request.getParameter("timeunit");

String subscription = request.getParameter("subscribe");
String confirmation = request.getParameter("confirmation");
String completion = request.getParameter("completion");
String priorityCode = request.getParameter("prioritycode");
String expDate = request.getParameter("expdate");

EzcJobParams ejcparams = new EzcJobParams();
EziJobParams ejiparams = new EziJobParams();

//Business Partner, userid, jobid, job_desc will have be set in CSB
//Get the auto generated jobid, jobdate and jobtime
//For now, lets hardcode
String BusPartner = "501";
String jobid = "JOB4";
ejiparams.setBussPartner("501");  //For Testing only; remove after testing
ejiparams.setJobId(jobid); //For Testing only; remove after testing


String TodaysDateFormat = "MM/dd/yy";
String TodaysTimeFormat = "hh:mm:ss";
SimpleDateFormat formatterDay = new SimpleDateFormat(TodaysDateFormat);
SimpleDateFormat formatterTime = new SimpleDateFormat(TodaysTimeFormat);
java.util.Date dt = new java.util.Date(System.currentTimeMillis());
String TodaysDate = formatterDay.format(dt);
String TodaysTime = formatterTime.format(dt);

ejiparams.setJobDate(TodaysDate);
ejiparams.setJobTime(TodaysTime);
ejiparams.setJobStartDate(jobdate);
ejiparams.setJobStartTime(jobtime);
ejiparams.setTimeIntreval(timeintreval);
ejiparams.setTimeUnit(timeunit);
ejiparams.setClient(client);
ejiparams.setJobType(jobtype);
ejiparams.setFilePath(inputfilepath);
ejiparams.setTransaction(transaction);
ejiparams.setPriorityCode(priorityCode);
ejiparams.setConfirmationNeeded(confirmation);
ejiparams.setCompletionNeeded(completion);
ejiparams.setSubscriptionFlag(subscription);
ejiparams.setExpireDate(expDate);

ejcparams.setLanguage("EN");
ejcparams.setObject(ejiparams);
Session.prepareParams(ejcparams);

//AddJobDetails
JobManager.addJobDetails(ejcparams);

//Show the details for the job created on next page
//response.sendRedirect("../Config/ezShowJobDetails.jsp?jobid="+jobid);
response.sendRedirect("../Config/ezListJobs.jsp");

%>
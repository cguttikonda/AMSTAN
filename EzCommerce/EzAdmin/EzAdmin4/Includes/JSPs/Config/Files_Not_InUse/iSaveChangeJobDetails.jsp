<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>

<%

// Get the input parameters from the User Entry screen
String jobid = request.getParameter("jobid");
String client = request.getParameter("client");
String jobdesc = request.getParameter("jobdesc");
String jobtype = request.getParameter("jobtype");
String transaction = request.getParameter("transaction");
String inputfilepath = request.getParameter("inputfilepath");
String jobdate = request.getParameter("jobdate");
String jobtime = request.getParameter("jobtime");
String timeintreval = request.getParameter("timeintreval");
String timeunit = request.getParameter("timeunit");
String subscription = request.getParameter("subscription");
String confirmation = request.getParameter("confirmation");
String completion = request.getParameter("completion");
String priorityCode = request.getParameter("priority");
String expDate = request.getParameter("expiredate");

EzcJobParams ejcparams = new EzcJobParams();
EziJobParams ejiparams = new EziJobParams();

//Business Partner, userid, jobid, job_desc will have be set in CSB
//Get the auto generated jobid, jobdate and jobtime
//For now, lets hardcode
String BusPartner = "501";
ejiparams.setBussPartner("501");  //For Testing only; remove after testing
ejiparams.setJobId(jobid); //For Testing only; remove after testing
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
JobManager.changeJobDetails(ejcparams);

//Show the details for the job created on next page
response.sendRedirect("../Config/ezShowJobDetails.jsp?jobid="+jobid);

%>
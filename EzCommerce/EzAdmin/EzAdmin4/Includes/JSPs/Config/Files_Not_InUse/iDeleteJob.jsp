<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>

<%

// Get the input parameters from the User Entry screen
String jobid = request.getParameter("jobid");

EzcJobParams ejcparams = new EzcJobParams();
EziJobParams ejiparams = new EziJobParams();

//Business Partner, userid, jobid, job_desc will have be set in CSB
//Get the auto generated jobid, jobdate and jobtime
//For now, lets hardcode
String BusPartner = "501";
ejiparams.setBussPartner("501");  //For Testing only; remove after testing
ejiparams.setJobId(jobid);

ejcparams.setLanguage("EN");
ejcparams.setObject(ejiparams);
Session.prepareParams(ejcparams);

//DeleteJobDetails
JobManager.deleteJobDetails(ejcparams);

//Show the list of jobs left out on next page
response.sendRedirect("../Config/ezDeleteJobDetails.jsp");

%>
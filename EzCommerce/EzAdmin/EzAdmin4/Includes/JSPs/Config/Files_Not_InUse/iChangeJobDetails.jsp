<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>

<%
// Key Variables : Globals in the page
ReturnObjFromRetrieve retinfo = null;
ReturnObjFromRetrieve retbp = null;

String jobid = "";

//Get Job_Ids
EzcJobParams ejp = new EzcJobParams();
EziJobParams eji = new EziJobParams();
ejp.setLanguage("EN");
ejp.setObject(eji);
Session.prepareParams(ejp);
retbp = (ReturnObjFromRetrieve) JobManager.getJobList(ejp);
retbp.check();

int numJobs = retbp.getRowCount();
if (numJobs > 0 )
{
   jobid = request.getParameter("jobid");
   if (jobid == null) 
   {
	jobid = (retbp.getFieldValue(0,JOB_ID)).toString();
   }
   
   EzcJobParams ejpl = new EzcJobParams();
   EziJobParams ejil = new EziJobParams();
   ejil.setJobId(jobid);
   ejpl.setLanguage("EN");
   ejpl.setObject(ejil);
   Session.prepareParams(ejpl);
   retinfo = (ReturnObjFromRetrieve) JobManager.getJobDetails(ejpl);
   retinfo.check();
}

%>
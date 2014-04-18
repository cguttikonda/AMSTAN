<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>


<%
// Key Variables
ReturnObjFromRetrieve ret = null;
EzcJobParams ecparams = new EzcJobParams();
ecparams.setLanguage("EN");
EziJobParams eiparams = new EziJobParams();

/** Set business partner, client, jobid and jobtype **/

ecparams.setObject(eiparams);
Session.prepareParams(ecparams);

// Get Business Partners
ret =(ReturnObjFromRetrieve) JobManager.getJobList(ecparams);
ret.check();
%>
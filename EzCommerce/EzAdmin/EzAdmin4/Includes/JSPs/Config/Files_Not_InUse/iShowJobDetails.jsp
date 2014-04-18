<%@ include file="../../../Includes/Lib/Job.jsp"%>
<%@ include file="../../../Includes/Lib/JobBean.jsp"%>

<%
String jobid = request.getParameter("jobid");

ReturnObjFromRetrieve retinfo = null;

EzcJobParams ejp = new EzcJobParams();
EziJobParams eji = new EziJobParams();
eji.setJobId(jobid);
ejp.setLanguage("EN");
ejp.setObject(eji);
Session.prepareParams(ejp);
retinfo = (ReturnObjFromRetrieve) JobManager.getJobDetails(ejp);
retinfo.check();
%>
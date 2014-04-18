<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="reportObj" class="ezc.client.EzReportManager" scope="page">
</jsp:useBean>
<%

java.util.Hashtable ht=new java.util.Hashtable();
ht.put("Sales","1");
ht.put("Vendor","2");
ht.put("Service","3");
ht.put("ReverseAuction","4");

String reports =request.getParameter("chk");
String system = request.getParameter("system");
String reportDomain = request.getParameter("reportDomain");

 EzExecReportParams repParams =new EzExecReportParams();
 repParams.setSysNum(system);
 repParams.setReportNo(reports);
 Session.prepareParams(repParams);
 reportObj.deleteReport(repParams);

 //response.sendRedirect("ezDeleteReport.jsp?system="+system+"&reportDomain="+reportDomain);
 response.sendRedirect("ezListReports.jsp?system="+system+"&reportDomain="+(String)ht.get(reportDomain));
%>

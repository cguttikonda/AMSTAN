<%@page import="ezc.ezparam.*,java.util.*"%>
<%@page import="ezc.ezaudit.params.*"%>
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<% 
     String site = (String)session.getValue("SITE");	
     if(site==null)
       site="167";

    String checkId = request.getParameter("chk1");	
     StringTokenizer st = new StringTokenizer(checkId,"$$");
     String auditId = st.nextToken();
     String tableName = st.nextToken();

    EzcParams mainParams = new EzcParams(false);
    EziAuditTableListParams iParams = new EziAuditTableListParams();
    iParams.setAuditId(auditId);
    mainParams.setObject(iParams);	
    Session.prepareParams(mainParams);		
    AuditManager.deleteAuditDocument(mainParams);

     ezc.ezaudit.db.EzGenAuditTrigger gen = new ezc.ezaudit.db.EzGenAuditTrigger(site);	
     gen.ezDropAuditTrigger(tableName);

    response.sendRedirect("ezGetAuditDocuments.jsp");	
%>



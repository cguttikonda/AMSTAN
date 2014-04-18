<%@page import="java.util.*"%>
<%@page import="ezc.ezparam.*"%>
<%@page import="ezc.ezaudit.params.*"%>
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<% 

    String checkId = request.getParameter("chk1");	
    StringTokenizer st = new StringTokenizer(checkId,"$$");
    String auditId = st.nextToken();
    String tableName = st.nextToken();
    String docId = st.nextToken();

    String site = (String)session.getValue("SITE");	
    if(site==null)
	site="167";	

    String status = request.getParameter("stat");
    String user = (String)Session.getUserId();	

    EzcParams mainParams = new EzcParams(false);
    EziAuditTableListParams iParams = new EziAuditTableListParams();
    iParams.setAuditId(auditId);
    iParams.setStatus(status);
    iParams.setChangedBy(user);
    iParams.setExt1(docId);
    iParams.setExt2("");
    iParams.setFlag("Y");
    mainParams.setObject(iParams);	
   
    Session.prepareParams(mainParams);		
    AuditManager.changeAuditDocument(mainParams);

    ezc.ezaudit.db.EzGenAuditTrigger gen = new ezc.ezaudit.db.EzGenAuditTrigger(site);	
    if(status.equals("A"))
	    gen.ezEnableAuditTrigger(tableName);
    else 
	    gen.ezDisableAuditTrigger(tableName);	

    response.sendRedirect("ezGetAuditDocuments.jsp");	

%>



<%@page import="java.util.*"%>
<%@page import="ezc.ezparam.*"%>
<%@page import="ezc.ezaudit.params.*"%>
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<% 
    String site = (String)session.getValue("SITE");	
    if(site==null)
	site = "167";	

    String docId = request.getParameter("docId");
    String auditId = request.getParameter("auditId");
    String tableName= request.getParameter("tableName");


    String user = (String)Session.getUserId();	

    EzcParams mainParams = new EzcParams(false);
    EziAuditTableListParams iParams = new EziAuditTableListParams();
    iParams.setAuditId(auditId);
    iParams.setStatus("A");
    iParams.setChangedBy(user);
    iParams.setExt1(docId);
    iParams.setExt2("");
    iParams.setFlag("N");


    mainParams.setObject(iParams);	

    String[] selectedAttributes = request.getParameterValues("selectedAttributes");	
    
    Vector insertVector = new Vector();
    Vector updateVector = new Vector();	
    Vector deleteVector = new Vector();	

    String ins=""; 
    String upd=""; 
    String del=""; 
    String field="";

    EziAuditTableDetailsTable table = new EziAuditTableDetailsTable();
    EziAuditTableDetailsTableRow tableRow = null;

    int Count = selectedAttributes.length;	
	String types="";
    for(int i=0;i<Count;i++)	
    {
	ins = request.getParameter("Insert"+i);
	field = selectedAttributes[i];
	types="";
	if(ins !=null)
	{
	   insertVector.addElement(field);
	   types = types+"I";
	}

	upd = request.getParameter("Update"+i);
	if(upd !=null)
	{
	   updateVector.addElement(field);
	   types = types+",U";
	}

	del = request.getParameter("Delete"+i);
	if(del !=null)
	{
	   deleteVector.addElement(field);
	   types = types+",D";
	}
	   tableRow = new EziAuditTableDetailsTableRow();
	   tableRow.setAuditId(auditId);	
	   tableRow.setFieldName(field);	
	   tableRow.setFieldType("");	
	   tableRow.setOperationType(types);	
	   tableRow.setExt1("");	
	   tableRow.setExt2("");	
	   table.appendRow(tableRow);	

     }	
     mainParams.setObject(table);	
  
     Hashtable values = new Hashtable();
     if(insertVector.size()>0)
	values.put("I",insertVector);		

     if(updateVector.size()>0)
	values.put("U",updateVector);		

     if(deleteVector.size()>0)
	values.put("D",deleteVector);		


     ezc.ezaudit.db.EzGenAuditTrigger gen = new ezc.ezaudit.db.EzGenAuditTrigger(site,tableName,values,user,"EzCommerce","Administrator");	
     gen.ezDropAuditTrigger(tableName);
     String trig = gen.ezGenerateAuditTrigger();
     gen.ezExecuteAuditTrigger(trig);

     Session.prepareParams(mainParams);		
     AuditManager.changeAuditDocument(mainParams);

     response.sendRedirect("ezGetAuditDocuments.jsp");	
%>

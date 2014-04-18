<%@page import="java.util.*"%>
<%@page import="ezc.ezparam.*"%>
<%@page import="ezc.ezaudit.params.*"%>
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<% 
    String docId = request.getParameter("documentId");
    StringTokenizer st = new StringTokenizer(docId,"$$");	
    String user = (String)Session.getUserId();	
    String site = (String)session.getValue("SITE");
    if(site==null)
	site="167";

    docId = st.nextToken();
    String tableName = st.nextToken();

    EzcParams mainParams = new EzcParams(false);
	
    EziAuditTableListParams iParams = new EziAuditTableListParams();
    iParams.setSiteNo(site);
    iParams.setTableName(tableName);
    iParams.setModule("V");
    iParams.setComponent("Admin");
    iParams.setCreatedBy(user);
    iParams.setStatus("A");
    iParams.setChangedBy(user);
    iParams.setExt1(docId);
    iParams.setExt2("");

    mainParams.setObject(iParams);	

    String fieldPrefix = "";	
    StringTokenizer stk = new StringTokenizer(tableName,"_");
    String temp="";	
    while(stk.hasMoreElements())
    {
	temp = stk.nextToken();
	fieldPrefix = fieldPrefix+temp.substring(0,1);
    }		

    String[] selectedAttributes = request.getParameterValues("selectedAttributes");	
	String[] dataTypes = request.getParameterValues("dataType");	
    
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
	String types = "";
    for(int i=0;i<Count;i++)	
    {
		ins = request.getParameter("Insert"+i);
		field = fieldPrefix+"_"+selectedAttributes[i];
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
			if(types.length()>0)
			{
				types = types+",U";
			}
			else
			{
				types = types+"U";	
			}			
		}

		del = request.getParameter("Delete"+i);
		if(del !=null)
		{
	   		deleteVector.addElement(field);
			if(types.length()>0)
			{
				types = types+",D";
			}
			else
			{
				types = types+"D";	
			}							
				
		}
	
	  if(types.length()>0)
	  {
   		tableRow = new EziAuditTableDetailsTableRow();
   		tableRow.setFieldName(field);	
   		tableRow.setFieldType(dataTypes[i]);	
   		tableRow.setOperationType(types);	
   		tableRow.setExt1("");	
   		tableRow.setExt2("");	
   		table.appendRow(tableRow);	
	  }	

     }	
     mainParams.setObject(table);	
   
     Hashtable values = new Hashtable();
     if(insertVector.size()>0)
	values.put("I",insertVector);		

     if(updateVector.size()>0)
	values.put("U",updateVector);		

     if(deleteVector.size()>0)
	values.put("D",deleteVector);		

     ezc.ezaudit.db.EzGenAuditTrigger gen = new ezc.ezaudit.db.EzGenAuditTrigger(site,tableName,values,user,"Vijay","Kumar");	
     String trig = gen.ezGenerateAuditTrigger();
     gen.ezExecuteAuditTrigger(trig);


     Session.prepareParams(mainParams);		
     AuditManager.addAuditDocument(mainParams);

     response.sendRedirect("ezGetAuditDocuments.jsp");	
%>

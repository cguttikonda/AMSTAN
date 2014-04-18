<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>


<%
	ReturnObjFromRetrieve retAttribueList = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntretAttribueList =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT * FROM EZC_ATTRIBUTE_SET");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retAttribueList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retAttribueList!=null && retAttribueList.getRowCount() > 0)cntretAttribueList =  retAttribueList.getRowCount();		
			
			
		//out.println("retAttribueList::"+retAttribueList.toEzcString());

	
	
	

%>
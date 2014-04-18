<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>


<%
	ReturnObjFromRetrieve retAttribueInAtrrList = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntretAttribueInAtrrList =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT * FROM EZC_ATTRIBUTE_SET_ATTR");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retAttribueInAtrrList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retAttribueInAtrrList!=null && retAttribueInAtrrList.getRowCount() > 0)cntretAttribueInAtrrList =  retAttribueInAtrrList.getRowCount();		
			
			
		//out.println("retAttribueInAtrrList::"+retAttribueInAtrrList.toEzcString());

	
	
	

%>
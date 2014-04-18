<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>


<%
	ReturnObjFromRetrieve retCatgDescList = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntretCatgDescList =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT EC_CODE FROM EZC_CATEGORIES");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retCatgDescList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retCatgDescList!=null && retCatgDescList.getRowCount() > 0)cntretCatgDescList =  retCatgDescList.getRowCount();		
			
			
		//out.println("retCatgDescList::"+retCatgDescList.toEzcString());

	
	
	

%>
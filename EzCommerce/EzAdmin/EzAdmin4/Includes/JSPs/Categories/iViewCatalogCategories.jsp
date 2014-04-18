<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>


<%
	ReturnObjFromRetrieve retCatCatgs = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntRetCatCatgs =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT * FROM EZC_PRODUCT_CATALOG EPC,EZC_CATALOG_CATEGORIES ECC WHERE EPC.EPC_NO=ECC.ECC_CATALOG_ID");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retCatCatgs = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retCatCatgs!=null && retCatCatgs.getRowCount() > 0)cntRetCatCatgs =  retCatCatgs.getRowCount();		
			
			
		//out.println("retCatCatgs::"+retCatCatgs.toEzcString());

	
	
	

%>
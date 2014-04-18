<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%
	EzcParams mainParamsMisc_PA= new EzcParams(false);
	EziMiscParams miscParams_PA = new EziMiscParams();

	miscParams_PA.setIdenKey("MISC_SELECT");
	miscParams_PA.setQuery("SELECT * FROM EZC_POINTS_MAPPING");

	mainParamsMisc_PA.setLocalStore("Y");
	mainParamsMisc_PA.setObject(miscParams_PA);
	Session.prepareParams(mainParamsMisc_PA);

	try
	{		
		retObjMisc_PA = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_PA);
	}
	catch(Exception e){}		
%>


<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
	String areaFlag = request.getParameter("Area");
	
	// Get the input parameters
	String SystemKey = null;

	SystemKey = request.getParameter("SystemKey");	
	
	String pDefKey[] = request.getParameterValues("DefaultsKey");
	String pDefValue[] = request.getParameterValues("DefaultsValue");

	if (pDefKey!= null )
		{
		for ( int j = 0  ; j < pDefKey.length; j++ )
			{
			// Transfer Structure for the Descriptions
			EzKeyValueStructure in = new EzKeyValueStructure();
	
			// Set the Structure Values
			in.setPKey(SystemKey);
			in.setKey(pDefKey[j].trim());
			in.setValue(pDefValue[j].trim());

			// Add Defaults
	                EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			snkparams.setEzKeyValueStructure(in);
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);
			sysManager.setCatAreaDefaults(sparams); 
			}//End For
		}// End if

	response.sendRedirect("../Config/ezSetBusAreaDefaults.jsp?SystemKey=" + SystemKey+"&Area="+areaFlag+"&saved=Y");
%>
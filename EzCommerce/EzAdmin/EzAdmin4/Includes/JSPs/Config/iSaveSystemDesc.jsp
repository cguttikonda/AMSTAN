<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	// Get the input parameters from the User Entry screen
	String lang = request.getParameter("Lang");
	String key = request.getParameter("key");
	key = key.toUpperCase();

	String SysType = request.getParameter("SysType");
	String desc = request.getParameter("Desc");
	String baseErp = request.getParameter("BaseErpCheck");

	// Transfer Structure for the Descriptions
	EzDescStructure in = new EzDescStructure();

	// Set the Structer Values
	in.setKey(new Integer(key));
	in.setLang(lang);
	in.setDesc(desc);

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	snkparams.setEzDescStructure(in);
	snkparams.setSystemType(SysType);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
      	ReturnObjFromRetrieve retC = (ReturnObjFromRetrieve) sysManager.getSystemDesc(sparams);
      	int checkDup = retC.getRowCount();
      	if ( checkDup > 0 )
      	{
		response.sendRedirect("../Config/ezAddSystemDesc.jsp?key="+key+"&systype="+SysType+"&desc="+desc);
	      	return;
      	}
	ReturnObjFromRetrieve retAddSys = (ReturnObjFromRetrieve) sysManager.addSystemDesc(sparams);
	String saved = "";
	if ( !retAddSys.isError() )
	{
		saved = "Y";			
	}
	else
	{
		saved = "N";
	}
	response.sendRedirect("../Config/ezListSystems.jsp?saved="+saved+"&skey="+key);
%>
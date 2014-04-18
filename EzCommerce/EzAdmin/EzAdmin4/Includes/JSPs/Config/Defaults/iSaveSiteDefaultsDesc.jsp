<%@ page import = "ezc.ezparam.EzDescStructure" %>
<html>
<head>
<%@ include file="../../../Lib/AddButtonDir1.jsp"%>
</head>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
// Get the input parameters from the User Entry screen
String syskey = request.getParameter("SysKey");

String lang = request.getParameter("Lang");
String key = request.getParameter("key");
key = key.trim();
String desc = request.getParameter("Desc");
String deftype = request.getParameter("DefType");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setKey(key.trim());
in.setLang(lang.trim());
in.setDesc(desc.trim());

// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
  	snkparams.setEzDescStructure(in);
	snkparams.setSystemKey(syskey);
      snkparams.setDef_type(deftype);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);

/****** Added by Venkat on 4/3/2001 ********/
      ReturnObjFromRetrieve retSite = (ReturnObjFromRetrieve) esManager.getNotCatDefaultsDesc(sparams);
      int retRows = retSite.getRowCount();
      if ( retRows > 0 )
      {
%>
		<br><br><br><br><br>
         <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>Site Default:<%=key%> already exists... Try a different Site Default Key</b></div>
		</Td>
	</Tr>
</Table>
    <BR><center><a href="JavaScript:history.go(-1)"><img src="../../../../Admin1/Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>

 <%
            return;
      }
/****** Venkats changes end here ***********/

	esManager.addDefaultsDesc(sparams);

response.sendRedirect("ezListSiteDefaults.jsp");
%>
</html>
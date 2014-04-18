<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String purposeOrder 	= request.getParameter("purposeOrder");

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve retObjDefCond = null;
	String showDef = "N";

	if(purposeOrder!=null && !"null".equalsIgnoreCase(purposeOrder) && !"".equals(purposeOrder))
	{
		focParams.setIdenKey("MISC_SELECT");

		String query = "SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='DEFCOND' AND VALUE1='"+purposeOrder+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			retObjDefCond = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}

		if(retObjDefCond!=null && retObjDefCond.getRowCount()>0)
			showDef = "Y";
	}
	out.print("DEF¥"+showDef);
%>
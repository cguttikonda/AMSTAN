<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>


<%
	String catgId = request.getParameter("catgId");
	ReturnObjFromRetrieve retCatgsList = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntRetCatgsList =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT * FROM EZC_CATALOG_CATEGORIES WHERE ECC_CATEGORY_ID <> '"+catgId+"' ");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retCatgsList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retCatgsList!=null && retCatgsList.getRowCount() > 0)cntRetCatgsList =  retCatgsList.getRowCount();		
			

%>
        <select name="catgParent" style="width:100%" id=FullListBox2>
	        <option value="sel">--Select Parent--</option>
<%
		for(int i=0;i<cntRetCatgsList;i++)
		{
%>
			<option value="<%=retCatgsList.getFieldValueString(i,"ECC_CATEGORY_ID")%>"><%=retCatgsList.getFieldValueString(i,"ECC_CATEGORY_ID")%></option>	

<%
		}
%>
        </select>
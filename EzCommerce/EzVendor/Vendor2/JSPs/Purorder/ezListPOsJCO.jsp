<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>

<%
 	JCO.Function function = EzSAPHandler.getFunction("Z_EZ_GET_PURCHASE_ORDERS");
        JCO.ParameterList parameterlist = function.getImportParameterList();
        
        parameterlist.setValue("O", "ITEMS_OPEN_FOR_RECEIPT");
        parameterlist.setValue("013", "PUR_GROUP");
        parameterlist.setValue("3000", "PURCH_ORG");
	parameterlist.setValue("F", "DOC_CATEGORY");
        
	JCO.Client client = EzSAPHandler.getSAPConnection();
	client.execute(function);
	//EzSAPHandler.commit(client);
	
	JCO.Table messageTable = function.getTableParameterList().getTable("PURORDLIST");
	int messCount = messageTable.getNumRows();
	out.println("<<<<<<<<<<<<>>>>>>>>>>>>>>"+messCount);
	
	if(messCount>0)
	{		
		out.println("<<<<<<<<<<<<>>>>>>>>>>>>>>"+messCount);
	}	

	if(client!=null)
	{
	      JCO.releaseClient(client);
	      client = null;
	      function=null;	
	}
	
%>	


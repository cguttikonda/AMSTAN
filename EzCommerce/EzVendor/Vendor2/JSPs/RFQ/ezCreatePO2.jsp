<%//@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	JCO.Function function= EzSAPHandler.getFunction("BAPI_PO_CREATE1");
	JCO.ParameterList importParameter = function.getImportParameterList();
	JCO.Structure headerStructure = importParameter.getStructure("POHEADER");
	JCO.Structure headerStructureX = importParameter.getStructure("POHEADERX");

	headerStructure.setValue("ZRMI","DOC_TYPE");
	headerStructure.setValue("1000","PURCH_ORG");
	headerStructure.setValue("351","PUR_GROUP");
	headerStructure.setValue(new Date(),"CREAT_DATE");
	headerStructure.setValue("1000","COMP_CODE");
	headerStructure.setValue("1100000887","VENDOR");
	
	headerStructureX.setValue("X","DOC_TYPE");
	headerStructureX.setValue("X","PURCH_ORG");
	headerStructureX.setValue("X","PUR_GROUP");
	headerStructureX.setValue("X","CREAT_DATE");
	headerStructureX.setValue("X","COMP_CODE");
	headerStructureX.setValue("X","VENDOR");
	
	JCO.Table  itemTable = function.getTableParameterList().getTable("POITEM");
	JCO.Table  itemTableX = function.getTableParameterList().getTable("POITEMX");

	JCO.Table  itemScheduleTable = function.getTableParameterList().getTable("POSCHEDULE");
	JCO.Table  itemScheduleTableX = function.getTableParameterList().getTable("POSCHEDULEX");
	
	itemTable.appendRow();
	itemTableX.appendRow();
	     
	itemScheduleTable.appendRow();
	itemScheduleTableX.appendRow();
	     	     
	itemTable.setValue("00010","PO_ITEM");
	itemTable.setValue("000000000004000060","MATERIAL");
	itemTable.setValue("1000","PLANT");
	itemTable.setValue("50.000","QUANTITY");
	itemTable.setValue("05K","PO_UNIT");
	itemTable.setValue("10.00","NET_PRICE");
	itemTable.setValue("AA","TAX_CODE");
	itemTable.setValue("0001","CONF_CTRL");
	//itemTable.setValue("OGL FOR RM","VAL_TYPE");

	 
	itemTableX.setValue("00010","PO_ITEM");
	itemTableX.setValue("X","MATERIAL");
	itemTableX.setValue("X","PLANT");
	itemTableX.setValue("X","QUANTITY");
	itemTableX.setValue("X","PO_UNIT");
	itemTableX.setValue("X","NET_PRICE");
	itemTableX.setValue("X","TAX_CODE");
	itemTableX.setValue("X","CONF_CTRL");
	//itemTableX.setValue("X","VAL_TYPE");
	
	itemScheduleTable.setValue("00010","PO_ITEM");
	itemScheduleTable.setValue("0001","SCHED_LINE");
	itemScheduleTable.setValue("04/19/2005","DELIVERY_DATE");
	itemScheduleTable.setValue("50.000","QUANTITY");

	itemScheduleTableX.setValue("00010","PO_ITEM");
	itemScheduleTableX.setValue("0001","SCHED_LINE");
	itemScheduleTableX.setValue("X","DELIVERY_DATE");
	itemScheduleTableX.setValue("X","QUANTITY");	     
	
	JCO.Client client1 = EzSAPHandler.getSAPConnection();
	client1.execute(function);
	EzSAPHandler.commit(client1);

	
	JCO.Table messageTable = function.getTableParameterList().getTable("RETURN");
	out.println("messageTable-------------------------"+messageTable.toString());
	JCO.ParameterList exportParameter = function.getExportParameterList();
	int messCount = messageTable.getNumRows();
	String retMessage = "";
	String poNumber = (String)exportParameter.getValue("EXPPURCHASEORDER");
	out.println("poNumber-------------------------"+poNumber);
	boolean isError = false;
	if (messCount>0)
	{
		int i = 0;
		do
		{
			if(messageTable.getValue("TYPE").equals("E"))
			{
				retMessage = (String)messageTable.getValue("MESSAGE");
				isError = true;
				out.println(messageTable.getValue("TYPE")+"-----");	
				out.println(messageTable.getValue("ID")+"-----");	
				out.println(messageTable.getValue("NUMBER")+"-----");	
				out.println(messageTable.getValue("LOG_NO")+"-----");	
				out.println(messageTable.getValue("LOG_MSG_NO")+"-----");	
				out.println(messageTable.getValue("MESSAGE_V1")+"-----");					
				out.println(messageTable.getValue("MESSAGE_V2")+"-----");
				out.println(messageTable.getValue("MESSAGE_V3")+"-----");
				out.println(messageTable.getValue("MESSAGE_V4")+"-----");
				out.println(messageTable.getValue("PARAMETER")+"-----");
				out.println(messageTable.getValue("FIELD")+"-----");
				out.println(messageTable.getValue("SYSTEM")+"-----");
				out.println(retMessage);			
				break;
			}
		  }
	   	  while(messageTable.nextRow());
	}   	  

	if (client1!=null)
	{
		JCO.releaseClient(client1);
		client1 = null;
		function=null;
	}
%>


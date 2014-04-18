<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%
	
    try
    {

	String contractType = "WK";



    
    	JCO.Function function		= EzSAPHandler.getFunction("Z_EZ_PURCHASE_CONTRACT_CREATE");
	JCO.ParameterList sapImpParam 	= function.getImportParameterList();
	JCO.ParameterList sapTabParam	= function.getTableParameterList();
	JCO.Structure SAHeader		= sapImpParam.getStructure("AGMTHEADER");
	JCO.Structure POHeader		= sapImpParam.getStructure("POHEADER");
	JCO.Table PoItem  		= function.getTableParameterList().getTable("POITEMS");


		
	
	PoItem.appendRow();
	
	
	SAHeader.setValue(contractType,"EVART");
	SAHeader.setValue("AGMT Text Header1 From Suite","LTEX1");
	SAHeader.setValue("AGMT Text Header2 From Suite","LTEX2");
	
	
	POHeader.setValue("1000"	,"BUKRS");
	POHeader.setValue("2200000245"	,"LIFNR");
	POHeader.setValue("4000"	,"EKORG");
	POHeader.setValue("102"		,"EKGRP");
	POHeader.setValue(new Date()	,"KDATB");
	POHeader.setValue(new Date(2005,11,11)	,"KDATE");

	PoItem.setValue("0.005CCB"	,"EMATN");
	PoItem.setValue("Item Text From Suite"	,"TXZ01");
	
	if("WK".equals(contractType))
	{
		POHeader.setValue("100"	,"KTWRT");
		PoItem.setValue("10.00"		,"NETPR");
	}	
	else
	{
		POHeader.setValue("100"	,"KTWRT");
		PoItem.setValue("1.00"		,"NETPR");
		PoItem.setValue("100.00"	,"KTMNG");
	}
		
	JCO.Client client = EzSAPHandler.getSAPConnection();
	out.println("SAP CONNETED<BR>");
	client.execute(function);
	out.println("FUNCTION EXECUTED");
	JCO.Table messageTable = function.getTableParameterList().getTable("MESSTAB");
	out.println("MESSAGE TABLE");
	int messCount = 0 ;
	if(messageTable != null)
	{
		messCount = messageTable.getNumRows();
		out.println("messageTable messageTable messageTable messageTable:"+messageTable.toString());
	}	
	
	if (client!=null)
	{
		JCO.releaseClient(client);
		client = null;
		function=null;
	}		

    }catch(Exception e){System.out.println(e);e.printStackTrace();}
%>


<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	JCO.Function function= EzSAPHandler.getFunction("BAPI_REQUISITION_GETITEMSREL");
	JCO.ParameterList importParameter = function.getImportParameterList();
	
	importParameter.setValue("01","REL_GROUP");
	importParameter.setValue("01","REL_CODE");
	importParameter.setValue("X","ITEMS_FOR_RELEASE");
	
	
	JCO.Client client1 = EzSAPHandler.getSAPConnection();
	client1.execute(function);
		
	JCO.Table messageTable = function.getTableParameterList().getTable("RETURN");
	//out.println("messageTable-------------------------"+messageTable.toString());
	
	JCO.Table resultTable = function.getTableParameterList().getTable("REQUISITION_ITEMS");
	//out.println("resultTable-------------------------"+messageTable.toString());
	int resultCount = resultTable.getNumRows();
	
	ezc.ezparam.ReturnObjFromRetrieve retRequisitionItems=null;
	String requisitionItems[]  = {"PREQ_NO","PREQ_ITEM","DOC_TYPE" ,"PUR_GROUP","CREATED_BY"  ,"PREQ_DATE","SHORT_TEXT"  ,"MATERIAL" ,"PUR_MAT"  ,"PLANT" ,"MAT_GRP"  ,"SUPPL_PLNT"  ,"QUANTITY" ,"UNIT"  ,"DEL_DATCAT"  ,"DELIV_DATE"  ,"REL_DATE" ,"GR_PR_TIME"  ,"C_AMT_BAPI"  ,"PRICE_UNIT"  ,"ITEM_CAT" ,"ACCTASSCAT","GR_IND"  ,"IR_IND" ,"AGMT_ITEM" ,"QUOTARRITM","MRP_CONTR" ,"RESUBMIS","NO_RESUB","PCKG_NO","INT_OBJ_NO","ORDERED","CURRENCY"  ,"DEL_DATCAT_EXT ","CURRENCY_ISO"  ,"PREQ_UNIT_ISO" };
	retRequisitionItems = new ezc.ezparam.ReturnObjFromRetrieve();
	retRequisitionItems.addColumns(requisitionItems);
	
	if (resultCount>0)
	{
		int i = 0;
		do
		{
			
				out.println(resultTable.getValue("PREQ_NO")+"-----");	
				out.println("<br>");
				
				retRequisitionItems.setFieldValue("PREQ_NO"     ,  resultTable.getValue("PREQ_NO"));               
				retRequisitionItems.setFieldValue("PREQ_ITEM"   ,   resultTable.getValue("PREQ_ITEM"));            
				retRequisitionItems.setFieldValue("DOC_TYPE"    ,  resultTable.getValue("DOC_TYPE"));              
				retRequisitionItems.setFieldValue("PUR_GROUP"   ,   resultTable.getValue("PUR_GROUP"));            
				retRequisitionItems.setFieldValue("CREATED_BY"  ,   resultTable.getValue("CREATED_BY"));           
				retRequisitionItems.setFieldValue("PREQ_DATE"   ,  resultTable.getValue("PREQ_DATE"));             
				retRequisitionItems.setFieldValue("SHORT_TEXT"  ,  resultTable.getValue("SHORT_TEXT"));            
				retRequisitionItems.setFieldValue("MATERIAL"    ,  resultTable.getValue("MATERIAL"));              
				retRequisitionItems.setFieldValue("PUR_MAT"     ,  resultTable.getValue("PUR_MAT"));               
				retRequisitionItems.setFieldValue("PLANT"       ,   resultTable.getValue("PLANT"));                
				retRequisitionItems.setFieldValue("MAT_GRP"     ,   resultTable.getValue("MAT_GRP"));              
				retRequisitionItems.setFieldValue("SUPPL_PLNT"  ,   resultTable.getValue("SUPPL_PLNT"));           
				retRequisitionItems.setFieldValue("QUANTITY"    ,   resultTable.getValue("QUANTITY"));             
				retRequisitionItems.setFieldValue("UNIT"        ,   resultTable.getValue("UNIT"));                 
				retRequisitionItems.setFieldValue("DEL_DATCAT"  ,   resultTable.getValue("DEL_DATCAT"));           
				retRequisitionItems.setFieldValue("DELIV_DATE"  ,   resultTable.getValue("DELIV_DATE"));           
				retRequisitionItems.setFieldValue("REL_DATE"    ,   resultTable.getValue("REL_DATE"));             
				retRequisitionItems.setFieldValue("GR_PR_TIME"  ,      resultTable.getValue("GR_PR_TIME"));        
				retRequisitionItems.setFieldValue("C_AMT_BAPI"  ,  resultTable.getValue("C_AMT_BAPI"));         
				retRequisitionItems.setFieldValue("PRICE_UNIT"  ,  resultTable.getValue("PRICE_UNIT"));         
				retRequisitionItems.setFieldValue("ITEM_CAT"    ,      resultTable.getValue("ITEM_CAT"));          
				retRequisitionItems.setFieldValue("ACCTASSCAT"  ,   resultTable.getValue("ACCTASSCAT"));      
				retRequisitionItems.setFieldValue("GR_IND"      ,    resultTable.getValue("GR_IND"));          
				retRequisitionItems.setFieldValue("IR_IND"      ,   resultTable.getValue("IR_IND"));          
				retRequisitionItems.setFieldValue("AGMT_ITEM"   ,   resultTable.getValue("AGMT_ITEM"));       
				retRequisitionItems.setFieldValue("QUOTARRITM"  ,   resultTable.getValue("QUOTARRITM"));      
				retRequisitionItems.setFieldValue("MRP_CONTR"   ,   resultTable.getValue("MRP_CONTR"));       
				retRequisitionItems.setFieldValue("RESUBMIS"    ,    resultTable.getValue("RESUBMIS"));         
				retRequisitionItems.setFieldValue("NO_RESUB"    ,    resultTable.getValue("NO_RESUB"));        
				retRequisitionItems.setFieldValue("PCKG_NO"     ,   resultTable.getValue("PCKG_NO"));         
				retRequisitionItems.setFieldValue("INT_OBJ_NO"  ,   resultTable.getValue("INT_OBJ_NO"));      
				retRequisitionItems.setFieldValue("ORDERED"     ,   resultTable.getValue("ORDERED"));         
				retRequisitionItems.setFieldValue("CURRENCY"    ,   resultTable.getValue("CURRENCY"));        
				//retRequisitionItems.setFieldValue("DEL_DATCAT_EXT",     resultTable.getValue("DEL_DATCAT_EXT "));  
				retRequisitionItems.setFieldValue("CURRENCY_ISO",     resultTable.getValue("CURRENCY_ISO"));     
				//retRequisitionItems.setFieldValue("PREQ_UNIT_ISO " ,    resultTable.getValue("PREQ_UNIT_ISO"));    

				retRequisitionItems.addRow();			
			
		  }
		  while(resultTable.nextRow());
	}   
	int Count =0;
	if(retRequisitionItems!=null)
	{
		//out.println("QWWWWWWWWWWWW"+retRequisitionItems.getRowCount());
		Count = retRequisitionItems.getRowCount();
		
	}
	
	if (client1!=null)
	{
		JCO.releaseClient(client1);
		client1 = null;
		function=null;
	}
	
%>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>


<html>
<head>

<title>UnReleased Purchase Requisitions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
</head>

<body bgcolor="#FFFFF7">
<form method="post" action="../Misc/ezGetInfo.jsp" name="vendadd">
<%
	String display_header = "UnReleased Purchase Requisitions";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<%
	if(Count>0)
	{
%> 
		

		<TABLE width="85%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

			    <tr align="center" valign="middle"> 
			      <th width="15%"></th>
			      <th width="10%"></th>
			      <th width="15%"></th>
			      <th width="17%"></th>
			      <th width="9%"></th>
			    </tr>

<%
		for(int i=0;i<Count;i++)
		{
			

%>

			<tr align="center" valign="middle"> 	
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,"PREQ_NO") %></td>
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,"PREQ_ITEM") %></td>
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,) %></td>
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,) %></td>
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,) %></td>
				<td width="15%"><%=retRequisitionItems.getFieldValueString(i,) %></td>

			</tr>      
<%
		}
%>
   
  		</TABLE>

<%	
	}
	else
	{
%>
		<br><br><br>
		<TABLE width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr>
				<Th>No Unreleased Purchase requisitions.</th>
			</tr>
		</table>
<%	
	}	
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

	
	
	
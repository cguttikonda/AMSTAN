<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ page import ="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Rfq/iGetAgreementDetails.jsp" %>
<html>
<head>
<Script>
	var tabHeadWidth=90
	var tabHeight="35%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body scroll=no>
<form name="myForm">
<%
	ezc.ezparam.ReturnObjFromRetrieve globalRet = null;

	if(ConHeader!=null)
	{
		Vector vc = new Vector();	
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm:ss");

		Vector colNames = new Vector();
		colNames.addElement("CREATED_ON");
		colNames.addElement("VPER_START");
		colNames.addElement("VPER_END");
		EzGlobal.setColNames(colNames);
		
		globalRet = EzGlobal.getGlobal(ConHeader);	
	}
	//ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
%>
	<br><br>	
	<Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
		<Tr>
			<Th>Contract Details</Th>
		</Tr>
	</Table>
	<br>
	<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
		<Tr>				
			<Th width="50%" align="left">Contract Number</th>
			<Td width="50%"><%=ConHeader.getFieldValueString("PO_NUMBER")%></Td>
		</Tr>
		<Tr>				
			<Th width="50%" align="left">Contract Type</th>
<%		conType = ConHeader.getFieldValueString("DOC_TYPE");
		if("MK".equals(conType))
		{
%>			<Td width="50%" align="left">Quantity Contract</Td>
<%		}
		else if("WK".equals(conType))
		{
%>			<Td width="50%" align="left">Value Contract</Td>			
<%		}
%>		</Tr>
		<Tr>
			<Th width="50%" align="left">Created Date</th>
			<!--<Td width="50%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue("CREATED_ON"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>-->
			<Td width="50%"><%=globalRet.getFieldValue("CREATED_ON")%></Td>
		</Tr>
		<Tr>
			<Th width="50%" align="left">Start Date</th>
			<!--<Td width="50%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue("VPER_START"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>-->
			<Td width="50%"><%=globalRet.getFieldValue("VPER_START")%></Td>
			
		</Tr>
		<Tr>
			<Th width="50%" align="left">End Date</th>
			<!--<Td width="50%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue("VPER_END"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>-->
			<Td width="50%"><%=globalRet.getFieldValue("VPER_END")%></Td>
		</Tr>
		<Tr>
			<Th width="50%" align="left">Target Value</th>
			<Td width="50%"><%=ConHeader.getFieldValueString("TARGET_VAL")%></Td>
		</Tr>
		<Tr>				
			<Th width="50%" align="left">Payment Terms</th>
<%
			java.util.ResourceBundle rc1  = java.util.ResourceBundle.getBundle("EzPurPayTerms");
			pmntTrms = rc1.getString(ConHeader.getFieldValueString("PMNTTRMS"));
%>
			<Td width="50%"><%=pmntTrms%></Td>
		</Tr>
		<Tr>				
			<Th width="50%" align="left">Inco Terms</th>
			<Td width="50%"><%=ConHeader.getFieldValueString("INCOTERMS1")%><%=ConHeader.getFieldValueString("INCOTERMS2")%></Td>
		</Tr>
	</Table>
 	</Div>
	</Div>
	<div id="buttons" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
<%
	    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	    butActions.add("window.close()");
	    out.println(getButtons(butNames,butActions));
%> 	
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


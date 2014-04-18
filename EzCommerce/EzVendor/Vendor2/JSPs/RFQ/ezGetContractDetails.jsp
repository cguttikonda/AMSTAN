<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: Satyanarayana.S
		Team:   EzcSuite
		Date:   03/10/2005
*****************************************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iGetContractDetails.jsp" %>
<%@ page import="java.util.*"%>
<Html>
<Head>
	<Title>Contract Details -- Powered By Answerthink India Pvt Ltd.</Title>
	<script>
	function getConDetPDF()
	{
		document.myForm.action="../Purorder/ezConDetPrint.jsp";
		document.myForm.submit();
	}
	</script>
</Head>
<Body scroll=no>
<Form  name="myForm">
<%
	String display_header = "Contract Details";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<Table align="center" width="80%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<Tr> 
		<Th align="left" width="12%">Contract No. </Th>
		<Td width="10%"><%=contractNo%></Td>
		<Th align="left" width="15%">Contract Type</Th>
<%
		String conType = ConHeader.getFieldValueString(0,"DOC_TYPE");
		String conTypeHeader = "";
		String targetData = "";
		if("WK".equals(conType.trim()))
		{
			conType = "Value Contract["+conType+"]";
			conTypeHeader = "Target Value";
		}	
		if("MK".equals(conType.trim()))
		{
			conType = "Quantity Contract["+conType+"]";	
			conTypeHeader = "Target Quantity";
		}	
		
%>
		<Td width="33%"><%=conType%></Td>
		<Th align="left" width="15%">Contract Date</Th>
		<Td width="10%"><%=fd.getStringFromDate((Date)ConHeader.getFieldValue(0,"CREATED_ON"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></Td>
		
	</Tr>
	<Tr> 
		<Th align="left">Vendor No. </Th>
		<Td><%=ConHeader.getFieldValueString(0,"VENDOR")%></Td>
		<Th align="left">Vendor Name</Th>
		<Td><%=ConHeader.getFieldValueString(0,"VEND_NAME")%></Td>
		<Th align="left">Currency</Th>
		<Td><%=ConHeader.getFieldValueString(0,"CURRENCY")%></Td>
	</Tr>
</Table>
<br>
		<Input type="hidden" name="agmtNo" value="<%=ConHeader.getFieldValueString(0,"PO_NUMBER")%>">
		<Input type="hidden" name="vendor" value="<%=ConHeader.getFieldValueString(0,"VENDOR")%>">
<%
	Hashtable poMaterials=new Hashtable();
	if(ConItemsCnt>0)
	{
%>	
		<Table align="center" width="96%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
			<Tr> 
				<Th align="center" colspan=7>Contract Items</Th>
			</Tr>
			<Tr> 
				<Th width="10%">Line No.</Th>
				<Th width="15%">Material</Th>
				<Th width="27%">Description</Th>
				<Th width="15%"><%=conTypeHeader%></Th>
				<Th width="15%">Net Price</Th>
				<Th width="8%">UOM</Th>
				<Th width="10%">Plant</Th>
			</Tr>
		</Table>
		<TABLE id="InnerBox1Tab" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
		String material = "";
		for(int c=0;c<ConItems.getRowCount();c++)
		{
			if(conType.indexOf("WK") != -1)
			{
				targetData = ConHeader.getFieldValueString(0,"TARGET_VAL");
			}	
			if(conType.indexOf("MK") != -1)
			{
				targetData = ConItems.getFieldValueString(c,"TARGET_QTY");
			}	
		
		
			material = ConItems.getFieldValueString(c,"MATERIAL");
			try{
				material = String.valueOf(Integer.parseInt(material));	
			}catch(Exception e){ }
			poMaterials.put(contractNo+ConItems.getFieldValueString(c,"PO_ITEM"),material);
%>
			<Tr align="center"> 
				<Td width="10%" align="center"><%=ConItems.getFieldValueString(c,"PO_ITEM")%>&nbsp;</Td>
				<Td width="15%" align="center"><%=material%>&nbsp;</Td>
				<Td width="27%" align="left"><%=ConItems.getFieldValueString(c,"SHORT_TEXT")%>&nbsp;</Td>
				<Td width="15%" align="right"><%=targetData%>&nbsp;</Td>
				<Td width="15%" align="right"><%=ConItems.getFieldValueString(c,"NET_PRICE")%>&nbsp;</Td>
				<Td width="8%" align="center"><%=ConItems.getFieldValueString(c,"ORDERPR_UN")%>&nbsp;</Td>
				<Td width="10%" align="center"><%=ConItems.getFieldValueString(c,"PLANT")%>&nbsp;</Td>
			</Tr>  
<%		}
%>
		</Table>
<%
	}
	else
	{
%>
		<br><br><br>
		<Table align="center" width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
			<Tr> 
				<Th align="center">Contract Details Not Found.</Th>
			</Tr>
		</Table>
<%
	}
%>

<Div id="buttonDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
	<Table>
		<Tr>
	<%
		if(request.getParameter("PopUp")!=null)
		{
		
	%>
		
		<Td class=blankcell>
			<img   src="../../Images/Buttons/<%=ButtonDir%>/close.gif"  onClick="javascript:window.close()" border="none" valign=bottom style="cursor:hand">

		
		</Td>
	
	<%
	}
	else
	{
	%>
			
			<Td class=blankcell>
				<img   src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  onClick="javascript:history.go(-1)" border="none" valign=bottom style="cursor:hand">
				<img   src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif" onClick="getConDetPDF()" border="none" valign=bottom style="cursor:hand">

			</Td>	
	<%
	}
	%>

		</Tr>
	</Table>
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>

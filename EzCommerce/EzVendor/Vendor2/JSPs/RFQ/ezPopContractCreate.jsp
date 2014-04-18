<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%	
	for(int i=0;i<myRet.getRowCount();i++)
	{
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);

	}
	
%>

<html>
<head>
<title>Enter Contract Creation Details -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<%
	//String valuationTypes[] = {"01","02","A/L (SFG)","A/L FOR RM","C1","C2","C3","DOM. (SFG)","DOM.FOR RM","EIGEN","FREMD","LAND 1","LAND 2","MFD (FG)","MFD (SFG)","OGL (SFG)","OGL FOR RM","PROC (FG)","RAKTION","RM MOHALI","RM TOANSA","RNORMAL"};	
	String valuationTypes[] = {"C1","C2","C3"};
%>
<%		
			java.util.Date today = new java.util.Date();
			ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
	%> 
<SCRIPT src="../../Library/JavaScript/checkFormFields.js"></SCRIPT>
<script>

function showLabel()
{
	
	var tdObj=document.getElementById("TV");
	//tdObj.text="Hai";
	
}

function closeWin()
{
	
	var endDate 	= document.myForm.contractEndDate.value;
	var startDate   = document.myForm.contractStartDate.value;
	var myDate	= new Date();
	var day		= myDate.getDate();	
	var month	= myDate.getMonth()+1;

	
	
	if(document.myForm.docType.selectedIndex==0)
	{
		alert("Please Select Document Type")
		document.myForm.docType.focus()
		return;
	}
	if(document.myForm.targetValue.value=="")
	{
		alert("Please Enter Target Value")
		document.myForm.targetValue.focus()
		return;
	}else if(!funNumber(document.myForm.targetValue.value))
	     {
			alert("Please enter valid Target Value ")
			document.myForm.targetValue.focus();
			return;
	     }
	if(document.myForm.contractEndDate.value=="")
	{
		alert("Please Enter End Date")
		document.myForm.contractEndDate.focus()
		return;
	}else if(endDate<=startDate)	
	{
		alert("Contract End date must be greater than StartDate");
		document.myForm.contractEndDate.focus();
		return;
	}
	/*if(document.myForm.valuationType.selectedIndex==0)
	{
		alert("Please Select Valuation Type")
		document.myForm.valuationType.focus()
		return;
	}
	if(document.myForm.headerText.value=="")
	{
		alert("Please Enter Header Text")
		document.myForm.headerText.focus()
		return;
	}
	if(document.myForm.itemText.value=="")
	{
		alert("Please Enter Item Text ")
		document.myForm.itemText.focus()
		return;
	}*/
	
	
	var VendorLength = document.myForm.vendor.length
	var clubVal="";

	if(!isNaN(VendorLength))
	{
		for(i=0;i<VendorLength;i++)
		{
			if(clubVal!="")
				clubVal = clubVal +"§"+document.myForm.vendor[i].value +"¥"+ document.myForm.poQuantity[i].value 
			else			
				clubVal = document.myForm.vendor[i].value +"¥"+ document.myForm.poQuantity[i].value 	
		}		
	}
	else
	{
		clubVal = document.myForm.vendor.value +"¥"+ document.myForm.poQuantity.value 
	}
	
	window.opener = window.dialogArguments;
	opener.document.myForm.vendors.value	= clubVal;
	opener.document.myForm.docType.value	= document.myForm.docType.value;;
	opener.document.myForm.conValue.value	= document.myForm.targetValue.value;
	opener.document.myForm.startDate.value	= document.myForm.contractStartDate.value;
	opener.document.myForm.endDate.value	= document.myForm.contractEndDate.value;
	opener.document.myForm.valType.value	= document.myForm.valuationType.value;
	opener.document.myForm.headerText.value = document.myForm.headerText.value;				
	opener.document.myForm.itemText.value   = document.myForm.itemText.value	
	window.close();

}
function winclose()
{
	window.returnValue =  "Cancel";
	window.close();
}

</script>
</head>
<body>
<form name="myForm"  >
<br><br>
<br><br>
    <Table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>    	
    	<Tr>	
    		<Th width="50%" align="left">Vendor</Th>
    		<Th width="50%" align="left">Quantity</Th>
    	</Tr>	
<%
	String vendor="",quantity="";
	for(int i=0;i<myRet.getRowCount();i++)
	{
		vendor	 = myRet.getFieldValueString(i,"VENDOR");
		quantity = myRet.getFieldValueString(i,"QUANTITY");		
%>		<Tr>			
			<Td width="50%"><input type="text" name="vendor" class="tx" size=15  maxlength="7" value="<%=vendor%>" readonly></Td>			
			<Td width="50%"><input type="text" name="poQuantity" class="InputBox" size=15  maxlength="7" value="<%=quantity%>"></Td>
		</Tr>
<%	}
%>	
    </Table>
    <Br>
    <table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
    	<tr>
		<Th width="40%" align="left">Document Type*</Th>
		<Td width="60%">
			<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel()">
					<option value="select">Select Document Type</option>
					<Option value='WK'>WK - ValueContract</Option>
					<Option value='MK'>MK - QuantityContract</Option>
			</select>
		</Td>
    	</tr>
    	<tr>
    		
    		<Th id="TV" width="40%" align="left" style="visibility:visible">Target Value/Quantity *:</Th>
    		<Td width="60%"><input type="text" name="targetValue" class="InputBox" size=15  maxlength="10"> </Td>
    	</tr>
	<tr>
		<Th width="40%" align="left">Contract Start Date:</Th>
		<Td width="60%"><input type="text" name="contractStartDate" class="InputBox" size=15 value="<%=format.getStringFromDate(today,".",ezc.ezutil.FormatDate.DDMMYYYY)%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractStartDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
    	</tr>
    	<tr>
		<Th width="40%" align="left">Contract End Date* :</Th>
		<Td width="60%"><input type="text" name="contractEndDate" class="InputBox" size=15 value="" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractEndDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
    	</tr>
	<tr>
		<Th width="40%" align="left">Valuation Type :</Th>
		<Td width="60%">
			<select name="valuationType" style="width:100%" id="CalendarDiv">
				<option value="">-Select Valuation Type-</option>
<%
				 for(int i=0;i<valuationTypes.length;i++)
				 {
%>
					<option value="<%=valuationTypes[i]%>"><%=valuationTypes[i]%></option>
<%
				  }
%>	
			</select>
		</Td>
	</tr>	
	<tr>
		<Th width="40%" align="left">Header text</Th>
		<Td width="60%"><textarea style='width:100%' rows=3 name=headerText ></textarea></Td>
	</tr>
	<tr>
		<Th width="40%" align="left">Item Text</Th>
		<Td width="60%"><textarea style='width:100%' rows=3 name=itemText ></textarea></Td>
	</tr>
    </table>
<br>    
 <center>
<%
 	   butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
           butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;");   
           butActions.add("closeWin()");
           butActions.add("winclose()");
           out.println(getButtons(butNames,butActions));
%>
 </center>
    
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<html>
<head>
<title>Enter PO Creation Details -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Jsps/Rfq/iSelectIds.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%	
	int cnt = myRet.getRowCount();
	for(int i=cnt-1;i>=0;i--)
	{
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);

	}
%>
<SCRIPT src="../../Library/JavaScript/checkFormFields.js"></SCRIPT>
<script>

function showLabel()
{
	var condVal = document.myForm.docType.value;
	if(condVal=='ZCPI' || condVal=='ZFGI' || condVal=='ZRFI' || condVal=='ZRMI')
	{
		document.myForm.ccKey.disabled=false;
		document.myForm.hbId.disabled=false;
	}
	else
	{
		document.myForm.ccKey.disabled=true;
		document.myForm.hbId.disabled=true;
	}		
}


function closeWin()
{
	
	
	var myDate	= new Date();
	var day		= myDate.getDate();	
	var month	= myDate.getMonth()+1;

	if(day<10)
	   day = "0"+day;	
	if(month<10)
	   month = "0"+month;
	var toDate  = day+"."+month+"."+myDate.getYear();
	
	if(document.myForm.docType.selectedIndex==0)
	{
		alert("Please Select Document Type")
		document.myForm.docType.focus()
		return;
	}
/*	if(document.myForm.poQuantity.value=="")
	{
		alert("Please Enter PO Quantity")
		document.myForm.poQuantity.focus()
		return;
	}
	else if(!funNumber(document.myForm.poQuantity.value))
	{
		alert("Please enter valid Quantity ")
		document.myForm.poQuantity.focus();
		return;
	}
*/
	if(document.myForm.valuationType.selectedIndex==0)
	{
		alert("Please Select Valuation Type")
		document.myForm.valuationType.focus()
		return;
	}
	
	if(!(document.myForm.ccKey.disabled) && document.myForm.ccKey.selectedIndex==0)
	{
		alert("Please Select Control Confirmation Key ")
		document.myForm.ccKey.focus()
		return;
	}
	if(!(document.myForm.hbId.disabled) && document.myForm.hbId.value=="")
	{
		alert("Please Select House Bank Id")
		document.myForm.hbId.focus()
		return;
	}
	if(document.myForm.deliveryDate.value=="")
	{
		alert("Please Enter Delivery Date")
		document.myForm.deliveryDate.focus()
		return;
	}
	if(document.myForm.taxCode.value=="")
	{
		alert("Please Enter Tax Code")
		document.myForm.taxCode.focus()
		return;
	}
/*	
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
	}
*/
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
	
	opener.document.myForm.vendors.value		= clubVal;
	opener.document.myForm.docType.value		= document.myForm.docType.value;
	opener.document.myForm.valType.value		= document.myForm.valuationType.value;
	opener.document.myForm.confCtrl.value		= document.myForm.ccKey.value;
	opener.document.myForm.houseBnkId.value 	= document.myForm.hbId.value;
	opener.document.myForm.delivDate.value		= document.myForm.deliveryDate.value;
	opener.document.myForm.taxCode.value		= document.myForm.taxCode.value;			     	
	opener.document.myForm.headerText.value  	= document.myForm.headerText.value;
	opener.document.myForm.itemText.value		= document.myForm.itemText.value;
	window.close();
}
function winclose()
{
	window.returnValue =  "Cancel";
	window.close();
}
</script>
</head>
<body >
<form name="myForm" >
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
    
    <br>
    <table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
    	
    	<tr>
		<Th width="40%" align="left">Document Type*</Th>
		<Td width="60%">
			<select name="docType" style="width:100%" id="CalendarDiv" onChange="javascript:showLabel()">
				<option value="">Select Document Type</option>
<%
				 for(int i=0;i<PoTypes.length;i++)
				 {
%>
					<option value="<%=PoTypes[i][0]%>"><%=PoTypes[i][1]%></option>
<%
				 }
%>	
			</select>
		</Td>
    	</tr>
    	<tr>
		<Th width="40%" align="left">Valuation Type* :</Th>
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
	    	<Th width="40%" align="left" style="visibility:visible">Confirmation control key*:</Th>
	    	<Td width="60%">
				<select name="ccKey" style="width:100%" id="CalendarDiv">
				<option value="" >-Select Confirmation Control- </option>
				
<%
				 for(int i=0;i<confctrlKeys.length;i++)
				 {
%>
					<option value="<%=confctrlKeys[i][0]%>"><%=confctrlKeys[i][1]%></option>
<%
				 }
%>	
				</select>
		</Td>
    	</tr>
    	<tr>
		<Th width="40%" align="left" style="visibility:visible">House Bank ID*:</Th>
		<Td width="60%">
			<select name="hbId" style="width:100%" id="CalendarDiv"> 
			<option value="" selected>-Select House Bank ID-</option>
<%
				for(int i=0;i<houseBankIds.length;i++)
				{
%>
					<option value="<%=houseBankIds[i][0]%>"><%=houseBankIds[i][1]%></option>
<%
				}
%>	
			</select>
		</Td>
		
    	</tr>
    	<tr>
		<Th width="40%" align="left">Delivery Date:</Th>
		<Td width="60%"><input type="text" name="deliveryDate" class="InputBox" size=15 value=""  readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.deliveryDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
    	</tr>
	<tr>
		<Th width="40%" align="left">Tax Code</Th>
		<Td width="60%">
			<select name="taxCode" style="width:100%" id="CalendarDiv">
			<option value="AA" selected>No LST/CST. No ED</option>
<%
				 for(int i=0;i<taxCodes.length;i++)
				 {
%>
					<option value="<%=taxCodes[i][0]%>"><%=taxCodes[i][1]%></option>
<%
				 }
%>	
					
			</select>
				</select>
			</Td>
	</tr>
	
	<tr>
			<Th width="40%" align="left">Header text</Th>
			<Td width="60%"><textarea style='width:100%' rows=3 name=headerText ></textarea></Td>
	</tr>
	<tr>
			<Th width="40%" align="left">Item Text</Th>
			<Td width="60%">
			<textarea style='width:100%' rows=3 name=itemText ></textarea>
			</Td>
	</tr>
    </table>
<br>    
<center>
	<img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" onClick="closeWin()">
	<img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/Cancel.gif" onClick="winclose()">
</center>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

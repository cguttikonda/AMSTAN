<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iGetInfo_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetInfo.jsp"%>
<html> 
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
	function funNumber(sValue)
	{
		var nValue=parseInt(sValue);
		nValue=nValue+"";
		if ((sValue != nValue) || nValue < 0)
		{
			return false;
		}
		return true;
	}
	function updateErp()
	{
		var submitForm = false;
		var zipVal = document.myForm.PayZip.value;
		var length = document.myForm.PayZip.value.length
		/*if(!(length == 6 || length == 10))
		{
			alert("Zip Code Length should be 6 or 10 digits");
			document.myForm.PayZip.focus()
			submitForm = false;
		}
		
		else if(!funNumber(zipVal))
		{
			alert("Zip Code should contain only numbers");
			document.myForm.PayZip.focus()
			submitForm = false;
		}
		if(length==0){
			alert("Please Enter Zip Code");
			document.myForm.PayZip.focus()
			submitForm = false;
		
		}
		else*/
			submitForm = true;
		
				
		if(submitForm)
		{	
			document.myForm.action="ezUpdateErpInfo.jsp";
			document.myForm.submit();
		}	
	}
</script>
<style>
	td.pagestyle
	{
		color: #660000;
		font-family: verdana, arial;
		font-size: 10px;
		background-color: #ffffff
	}
</style>
</head>
<body scroll=no>
<%
	String display_header = cAddr_L;
%>	
<%@ include file="ezDisplayHeader.jsp"%>
<br> 
<%
	if(showAddressInfo) 
	{
%>
		<form method="post" name="myForm">
		<input type="hidden" value="<%=companyName%>" name="payCompany" >
		
		<TABLE align=center style="BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" cellSpacing=0 cellPadding=0 width="75%"  height=60% border=0>
		<TR>
			<TD class="pagestyle" width="40%" align=center valign=middle>
				<img src="../../Images/Others/chgadd.jpg">

			</TD>
			<TD class="pagestyle" width="60%" align=left valign=middle>
				<TABLE width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
				<tr >
					<th align="center" colspan=2><%=plzChkAddr_L%></th>
				</tr>
				<tr>
					<th width="40%" align="left"><%=company_L%></th>
					<td width="60%" height="3"><%=companyName%></td>
				</tr>
				<tr>
					<th width="40%" align="left"><%=addr_L%></th>
					<td width="60%">
						<input type="text" class=InputBox  name="PayAddress1" value="<%=address1%>" size="40" maxlength="30">
					</td>
				</tr>
				<tr>
					<th width="40%" align="left"><font size="3">&nbsp;</font></th>
					<td width="60%">
						<input type="text" class=InputBox  name="PayAddress2" value = "<%=address2%>" size="40" maxlength="30">
					</td>
				</tr>
				<tr>
					<th width="40%" align="left"><%=city_L%></th>
					<td width="60%">
						<input type="text" class=InputBox  maxlength="25" name="PayCity" size="40" value = "<%=city%>">
					</td>
				</tr>
				<tr>
					<th width="40%" align="left"><%=zip_L%></th>
					<td width="60%">
						<input type=text class=InputBox name=PayZip size=15 maxlength=10 value=<%=zipCode%>>
					</td>
				</tr>
				<tr>
					<th width="40%" align="left" ><%=country_L%></th>
					<td width="60%">
						<input type="text" class=InputBox  name="PayCountry" size="3" value = "<%=country%>" maxlength="3">
					</td>
				</tr>
				</TABLE>
			</TD>
		</TR>
		</TABLE>
		<br>
		<div align="center">
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

			buttonName.add("Change Address");
			buttonMethod.add("updateErp()");

			buttonName.add("Clear");
			buttonMethod.add("document.forms[0].reset()");

			out.println(getButtonStr(buttonName,buttonMethod));	
%>    
		</div>

		<input type="hidden" name="defOrderToCustNum" value="<%=shpECANum%>">
		<input type="hidden" name="defPayToCustNum" value="<%=payECANum%>">
		</form>
<%
	} 
	else 
	{
		noDataStatement = noAddrUpdate_L+"";
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
%>
<Div id="MenuSol"></Div>	
</body>
</html>

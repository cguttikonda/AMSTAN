<div align="center">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr>
      	<Td width="25%" class="labelcell" height="18">
        <div align="left"><font size="-1"><b>SAP Attributes</b></font></div>
      	</Td>
      	<Td colspan="3" height="18" class="labelcell">
        <div align="center"><font size="-1"> Details about ERP IP address, ERP login &amp; password etc. </font></div>
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="13">
        <div align="right">Group ID:</div>
      	</Td>
      	<Td width="25%" height="13">
<%
	grpId = request.getParameter("SystemNumber");
	if(grpId==null)
		{
		grpId = retsys.getFieldValueString(0,SYSTEM_NO);
		}
%>
        <%=grpId%>
        <input type="hidden" name="GroupID" value="<%=grpId%>">
      	</Td>
      	<Td width="25%" class="labelcell" height="28">
        <div align="right">Group Name:*</div>
      	</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="GroupName" maxlength="60" size="20">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" height="34" class="labelcell">
        <div align="right">ERP Host111:*</div>
      	</Td>
      	<Td width="25%" height="34">
        <input type=text class = "InputBox" name="R3Host" maxlength="75" size="15" value="">
      	</Td>
      	<Td width="25%" class="labelcell">
        <div align="right">ERP Client:*</div>
      	</Td>
      	<Td width="25%">
        <input type=text class = "InputBox" name="R3Client" maxlength="3" size="3">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell">
        <div align="right">ERP UserID:*</div>
      	</Td>
	<Td width="25%">
        <input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value="">
      	</Td>
      	<Td width="25%" class="labelcell">
        <div align="right">ERP Password:*</div>
      	</Td>
      	<Td width="25%">
        <input type="password" name="R3Password" class = "InputBox" maxlength="16" size="15" value="">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="28">
        <div align="right">ERP System Number:*</div>
      	</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="R3SystemNumber" maxlength="3" size="3">
      	</Td>
      	<Td width="25%" class="labelcell">
        <div align="right">ERP Language:</div>
      	</Td>
      	<Td width="25%">
        <input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="13">
        <div align="right">ERP Group Name:</div>
      	</Td>
      	<Td width="25%" height="13">
        <input type=text class = "InputBox" name="*R3GroupName" maxlength="64" size="15">
      	</Td>
      	<Td width="25%" class="labelcell" height="28">
        <div align="right">ERP Message Server:</div>
      	</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="*R3MessageServer" maxlength="64" size="15">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="20">
        <div align="right">ERP Gateway Host:</div>
      	</Td>
      	<Td width="25%" height="20">
        <input type=text class = "InputBox" name="*R3GatewayHost" maxlength="32" size="15">
      	</Td>
      	<Td width="25%" class="labelcell">
        <div align="right">ERP System Name:</div>
      	</Td>
      	<Td width="25%">
        <input type=text class = "InputBox" name="*R3SystemName" maxlength="128" size="15">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="2">
        <div align="right">ERP Code Page:</div>
      	</Td>
      	<Td width="25%" height="2">
        <input type=text class = "InputBox" name="R3CodePage" maxlength="4" size="4" value="1103">
      	</Td>
      	<Td width="25%" height="2" class="labelcell">
        <div align="right">ERP Load Balance:</div>
      	</Td>
      	<Td width="25%" height="2">
        <select name="R3LoadBalance">
          <option value="1">True</option>
          <option value="0" selected>False</option>
        </select>
      	</Td>
    	</Tr>
</Table>
</div>


<Title>BaaN Connection Parameters</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body >
<div align="center">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr>
      	<Td width="25%" class="labelcell" height="13"><font size="-1"><b>BaaN Attributes</b></font></Td>
      	<Td colspan="3" height="13"  class="labelcell">
        <div align="center"><font size="-2" > Details about ERP IP address, ERP login &amp; password etc. </font></div>
        <input type="hidden" name="*R3GroupName" value="NA">
        <input type="hidden" name="R3LoadBalance" value="0">
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="25%" class="labelcell" height="13" align="right" >Group ID:</Td>
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
      	<Td width="25%" class="labelcell" height="28" align="right" >Group Name:*</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="GroupName" maxlength="60" size="20">
      	</Td>
    </Tr>
    <Tr>
      <Td width="25%" height="34" class="labelcell" align="right" >ERP Host:*</Td>
      <Td width="25%" height="34">
        <input type=text class = "InputBox" name="R3Host" maxlength="32" size="15" value="">
      </Td>
      <Td width="25%" class="labelcell" height="28" align="right" >B.S.E Path:</Td>
      <Td width="25%" height="28">
        <input type=text class = "InputBox" name="*R3MessageServer" maxlength="64" size="15">
      </Td>
    </Tr>
    <Tr>
      <Td width="25%" class="labelcell" height="28" align="right" >Port Number:*</Td>
      <Td width="25%" height="28">
        <input type=text class = "InputBox" name="R3SystemNumber" maxlength="3" size="3">
      </Td>
      <Td width="25%" class="labelcell" align="right" > Company Code:*</Td>
      <Td width="25%">
        <input type=text class = "InputBox" name="R3Client" maxlength="3" size="3" value="">
      </Td>
    </Tr>
    <Tr>
      <Td width="25%" class="labelcell" align="right" >ERP UserID:*</Td>
      <Td width="25%">
        <input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value="">
      </Td>
      <Td width="25%" class="labelcell" align="right" >ERP Password:</Td>
      <Td width="25%">
        <input type="password" name="R3Password" maxlength="16" size="15" value="">
      </Td>
    </Tr>
    <Tr>
      <Td width="25%" class="labelcell" align="right" >B-Shell Name:</Td>
      <Td width="25%">
        <input type=text class = "InputBox" name="*R3SystemName" maxlength="128" size="15">
      </Td>
      <Td width="25%" class="labelcell" align="right" >BaaN Version:</Td>
      <Td width="25%">
        <input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
      </Td>
    </Tr>
    <Tr>
      <Td width="25%" class="labelcell" height="2" align="right" >Command:</Td>
      <Td width="25%" height="2">
        <input type=text class = "InputBox" name="*R3GatewayHost" maxlength="32" size="15">
      </Td>
      <Td width="25%" class="labelcell" height="2" align="right" >Time Out:</Td>
      <Td width="25%" height="2">
        <input type=text class = "InputBox" name="R3CodePage" maxlength="4" size="4" value="1103">
      </Td>
    </Tr>
  </Table>
</div>
</body>
</html>

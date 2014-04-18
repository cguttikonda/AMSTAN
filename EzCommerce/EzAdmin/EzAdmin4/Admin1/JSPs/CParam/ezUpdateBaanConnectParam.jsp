
<html>
<head>
<Title>SAP Connection Parameters</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFF7">
<Table  width="100%" border="2" cellpadding="0" cellspacing="0" height="176" bordercolor="#000000">
  <Tr bordercolor="#FFFFF7"> 
    <Td class="tdmenuclass" height="13" width="25%"><font size="-1"><b> Baan Attributes</b></font></Td>
    <Td colspan="3" height="13"> 
      <div align="center"><font size="-2">Details about ERP IP address, ERP login 
        &amp; password etc. </font></div>
      </Td>
  </Tr>
  <Tr> 
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">Group ID:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="GroupNum" readonly size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_ID")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">Group Name:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="GroupName" maxlength="64" size="20" value = "<%=retgrpinfo.getFieldValue(0,"EUG_NAME")%>" >
    </Td>
  </Tr>
  <Tr> 
    <Td width="25%" height="33" class="labelcell" bordercolor="#FFFFF7">ERP Host:</Td>
    <Td width="25%" height="33" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="R3Host" maxlength="32" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_HOST")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">B.S.E Path:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="*R3MessageServer" maxlength="64" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_MSG_SERVER")%>" >
    </Td>
  </Tr>
  <Tr> 
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">Port Number:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="R3SystemNumber" size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_R3_SYS_NO")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="33"> Company 
      Code:</Td>
    <Td width="25%" bordercolor="#FFFFF7" height="33"> 
      <input type=text class = "InputBox" name="R3Client" size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_R3_CLIENT")%>">
    </Td>
  </Tr>
  <Tr> 
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">ERP UserID:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_USER_ID")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">ERP Password:</Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29"> 
      <input type="password" name="R3Password" maxlength="16" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_PASSWD")%>">
    </Td>
  </Tr>
  <Tr> 
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">B-Shell Name:</Td>
    <Td width="25%" bordercolor="#FFFFF7"> 
      <input type=text class = "InputBox" name="*R3SystemName" maxlength="128" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_SYS_NAME")%>" >
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">Baan Version:</Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29"> 
      <input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
    </Td>
  </Tr>
  <Tr> 
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">Command:</Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29"> 
      <input type=text class = "InputBox" name="*R3GatewayHost" maxlength="32" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_GATEWAY_HOST")%>" >
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">Time Out:</Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29"> 
      <input type=text class = "InputBox" name="R3CodePage" maxlength="4" size="4" value="1103">
      <input type="hidden" name="R3LoadBalance" value="2">
	  
    </Td>
  </Tr>
</Table>
</body>
</html>
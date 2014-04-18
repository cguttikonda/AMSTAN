
<html>
<head>
<Title>Oracle Connection Parameters</Title>
</head>
<body>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
  	<Tr> 
    	<Td class="tdmenuclass" height="19" width="25%"><font size="-1"><b> 
<%
	if(sys_type.equals("999"))
		{
%>
      		EzSystem Attributes 
<%
		}
	else
		{
%>
	      	OraApps Attributes 
<%
		}
%>
	      	</b></font></Td>
    	<Td colspan="3" height="19"> 
      	<div align="center"><font size="-2">Details about ERP IP address, ERP login 
        &amp; password etc. </font></div>
      	<%//Hidden variables....%>
      	<input type="hidden" name="*R3GroupName" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_GROUP_NAME")%>" >
      	<input type="hidden" name="R3Host" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_HOST")%>">
      	<input type="hidden" name="R3Client" value="0">
      	<input type="hidden" name="R3SystemNumber" value="<%=retgrpinfo.getFieldValue(0,"EUG_R3_SYS_NO")%>">
      	<input type="hidden" name="*R3GatewayHost" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_GATEWAY_HOST")%>" >
      	<input type="hidden" name="R3CodePage" value="1103">
      	<input type="hidden" name="R3LoadBalance" value="2">
    	</Td>
  	</Tr>
  	<Tr> 
    	<Td width="25%" class="labelcell"  height="32" align="right">Group ID:</Td>
    	<Td width="25%"  height="32"> 
    	<%=retgrpinfo.getFieldValue(0,"EUG_ID")%>
      	<input type="hidden" name="GroupNum" value="<%=retgrpinfo.getFieldValue(0,"EUG_ID")%>">
    	</Td>
    	<Td width="25%" class="labelcell"  height="32" align="right">Group Name:*</Td>
    	<Td width="25%"  height="32"> 
      	<input type=text class = "InputBox" name="GroupName" maxlength="64" size="20" value = "<%=retgrpinfo.getFieldValue(0,"EUG_NAME")%>" >
    	</Td>
  	</Tr>
  	<Tr> 
      	<Td width="25%" class="labelcell"  align="right">JDBC Driver:*</Td>
      	<Td width="25%" > 
        <input type=text class = "InputBox" name="R3MessageServer" maxlength="64" size="20" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_MSG_SERVER")%>" >
    	</Td>
    	<Td width="25%" class="labelcell"  align="right">Connection URL:*</Td>
    	<Td width="25%" > 
      	<input type=text class = "InputBox" name="R3SystemName" maxlength="128" size="20" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_SYS_NAME")%>" >
    	</Td>
	</Tr>
  	<Tr> 
    	<Td width="25%" class="labelcell"  align="right">ERP UserID:*</Td>
    	<Td width="25%" > 
      	<input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_USER_ID")%>">
    	</Td>
    	<Td width="25%" class="labelcell"  align="right" height="29">ERP Password:*</Td>
<%
	session.putValue("ERPPASSWORD",retgrpinfo.getFieldValue(0,"EUG_R3_PASSWD"));
%>
    	<Td width="25%"  height="29"> 
      	<input type="password" name="R3Password" maxlength="18" size="15" value = "********">
    	</Td>
  	</Tr>
  	<Tr> 
    	<Td width="25%" class="labelcell"  align="right" height="29">ERP Language:</Td>
    	<Td width="25%"  height="29"> 
      	<input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
    	</Td>
    	<Td width="25%" class="labelcell"  height="29">&nbsp;</Td>
    	<Td width="25%"  height="29">&nbsp;</Td>
  	</Tr>
</Table>
</body>
</html>

<Title>Oracle Connection Parameters</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body >
<div align="center">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr >
      	<Td width="25%" class="tdmenuclass" height="18"><font size="-1"><b>
<%
	if(sysType.equals("999"))
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
      	<Td colspan="3" height="18">
        <div align="center"><font size="-2"> Details about ERP IP address, ERP login &amp; password etc. </font></div>
        <input type="hidden" name="R3Host" value="NA">
        <input type="hidden" name="*R3GroupName" value="NA">
        <input type="hidden" name="R3LoadBalance" value="0">
        <input type="hidden" name="R3Client" value="0">
        <input type="hidden" name="R3SystemNumber" value="000">
        <input type="hidden" name="*R3GatewayHost" value="NA">
        <input type="hidden" name="R3CodePage" value="1103">
      	</Td>
    	</Tr>
    	<Tr >
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
      	<Td width="25%" class="labelcell" align="right" height="28">Group Name:*</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="GroupName" maxlength="60" size="20">
      	</Td>
    	</Tr>
    	<Tr >
      	<Td width="25%" class="labelcell"  align="right" height="28">JDBC Driver:*</Td>
      	<Td width="25%" height="28">
        <input type=text class = "InputBox" name="R3MessageServer" maxlength="64" size="20">
      	</Td>
      	<Td width="25%" class="labelcell" align="right" >Connection URL:*</Td>
      	<Td width="25%">
        <input type=text class = "InputBox" name="R3SystemName" maxlength="128" size="22">
      	</Td>
    	</Tr>
    	<Tr >
      	<Td width="25%" class="labelcell" align="right" >ERP UserID:*</Td>
      	<Td width="25%">
	<input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value="">
      	</Td>
      	<Td width="25%" class="labelcell" align="right" >ERP Password:*</Td>
      	<Td width="25%">
	<input type="password" name="R3Password" maxlength="18" size="15" value="">
      	</Td>
    	</Tr>
    	<Tr >
      	<Td width="25%" class="labelcell" align="right" >ERP Language:</Td>
      	<Td width="25%">
        <input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
      	</Td>
      	<Td width="25%" class="labelcell">&nbsp;</Td>
      	<Td width="25%">&nbsp;</Td>
    	</Tr>
</Table>
</div>
</body>
</html>

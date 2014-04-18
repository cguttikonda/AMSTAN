
<html>
<head>
<Title>SAP Connection Parameters</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFF7">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
  <Tr bordercolor="#FFFFF7">
    <Td class="labelcell" height="18" width="25%">
      <div align="left"><font size="-1"><b> SAP Attributes</b></font></div>
    </Td>
    <Td colspan="3" height="18" class="labelcell">
      <div align="center"><font size="-2">Details about ERP IP address, ERP login
        &amp; password etc. </font></div>
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">Group ID:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7">
   <!--  <input type=text class = "InputBox" name="GroupNum" readonly size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_ID")%>">-->
   <%=retgrpinfo.getFieldValue(0,"EUG_ID")%>
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">Group Name:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="GroupName" maxlength="64" size="20" value = "<%=retgrpinfo.getFieldValue(0,"EUG_NAME")%>" >
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" height="34" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP Host:</div>
    </Td>
    <Td width="25%" height="34" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="R3Host" maxlength="75" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_HOST")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP Client: </div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="R3Client" size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_R3_CLIENT")%>">
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP UserID:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="R3UserID" maxlength="16" size="15" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_USER_ID")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">
      <div align="right">ERP Password:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29">
<%
	session.putValue("ERPPASSWORD",retgrpinfo.getFieldValue(0,"EUG_R3_PASSWD"));
%>
      <input type="password" name="R3Password" maxlength="16" size="15" value = "********">
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP System Number:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="R3SystemNumber" size="3" maxlength="3" value="<%=retgrpinfo.getFieldValue(0,"EUG_R3_SYS_NO")%>">
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">
      <div align="right">ERP Language:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7" height="29">
      <input type=text class = "InputBox" name="R3Lang" maxlength="2" size="2" value="EN">
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP Group Name:</div>
    </Td>
<%
	String groupName = retgrpinfo.getFieldValueString(0,"EUG_R3_GROUP_NAME");
	if (groupName.equals("null") || "null".equals(groupName))
		{
			groupName = "";
		}
%>    
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="*R3GroupName" maxlength="64" size="15" value = "<%= groupName%>" >
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP Message Server:</div>
    </Td>
<%
	String msgServer = retgrpinfo.getFieldValueString(0,"EUG_R3_MSG_SERVER");
	if (msgServer.equals("null") || "null".equals(msgServer))
		{
			msgServer = "";
		}
%>
	<Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="*R3MessageServer" maxlength="64" size="15" value = "<%=msgServer%>" >
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="29">
      <div align="right">ERP Gateway Host:</div>
    </Td>
<%
	String gatewayHost = retgrpinfo.getFieldValueString(0,"EUG_R3_GATEWAY_HOST");
	if (gatewayHost.equals("null") || "null".equals(gatewayHost))
		{
			gatewayHost = "";
		}
%>

    <Td width="25%" bordercolor="#FFFFF7" height="29">
      <input type=text class = "InputBox" name="*R3GatewayHost" maxlength="32" size="15" value = "<%=gatewayHost%>" >
    </Td>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP System Name:</div>
    </Td>
<%
	String systemName = retgrpinfo.getFieldValueString(0,"EUG_R3_SYS_NAME");
	if (systemName.equals("null") || "null".equals(systemName))
		{
			systemName = "";
		}
%>    
    <Td width="25%" bordercolor="#FFFFF7">
      <input type=text class = "InputBox" name="*R3SystemName" maxlength="128" size="15" value = "<%=systemName%>" >
    </Td>
  </Tr>
  <Tr>
    <Td width="25%" class="labelcell" bordercolor="#FFFFF7" height="2">
      <div align="right">ERP Code Page:</div>
    </Td>
    <Td width="25%" bordercolor="#FFFFF7" height="2">
      <input type=text class = "InputBox" name="R3CodePage" maxlength="4" size="4" value="1103">
    </Td>
    <Td width="25%" height="2" class="labelcell" bordercolor="#FFFFF7">
      <div align="right">ERP Load Balance:</div>
    </Td>
    <Td width="25%" height="2" bordercolor="#FFFFF7">
      <%
String Name10 = "R3LoadBalance";
Object UserTypes10[] = {"True", "False"};
Object TypeValues10[] = {"1", "2"};
String Select_Value10 = (retgrpinfo.getFieldValue(0,"EUG_R3_LOAD_BALANCE").toString());

if(Select_Value10 != null){
%>
				<select name=<%=Name10%> >
<%
			for (int i = 0 ; i < TypeValues10.length ; i++ ){

				if (Select_Value10.equals (TypeValues10[i]) ) // Select the Value
				{
%>
					<option value=<%=TypeValues10[i]%> selected>
					<%=UserTypes10[i].toString ()%>
					</option>
<%				}
				else
				{
%>
					<option value=<%=TypeValues10[i]%>  >
					<%=UserTypes10[i].toString ()%>
					</option>
<%				}
			}
%>

			</select>
<%
	}else{
%>
				<select name=<%=Name10%> >
<%
			for (int i = 0 ; i < TypeValues10.length ; i++ ){

				if ("1".equals (TypeValues10[i]) ) // Select the Value
				{
%>
					<option value=<%=TypeValues10[i]%> selected>
					<%=UserTypes10[i].toString ()%>
					</option>
<%				}
				else
				{
%>
					<option value=<%=TypeValues10[i]%>  >
					<%=UserTypes10[i].toString ()%>
					</option>
<%				}
			}
%>

			</select>

<%
	}
%>
    </Td>
  </Tr>
</Table>
</body>
</html>

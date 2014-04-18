<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iAddBusAreaDesc.jsp"%>
<html>
<head>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script src="../../Library/JavaScript/Config/ezAddBusAreaDesc.js">
</script>
<Title>Add Business Area</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<%
int sysRows = retsys.getRowCount();
if ( sysRows > 0 )
	{
%>
	<body onload="document.myForm.SystemNumber.focus()">
<%
	}
else
	{
%>
	
<%
	}
%>
<form name=myForm method=post action="ezSaveBusAreaDesc.jsp" onSubmit="return CheckValue()">

<%
	if ( sysRows > 0 )
		{
%>


<%
	String areaFlag = request.getParameter("Area");
	String areaLabel = "";
	String disableFlag = "";
	String yChecked = "";
	String nChecked = "";

	if ( areaFlag.equals("C") )
		{
		areaLabel = "Sales Area";
		yChecked="checked";
		nChecked="";
		}
	else if ( areaFlag.equals("V") )
		{
		areaLabel = "Purchase Area";
		disableFlag = "disabled";
		nChecked="checked";
		yChecked="";
		}
	else if ( areaFlag.equals("S") )
		{
		areaLabel = "Service Area";
		disableFlag = "disabled";
		nChecked="checked";
		yChecked="";
		}
	else
		{
		areaLabel = "Other Area";
		disableFlag = "disabled";
		nChecked="checked";
		yChecked="";
		}
%>
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
	<Td class="displayheader">Add <%= areaLabel %></Td>
	</Tr>
</Table>
<%
	String rCode = request.getParameter("code");
	String rDesc = request.getParameter("desc");
	String rSysNo = request.getParameter("sysno");
	String rSyncFlag = request.getParameter("syncflag");
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
      	<Th colspan="3">
        <div align="center">Please enter the following <%= areaLabel %> information</div>
      	</Th>
    	</Tr>
    	<Tr>
      	<Td width="30%" class="labelcell">
        <div align="right">System:*</div>
      	</Td>
      	<Td width="70%">
<%
	if ( sysRows > 0 )
		{
%>
		<select name="SystemNumber" id=ListBoxDiv>
        	<option value="sel" >--Select System--</option>
<%
		for ( int i = 0 ; i < sysRows ; i++ )
			{
			String sel = "";
			String aSysNo = retsys.getFieldValueString(i,SYSTEM_NO);
			String system_desc = (String)(retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION));
			if ( rSysNo != null && rSysNo.equals(aSysNo) )
				{
				sel = "selected";
				}
%>
	        	<option value=<%=aSysNo%> >
				<%=aSysNo%> --> <%=system_desc%>
	        	</option>
<%
			}
%>
        	</select>
        	
<%
		}
%>
      	</Td>
      	</Tr>
	<Tr>
      	<Td width="30%" class="labelcell">
        <div align="right">Code:*</div>

      	<Td width="70%">
        <input type=text class = "InputBox" name=Code size="10" maxlength="3" >
        </Td>
      	</Td>
	</Tr>
      	<Tr>
      	<Td width="30%" class="labelcell">
        <div align="right">Language:*</div>
      	</Td>
      	<Td>
        <%@ include file="../../../Includes/Lib/ListBox/LBLanguage.jsp"%>
      	</Td>
    	</Tr>

    	<Tr>
      	<Td width="30%" class="labelcell">
        <div align="right">Description :*</div>
      	</Td>
      	<Td>
        <input type=text class = "InputBox" name=Desc size="40" maxlength="128" Style = "width:100%">
        </Td>
    	</Tr>
    	<Tr>
      	<Td width="30%" class="labelcell">
        <div align="right">Synchronizable:</div>
      	</Td>
      	<Td>
        <input type="radio" name="syncFlag" value="Yes" <%=disableFlag%> <%=yChecked%>>
        Yes
        <input type="radio" name="syncFlag" value="No" <%=nChecked%>>
        No   </Td>
    	</Tr>
</Table>
<br>
<%
	if ( sysRows > 0 )
		{
%>
	       	<center>
       		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  >
       		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
       		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


       		</center>
<%
		}

%>
<%
	if ( rCode != null )
		{
%>
	<script Language="JavaScript">
	alert('Code <%= rCode %> has been assigned for system <%= rSysNo %>. Try a different one');
	document.forms[0].Code.value='<%=rCode%>';
	document.forms[0].Desc.value='<%=rDesc%>';
<%
	if ( rSyncFlag.equals("Y") )
		{
%>
		document.forms[0].syncFlag[0].checked=true;
<%
		}
	else
		{
%>
		document.forms[0].syncFlag[1].checked=true;
<%
		}
%>
	document.forms[0].Code.focus();
</script>
<%
	}
%>
<input type="hidden" name="Area" value="<%=areaFlag%>">
</form>
<%
	}
else
	{
%>
<br><br><br><br><br>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
    <Th>There are No Systems Created Currently.</Th>
  </Tr>
</Table>
<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
	}
%>
</body>
</html>

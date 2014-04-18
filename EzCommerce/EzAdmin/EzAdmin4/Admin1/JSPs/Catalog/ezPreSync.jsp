<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iPreSync.jsp"%>
<html>
<head>
<Title>ezPreSync--Powered by EzCommerce Global Solutions</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Catalog/ezPreSync.js"></script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%
	if (retsyskey != null && retsyskey.find("ESKD_SYNC_FLAG","Y") )
	{
%>
		<body onLoad='scrollInit();document.myForm.SystemKey.focus()' onResize = "scrollInit()" scroll="no">

<%
	}
	else
	{
%>
		<body>
<%
	}
%>
		
<form name=myForm method=post onSubmit="return submitForm()">

<%
if ( retsyskey != null && retsyskey.find("ESKD_SYNC_FLAG","Y") )
{
%>
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  <Tr>
      <Th width="20%" class="labelcell">Sales Area:</Th>
      <Td width="80%">
<%
      int sysRows = retsyskey.getRowCount();
%>
      
      <select style="width:100%;" name="SystemKey" id=FullListBox onChange="funSubmit()">
        <option value="sel" >--Select Sales Area--</option>
      <%
             String val=null,checkFlag=null,syskeyDesc=null;
             retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
	     for ( int i = 0 ; i < sysRows ; i++ )
	     {
	  	val = retsyskey.getFieldValueString(i,SYSTEM_KEY);
	  	checkFlag = retsyskey.getFieldValueString(i,"ESKD_SYNC_FLAG");
	  	checkFlag = checkFlag.trim();
	  	syskeyDesc = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));
	  	if(! checkFlag.equals("Y"))
	  	continue;

	  	val = val.toUpperCase();
	        val = val.trim();
	  	if(sys_key.equals(val))
	  	{
%>	  		<option selected value=<%=val%> ><%=syskeyDesc%>(<%=val%>)</option>
<%
		}
		else
		{
%>
			<option value=<%=val%> ><%=syskeyDesc%> (<%=val%>)</option>
<%
	  	}
	   }
%>
	</select>
	
	</Td>
    </Tr>
  </Table>

<%
	if(sys_key!=null && !sys_key.equals("sel"))
 	{
 %>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
		<Tr align="center">
		    <Td class="displayheader">Products Synchronization </Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	        <Tr align="left">
		    <Th width="62%">Default</Th>
		    <Th width="38%">Value</Th>
		</Tr>
		</Table>
		</div>

<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

<%
		int defRows = retdef.getRowCount();
		String defDescription = null,defValue=null;
		if ( defRows > 0 )
		{
		    for ( int i = 0 ; i < defRows; i++ )
		    {
			defDescription = retdef.getFieldValueString(i,"EUDD_DEFAULTS_DESC");
			defDescription=(defDescription==null || "null".equals(defDescription))?"  ":defDescription;
			defValue = retdef.getFieldValueString(i,"ECAD_VALUE");
			defValue=(defValue==null || "null".equals(defValue) || defValue.equals(" "))?"&nbsp;":defValue;
%>
		    	<Tr align="left">
		    	<Td width="62%">
			    	<input type="hidden" name="ChangeFlag" value="N" >
	     			<%=defDescription%>
			</Td>

      			<Td width="38%">
				<%=defValue%>&nbsp;
			</Td>


<%			if(defDescription.equals("SYSNO"))
			{
%>
				<input type="hidden" name="System" value=<%=defValue%> >
<%
			}
%>

		        </Tr>
<%
		}//End for
	   }

%>
	 </Table>
	 </div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<input type = image src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif" onClick="setOption(2)">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>

	</form>
<%
	}
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell" align=center>
			<b>Please Select  Sales Area to continue.</b>
			</Td>
		</Tr>
		</Table>
		<center>
		<br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>

<%
	}
}
else
{
%>
	<BR><BR><BR><BR>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
        <Tr align="center">
	    <Th>There are No Synchronizable  Sales Areas </Th>
	</Tr>
	</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>

<%
}//end if Cat Areas >0
%>
</body>
</html>



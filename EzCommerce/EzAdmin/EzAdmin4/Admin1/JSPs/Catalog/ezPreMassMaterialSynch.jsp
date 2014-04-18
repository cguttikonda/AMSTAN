<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iMassSynchronize.jsp"%>
<%
	String syskey = "ESKD_SYS_KEY";
	String syskeyDesc = "ESKD_SYS_KEY_DESC";
	int retCount=ret.getRowCount();
%>
<html>
<head>
	<Title>Mass Material Synch</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<Script>
	function funSelect()
	{
		var from = document.myForm.from.value
		var to = document.myForm.to.value
		var len = document.myForm.syskey.length
		if(isNaN(len))
		{
			document.myForm.syskey.checked = false;
		}
		else
		{
			for(var i=0;i<len;i++)
			{
				document.myForm.syskey[i].checked = false;
			}
		}		
		if(from!="" && to!="")
		{
			if(isNaN(len))
			{
				if(document.myForm.syskey.value >= from && document.myForm.syskey.value <= to)
				{
					document.myForm.syskey.checked = true;
				}
			}
			else
			{
				for(var i=0;i<len;i++)
				{
					if(document.myForm.syskey[i].value >= from && document.myForm.syskey[i].value <= to)
					{
						document.myForm.syskey[i].checked = true;
					}
				}
			}
		}
	}
	function chkAll()
	{
		var count = 0;
		var len = document.myForm.syskey.length
		if(isNaN(len))
		{
			if(document.myForm.syskey.checked)
			{
				count++;
			}
		}
		else
		{
			for(var i=0;i<len;i++)
			{
				if(document.myForm.syskey[i].checked)
				{
					count++
				}
			}
		}
		if(count==0)
		{
			alert("Please Select a Sales Area.")
			return false;
		}
		return true;
	}
	</Script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll = "no">
<form name = "myForm" onSubmit = "return chkAll()"  action="ezMassMaterialSynch.jsp" method=post>
<%
	if(retCount==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		<Th>There are no Sales Areas to List.</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
<br>
	<div id="theads">
       	<Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class = "displayheader" align="center" width = "30%" colspan = 4>Mass Material Synchronization</Td>
	</Tr>
	<Tr>

		<Th align="center" width = "30%" colspan = 4><b>Sales Area</b></Th>
	</Tr>
	<Tr>
		<Th width = "20%" align = "right">From</Th>
		<Td width = "30%"><input type = "text" name = "from" value = "" class = "InputBox" style = "width:100%" maxlength = "18" onChange = "funSelect()"></Td>
		<Th width = "20%" align = "right">To</Th>
		<Td width = "30%"><input type = "text" name = "to" value = "" class = "InputBox" style = "width:100%" maxlength = "18" onChange = "funSelect()"></Td>
	</Tr>
	</Table>
	</Div>
	<div id="InnerBox1Div">
        <Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>

<%
	for(int i=0;i<retCount;i++)
	{
%>
		<label for="cb_<%=i%>">


<%
		if(i%3==0)
		{
%>
			</tr>
		<tr>
<%
		}
%>
			<Td width = "33%" title = "(<%=ret.getFieldValueString(i,syskey)%>) <%=ret.getFieldValueString(i,syskeyDesc)%>">
				<input type = "CheckBox" name = "syskey" id="cb_<%=i%>" value = "<%=ret.getFieldValueString(i,syskey)%>#####<%=ret.getFieldValueString(i,syskeyDesc)%>" >
				<input type = "text" value = "(<%=ret.getFieldValueString(i,syskey)%>) <%=ret.getFieldValueString(i,syskeyDesc)%>" size = "30" class = "DisplayBox" readonly>
			</Td>
<%
	}
	if(retCount>3)
	{
		retCount = 3 - (retCount%3);
		for(int i=0;i<retCount;i++)
		{
%>
			<Td width = "33%">&nbsp;</Td>
<%
		}
	}
%>
	</label>
	</Tr>
	</Table>
	</Div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	 	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif" name="Submit">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</div>
</form>
</body>
</html>

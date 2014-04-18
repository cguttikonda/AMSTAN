<%@page import="java.util.*"%>

<%
	String[] attributes = request.getParameterValues("selectedAttributes");
	Hashtable ht = (Hashtable)session.getAttribute("ATTRIBUTES");
%>


<html>
<head>
<script>
function goBack()
{
	document.myForm.action="ezAddAuditDocuments.jsp"
	document.myForm.submit();
}

function funSubmit()
{
	var len = document.myForm.selectedAttributes.length
	var count=0;
	if(len>0)
	{
		for(var i=0;i<len;i++)
		{
			var obj = eval("document.myForm.Insert"+i)
			var obj1 = eval("document.myForm.Update"+i)
			var obj2 = eval("document.myForm.Delete"+i)
			if(obj.checked)
			{
				count++;
				break;
			}

			if(obj1.checked)
			{
				count++;
				break;
			}

			if(obj2.checked)
			{
				count++;
				break;
			}
	
		}
	}
	else
	{
		if(document.myForm.Insert0.checked)
		{
			count++;
		}
		else if(document.myForm.Update0.checked)
		{
			count++;
		}
		else if(document.myForm.Delete0.checked)
		{
			count++;
		}
	}

	if(count>0)
	{
		document.myForm.action="ezAddSaveAudit.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Select atleast one field to Insert")
	}
	
}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()'>
<form name="myForm" method="post">
<br>
<table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<tr>
<th align="center" class="displayheader">Add Document Attributes</th>
</tr></table><br>

<div id="theads">
<table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<tr>
<th width="40%" align="center"> Attribute Name </th>
<th width="20%" align="center"> Insert </th>
<th width="20%" align="center"> Update </th>
<th width="20%" align="center"> Delete </th>
</tr>
</table>
</div>
    <DIV id="InnerBox1Div">
    <Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

<%
	int Count = attributes.length;
	String shtDesc ="";
	String dataType="";
	for(int i=0;i<Count;i++)
	{
		StringTokenizer stk = new StringTokenizer((String)ht.get(attributes[i]),"$$");
		shtDesc = stk.nextToken();
		dataType = stk.nextToken();
%>
	<tr>
	<td width="40%"><%=shtDesc%>
	<input type="hidden" name="selectedAttributes"  value="<%=attributes[i]%>">
	<input type="hidden" name="dataType"  value="<%=dataType%>">
	</td>
	<td align="center" width="20%"><input type="checkbox" name="Insert<%=i%>"></td>
	<td align="center" width="20%"><input type="checkbox" name="Update<%=i%>"></td>
	<td align="center" width="20%"><input type="checkbox" name="Delete<%=i%>"></td>
	</tr>
<%
	}
%>
</table></div>

<input type="hidden" name="documentId" value="<%=request.getParameter("documentId")%>">

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" style="cursor:hand" border=none onClick="funSubmit()">
<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="goBack()">
</div>

</form>
</body>
</html>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<Title>Add Folder -- Powered By Answerthink India Pvt Ltd.</Title>
	<script src="../../Library/JavaScript/Inbox/ezAddFolder.js" ></script>
	<script>
	function ezHref(event)
	{
		document.location.href = event;
	}
	
	
	function VerifyFields() 
	{
		if (document.forms[0].FolderName.value == "" )
		{
			alert("Please Enter The Folder Name");
			document.myForm.FolderName.focus();
			return false;
		}
		else
		{
			return true;
		}
	
		if (document.returnValue)
		{
			if (!checkFolder(document.myForm.FolderName.value))
			{
				alert('Folder Name Can Be Alphabets And Numbers Only');
				document.myForm.FolderName.focus();
				return false;
			}
			else
			{	
				return true;
			}
		}
		return true;
	}

	function checkAdd()
	{
		
		if(VerifyFields())
		{
		 	document.myForm.action="ezSaveFolderName.jsp" 
		 	document.myForm.submit();
		}
	}
	</script>
</head>
<body onLoad="document.myForm.FolderName.focus()" scroll=no>
<form name=myForm method=post >
<% String display_header="Add Folder"; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br><br>
<Table  width=100% height=50% align=center cellPadding=0 cellSpacing=0 >
	<Tr>
		<Td>
		      <Table valign=center align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		      <Tr>
			      <Th  height="27" class="labelcell"><%=getLabel("FOL_DESC")%></Th>
			      <Td  height="27"><input type=text class = "InputBox" name="FolderName" size="20" maxlength="128"></Td>
		      </Tr>
		      </Table>
		</Td>
	</Tr>
</Table>

<Div align="center">

<%		
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add Folder");
			buttonMethod.add("checkAdd()");
			buttonName.add("Clear");
			buttonMethod.add("document.myForm.reset();document.myForm.FolderName.focus()");
			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");
			out.println(getButtonStr(buttonName,buttonMethod));	
%>
</Div>

<Script Language="JavaScript">
<%
	String fName = request.getParameter("Folder");
	if ( fName != null )
	{
%>
		alert('Folder already exists. Try a different one');
		document.forms[0].FolderName.value='<%=fName%>';
<%
	 }
%>
	document.forms[0].FolderName.focus();
</Script>
<Div id="MenuSol">
</Div>
</form>
</body>
</html>

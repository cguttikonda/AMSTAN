<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iSelectAcknowledgeUsers.jsp" %>
<html>
<head>
	<title>List of Users</title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script language="javascript">
	var docObj="";
	if(!document.all)
	{
  		docObj = opener.document
	}
	else
	{
  		docObj = parent.opener.document
	}
	
	function CheckSelect()
	{
		var selCount=0;
		for (var i = 0; i < document.ListUsers.elements.length; i++)
		{
			var e = document.ListUsers.elements[i];
			if (e.name == 'to' && e.checked)
			{
				selCount = selCount + 1;
			}
		}

		if(selCount<1){
			alert("Select User(s) Before Submitting");
			return false;
			document.returnValue = false;
		}else{
			document.ListUsers.submit();
			document.returnValue = true;
		}

	}
	</script>
	 <script language="JavaScript">
	<!--
	function Update()
	{
		var e2 = document.ListUsers.userStr.value;
		for (var i = 0; i < document.ListUsers.elements.length; i++)
		{
			var e = document.ListUsers.elements[i];
			if (e.name == 'to' && e.checked)
			{
				if (e2)
					e2 += ",";
				e2 += e.value;
			}
		}
		e2 += ",";
		s=docObj.myForm.toUser.value;
		if (s == '')
			docObj.myForm.toUser.value = e2;
		else
			docObj.myForm.toUser.value =s+e2;
		
		docObj.myForm.submit();
		
		if(docObj.getElementById("msg")!=null)
		{
			docObj.getElementById("back").style.visibility = "hidden"
			docObj.getElementById("msg").style.visibility = "visible"
		}
		
		window.close();

	}
	//-->
	</script>

</head>
<body scroll=no>
<form method="post" action="javascript:Update()" name="ListUsers">
<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Caption><b>Select the user for sending the rejection</b></Caption>
<Tr align="center" valign="middle">
      <Th width="19%">Select</Th>
      <Th width="81%">User Name</Th>
</Tr>
<%
	int selectSize = selectUsers.size();
	String checked = "";
	for(int i=0;i<selectSize;i++)
	{
		if(i == 0)
			checked = "checked";
		else	
			checked = "";
%>
		    <Tr>
			<Td width="19%" align="center">
				<input type="checkbox" name= "to" value=<%=selectUsers.elementAt(i)%> <%=checked%>>
		 	</Td>
      			<Td width="81%" align="left">
				<%=(String)userHash.get(selectUsers.elementAt(i))%>
			</Td>
		    </Tr>
<%
	}
%>
	<input type="hidden" name="userStr" value="">
	</Table>
	
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Select");
	buttonMethod.add("CheckSelect()");
	
	buttonName.add("Cancel");
	buttonMethod.add("window.close()");	

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>	
</form>
<Div id="MenuSol"></Div>
</body>

</html>

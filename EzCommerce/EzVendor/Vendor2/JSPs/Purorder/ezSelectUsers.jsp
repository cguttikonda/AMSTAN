<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iSelectUsers.jsp" %>

<html>
<head>
	<title>List of Users</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script language="javascript">
	var docObj="";
	if(!document.all)
	{
  		docObj = opener.document.myForm
		if(docObj==null)
		 docObj=opener.document.composeform	
	}
	else
	{
  		docObj = parent.opener.document.myForm
		if(docObj==null)
		 docObj=parent.opener.document.composeform	

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
		s = docObj.toUser.value;
		
		if (s == '')
			docObj.toUser.value = e2;
		else
			docObj.toUser.value =s+e2;
			
	        docObj.submit();
		
		window.close();

	}
	//-->
	</script>

</head>
<body scroll=no>
<form method="post" action="javascript:Update()" name="ListUsers">
<TABLE width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center" valign="middle">
      <Th width="19%">&nbsp;</Th>
      <Th width="40%">User </Th>
      <Th width="41%">User Name</Th>
</Tr>
<%
	String checked = "";
	int i =0;
	Enumeration enum1=selectUsers.keys();
	while(enum1.hasMoreElements())
	{
		String key	= (String)enum1.nextElement();
		String value	= (String)selectUsers.get(key);
		if(i == 0)
			checked = "checked";
		else
			checked = "";
%>
		    <Tr>
			<Td width="19%" align="center">
				<input type="checkbox" name= "to" value=<%=key%> <%=checked%>>
		 	</Td>
      			<Td width="40%" align="left">
				<%=key%>
			</Td>
      			<Td width="41%" align="left">
				<%=value%>
			</Td>
		    </Tr>
<%
		i++;
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

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iSelectUsers_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iSelectUsers.jsp" %>
<html>
<head>
	<title>List of Users</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script language="javascript">
	function CheckSelect()
	{
		var selCount=0;
		len=document.ListUsers.to.length
		var e2="";
		if(!isNaN(len))
		{
			for (var i = 0; i < document.ListUsers.to.length; i++)
			{
				if(document.ListUsers.to[i].checked)	
				{
					selCount = selCount + 1;	
					e2 += document.ListUsers.to[i].value+",";
					
				}

			}
			e2=e2.substring(0,e2.length-1)
		}
		else
		{
			
			if(document.ListUsers.to.checked)
			{
				
				selCount = selCount + 1;
				e2 =e2+document.ListUsers.to.value+",";

			}
			e2=e2.substring(0,e2.length-1)

		}
		if(selCount<1){
			alert("Please Select User(s) Before Submitting");
			return false;
			document.returnValue = false;
		}
		else
		{
			//opener.document.myForm.toUser.value =e2;
			var e2 = document.ListUsers.userStr.value;
			for (var i = 0; i < document.ListUsers.elements.length; i++)
			{
				var e = document.ListUsers.elements[i];
				if (e.name == 'to' && e.checked)
				{
					if (e2)
						e2 += ";";
					e2 += e.value;
				}
			}
			e2 += ";";
			var type = '<%=request.getParameter("type")%>'
			if(type=="TO")
			{
				window.opener.document.myForm.toUser.value = e2.substring(0,e2.length-1);
			}
			if(type=="CC")
			{
				window.opener.document.myForm.ccUser.value = e2.substring(0,e2.length-1);
			}
			if(type=="BCC")
			{
				window.opener.document.myForm.bccUser.value = e2.substring(0,e2.length-1);
			}
			window.close();


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
					e2 += ";";
				e2 += e.value;
			}
		}
		e2 += ";";
		s=window.opener.document.composeform.toUser.value;
		if (s == '')
			window.opener.document.composeform.toUser.value = e2;
		else
			window.opener.document.composeform.toUser.value =s+e2;
		window.close();

	}
	//-->
	</script>
	<Script>
		  var tabHeadWidth=90
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>

</head>
<body scroll=no  onLoad='scrollInit(10)' onResize='scrollInit(10)'>
<form method="post"  name="ListUsers">
<Div id="theads">
<TABLE id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center" valign="middle">
      <Th width="19%"><%=select_L%></Th>
      <Th width="40%"><%=user_L%></Th>
      <Th width="41%"><%=userName_L%></Th>
</Tr>
</Table>

</div>
<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:45%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
//This Part is added by nagesh

/*	if (stMailIds!=null)
	{
		while(stMailIds.hasMoreTokens())
		{
			String id=(String)stMailIds.nextToken();


			if(selectUsers.contains(id))
				continue;
			else
				selectUsers.addElement(id);
		}
	}
*/
//Ends

	Enumeration enum=selectUsers.keys();

	while(enum.hasMoreElements())
	{
		String key=(String)enum.nextElement();
		String value=(String)selectUsers.get(key);

%>
		    <Tr>
			<Td width="19%" align="center">
			<input type="checkbox" name= "to" value=<%=key%> >
		 	</Td>
      			<Td width="40%" align="left">
			<%=key%>
			</Td>
      			<Td width="41%" align="left">
			<%=value%>
			</Td>

		    </Tr>
	<%
	}

	%>

      <input type="hidden" name="userStr" value="">
     </Table>
     </div>
     <div align="center" style="position:absolute;top:80%;WIDTH:100%">
    <br>
    <CENTER>
    <%
    		
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		
    		buttonName.add("Select");
    		buttonMethod.add("CheckSelect()");
    		
    		buttonName.add("Cancel");
    		buttonMethod.add("window.close()");
    		out.println(getButtonStr(buttonName,buttonMethod));
    %>
    </CENTER>
    </div>

</form>
<Div id="MenuSol"></Div>
</body>

</html>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iQueryToUser.jsp"%>
<%@include file="../../../Includes/JSPs/Misc/iWFMethods.jsp"%>
<html>
<head>
<title>Select User to send the Query</Title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="70%"
	function returnUsers()
	{
		var rfqObj = document.myForm.chk1
		var rfqLen 
		var chooseUser = "";
		var chooseRfq = 0;
		if(rfqObj != null)
		{
			rfqLen = document.myForm.chk1.length
			if(!isNaN(rfqLen))
			{
				for(i=0;i<rfqLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						if(chooseRfq == 0)
							chooseUser = document.myForm.chk1[i].value
						else
							chooseUser += "¥"+document.myForm.chk1[i].value
						chooseRfq++
					}
				}
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					chooseUser = document.myForm.chk1.value
					chooseRfq = 1
				}	
				else
				{
					chooseRfq = 1
				}
			}
			if(chooseRfq > 0)
			{
				window.returnValue=chooseUser;
				window.close();
			}
			else
			{
				alert("Please select the user to send the query");
			}
		}	
	}
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">

<form name=myForm>
<%
	if(hashSize > 0)
	{
		java.util.Enumeration enum = userHash.keys();
		String keyId = "";
		String valueId = "";
%>
		<Div align=center style="position:absolute;top:10%;visibility:visible;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="50%">
		<Tr>
			<Th width=20%>&nbsp;</Th><Th width=80%>UserName</Th>
		</Tr>
<%
		String tempData = "";
		for(int i =0;i<userHash.size();i++)
		{
			tempData = (String)userHash.get(i+"");
			keyId 	= tempData.substring(0,tempData.indexOf("¥"));
			valueId = tempData.substring(tempData.indexOf("¥")+1);
			if(!("-".equals(keyId) || "-".equals(valueId)))	
			{				
%>
			<Tr>
				<Td width=20% align=center><input type=checkbox name=chk1 value='<%=keyId%>'></Td>
				<Td width=80%><%=valueId%></Td>
			</Tr>
<%
			}
			initCount++;
		}
%>
		</Table>
		</Div>
<%
	}
	else
	{
%>
		<Div align=center style="position:absolute;top:10%;visibility:visible;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="50%">
		<Tr>
			<Th>No users to send query</Th>
		</Tr>
		</Table>
		</Div>
<%
	}
%>
		<Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%    
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
    butActions.add("returnUsers()");
    out.println(getButtons(butNames,butActions));
%>
</Div>
</form>
</body>
</html>

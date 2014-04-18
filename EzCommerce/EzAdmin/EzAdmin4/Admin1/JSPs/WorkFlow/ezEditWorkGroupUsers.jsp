<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>

<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupUsersDetails.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<script>

 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;

		FieldNames[0]="GroupId";
		CheckType[0]="MName";
		Messages[0]="Please enter GroupId";
		FieldNames[1]="UserId";
		CheckType[1]="MName";
		Messages[1]="Please enter UserId";
	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		document.myForm.action=filename
		return true
	}else{
		return false
	}
}
</script>
</head>
<body >
<%
		String Str1="";
		for(int i=0;i<detailsRet.getRowCount();i++)
		{
			Str1 =Str1+ detailsRet.getFieldValueString(i,"USERID")+",";
		}
		Str1=Str1.substring(0,Str1.length()-1);
%>

<form name=myForm method=post onSubmit="return checkOption('ezEditSaveWorkGroupUsers.jsp')">
<br>


<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Edit WorkGroupUsers For <%= removeNull(detailsRet.getFieldValue("GROUP_ID"))%></Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td align=left class=labelcell width=50%>UserId</Td>
		<Td width=50%>
					<%=Str1%>
					<input type="hidden" name="users" value="<%=Str1%>" >
		</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>EffectiveFrom*</Td>
		<Td width=50%>
		<input type=text class = "InputBox" size=18  name=EffectiveFrom maxlength="0" value="<%= effectivefrom%>" readonly>
		<a href="javascript:showCal('document.myForm.EffectiveFrom',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>EffectiveTo*</Td>
		<Td width=50%>
		<input type=text class = "InputBox" size=18  name=EffectiveTo maxlength="0" value="<%= effectiveto%>" readonly>
		<a href="javascript:showCal('document.myForm.EffectiveTo',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</Td>
	</Tr>
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<input type="hidden" name="groupid" value="<%= removeNull(detailsRet.getFieldValue("GROUP_ID"))%>" %>
</form>
</body>
</html>

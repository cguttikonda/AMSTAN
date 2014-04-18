<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddDelegationConditions.jsp"%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<script>
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;

		FieldNames[0]="DelegationId";
		CheckType[0]="MNull";
		Messages[0]="Please enter DelegationId";
		FieldNames[1]="ConditionId";
		CheckType[1]="MNull";
		Messages[1]="Please enter ConditionId";
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
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveDelegationConditions.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Add DelegationConditions</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=left class=labelcell width=50%>DelegationId*</Td>
		<Td width=50%><%=DelegationId%></Td>
	</Tr>
	<Tr>
		<Td align=left  width=50%><input type=checkbox name=chk value=""></Td>
		<Td width=50%>Condition1</Td>
	</Tr>
	<Tr>
		<Td align=left  width=50%><input type=checkbox name=chk value=""></Td>
		<Td width=50%>Condition2</Td>
	</Tr>

</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>

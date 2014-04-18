<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeList.jsp"%>
<Html>
<Head>
<meta name="author"  content="kp">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script>

function showUsers(val)
{
var tcode=document.myForm.TemplateCode.value
	newWindow = window.open("ezSourceUser.jsp?tCode="+tcode+"&formObj="+val,null,"resizable=yes,left=225,top=100,height=320,width=500,status=no,toolbar=no,menubar=no,location=no")
}

 function checkOption(filename)
 {
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();

		
		FieldNames[0]="DelegationId";
		CheckType[0]="MNull";
		Messages[0]="Please enter DelegationId";
		FieldNames[1]="SourceUser";
		CheckType[1]="MNull";
		Messages[1]="Please enter SourceUser";
		FieldNames[2]="DestUser";
		CheckType[2]="MNull";
		Messages[2]="Please enter DestUser";
		FieldNames[3]="ValidFrom";
		CheckType[3]="MNull";
		Messages[3]="Please enter ValidFrom";
		FieldNames[4]="ValidTo";
		CheckType[4]="MNull";
		Messages[4]="Please enter ValidTo";

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
<%
	if(listRet.getRowCount()==0)
	{
%>
	<body>
	<Form name=myForm method="post" onSubmit="return goForSubmit(document.myForm)">

		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Templates To Add Delegation
			</Th>
		</Tr>
		</Table><br><center>
		<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Click Here To Add" border=no onClick="funOpt(1,'ezAddTemplateCode.jsp')">
		</center>	

		</form>
		</body>

<%
	}else{
%>
<body onLoad="document.myForm.TemplateCode.focus();">
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveDelegationInfo.jsp')">
<br>

<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Add Delegation Info</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>Template Code*</Td>
		<Td width=50%><div id="ListBoxDiv">
		<select name=TemplateCode>
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
%>
			<option value="<%=listRet.getFieldValue(i,"TCODE")%>"><%=listRet.getFieldValue(i,"DESCRIPTION")%></option>
<%
		}
%>
		</select></div>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Delegation Id*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=DelegationId maxlength="20"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Source User*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=SourceUser maxlength="10"  >
		<!--<a href="JavaScript:showUsers('SourceUser')">Select</a>-->
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Destination User*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=DestUser maxlength="10"  >
		<!--<a href="JavaScript:showUsers('DestUser')">Select</a>-->
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid From*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=ValidFrom maxlength="0" readonly>
		 <a href="javascript:showCal('document.myForm.ValidFrom',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid To*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=ValidTo maxlength="0" readonly>
		<a href="javascript:showCal('document.myForm.ValidTo',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</Td>

	</Tr>
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
<%
	}
%>

</html>

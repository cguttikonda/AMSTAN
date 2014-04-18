<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditDelegationInfo.jsp"%>
 
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script>
function showUsers(val)
{
var tcode=document.myForm.TemplateCode.value
	newWindow = window.open("ezSourceUser.jsp?tCode="+tcode+"&formObj="+val,null,"resizable=yes,left=225,top=100,height=320,width=500,status=no,toolbar=no,menubar=no,location=no")
}
 function checkOption()
 {

	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
		FieldNames[0]="SourceUser";
		CheckType[0]="MNull";
		Messages[0]="Please enter SourceUser";
		FieldNames[1]="DestUser";
		CheckType[1]="MNull";
		Messages[1]="Please enter DestUser";
		FieldNames[2]="ValidFrom";
		CheckType[2]="MNull";
		Messages[2]="Please enter ValidFrom";
		FieldNames[3]="ValidTo";
		CheckType[3]="MNull";
		Messages[3]="Please enter ValidTo";
	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		return true
	}else{
		return false
	}
}
</script>
</head>
<body onLoad="document.myForm.TemplateCode.focus();">
<form name=myForm method=post action="ezEditSaveDelegationInfo.jsp" onSubmit="return checkOption();">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Edit Delegation Info</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td align=right class=labelcell width=50%>Delegation Id</Td>
		<Td width=50%><input type=hidden name=DelegationId value="<%= detailsRet.getFieldValue("DELEGATIONID") %>"><%= removeNull(detailsRet.getFieldValue("DELEGATIONID")) %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Template Code*</Td>
		<Td width=50%><div id="ListBoxDiv">
		<select name=TemplateCode>
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
			
			if((detailsRet.getFieldValue("TCODE")).equals(listRet.getFieldValue(i,"TCODE")))
			{
%>
			<option selected value="<%=listRet.getFieldValue(i,"TCODE")%>"><%=listRet.getFieldValue(i,"DESCRIPTION")%></option>
			<%}else{%>
			<option value="<%=listRet.getFieldValue(i,"TCODE")%>"><%=listRet.getFieldValue(i,"DESCRIPTION")%></option>
<%
			}
		}
%>
		</select></div>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Source User*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=SourceUser maxlength="10" value="<%= removeNull(detailsRet.getFieldValue("SOURCEUSER"))%>"  resdonly>
		<!--<a href="JavaScript:showUsers('SourceUser')">Select</a>-->
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Destination User*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=DestUser maxlength="10" value="<%= removeNull(detailsRet.getFieldValue("DESTUSER"))%>" resdonly>
		<!--<a href="JavaScript:showUsers('DestUser')">Select</a>-->
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid From*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=ValidFrom maxlength="0" value="<%=fromdate%>" readonly>
		<a href="javascript:showCal('document.myForm.ValidFrom',100,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Valid To*</Td>
		<Td width=50%><input type=text class = "InputBox" size=15  name=ValidTo maxlength="0" value="<%=todate%>" readonly>
		<a href="javascript:showCal('document.myForm.ValidTo',100,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></Td>
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
</html>

<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Arms/iListUserRoles.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditTemplateSteps.jsp"%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
 function setParticipant(obj)
 {
 	if(document.myForm.role.selectedIndex!=0)
 	{
		var role = document.myForm.role.options[document.myForm.role.selectedIndex].value;
		if(obj=="OP")
		{
			var opt=""
			for(i=0;i<document.myForm.opType.length;i++)
			{
				if(document.myForm.opType[i].checked)
					opt=document.myForm.opType[i].value
			}
			if(opt=="U")
				newWindow = window.open("ezGetStepUsers.jsp?formObj=op&role="+role,null,"resizable=no,left=200,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")
			 else if(opt=="G")
				newWindow = window.open("ezGetStepGroups.jsp?formObj=op&role="+role,null,"resizable=no,left=200,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")	
			 else if(opt=="R")
				newWindow = window.open("ezGetStepRoles.jsp?formObj=op&role="+role,null,"resizable=no,left=200,top=100,height=300,width=550,status=no,toolbar=no,menubar=no,location=no")	
		}	
		else if(obj=="FYI")
		{
			var opt=""
			for(i=0;i<document.myForm.fyiType.length;i++)
			{
				if(document.myForm.fyiType[i].checked)
					opt=document.myForm.fyiType[i].value
			}
			if(opt=="U")
				newWindow = window.open("ezGetStepUsers.jsp?formObj=fyi&role="+role,null,"resizable=no,left=200,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")
			 else if(opt=="G")
				newWindow = window.open("ezGetStepGroups.jsp?formObj=fyi&role="+role,null,"resizable=no,left=200,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")	
			 else if(opt=="R")
				newWindow = window.open("ezGetStepRoles.jsp?formObj=fyi&role="+role,null,"resizable=no,left=200,top=100,height=300,width=550,status=no,toolbar=no,menubar=no,location=no")	
		}
	}
	else
	{
		alert("Please Select Role");
		document.myForm.role.focus();
	}
 }

/*function setParticipant(obj)
 {
  	if(obj=="OP")
 	{
 		var opt=""
 		for(i=0;i<document.myForm.opType.length;i++)
 		{
 			if(document.myForm.opType[i].checked)
 				opt=document.myForm.opType[i].value
 		}
 		if(opt=="U")
		 	newWindow = window.open("ezGetStepUsers.jsp?formObj=op",null,"resizable=yes,left=275,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")
		 else if(opt=="G")
		 	newWindow = window.open("ezGetStepGroups.jsp?formObj=op",null,"resizable=yes,left=275,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")	
		 else if(opt=="R")
 			newWindow = window.open("ezGetStepRoles.jsp?formObj=op",null,"resizable=yes,left=250,top=100,height=300,width=550,status=no,toolbar=no,menubar=no,location=no")	
 	}	
 	else if(obj=="FYI")
 	{
 		var opt=""
		for(i=0;i<document.myForm.fyiType.length;i++)
		{
			if(document.myForm.fyiType[i].checked)
				opt=document.myForm.fyiType[i].value
		}
		if(opt=="U")
			newWindow = window.open("ezGetStepUsers.jsp?formObj=fyi",null,"resizable=yes,left=275,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")
		 else if(opt=="G")
			newWindow = window.open("ezGetStepGroups.jsp?formObj=fyi",null,"resizable=yes,left=275,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")	
		 else if(opt=="R")
			newWindow = window.open("ezGetStepRoles.jsp?formObj=fyi",null,"resizable=yes,left=250,top=100,height=300,width=550,status=no,toolbar=no,menubar=no,location=no")	
 	}
}*/
function setClear(obj)
{
 	if(obj=="OP")
 	{
 		document.getElementById("mySelect").style.visibility = "visible";
 		document.myForm.op.value=""
 	}
 	else
 	{
 		document.getElementById("mySelectFYI").style.visibility = "visible";
 		document.myForm.fyi.value=""
 	}
}
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
	FieldNames[0]="StepDesc";
	CheckType[0]="MNull";
	Messages[0]="Please enter Step Description";
	FieldNames[1]="op";
	CheckType[1]="MNull";
	Messages[1]="Please enter Default Participant";
	if(document.myForm.fyi.value != "")
	{
		FieldNames[2]="fyi";
		CheckType[2]="MNull";
		Messages[2]="Please enter FYI Participant";
	}

	if(document.myForm.role.selectedIndex==0)
	{
		alert("Please select Role")
		return false
	}
	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		document.myForm.action=filename
		return true
	}else{
		return false
	}
}

function setChk()
{
	var opt="<%=detailsRet.getFieldValueString("OWNER_PARTICIPANT_TYPE")%>"
	var fyit="<%=detailsRet.getFieldValueString("FYITYPE")%>"
	
	for(i=0;i<document.myForm.opType.length;i++)
	{
		if(document.myForm.opType[i].value==opt)
			document.myForm.opType[i].checked=true
	}
	for(i=0;i<document.myForm.fyiType.length;i++)
	{
		if(document.myForm.fyiType[i].value==fyit)
			document.myForm.fyiType[i].checked=true
	}
}
function setClear1(obj)
{
	if(document.myForm.role.selectedIndex!=0)
	{
		if(obj=="OP")
		{
			document.getElementById("mySelect").style.visibility = "hidden";
			document.myForm.op.value=document.myForm.role.options[document.myForm.role.selectedIndex].value;
		}
		else
		{
			document.getElementById("mySelectFYI").style.visibility = "hidden";
			document.myForm.fyi.value=document.myForm.role.options[document.myForm.role.selectedIndex].value;
		}
	}
	else
	{
		if(obj=="OP")
		{
			alert("Please Select Role");
			document.myForm.opType[0].checked = true
			document.myForm.role.focus();
		}
		else
		{
			alert("Please Select Role");
			document.myForm.fyiType[0].checked = true
			document.myForm.role.focus();
		}
	}
}
</script>
</head>
<body onLoad="document.myForm.role.focus();setChk()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveTemplateSteps.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit Template Step</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td align=right class=labelcell width=35%>Template Code</Td>
		<Td width=65%><%= removeNull(detailsRet.getFieldValue("TCODE")) %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>Step</Td>
		<Td width=65%><%= removeNull(detailsRet.getFieldValue("STEP")) %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>Role*</Td>
		<Td width=65%>
		<select name = "role" Style = "width:100%" id = "FullListBox">
			<option value = "">--Select Role--</option
<%
		retRoles.sort(new String[]{"DESCRIPTION"},true);
		int roleCount = retRoles.getRowCount();
		for(int i=0;i<roleCount;i++)
		{
		if(!retRoles.getFieldValueString(i,"DELETE_FLAG").equals("Y"))
			{
				if((retRoles.getFieldValueString(i,"ROLE_NR")).equals(detailsRet.getFieldValueString(0,"ROLE")))
				{
%>
					<option value = "<%=retRoles.getFieldValueString(i,"ROLE_NR")%>" selected><%=retRoles.getFieldValueString(i,"DESCRIPTION")%></option>
<%
				}	
				else
				{
%>				
					<option value = "<%=retRoles.getFieldValueString(i,"ROLE_NR")%>"><%=retRoles.getFieldValueString(i,"DESCRIPTION")%></option>
<%
				}
			}
		}
%>
		</select>
		</Td>
	</Tr>	
	<Tr>
		<Td align=right class=labelcell width=35%>Step Description*</Td>
		<Td width=65%><input type=text class = "InputBox" size=60  name=StepDesc maxlength="100" value="<%= removeNull(detailsRet.getFieldValue("STEP_DESC"))%>"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>Default Participant Type*</Td>
		<Td width=65%>
		<input type=radio name=opType value="U" onClick="setClear('OP')">User
		<input type=radio name=opType value="G" onClick="setClear('OP')">Group
		<input type=radio name=opType value="R" onClick="setClear1('OP')">Role
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>Default Participant*</Td>
		<Td width=65%><input type=text class = "InputBox" size=40  name=op maxlength="20" value="<%= removeNull(detailsRet.getFieldValue("OWNERPARTICIPANT"))%>" >
		<span id = "mySelect">
			<a style="text-decoration:none" href="javascript:setParticipant('OP')">Select</a> 
		</span>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>FYI Participant Type*</Td>
		<Td width=65%>
		<input type=radio name=fyiType value="U" onClick="setClear('FYI')">User
		<input type=radio name=fyiType value="G" onClick="setClear('FYI')">Group
		<input type=radio name=fyiType value="R" onClick="setClear1('FYI')">Role
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=35%>FYI Participant</Td>
		<Td width=65%><input type=text class = "InputBox" size=40  name=fyi maxlength="20" value="<%= removeNull(detailsRet.getFieldValue("FYIPARTICIPANT"))%>" >
		<span id = "mySelectFYI">
			<a style="text-decoration:none" href="javascript:setParticipant('FYI')">Select</a> 
		</span>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=35%>Is Mandatory</Td>
		<Td width=65%>
<%

		if("Y".equals(detailsRet.getFieldValueString("ISMANDATORY")))
		{
%>
			<input type=checkbox name=isMandatory value="Y" checked>
<%
		} else {
%>
			<input type=checkbox name=isMandatory value="N">
<%
		}
%>
		</Td>
	</Tr>
</Table>
		<input type=hidden name=tempCode value="<%=tCode%>">
		<input type=hidden name=stepCode value="<%=sCode%>">
		<input type=hidden name=tempDesc value="<%=tDesc%>">
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();setChk()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
</html>

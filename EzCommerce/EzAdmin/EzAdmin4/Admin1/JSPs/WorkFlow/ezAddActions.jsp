<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsList.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>

	actions= new Array();
<%
	for(int i=0;i<listRet.getRowCount();i++)
	{
%>
	
		actions[<%=i%>]= "<%=listRet.getFieldValue(i,"CODE")%>"
<%
	}
%>

 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
	FieldNames[0]="acode";
	CheckType[0]="MNumber";
	Messages[0]="Please enter code (Number format only)";	
	
	FieldNames[1]="Desc";
	CheckType[1]="MNull";
	Messages[1]="Please enter Description";
	
	FieldNames[2]="Lang";
	CheckType[2]="MNull";
	Messages[2]="Please Select Language";
	
	FieldNames[3]="Direction";
	CheckType[3]="MNull";
	Messages[3]="Please Select Direction";
	
	FieldNames[4]="WFStatOrAction";
	CheckType[4]="MNull";
	Messages[4]="Please Select Action or Status";
	
	
	
	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		for(i=0;i<actions.length;i++)
		{
			if(actions[i]==funTrim(document.myForm.acode.value))
			{
				alert("Action Code already Exists. Please Enter another Action Code");
				document.myForm.acode.focus();				
				return false;
			}
		}
	   	document.myForm.action=filename
		return true
	}
	return false;
	
}

function ezReset()
{
	for(i=0;i<document.myForm.Lang.options.length;i++)
	{
			if(document.myForm.Lang.options[i].value=="EN")
			{
				document.myForm.Lang.selectedIndex=i;
				break;
			}
	}
}		
</script>
</head>
<body onLoad="document.myForm.Lang.focus();ezReset()">
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveActions.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Add WF Action / Status</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	
	<Tr>
			<Td align=right class=labelcell width=30%>Language*</Td>
			<Td width=70%>
			<select name=Lang style = "width:100%" id = "FullListBox">
			<option selected value="-">--Select Language--</option>
<%
			for(int i=0;i<langRet.getRowCount();i++)
			{
%>
				<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>" >
							<%=langRet.getFieldValue(i,LANG_DESC)%>
		      		</option>
<%		    
			}
%>
			</select>
			
			
			</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=30%>Code*</Td>
		<Td width=70%><input type=text class = "InputBox"   name=acode maxlength = "6"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=30%>Description*</Td>
		<Td width=70%><input type=text class = "InputBox" size="67"  name=Desc maxlength="255"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=30%>Direction*</Td>
		<Td width=70%>
		<select name=Direction  style = "width:100%" id = "FullListBox">
		<option value="">--Select Direction--</option>
		<option value="B">Backward</option>
		<option value="F">Forward</option>
		<option value="N">None</option>
		</select>
                </Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=30%>WF Action / Status*</Td>
		<Td width=70%>
                <select name=WFStatOrAction  style = "width:100%" id = "FullListBox">
                <option value="">--Select WF Action / Status--</option>
		<option value="A">Action</option>
		<option value="S">Status</option>
		<!-- option value="B">Both</option -->
		</select>
                </Td>
	</Tr>

	
	<!-- Tr>
		<Td align=right class=labelcell width=30%>Availability Condition</Td>
		<Td width=70%><input type=text class = "InputBox" size=18  name=AvailCondition maxlength="255"></Td>
	</Tr -->
	</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();ezReset();" ></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
</html>

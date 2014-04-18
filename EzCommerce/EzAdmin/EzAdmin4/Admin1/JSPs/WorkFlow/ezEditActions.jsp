<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>

<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
function setFieldValues()
{
	for(i=0;i<document.myForm.Direction.length;i++)
	{
  		if(document.myForm.Direction.options[i].value=='<%=detailsRet.getFieldValueString(0,"DIRECTION")%>')
			document.myForm.Direction.options[i].selected=true;
	}

	for(i=0;i<document.myForm.Lang.length;i++)
	{
  		if(document.myForm.Lang.options[i].value=='<%=detailsRet.getFieldValueString(0,"LANG")%>')
			document.myForm.Lang.options[i].selected=true;
	}
	
	document.myForm.Lang.focus();
}	

</script>
<script>
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;

	
	FieldNames[0]="Desc";
	CheckType[0]="MNull";
	Messages[0]="Please enter Description";

	FieldNames[1]="Lang";
	CheckType[1]="MNull";
	Messages[1]="Please Select Language";

	FieldNames[2]="Direction";
	CheckType[2]="MNull";
	Messages[2]="Please Select Direction";

	FieldNames[3]="WFStatOrAction";
	CheckType[3]="MNull";
	Messages[3]="Please Select Action or Status";



	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		
		document.myForm.action=filename
		return true
	}
	return false;


}


</script>
</head>
<body onLoad="setFieldValues()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveActions.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit WorkFlow Action / Status</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
			<Td align=right class=labelcell width=35%>Action/Status Code</Td>
			<Td width=65%><%=chkValue%></Td>
	</Tr>
	<Tr>
			<Td align=right class=labelcell width=35%>Language*</Td>
			<Td width=65%>
			<select name=Lang style="width:100%" id="FullListBox">
			<option selected value="">--Select Language--</option>

			<%
			   for(int i=0;i<langRet.getRowCount();i++)
			   {
			%>
			<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>" >
			<%=langRet.getFieldValue(i,LANG_DESC)%>
		      	</option>
			<% }

			%>
			</select>
			</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Description*</Td>
		<Td ><input type=text class = "InputBox" style = "width:100%" size=53  name=Desc maxlength="255" value="<%=detailsRet.getFieldValue("DESCRIPTION")%>"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Direction*</Td>
		<Td >
		<select name=Direction id=ListBoxDiv>
		<option value="">--Select Direction--</option>
		<option value="B">Backward</option>
		<option value="F">Forward</option>
		<option value="N">None</option>
		</select>
                </Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>WF Action/Status</Td>
		<% 
		  
		  String act=detailsRet.getFieldValueString("STAT_OR_ACTION");
		  if(act.equals("A"))
		  {
			 act="Action";
		  }
		  else if(act.equals("S"))
		  {
		         act="Status";
		  }
		  else if(act.equals("B"))
		  {
		    	 act="Both";
		  } %>
		<Td width=50%><%=act%>&nbsp;</Td>
	</Tr>

</Table>
<input type="hidden" name="Code" value="<%=chkValue%>">
<input type="hidden" name="WFStatOrAction" value="<%=detailsRet.getFieldValue(0,"STAT_OR_ACTION")%>">
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();javascript:setFieldValues()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>

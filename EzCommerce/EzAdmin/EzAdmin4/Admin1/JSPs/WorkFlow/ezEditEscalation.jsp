<%@page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@include file="../../../Includes/JSPs/WorkFlow/iAddEscalation.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iEscalationDetails.jsp"%>
<%@include file="../../../Includes/JSPs/WorkFlow/iRollList.jsp" %>
<%@include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>

<script>

 function setParticipant(obj)
 {
  	newWindow = window.open("ezGetStepUsers.jsp?formObj=op",null,"resizable=yes,left=275,top=100,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")
	
 }

function showSpan()
{

			
   var num = document.myForm.Level.options[document.myForm.Level.selectedIndex].value
   
   for(var j=1;j<=6;j++)
   {
   	document.all["span"+j].style.visibility="hidden";
   	document.all["span"+j].style.display="none";
   }
   
   if(num!="-")
   {
   	document.all["span"+num].style.display="";
   	document.all["span"+num].style.visibility="visible";
   }	
   
	
}
</script>
<script>
  
 var templates = new Array() 
 var groups = new Array() 
 var roles = new Array() 
 
 function setTemplateData(templateCode,templateDesc)
 {
     this.templateCode= templateCode
     this.templateDesc= templateDesc
 }
 
 function setGroupsData(groupCode,groupDesc)
 {
      this.groupCode= groupCode
      this.groupDesc= groupDesc
 }
 
 function setRolesData(roleNumber,roleDesc)
 {
       this.roleNumber=roleNumber
       this.roleDesc=roleDesc
 }
 
 <%
 	for(int i=0;i<listTemplateRet.getRowCount();i++)
 	{
 %>
 	    templates[<%=i%>]=new setTemplateData("<%=listTemplateRet.getFieldValueString(i,"TCODE")%>","<%=listTemplateRet.getFieldValueString(i,"DESCRIPTION")%>");	
 <%    
 	} 
 %>
 
 <%
  	for(int i=0;i<listGroupRet.getRowCount();i++)
  	{
 %>
  	    groups[<%=i%>]=new setGroupsData("<%=listGroupRet.getFieldValueString(i,"GROUP_ID")%>","<%=listGroupRet.getFieldValueString(i,"DESCRIPTION")%>");	
 <%    
  	} 
 %>
 
 <%
   	for(int i=0;i<retRoles.getRowCount();i++)
   	{
 %>
   	    roles[<%=i%>]=new setRolesData("<%=retRoles.getFieldValueString(i,"ROLE_NR")%>","<%=retRoles.getFieldValueString(i,"DESCRIPTION")%>");	
 <%    
   	} 
 %>
 
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
		
		FieldNames[0]="Description";
		CheckType[0]="MName";
		Messages[0]="Please enter Description";
		FieldNames[1]="Duration";
		CheckType[1]="MNumber";
		Messages[1]="Please enter Duration";
		FieldNames[2]="MoveCount";
		CheckType[2]="MNumber";
		Messages[2]="Please enter Move Number";
		
	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
	    if(document.myForm.Lang.selectedIndex!=0)
	    {
	    	
	    	if(document.myForm.Level.selectedIndex!=0)
	    	{
			document.myForm.action=filename
			return true
		}	
		else
		{
		    	alert("Please Select Level")
		    	return false
	    	}
	    }
	    else
	    {
	    	alert("Please Select Language")
	    	return false
	    }
	}else{
		return false
	}
}
</script>

<script>

function setDefaultValues()
{

	for(i=0;i<document.myForm.Lang.length;i++)
	{
  		if(document.myForm.Lang.options[i].value=='<%=detailsRet.getFieldValueString("LANG")%>')
			document.myForm.Lang.options[i].selected=true;
	}

	for(i=0;i<document.myForm.Level.length;i++)
	{
  		if(document.myForm.Level.options[i].value=='<%=detailsRet.getFieldValueString("ESCLEVEL")%>')
			document.myForm.Level.options[i].selected=true;
	}


	var lev = '<%=detailsRet.getFieldValueString("ESCLEVEL")%>'

	document.all["span"+lev].style.visibility="visible";
	document.all["span"+lev].style.display="";
	
	if(lev=='1')
	{
		for(var i=0;i<document.myForm.Template.length;i++)
		{
			if(document.myForm.Template.options[i].value=='<%=detailsRet.getFieldValueString("TEMPLATE")%>')
				document.myForm.Template.options[i].selected=true;
		}		
	}
	else if(lev=='2')
	{
		for(var i=0;i<document.myForm.Role.length;i++)
		{
				if(document.myForm.Role.options[i].value=='<%=detailsRet.getFieldValueString("ROLE")%>')
					document.myForm.Role.options[i].selected=true;
		}
			
	}
	else if(lev=='3')
	{
		for(var i=0;i<document.myForm.GroupId.length;i++)
		{
			if(document.myForm.GroupId.options[i].value=='<%=detailsRet.getFieldValueString("GROUP_ID")%>')
				document.myForm.GroupId.options[i].selected=true;
	        }				
	        
	}
	else if(lev=='4')
	{
		document.myForm.op.value='<%=detailsRet.getFieldValueString("ESCUSER")%>'
	}
	else if(lev=='5')
	{
		for(var i=0;i<document.myForm.Template1.length;i++)
		{
			if(document.myForm.Template1.options[i].value=='<%=detailsRet.getFieldValueString("TEMPLATE")%>')
				document.myForm.Template1.options[i].selected=true;
		}
			
		for(var i=0;i<document.myForm.Role1.length;i++)
		{
				if(document.myForm.Role1.options[i].value=='<%=detailsRet.getFieldValueString("ROLE")%>')
					document.myForm.Role1.options[i].selected=true;
		}				
	}
	else if(lev=='6')
	{
		for(var i=0;i<document.myForm.Template2.length;i++)
		{
			if(document.myForm.Template2.options[i].value=='<%=detailsRet.getFieldValueString("TEMPLATE")%>')
				document.myForm.Template2.options[i].selected=true;
		}
			
		for(var i=0;i<document.myForm.GroupId1.length;i++)
		{
			if(document.myForm.GroupId1.options[i].value=='<%=detailsRet.getFieldValueString("GROUP_ID")%>')
			document.myForm.GroupId1.options[i].selected=true;
		}		
	}

		
	for(var i=0;i<document.myForm.Type.length;i++)
	{
		if(document.myForm.Type.options[i].value=='<%=detailsRet.getFieldValueString("ESCTYPE")%>')
			document.myForm.Type.options[i].selected=true;
	}	
		
 
	
}


</script>



</head>
<body onLoad="setDefaultValues()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveEscalation.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Edit Escalation</Td>
	</Tr>
</Table>

<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Description*</Td>
		<Td width=50%><input type=text class = "InputBox" size=18  name=Description maxlength="50" value="<%=detailsRet.getFieldValue("DESCRIPTION")%>"></Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Lang*</Td>
		<Td width=50%>
		<select name=Lang>
		<option selected value="-">--Select--</option>
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
		<Td align=right class=labelcell width=50% >Level</Td>
		<Td width=50%>
		<select name="Level" onChange="showSpan()">
		<option value="-">--Select--</option>
		<option value="1">Template Level</option>
		<option value="2">Role Level</option>
		<option value="3">Group Level</option>
		<option value="4">User Level</option>
		<option value="5">Template and Role Level</option>
		<option value="6">Template and Group Level</option>
		</select>
		</Td>
	</Tr>
</Table>
<span id="span1" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>

	<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%>
		<select name="Template">
		<option value="-">--Select--</option>
		<script>
		for(var i=0;i<templates.length;i++)
		{
			document.write("<option value="+templates[i].templateCode+">"+templates[i].templateDesc+"</option>")	
		}
		</script>
		</select>
		</Td>
	</Tr>
	
</Table>
</span>
<span id="span2" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Role</Td>
		<Td width=50%>
		<select name=Role>
		<option value="-">--Select--</option>
		<script>
			for(var i=0;i<roles.length;i++)
			{
				document.write("<option value="+roles[i].roleNumber+">"+roles[i].roleDesc+"</option>")	
			}
		</script>
		</select>
		</Td>
	</Tr>
</Table>
</span>
<span id="span3" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	
	<Tr>
		<Td align=right class=labelcell width=50%>GroupId</Td>
		<Td width=50%>
		<select name=GroupId>
		<option value="-">--Select--</option>
		<script>
			for(var i=0;i<groups.length;i++)
			{
				document.write("<option value="+groups[i].groupCode+">"+groups[i].groupDesc+"</option>")	
			}
		</script>
		</select>
		</Td>
	</Tr>

</Table>
</span>
<span id="span4" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	
	<Tr>
		<Td align=right class=labelcell width=50%>User</Td>
		<Td width=50%><input type=text class = "InputBox" size=18  name=op maxlength="10">
		<a style="text-decoration:none" href="javascript:setParticipant('OP')">Select</a></Td>
	</Tr>

</Table>
</span>
<span id="span5" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>

	<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%>
		<select name="Template1">
		<option value="-">--Select--</option>
		<script>
		for(var i=0;i<templates.length;i++)
		{
			document.write("<option value="+templates[i].templateCode+">"+templates[i].templateDesc+"</option>")	
		}
		</script>
		</select>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Role</Td>
		<Td width=50%>
		<select name="Role1">
		<option value="-">--Select--</option>
		<script>
			for(var i=0;i<roles.length;i++)
			{
				document.write("<option value="+roles[i].roleNumber+">"+roles[i].roleDesc+"</option>")	
			}
		</script>
		</select>
		</Td>
	</Tr>
</Table>
</span>
<span id="span6" style="visibility:hidden;display:none">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>

	<Tr>
		<Td align=right class=labelcell width=50%>Template</Td>
		<Td width=50%>
		<select name="Template2">
		<option value="-">--Select--</option>
		<script>
		for(var i=0;i<templates.length;i++)
		{
			document.write("<option value="+templates[i].templateCode+">"+templates[i].templateDesc+"</option>")	
		}
		</script>
		</select>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>GroupId</Td>
		<Td width=50%>
		<select name="GroupId1">
		<option value="-">--Select--</option>
		<script>
		for(var i=0;i<groups.length;i++)
		{
			document.write("<option value="+groups[i].groupCode+">"+groups[i].groupDesc+"</option>")	
		}
		</script>
		</select>
		</Td>
	</Tr>

	
</Table>
</span>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>	
 
	<Tr>
		<Td align=right class=labelcell width=50%>Duration</Td>
		<Td width=50%><input type=text class = "InputBox" size=18  name=Duration maxlength="20" value="<%=detailsRet.getFieldValue("DURATION")%>"></Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Type</Td>
		<Td width=50%>
		<select name=Type>
		<option value="-">--Select--</option>
		<option value="A">Absolute</option>
		<option value="R">Relative</option>
		</select>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Move</Td>
		<Td width=50%>
		<%
		   String move=detailsRet.getFieldValueString("ESCMOVE");
		   if(move.startsWith("-"))
		   {
		   	String sign=move.substring(0,1);
		   	String num=move.substring(1,move.length());
		   %>
			<input type=radio name="MoveSign" value="">Up &nbsp;<input type=radio name="MoveSign" value="-" checked>Down <br>
			<input type=text class = "InputBox" size=18  name=MoveCount maxlength="6" value="<%=num%>"></Td>
		  <%}else{%>	
			<input type=radio name="MoveSign"  value="" checked>Up &nbsp;<input type=radio name="MoveSign" value="-">Down <br>
			<input type=text class = "InputBox" size=18  name=MoveCount maxlength="6" value="<%=move%>"></Td>
		   <% } %>	
			
	</Tr>
</Table>
<br>
<input type="hidden" name="Code" value="<%=detailsRet.getFieldValue("CODE")%>">
<center>
<input type=image src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();setDefaultValues()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>

<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAddRoleConditions.jsp" %>
<jsp:useBean id="ArmsManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" />
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>										    
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>											    
<script>

function openDelWin()
{
	var Level 	= document.myForm.delegatLevel.value;
	if(Level == "")
		Level = "-";
	var srcLevel 	= document.myForm.srcHiddenDel.value;	
	if(srcLevel == "")
		srcLevel = "-";
	
	var dstLevel 	= document.myForm.dstHiddenDel.value;
	if(dstLevel == "")
		dstLevel = "-";
	
	var windowURL = "ezSelectDelegators.jsp?Level="+Level+"&delSrcLevel="+srcLevel+"&delDstLevel="+dstLevel
	window.showModalDialog(windowURL,window.self,'center:yes;dialogWidth:30;dialogHeight:20;status:no;minimize:no;close:no;')
}

function openBypassWin()
{
	var template = document.myForm.template.value
	var srcLevel = document.myForm.srcLevel.value
	var dstLevel = document.myForm.dstLevel.value	
	window.showModalDialog("ezSelectBypass.jsp?template="+template+"&srcLevel="+srcLevel+"&dstLevel="+dstLevel,window.self,'center:yes;dialogWidth:25;dialogHeight:15;status:no;minimize:no;close:no;')
}

// To build the Dynamic list depending on Doc type

	function showList()
	{

		var divObj = document.getElementById("conditionList");
		var docTypeObj = document.myForm.doctype;
		
		var bypassDiv = document.getElementById("bypassCondition");
		bypassDiv.style.visibility="hidden";
		
		var dCon = document.getElementById("delegateCondition");
		dCon.style.visibility="hidden";

		
		
		if(docTypeObj!=null)
		{
			docTypeObjValue = docTypeObj.value;
			docTypeObjValue = funTrim(docTypeObjValue);
		}
		
		if(docTypeObjValue != 'D' && docTypeObjValue != 'B')
		{
			var listname= "";
			for(i=document.myForm.list.options.length;i>0;i--)
				document.myForm.list.options[i]=null;	
			document.myForm.list.options[0]=new Option("--Select--");
	
			if(document.myForm.doctype.selectedIndex==0)
			{
				divObj.style.visibility="hidden";
				return;
			}
	
			if('R'==docTypeObjValue)
			{
				listname = "Roles List*";
	<%	
				int retRolesCount = 0;
				ReturnObjFromRetrieve retRoles  = null;
				EzcParams inParams = new EzcParams(false);
				Session.prepareParams( inParams );
				try
				{
					retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );
				}
				catch(Exception e)
				{
					System.out.println("Exception Occured in ezAddRoleConditions.jsp"+e);
				}
				if(retRoles!=null)
					retRolesCount = retRoles.getRowCount();
	
	
				for(int i=0;i<retRolesCount;i++)
				{
	%>
					document.myForm.list.options[<%=i+1%>]=new Option([<%=i%>]);
					document.myForm.list.options[<%=i+1%>].value="<%=retRoles.getFieldValueString(i,"ROLE_NR")%>";
					document.myForm.list.options[<%=i+1%>].text="<%=retRoles.getFieldValueString(i,"DESCRIPTION")%>";
	
	<%		
				}
	%>	
			}
			if('T'==docTypeObjValue)
			{
				listname = "Templates List*";
	<%
				int templateRetCount = 0;
				ezc.ezparam.ReturnObjFromRetrieve templateRet = null;		
				ezc.ezparam.EzcParams templateParams = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziTemplateCodeParams templateCodeParams= new ezc.ezworkflow.params.EziTemplateCodeParams();
				mainParams.setObject(templateCodeParams);
				Session.prepareParams(templateParams);
				try
				{
					templateRet = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(templateParams);
				}
				catch(Exception e)
				{
					System.out.println("Exception Occured in iAddRoleConditions.jsp"+e);	
				}
				if(templateRet!=null)
					templateRetCount = templateRet.getRowCount();
	
				for(int i=0;i<templateRetCount;i++)
				{
	%>
					document.myForm.list.options[<%=i+1%>]=new Option([<%=i%>]);
					document.myForm.list.options[<%=i+1%>].value="<%=templateRet.getFieldValueString(i,"TCODE")%>";
					document.myForm.list.options[<%=i+1%>].text="<%=templateRet.getFieldValueString(i,"DESCRIPTION")%>";
	<%		
				}
	%>

			}
			if('A'==docTypeObjValue)
			{
				listname = "Actions List*";
	<%
				ezc.ezparam.ReturnObjFromRetrieve actListRet = null;
				ezc.ezparam.EzcParams actMainParams = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziActionsParams actParams= new ezc.ezworkflow.params.EziActionsParams();
				actMainParams.setObject(actParams);
				Session.prepareParams(actMainParams);
				try
				{
					actListRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getActionsList(actMainParams);
				}
				catch(Exception e)
				{
					System.out.println("Exception Occured in iAddRoleConditions.jsp"+e);	
				}
				int actCount = 0;
				if(actListRet!=null)
					actCount = actListRet.getRowCount();
				for(int a=0;a<actCount;a++)
				{
	%>
					document.myForm.list.options[<%=a+1%>]=new Option('<%=actListRet.getFieldValueString(a,"DESCRIPTION")%>','<%=actListRet.getFieldValueString(a,"CODE")%>');
					
	<%
				}
		
	%>
			}

			// To get list name dynamically
			
			var textDiv = document.getElementById("listText");
			textDiv.innerHTML = listname;
			divObj.style.visibility="visible";
		}	
		else
		{
			if(docTypeObjValue == 'B')
			{
				bypassDiv.style.visibility="visible";
				divObj.style.visibility="hidden";
			}
			if(docTypeObjValue == 'D')
			{
				bypassDiv.style.visibility="hidden";
				dCon.style.visibility="visible";
			}
			
		}	
	}
	
// End of building dynamical List

 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
	FieldNames[0]="desc";
	CheckType[0]="MNull";
	Messages[0]="Please enter Description";
	FieldNames[1]="result";
	CheckType[1]="MNull";
	Messages[1]="Please enter Result";

	if(document.myForm.authKey.selectedIndex==0)
	{
		alert("Please select authkey")
		document.myForm.authKey.focus();
		return false
	}
	if(document.myForm.busDomain.selectedIndex==0)
	{
		alert("Please select Bus Domain")
		document.myForm.busDomain.focus();
		return false
	}
	if(document.myForm.doctype.selectedIndex==0)
	{
		alert("Please select Doc Type")
		document.myForm.doctype.focus();
		return false
	}
	
	if(document.myForm.list.selectedIndex==0)
	{
		alert("Please select List")
		document.myForm.list.focus();
		return false
	}
	
	var attLen=document.myForm.len.value
	var flag=false
	for(i=0;i<attLen;i++)
	{
		var attObj=eval("document.myForm.attribute"+i);
		if(attObj.selectedIndex != 0)
		{
			flag=true
			var val1=(eval("document.myForm.attribute"+i)).value
			val1=val1.substring(val1.lastIndexOf(",")+1,val1.length);
			if(val1=="Number")
			{
				var val2=(eval("document.myForm.fType"+i)).value
				var t1=eval("document.myForm.txt"+i+"0")
				var t2=eval("document.myForm.txt"+i+"1")
				if(t1.value=="" || isNaN(t1.value) )
				{
					alert("Please enter number");
					t1.focus();
					return false;
				}
				if(val2 == "BN")
				{
					if(t2.value=="" || isNaN(t2.value))
					{
						alert("Please enter number")
						t2.focus()
						return false
					}	
				}
			}
			if(val1=="String")
			{
				var t=eval("document.myForm.txt"+i+"0")
				var t1=t.value
				if(t1.indexOf("'")>=0 || t1.indexOf("\"")>=0)
				{
					alert(" ' and \" are invalid characters")
					t.focus()
					return false
				}
			}
		}	
	}
	if(!flag)
	{
		alert("Please select atleast one attribute");
		document.myForm.attribute0.focus()
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
function setTypes(ind)
{
	var attObj=eval("document.myForm.attribute"+ind)
	var typeObj=eval("document.myForm.fType"+ind)
	
	
	for(i=typeObj.length-1;i>=0;i--)
	{
		typeObj.options[i]=null
	}
	var val=attObj.value
	var actionVal = val.substring(0,val.indexOf(",")-1)
	var typeVal= val.substring(val.lastIndexOf(",")+1,val.length)

	if(typeVal=="String")
	{
		
		typeObj.options[0]=new Option("Contains","CN");
		typeObj.options[1]=new Option("Starts With","SW");
		typeObj.options[2]=new Option("Ends With","EW");
		typeObj.options[3]=new Option("Equals","EQ");
		
		var txtObj1=document.getElementById("txt"+ind+"0")
		txtObj1.style.visibility="visible"
		txtObj1.readOnly=false
		var txtObj2=document.getElementById("txt"+ind+"1")
		txtObj2.style.visibility="hidden"
		
		var img1=document.getElementById("img1"+ind);
		img1.style.visibility="hidden"
		var img2=document.getElementById("img2"+ind);
		img2.style.visibility="hidden"	
	}
	else if(typeVal=="Number")
	{
		typeObj.options[0]=new Option("Between","BN");
		typeObj.options[1]=new Option(">","GT");
		typeObj.options[2]=new Option("<","LT");
		typeObj.options[3]=new Option(">=","GE");
		typeObj.options[4]=new Option("<=","LE");
		typeObj.options[5]=new Option("=","EQ");
		
		var txtObj1=document.getElementById("txt"+ind+"0")
		txtObj1.style.visibility="visible"
		txtObj1.readOnly=false
		var txtObj2=document.getElementById("txt"+ind+"1")
		txtObj2.style.visibility="visible"
		txtObj2.readOnly=false
	
		var img1=document.getElementById("img1"+ind);
		img1.style.visibility="hidden"
		var img2=document.getElementById("img2"+ind);
		img2.style.visibility="hidden"	
	}
	else if(typeVal=="Date")
	{
		typeObj.options[0]=new Option("Between","BN");
		typeObj.options[1]=new Option("On","ON");
		typeObj.options[2]=new Option("Before","BF");
		typeObj.options[3]=new Option("After","AF");
		typeObj.options[4]=new Option("On or Before","OB");
		typeObj.options[5]=new Option("On or After","OA");
		
		var txtObj1=document.getElementById("txt"+ind+"0")
		txtObj1.style.visibility="visible"
		txtObj1.readOnly=true
		var txtObj2=document.getElementById("txt"+ind+"1")
		txtObj2.style.visibility="visible"
		txtObj2.readOnly=true
		
		var img1=document.getElementById("img1"+ind);
		img1.style.visibility="visible"
		var img2=document.getElementById("img2"+ind);
		img2.style.visibility="visible"
		
	}
	else
	{
		typeObj.options[0]=new Option("--Select--","--Select--");
	}
	
	
	var docTypeObj = document.myForm.doctype;
	var docTypeObjValue = ""
	if(docTypeObj!=null)
		docTypeObjValue = docTypeObj.value;		
	else
		docTypeObjValue = ""

	//if(docTypeObjValue == 'D' && typeVal=="String" && actionVal == '10009')
	//	document.getElementById("selDelegate_"+ind).style.visibility='visible'
	//else
	//	document.getElementById("selDelegate_"+ind).style.visibility='hidden'
	
	
	
	
}
function setSecFld(ind)
{
	var typeObj=eval("document.myForm.fType"+ind)
	var txtObj=document.getElementById("txt"+ind+"1")
	if(typeObj.value=="BN")
	{
		txtObj.style.visibility="visible"
		txtObj.readOnly=false
		var img1=document.getElementById("img1"+ind);
		if(img1.style.visibility=="visible")
		{
			txtObj.readOnly=true
			var img2=document.getElementById("img2"+ind);
			img2.style.visibility="visible"
		}
	
	}	
	else
	{
		txtObj.style.visibility="hidden"
		var img2=document.getElementById("img2"+ind);
		img2.style.visibility="hidden"
	}	
}
</script>
</head>
<body onLoad="document.myForm.desc.focus();">
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveRoleConditions.jsp')">

<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Add Conditions</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		
		<Td align=right class=labelcell >Description*</Td>
		<Td colspan=3><input type=text class = "InputBox" style="width:100%"  name=desc maxlength="255"></Td>
		
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Auth Key*</Td>
		<Td ><div id="ListBoxDiv1">
		<select name=authKey id=ListBoxDiv>
			<option>--Select--</option>
<%
		int authCnt=ret.getRowCount();
		for(int i=0;i<authCnt;i++)
		{
%>
			<option value="<%=ret.getFieldValue(i,AUTH_KEY)%>"><%=ret.getFieldValue(i,AUTH_DESC)%></option>
<%
		}
%>
			</select></div>
		</Td>
	
		<Td align=right class=labelcell >Result*</Td>
		<Td ><input type=text class = "InputBox" size=18  name=result maxlength="255"></Td>
	</Tr>
	</Table>
	
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
	
		<Td align=right class=labelcell width="10%">Bus Domain*</Td>
		<Td width="20%">
			<select name=busDomain id=ListBoxDiv style="width:100%">
				<option value="">--Select--</option>
				<option value="S">Sales</option>
				<option value="V">Vendor</option>
				<option value="E">Service</option>
				<option value="A">Admin</option>
			</select>
		</Td>
		<Td width="10%" align=right class=labelcell >DocType*</Td>
		<Td width="20%">
			<select name=doctype id=ListBoxDiv onChange="showList()" style="width:100%">
				<option value="">--Select--</option>
				<option value="A">Action</option>
				<option value="B">ByPass</option>
				<option value="D">Delegation</option>
				<option value="R">Role</option>
				<option value="T">Template</option>
			</select>
		</Td>
		<Td>
		<Div id="conditionList" style="position:absolute;align:center;visibility:hidden;top:97">
			<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=100%>
			<tr>
			<Td id="listText" align=right class=labelcell width="10%"></Td>
			<Td width="20%">
				<select name=list id=ListBoxDiv style="width:100%">
				</select>
			</Td>
			</tr>
			</table>
		</Div>
		<Div id="bypassCondition" style="position:absolute;align:center;visibility:hidden;top:97">
			<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=100%>
			<tr>
			<Td align=center>
				<a href='javascript:openBypassWin()'>ByPass Approvers</a>
				<input type=hidden name='template' value=''>
				<input type=hidden name='srcLevel' value=''>
				<input type=hidden name='dstLevel' value=''>
				<input type=hidden name='direction' value=''>
			</Td>
			</tr>
			</table>
		</Div>

		<Div id="delegateCondition" style="position:absolute;align:center;visibility:hidden;top:97">
			<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=100%>
			<tr>
			<Td align=center>
				<a href='javascript:openDelWin()'">Select Delegate Approvers</a>
				<input type=hidden name='delegatLevel' value=''>
				<input type=hidden name='srcHiddenDel' value=''>
				<input type=hidden name='dstHiddenDel' value=''>
			</Td>
			</tr>
			</table>
		</Div>
		</Td>
	</Tr>
</Table>
	
	
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td align=center class=labelcell >Attribute</Td>
		<Td align=center class=labelcell colspan=2>Condition</Td>
		<Td align=center class=labelcell>AND  OR</Td>
	</Tr>
<%
	int attCnt=listRet.getRowCount();
	int attribLength=6;
	for(int k=0;k<attribLength;k++)	
	{
%>
	<Tr>
		<Td><select name=attribute<%=k%> onChange="setTypes(<%=k%>)" id=ListBoxDiv>
			<option value="sel">--Select--</option>
<%
		
		for(int i=0;i<attCnt;i++)
		{
%>
			<option value="<%=listRet.getFieldValue(i,"ATTRIBUTE")%>,<%=listRet.getFieldValue(i,"DESCRIPTION")%>,<%=listRet.getFieldValue(i,"TYPE")%>"><%=listRet.getFieldValue(i,"DESCRIPTION")%></option>
<%
		}
%>
		</select>
		</Td>
		<Td><select name=fType<%=k%> onChange="setSecFld(<%=k%>)" id=ListBoxDiv>
			<option>--Select--</option>
		</select>
		</Td>
		<Td>
			
			<input type=text class = "InputBox" name="txt<%=k%>0" size=10 style="visibility:visible">
			<img id=img1<%=k%> src="../../Images/calendar.gif" onClick="showCal('document.myForm.txt<%=k%>0',100,400)" style="cursor:hand;visibility:hidden">
			<input type=text class = "InputBox" name="txt<%=k%>1" size=10 style="visibility:visible">
			<img id=img2<%=k%> src="../../Images/calendar.gif" onClick="showCal('document.myForm.txt<%=k%>1',100,400)" style="cursor:hand;visibility:hidden">
		</Td>
		<Td align=center>
			<input type=radio name=chk<%=k%> value="AND" checked>
			<input type=radio name=chk<%=k%> value="OR">
		</Td>
	</Tr>
<%
	}
%>

</Table>
		<input type=hidden name=len value="<%=attribLength%>">
		<input type=hidden name=role value="<%=roleId%>">
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
</html>

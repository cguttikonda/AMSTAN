<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="ArmsManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" />
<%@ include file="../../../Includes/JSPs/WorkFlow/iEditRoleConditions.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script>

	// This block is to build List option dynamically
	function openBypassWin(template,srcLevel,dstLevel)
	{
		template = template.split("¥")
		window.showModalDialog("ezSelectBypass.jsp?template="+template[0]+"&srcLevel="+srcLevel+"&dstLevel="+dstLevel,window.self,'center:yes;dialogWidth:25;dialogHeight:15;status:no;minimize:no;close:no;')
	}
	
	function openDelWin(lineIndex)
	{
		var txtObj=document.getElementById("txt"+lineIndex+"0")
		if(txtObj.value == null || txtObj.value == "")			    
		{								    
			alert("Please enter the Role")			    
			txtObj.focus();
		}
		else
		{
			var Level = "";
			var levelObj = 	eval("document.myForm.delegatLevel"+lineIndex)	
			if(levelObj != null)
				Level = levelObj.value;
			var srcLevel = "";	
			levelObj = 	eval("document.myForm.srcHiddenDel"+lineIndex)
			if(levelObj != null)
				srcLevel = levelObj.value;
			var dstLevel = "";	
			levelObj = 	eval("document.myForm.dstHiddenDel"+lineIndex)
			if(levelObj != null)
				dstLevel = levelObj.value;

			window.showModalDialog("ezSelectDelegators.jsp?lineIndex="+lineIndex+"&actionRole="+txtObj.value+"&Level="+Level+"&delSrcLevel="+srcLevel+"&delDstLevel="+dstLevel,window.self,'center:yes;dialogWidth:30;dialogHeight:20;status:no;minimize:no;close:no;')
		}	
	}	
	
	function showList()
	{

		var divObj = document.getElementById("conditionList");
		var docTypeObj = document.myForm.doctype;
		
		var bypassDiv = document.getElementById("bypassCondition");
		bypassDiv.style.visibility="hidden";
		
		if(docTypeObj!=null)
		{
			docTypeObjValue = docTypeObj.value;
			docTypeObjValue = funTrim(docTypeObjValue);
		}
		
		

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
					if("<%=listStr%>"=="<%=retRoles.getFieldValueString(i,"ROLE_NR").trim()%>")
					{
						document.myForm.list.options.selectedIndex= <%=i+1%>
					}	
		<%		
				}
		%>	
			}
			if('D'==docTypeObjValue)
			{
				listname = "Delegations List*";
		<%
				int delegationRetCount = 0;
				ezc.ezparam.ReturnObjFromRetrieve delegationRet=null;
				ezc.ezparam.EzcParams delegationParams = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziRoleConditionsParams roleConditionsParams= new ezc.ezworkflow.params.EziRoleConditionsParams();
				delegationParams.setObject(roleConditionsParams);
				Session.prepareParams(delegationParams);
				try
				{
					delegationRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getDelegationsList(delegationParams);
				}
				catch(Exception e)
				{
					System.out.println("Exception Occured in iAddRoleConditions.jsp"+e);
				}
				if(delegationRet!=null)
					delegationRetCount = delegationRet.getRowCount();

				for(int i=0;i<delegationRetCount;i++)
				{
		%>
					document.myForm.list.options[<%=i+1%>]=new Option([<%=i%>]);
					document.myForm.list.options[<%=i+1%>].value="<%=delegationRet.getFieldValueString(i,"DELEGATIONID")%>";
					document.myForm.list.options[<%=i+1%>].text="<%=delegationRet.getFieldValueString(i,"DELEGATIONID")%>";
					if("<%=listStr%>"=="<%=delegationRet.getFieldValueString(i,"DELEGATIONID")%>")
						document.myForm.list.options.selectedIndex= <%=i+1%>

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
					if("<%=listStr%>"=="<%=templateRet.getFieldValueString(i,"TCODE")%>")
						document.myForm.list.options.selectedIndex= <%=i+1%>

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
				for(int i=0;i<actCount;i++)
				{
		%>
					document.myForm.list.options[<%=i+1%>]=new Option([<%=i%>]);
					document.myForm.list.options[<%=i+1%>].value="<%=actListRet.getFieldValueString(i,"CODE")%>";
					document.myForm.list.options[<%=i+1%>].text="<%=actListRet.getFieldValueString(i,"DESCRIPTION")%>";
					if("<%=listStr%>"=="<%=actListRet.getFieldValueString(i,"CODE").trim()%>")
						document.myForm.list.options.selectedIndex= <%=i+1%>


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
			divObj.style.visibility="hidden";
			if(docTypeObjValue == 'B')
				bypassDiv.style.visibility="visible";
		}	
		
	}
	
// End of building dynamical List


	function EzDomain(code,desc)
	{
		this.code	= code;
		this.desc	= desc;
	}

	busDomain = new Array();
	docType	  =  new Array();
	
      	busDomain[0]  = new EzDomain("S","Sales");
	busDomain[1]  = new EzDomain("V","Vendor");
	busDomain[2]  = new EzDomain("A","Admin");
	busDomain[3]  = new EzDomain("E","Service");

      	docType[0]  = new EzDomain("T","Templates");
	docType[1]  = new EzDomain("R","Roles");
	docType[2]  = new EzDomain("D","Delegations");
	docType[3]  = new EzDomain("A","Actions");
	docType[4]  = new EzDomain("B","ByPass");

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

	if(docTypeObjValue == 'D' && typeVal=="String" && actionVal == '10009')
		document.getElementById("selDelegate_"+ind).style.visibility='visible'
	else
		document.getElementById("selDelegate_"+ind).style.visibility='hidden'
	
	
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

function setDefaults()
{	     
	for(i=0;i<document.myForm.authKey.length;i++)
	{
		if(document.myForm.authKey.options[i].value=="<%=detailsRet.getFieldValue(0,"AUTHKEY")%>")
			document.myForm.authKey.options[i].selected=true;
	}
	<%
		int cnt=masterRet.getRowCount();
		for(int i=0;i<cnt;i++)
		{
	%>
			var listObj=eval("document.myForm.attribute<%=i%>")
			for(k=0;k<listObj.length;k++)
			{
				var val=listObj.options[k].value
				if(val.substring(0,val.indexOf(",")) == "<%=masterRet.getFieldValueString(i,"ATTRIBUTE")%>")
				{
					listObj.options[k].selected=true
					setTypes(<%=i%>)
				}	
			}
			var tObj=eval("document.myForm.fType<%=i%>");
			for(k=0;k<tObj.length;k++)
			{
				if(tObj.options[k].value=="<%=masterRet.getFieldValue(i,"CONDOPERATOR")%>")
				{
					tObj.options[k].selected=true
					setSecFld(<%=i%>)
				}
			}
			
			var txt1=eval("document.myForm.txt<%=i%>0")
			txt1.value="<%=masterRet.getFieldValue(i,"VALUE1")%>"
			if("<%=masterRet.getFieldValue(i,"VALUE2")%>" != null)
			{
				var txt2=eval("document.myForm.txt<%=i%>1")
				txt2.value="<%=masterRet.getFieldValue(i,"VALUE2")%>"
			}
	<%
			if(i < cnt-1)
			{
	%>
				var chk=eval("document.myForm.chk<%=i%>")
				if("<%=operators.elementAt(i)%>" == "AND")
					chk[0].checked=true
				else if("<%=operators.elementAt(i)%>" == "OR")	
					chk[1].checked=true
	<%
			}
		}
	%>
}

</script>
</head>
<body onLoad="document.myForm.desc.focus();setDefaults();showList()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveRoleConditions.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit Conditions for :<%=detailsRet.getFieldValueString(0,"CONDITION_ID")%></Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		
		<Td align=left class=labelcell >Description*</Td>
		<Td><input type=text class = "InputBox" size=18  name=desc maxlength="255" value="<%=detailsRet.getFieldValue(0,"DESCRIPTION")%>"></Td>
		<Td align=left class=labelcell colspan=2>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell >AuthKey*</Td>
		<Td ><select name=authKey id=ListBoxDiv>
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
			</select>
		</Td>
	
		<Td align=left class=labelcell >Result*</Td>
		<Td ><input type=text class = "InputBox" size=18  name=result maxlength="255" value="<%=detailsRet.getFieldValue(0,"RESULT")%>"></Td>
	</Tr>
	</Table>
	
	
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
	
		<Td align=right class=labelcell width="10%">Bus Domain*</Td>
		<Td width="20%">
			<select name=busDomain id=ListBoxDiv style="width:100%">
				<option value="">--Select--</option>
				<script>
					for(var i=0;i<busDomain.length;i++)
					{
						if(busDomain[i].code=="<%=busStr%>")
						{
							document.write('<Option value='+busDomain[i].code+' selected>'+busDomain[i].desc+'</Option>');
						}
						else
						{
							document.write('<Option value='+busDomain[i].code+'>'+busDomain[i].desc+'</Option>');
						}
					}
				</script>	
			</select>
		</Td>
		<Td width="10%" align=right class=labelcell >Doc Type*</Td>
		<Td width="20%">
			<select name=doctype id=ListBoxDiv onChange="showList()" style="width:100%">
				<option value="">--Select--</option>
				<script>
					for(var i=0;i<docType.length;i++)
					{
						if(docType[i].code=="<%=docStr%>")
						{
							document.write('<Option value='+docType[i].code+' selected>'+docType[i].desc+'</Option>');
						}
						else
						{
							document.write('<Option value='+docType[i].code+'>'+docType[i].desc+'</Option>');
						}
					}
				</script>	
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
				<a href='javascript:openBypassWin("<%=template%>",<%=srcLevel%>,<%=dstLevel%>)'>ByPass Approvers</a>
				<input type=hidden name='template' value='<%=template%>'>
				<input type=hidden name='srcLevel' value='<%=srcLevel%>'>
				<input type=hidden name='dstLevel' value='<%=dstLevel%>'>
				<input type=hidden name='direction' value='<%=direction%>'>
				<input type=hidden name='byPassCode' value='<%=byPassCode%>'>
				
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
			<a href='javascript:openDelWin(<%=k%>)' id='selDelegate_<%=k%>' style="visibility='hidden'">select</a>
			<input type=hidden name='delegatLevel<%=k%>' value='<%=direction%>'>
			<input type=hidden name='srcHiddenDel<%=k%>' value='<%=srcLevel%>'>
			<input type=hidden name='dstHiddenDel<%=k%>' value='<%=dstLevel%>'>
			
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
		<input type=hidden name=rule value="<%=ruleId%>">
		<input type=hidden name='delIndex'>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();setDefaults()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
</html>
 

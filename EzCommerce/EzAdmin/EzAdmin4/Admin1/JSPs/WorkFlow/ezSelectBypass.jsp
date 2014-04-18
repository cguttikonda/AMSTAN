<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeList.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iBypassTemplateStepsList.jsp" %>
<Html>
<Head>
	<Title>Bypassing Condition</Title>
	<base target='_self'>
	<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
	<Script src="../../Library/JavaScript/WorkFlow/ezSelectBypass.js"></Script>
</Head>
<body onLoad='fillDefaults()'>
	<form name='myForm'>
	<Br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=70%>
	<Tr>
			<Th align='center'>Add Bypass Condition</Th>
	</Tr>
	</Table>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=70%>
	<Tr>
			<Th width=30% align='left'>Template*</Th>
			<Td>
			<select name='template' style='width:100%' onchange='fillTemplateSteps()'>
				<option value='-'>--Select--</option>
			<%
				String selected = "";
				for(int i=0;i<listCount;i++)
				{
					if(tCode.equals(listRet.getFieldValueString(i,"TCODE")))
						selected = "selected";
					else
						selected = "";
			%>
					<option value='<%=listRet.getFieldValueString(i,"TCODE")%>' <%=selected%>><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>
			<%
				}
			%>
			</select>
			</Td>		
	</Tr>
	<Tr>
		<Th width=30% align='left'>Source Step*</Th>
		<Td>
		<select name='srcLevel' style='width:100%'>
			<option value='-'>--Select--</option>
			<%
				for(int i=0;i<listBypassCount;i++)
				{
					if(sourceStep.equals(listBypassRet.getFieldValueString(i,"STEP")))
						selected = "selected";
					else
						selected = ""; 
			%>
					<option value='<%=listBypassRet.getFieldValueString(i,"STEP")%>' <%=selected%>><%=listBypassRet.getFieldValueString(i,"OWNERPARTICIPANT")%></option>
			<%
				}
			%>			
		</select>
		</Td>
	</Tr>
	<Tr>
		<Th width=30% align='left'>Destination Step*</Th>
		<Td>
		<select name='dstLevel' style='width:100%' >
			<option value='-'>--Select--</option>
			<%
				for(int i=0;i<listBypassCount;i++)
				{
					if(sourceStep.equals(listBypassRet.getFieldValueString(i,"STEP")))
						selected = "selected";
					else
						selected = ""; 
			%>
					<option value='<%=listBypassRet.getFieldValueString(i,"STEP")%>' <%=selected%>><%=listBypassRet.getFieldValueString(i,"OWNERPARTICIPANT")%></option>
			<%
				}
			%>			
			
		</select>
		</Td>		
	</Tr>
	<!--
	<Tr>
		<Th width=30% align='left'>Direction *</Th>
		<Td>
		<select name='direction' style='width:100%' >
			<option value='-'>--Select--</option>
			<option value='B'>Backward</option>
			<option value='F'>Forward</option>
		</select>
		</Td>		
	</Tr>
	-->
	<input type=hidden name='direction' value='F'>
	</Table>

	<Div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
	<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width=60%>
	<Tr>
	<Td align='center' class='blankcell'><input type=image  src=../../Images/Buttons/<%= ButtonDir%>/ok.gif  alt="Click Here To Select" border=no onClick="saveSelected()"></Td>
	<Td align='center' class='blankcell'><input type=image  src=../../Images/Buttons/<%= ButtonDir%>/close.gif  alt="Click Here To Close" border=no onClick="window.close()"></Td>
	</Tr>
	</Table>
	</Div>

	
	</form>
</dody>
</Html>
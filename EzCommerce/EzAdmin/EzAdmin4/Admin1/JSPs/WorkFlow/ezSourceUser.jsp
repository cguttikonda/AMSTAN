<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateStepsListForDeligations.jsp"%>
<Html>
<Head>
<meta name="author"  content="kp">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
	function checkOption()
	{
		opener.document.myForm.srcUser.value="MGR1"
		window.close()
	}
	function setReload()
	{
		document.myForm.submit()
		document.myForm.action="ezSourceUser.jsp"
	}
	
	function setSelected()
	{
		for(i=0;i<document.myForm.uType.length;i++)
		{
			if(document.myForm.uType.options[i].value=="<%=uType%>")
				document.myForm.uType.options[i].selected=true
		}
		for(i=0;i<document.myForm.WebSysKey.length;i++)
		{
			if(document.myForm.WebSysKey.options[i].value=="<%=sysKey%>")
				document.myForm.WebSysKey.options[i].selected=true
		}
		if("SourceUser"=="<%=formObj%>")
		{
			for(i=0;i<document.myForm.templateStep.length;i++)
			{
				if(document.myForm.templateStep.options[i].value=="<%=tSteps%>")
					document.myForm.templateStep.options[i].selected=true
			}
		}	
	}
	
	function setUser()
			{
				var user="";
				var len=document.myForm.chk1.length;
				if(isNaN(len))
				{
					user=document.myForm.chk1.value
				}
				else
				{
					for(i=0;i<len;i++)
					{
						if(document.myForm.chk1[i].checked)
							user=document.myForm.chk1[i].value
					}
				}
				
				if("SourceUser"=="<%=formObj%>")
					opener.document.myForm.SourceUser.value=user
				else
				if("DestUser"=="<%=formObj%>")
					opener.document.myForm.DestUser.value=user
					
				window.close();		
		}
</script>
</head>
<body  onLoad="scrollInit();setSelected()" onResize="scrollInit()" >

<form name=myForm method=post onSubmit="return checkOption()">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class="displayheader" align=center colspan=2>Select Source User</Td>
	</Tr>
	<Tr>
		<Td align=left class=labelcell width=50%>User Type*</Td>
		<Td width=50%><select name=uType onChange="setReload()">
			<option>--Select--</option>
			
			<option value="V">Vendor</option>
			<option value="C">Sales</option>
			<option value="S">Service</option>
			
			</select>
		</Td>
	<Tr>
	<Tr>
			<Td align=left class=labelcell width=50%><%=areaLabel%>*</Td>
			<Td width=50%><select name=WebSysKey  onChange="setReload()"> 
			<option value="sel">--Select--</option>
			<option value="All">All</option>
<%
		if(areaRet != null)
		{
			int sysCount=areaRet.getRowCount();
			for(int i=0;i<sysCount;i++)
			{
%>
				<option value="<%=areaRet.getFieldValue(i,SYSTEM_KEY)%>" > <%=areaRet.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%
			}
		}	
%>


				</select>
		</Td>
	</Tr>
		<%	
			if(!("DestUser".equals(formObj)))	
			{
		%>
			<Tr>
				<Td align=left class=labelcell width=50%>TemplateSteps*</Td>
				<Td width=50%>
				<select name=templateStep>
				<option value="sel">--Select--</option>
		<%
				for(int i=0;i<listTSRet.getRowCount();i++)
				{
		%>
				<option value="<%=listTSRet.getFieldValue(i,"TCODE")%>" > <%=listTSRet.getFieldValue(i,"STEP_DESC")%> </option>
		<%
				}
		%>
				</select>
		</Td>
			</Tr>
		<%
			}
		%>

	</Table><br>
<%
		if(areaRet == null)
		{
%>
			<Center>
			<Br><Br><Span class=nolabelcell> Please Select User Type</Span></center>
<%
		}
		else
		{
		    if(areaRet.getRowCount()==0)
		    {
%>
			<Center>
			<Br><Br><Span class=nolabelcell> No <%=areaLabel%> To List</Span></center>
<%
		    }
		    else
		    {
			if(usersRet==null)
			{
%>			
				<Center>
				<Br><Br><Span class=nolabelcell> Please Select <%=areaLabel%></Span></center>
<%				
			}
			else
			{
			    if(usersRet.getRowCount()==0)
			    {
%>
				<Center>
				<Br><Br><Span class=nolabelcell> No Users To List in Selected <%=areaLabel%></Span></center>	
<%
			    }
			    else
			    {
%>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
				<Tr>
					<Td colspan=2 align=center class=displayheader>Select User</Td>
				</Tr>
<%				
			    	int userCount=usersRet.getRowCount();
				for(int i=0;i<userCount;i++)
				{
%>
					<Tr>
<%
					if(i==0)
					{
%>			
						<Td align=center><input type=radio name=chk1 value="<%=usersRet.getFieldValue(i,USER_ID)%>" checked></Td>
<%
					} else {
%>
						<Td align=center><input type=radio name=chk1 value="<%=usersRet.getFieldValue(i,USER_ID)%>"></Td>
<%
					}
%>
						<Td><%=usersRet.getFieldValue(i,USER_FIRST_NAME) %><!-- <%=usersRet.getFieldValue(i,USER_MIDDLE_INIT) %> <%= usersRet.getFieldValue(i,USER_LAST_NAME) %>--></Td>
					</Tr>
<%
				}
%>
				</Table>
			

				<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
					<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Add" style="cursor:hand" border=no onClick="javascript:setUser()">
					<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
				</div>
<%			    
			    }
			}    
		    }	
		}
%>
</form>
</body>
</html>

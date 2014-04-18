<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%
	String groupDesc = request.getParameter("groupDesc");
%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetArea.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetUsersByArea.jsp" %>  
<script>
function ezAlphabet(alphabet)
{
 	searchstring=alphabet+"*";
 	if(searchstring=="All*")
 		document.myForm.searchcriteria.value="";
 	else
 		document.myForm.searchcriteria.value=searchstring;
 	if(searchstring!=null)
 	{
 		if(searchstring.length!=0)
 		{
			if(document.myForm.area.selectedIndex != 0)
			{
				document.myForm.action="ezAddWorkGroupUsers.jsp?areaFlag=<%=areaFlag%>";
 				document.myForm.submit();
			}
			else
			{
				alert("Please Select <%=areaLabel%>.")
				document.myForm.area.focus()
			}
 		}
 	}
}
function chkAdd()
{
	chkLength=document.myForm.chk1.length
	if(!(isNaN(chkLength)))
	{
	      count=0;
		for(i=0;i<chkLength;i++)
		{
			if(document.myForm.chk1[i].checked)
			count=count+1
		}
	}
	else
	{
		count=0;
		if(document.myForm.chk1.checked)
			count=count+1;
	}

	if(count ==0)
	{
		alert("Please check checkbox(s) which you want to Add")
		return false;
	}
	else
	{
		return true;
	}
}
function funSubmit()
{
	if(document.myForm.groups.selectedIndex!=0)
	{
		alert("In Fun Submit")
		document.myForm.groupDesc.value = document.myForm.groups.options[document.myForm.groups.selectedIndex].text
		if(checkOption('ezAddSaveWorkGroupUsers.jsp'))
			return true
		else
			return false
	}
	else
	{
		alert("Please Select Work Group.")
		document.myForm.groups.focus();
		return false
	}
	return false
}

function funGetAreas()
{
	document.myForm.action="ezAddWorkGroupUsers.jsp?areaFlag=<%=areaFlag%>";
	document.myForm.submit();
}
function funGetUsers()
{
	if(document.myForm.area.selectedIndex!=0)
	{
 		//document.myForm.searchcriteria.value="A*";	
		document.myForm.action="ezAddWorkGroupUsers.jsp?areaFlag=<%=areaFlag%>";
		document.myForm.submit();
	}
	else
	{
		alert("Please Select UserArea");
		return false;
	}
}
 function checkOption(filename)
 {
	if(chkAdd())
	{
		document.myForm.action=filename
		return true;
	}
	else
	{
		return false;
	}
}
function checkAll()
{
	if(document.myForm.tochkall.checked)
	{
		var chkObj = document.myForm.chk1
		var chkObjLen =  document.myForm.chk1.length
		if(chkObj != null)
		{
			if(!isNaN(chkObjLen))
			{
				for(i=0;i<chkObjLen;i++)
				{
					chkObj[i].checked = true		
				}
			}
			else
			{
				chkObj.checked = true
			}
		}
	}
}
</script>
</head>
<body  onLoad="scrollInit();" onResize="scrollInit()" scroll="no" >
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveWorkGroupUsers.jsp')">
<input type = "hidden" name = "groupDesc" value = "<%=groupDesc%>">
<input type="hidden" name="groups" value="<%=grpid%>" >
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Add Users to the Work Group <%=groupDesc%> (<%=grpid%>)  </Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td width=20% align=left class=labelcell ><%=areaLabel%>:*</Td>
		<Td width=80%>
		<select name="area" style="width:100%" id=FullListBox onChange="funGetUsers()">
			<option value="sel">--Select <%=areaLabel%>--</option>
<%
		if(ret1!=null)
		{
			ret1.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
			for(int i=0;i<ret1.getRowCount();i++)
			{
					if(websyskey!=null)
					{
						if(websyskey.equals(ret1.getFieldValue(i,"ESKD_SYS_KEY")))
						{
%>
							<option value="<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>" selected><%=ret1.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>)</option>
<%
						}
						else
						{
%>
							<option value="<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=ret1.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>)</option>
<%
						}
					}
					else
					{
%>
							<option value="<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=ret1.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=ret1.getFieldValue(i,"ESKD_SYS_KEY")%>)</option>
<%
					}
			}
		}
%>
		</select>
		</Td>
	</Tr>
</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
	<td align = "center">
		<%@ include file="../../../Includes/Lib/WFAlphabetBean.jsp" %>
	</Td>
	</Tr>
	</Table>
	<input type="hidden" name="searchcriteria" value="$">
<%
	if(retUsers!=null && retUsers.getRowCount()==0 &&websyskey!=null && !websyskey.equals(""))
	{
%>
			<br><br><br>
				<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
				<Tr>
					<Th width="100%" align=center>
						No Users In This <%=areaLabel%>.
					</Th>
				</Tr>
			</Table>
			<br>
			<Center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
			<input type="hidden" name="groups" value="<%=grpid%>" >


<%
	return;
	}
%>
<%
	if(retUsers!=null && alphaTree.size()>0 )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          	mySearch.search(retUsers,"EU_FIRST_NAME",searchPartner.toUpperCase());
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && retUsers.getRowCount()==0)
		{
%>
			<br>
			<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader">
    		      			<div align="center">There are no Users to list with alphabet starts with "<%=searchPartner.substring(0,searchPartner.indexOf("*"))%>".</div>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
		}

	}
%>
<%
	if(retUsers!=null && retUsers.getRowCount()>0)
	{
	    retUsers.sort(new String[]{"EU_FIRST_NAME"},true);
	    if("IC".equals(groupType) || "IV".equals(groupType))
	    {
%>
		<Div id="theads">
		<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
		<Th class="displayheader" width="10%"><input type=checkbox name=tochkall onclick='checkAll()'></Th>
		<Th class="displayheader" width="45%">User</Th>
		<Th class="displayheader" width="45%">Name</Th>
		</Tr>
		</Table >
		</Div>

		<DIV id="InnerBox1Div">

		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
		int rowCount=retUsers.getRowCount();
		for(int i=0;i<rowCount;i++)
		{
%>
			<Tr>
			<label for="cb_<%=i%>">
				<Td width="10%"><input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=retUsers.getFieldValueString(i,"EU_ID")%>,<%=websyskey%>,0"></Td>
				<Td width="45%">
				<a href = "../User/ezViewIntranetUserData.jsp?UserID=<%=retUsers.getFieldValueString(i,"EU_ID")%>&WebSysKey=<%=websyskey%>">
				<%=retUsers.getFieldValueString(i,"EU_ID")%></a>
				</Td>
				<Td width="45%"><%=retUsers.getFieldValueString(i,"EU_FIRST_NAME")%>&nbsp;&nbsp;<%=retUsers.getFieldValueString(i,"EU_LAST_NAME")%></Td>
			</label>
			</Tr>
<%
		}
%>
		</Table>
		</div>
<%
	    }
	    else
	    {
%>
		<Div id="theads">
		<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
		<Th width="5%"><input type=checkbox name=tochkall onclick='checkAll()'></Th>
		<Th width="20%">User Id</Th>
		<Th width="40%">User Name</Th>
		<Th width="35%">SoldTo</Th>
		</Tr>
		</Table >
		</Div>

		<DIV id="InnerBox1Div">

		<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">

<%
		String user="";
		int retUserCount=retUsers.getRowCount();
		for(int i=0;i<retUserCount;i++)
		{
%>
		    <Tr>
		    	<label for="cb_<%=i%>">
			<Td width="5%">
				<input type=checkbox name=chk1 id="cb_<%=i%>" value="<%=retUsers.getFieldValueString(i,"EU_ID")%>,<%=retUsers.getFieldValue(i,"EC_SYS_KEY")%>,<%=retUsers.getFieldValue(i,"EC_ERP_CUST_NO")%>">
			</Td>
<%
		    if(! user.equals(retUsers.getFieldValueString(i,"EU_ID")))
		    {
			user=retUsers.getFieldValueString(i,"EU_ID");
%>
			<Td width="20%"><a href = "../User/ezUserDetails.jsp?UserID=<%=user%>&WebSysKey=<%=retUsers.getFieldValue(i,"EC_SYS_KEY")%>"><%=user%></a></Td>
			<Td width="40%">
			<%=retUsers.getFieldValueString(i,"EU_FIRST_NAME")%>&nbsp;&nbsp;<%=retUsers.getFieldValueString(i,"EU_LAST_NAME")%>
			</Td>
<%
		    } else {
%>
			<Td width="20%">&nbsp;</Td>
			<Td width="40%">&nbsp;</Td>
<%
		    }
%>
			<Td width="35%"><%=retUsers.getFieldValue(i,"ECA_NAME")%> (<%=retUsers.getFieldValue(i,"EC_ERP_CUST_NO")%>)</Td>

			  </label>
			</Tr>
<%
		}

%>

		</Table>
		</Div>
<%
	    }
%>
		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</Div>

<%
	}
	else
	{
%>
		<br><br><br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				Please Select <%=areaLabel%> To Continue.
			</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>			
		</center>
<%
	}
%>
</form>
</body>
</html>

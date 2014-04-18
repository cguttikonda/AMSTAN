<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetStepUsers.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%
	//String searchPartner=request.getParameter("searchcriteria");
%>
<html>
<head>
<Title>EzCommerce Administration Module -- Powered By EzCommerce Global Solutions Inc.</Title>
<script src="../../Library/JavaScript/WorkFlow/ezGetStepUsers.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/ezSortTableData.js"></script>
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
			if(document.myForm.sysKey.selectedIndex != 0)
			{
				document.myForm.action="ezGetStepUsers.jsp";
 				document.myForm.submit();
			}
			else
			{
				alert("Please Select Business Area.")
				document.myForm.sysKey.focus()
			}
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
	if("op"=="<%=formObj%>")
		opener.document.myForm.op.value=user
	else
	if("fyi"=="<%=formObj%>")
		opener.document.myForm.fyi.value=user

	window.close();
}
function reSub()
{
	if(document.myForm.sysKey.selectedIndex!=0)
	{
 		//document.myForm.searchcriteria.value="A*";
		document.myForm.action="ezGetStepUsers.jsp"
		document.myForm.submit()
	}
	else
	{
		alert("Please Select Business Area.")
		document.myForm.sysKey.focus()
	}
}
</script>
</head>
<body  bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="">
<input type="hidden" name="formObj" value="<%=formObj%>">
<input type="hidden" name="role" value="<%=role%>">
<br>
	<Table  align=center width=89% border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Td class=labelcell width = "20%"><nobr>Business Area</nobr></Td>
		<Td width = "80%">
			<select name=sysKey onChange = "reSub()" id = "ListBoxDiv" Style = "width:100%">
				<option value="">--Select Business Area--</option>
				<!-- option value="All">All</option -->
<%
			int sysCnt=ret.getRowCount();
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<sysCnt;i++)
			{
			    if((ret.getFieldValueString(i,SYSTEM_KEY)).equals(selSysKey))
			    {
%>
				<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>" selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
			    } else {
%>
				<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
			    }
			}
%>
			</select></div>
		</Td>
	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
	<td align = "center">
		<%@ include file="../../../Includes/Lib/WFAlphabetBean.jsp" %>
	</Td>
	</Tr>
	</Table>
	<input type="hidden" name="searchcriteria" value="$">
<%
	if(usersRet!=null && alphaTree.size()>0 )
	{
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          	mySearch.search(usersRet,USER_FIRST_NAME,searchPartner.toUpperCase());
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && usersRet.getRowCount()==0)
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
	if(usersRet == null)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Td class = "labelcell">
		        <div align="center"><b>Please Select Business Area.</b></div>
		    </Td>
				</Tr>
				</Table><br>
				<center>
					<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
				</center>
<%
	}
	else
	{
		int uCnt=usersRet.getRowCount();
		if(uCnt == 0)
		{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>No Users to List in Selected Business Area.</b></div>
		    		</Td>
			</Tr>
			</Table><br>
			<center>
				<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
			</center>
<%
		}
		else
		{
%>	
			<div id="theads" >
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th align="center" width="5%">&nbsp;</Th>
				<Th width="20%">User Name</Th>
			</Tr>
			</Table></div>
			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
			String uType="",userUrl="",userType="",userName=""; 
			for(int i=0;i<uCnt;i++)
			{
				userName=usersRet.getFieldValueString(i,USER_FIRST_NAME);
				if(usersRet.getFieldValue(i,USER_MIDDLE_INIT) != null)
					userName += " "+ usersRet.getFieldValueString(i,USER_MIDDLE_INIT);
				userName += " "+usersRet.getFieldValueString(i,USER_LAST_NAME);	
%>
				<Tr>
					<Td align="center" width="5%" ><input type=radio name="chk1" value="<%=usersRet.getFieldValueString(i,USER_ID).trim()%>" >
						<input type=hidden name="<%=(usersRet.getFieldValueString(i,USER_ID)).trim()%>" value="<%=uType%>">
					</Td>
					<Td width="20%"><%=userName%></Td>
				</Tr>
				<script>
					rowArray=new Array()
					rowArray[0]=""
					rowArray[1]="<%= userName%>"
					dataArray[<%=i%>]=rowArray
				</script>
<%
			}
%>
			</Table>
			</div>
			<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
				<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Add" style="cursor:hand" border=no onClick="javascript:setUser()">
				<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="javascript:window.close()"></a>
			</div>
<%
		}
	}
%>
</form>
</body>
</html>


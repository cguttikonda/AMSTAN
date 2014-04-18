<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWFAuthList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionStatList.jsp"%>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">

<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<script>
	
function checkAuth()
{

	var action=document.myForm.Action.options[document.myForm.Action.selectedIndex].value
	var authkey=document.myForm.AuthKey.options[document.myForm.AuthKey.selectedIndex].value
	<%
		for(int i=0;i<listStatRet.getRowCount();i++)
		{
	    	    
	%>  	    	
		    var retact='<%=listStatRet.getFieldValueString(i,"ACTION")%>'			
		    var retauthkey='<%=listStatRet.getFieldValueString(i,"AUTH_KEY")%>'		
			    	
		    if(retact==action && retauthkey==authkey)
		    {
	    	     	alert("You have already added Status for this Action wiht Same Key");
	    	     	return false
		    }
			    
	 <%
	  	} 
	  
	  %>	
	    return true
}

 function checkOption(filename)
 {
	
	if(document.myForm.Action.selectedIndex!=0)
	{
	
		if(document.myForm.ResultStatus.selectedIndex!=0)
		{
			if(document.myForm.AuthKey.selectedIndex!=0)
			{
			    var x=checkAuth()
			    if(x)
			    {
			       	document.myForm.action=filename
				return true
		 	    }
		 	    else
		 	    {
		 	    	return false
		 	    }
			    
			}
			else
			{
				alert("Please Select Transaction")
				return false
			}	
		}
		else
		{
			alert("Please Select Result Status")
			return false
		}
		
	}
	else
	{
	        alert("Please Select Action")
		return false
	}
}
</script>
</head>
<body onLoad="document.myForm.Action.focus();">
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveActionStat.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Add WorkFlow Action Result Status</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	
	<Tr>
		<Td align=right class=labelcell width=35%>WF Action*</Td>
		<Td width=65%>
		<select name=Action style="width:100%" id=FullListBox>
		<option value="-">--Select WF Action--</option>
		<%
		   listRet.sort(new String[]{"DESCRIPTION"},true);

		   for(int i=0;i<listRet.getRowCount();i++)
		   {
		   	if(listRet.getFieldValueString(i,"STAT_OR_ACTION").equals("A"))
		   	{
		%>
		  	<option value="<%=listRet.getFieldValueString(i,"CODE")%>"><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>				
		
		<%	}
		   }
		%>
		
		</select>
		</Td>
	</Tr>
	
	
	<Tr>
		<Td align=right class=labelcell >Result Status*</Td>
		<Td >
		<select name=ResultStatus style="width:100%" id=FullListBox>
		<option value="-">--Select Result Status--</option>
		<%
		 	for(int i=0;i<listRet.getRowCount();i++)
		        {
			   	if(listRet.getFieldValueString(i,"STAT_OR_ACTION").equals("S"))
			   	{
		%>
				  	<option value="<%=listRet.getFieldValueString(i,"CODE")%>"><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>				
				
		<%		}
		        }
		%>
		</select>
		</Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell >Transaction*</Td>
		<Td >
		<select name=AuthKey style="width:100%" id=FullListBox>
		<option value="-">--Select Transaction--</option>
		<%
		       ret.sort(new String[]{AUTH_DESC},true);
		       for(int i=0;i<ret.getRowCount();i++)
		       {
		 %>
				<option value="<%=ret.getFieldValue(i,AUTH_KEY)%>"><%=ret.getFieldValue(i,AUTH_DESC)%></option>				
				
		<%		
			}
		%>
		</select>
		</Td>
	</Tr>
	
	
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>

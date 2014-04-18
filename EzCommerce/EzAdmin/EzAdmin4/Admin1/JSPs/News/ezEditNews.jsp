<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%@ include file="../../../Includes/JSPs/News/iEditNews.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<html>
<head>
	<title>Edit News Details-- Powered By Answerthink India Ltd.</title>
<Script src="../../Library/JavaScript/News/ezNews.js"></Script>
<Script>
	 function funEditSave()
	 {
	 	var flag = funValidations();
	 	if(flag)
	 	{
			document.myForm.action = "ezEditSaveNews.jsp";
			document.myForm.submit();
		}	
	 }

	 function funSubmit()
	 {
	 	document.myForm.action = "ezEditNews.jsp";
	 	document.myForm.submit();
	 }
</Script>

</head>

<body scroll="no">
<form name="myForm" method="POST">
<input type="hidden" name="newsId" value="<%=newsid%>">
<input type="hidden" name="syskey" value="<%=syskey%>"> 
    <br><br>
    <table width="70%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	    <tr>
		    <th width="20%" align="left">News*</th>
		    <td width="40%">
		    	<input type="text" class="InputBox"  style="width:100%"  name="news" size="25" value="<%=news%>">
	    	    </Td>
	    </tr> 	    	    
	    <tr>
		    <th width="20%" align="left">News Start Date*</th>
		    <td width="80%">
		    	<input type="text" class=InputBox  name="newsStrtDate" style="width:50%"  maxlength="12" size="12" value="<%=startdate%>" readonly>
			<a href="javascript:showCal('document.myForm.newsStrtDate',50,650)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>		    
		    </td>
	    </tr> 
	    <tr>
	    	    <th width="20%" align="left">News End Date*</th>
	   	    <Td width="80%">
	   	    	<input type="text" class=InputBox  name="newsEndDate" style="width:50%"  maxlength="12" size="12" value="<%=enddate%>" readonly>
	   	    	<a href="javascript:showCal('document.myForm.newsEndDate',50,650)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>		    
	   	    </td>
	    </tr>  
	    <tr>
		    <th width="20%" align="left">Role</th>
		    <td width="80%">
		    	<Select name="role" style="width:60%" id=FullListBox onChange="funSubmit()">
				<Option value="">--Select Role--</Option>
				
<%
				String rDesc ="",rRole="",selStr="";
				retRoles.sort(new String[]{"DESCRIPTION"},true);
				for ( int i = 0 ; i < retRoles.getRowCount() ; i++ )
				{
						selStr="";
						rDesc = retRoles.getFieldValueString(i,"DESCRIPTION");
						rRole = retRoles.getFieldValueString(i,"ROLE_NR").trim();
						if(newsrole.equals(rRole)) selStr=" selected"; 
%>	
						 <option value="<%=rRole%>" <%=selStr%>><%=rDesc%></option>
<%
				}
%>				
				
				
	       	    	</Select>
		    </td>
	    </tr>
	    <tr>
	       	    <th width="20%" align="left">Group</th>
	       	    <td width="80%">
	       	    	<Select name="group" style="width:60%" id=FullListBox>
	       	    		<Option value="">--Select Group--</Option>
<%
			if(listRet!=null && listRet.getRowCount()>0)
			{
				listRet.sort(new String[]{"GROUP_ID"},true);
				for(int i=0;i<listRet.getRowCount();i++)
				{
					selStr="";
					if(group.equals(listRet.getFieldValue(i,"GROUP_ID")))  selStr="selected";
%>
					<option value="<%=listRet.getFieldValue(i,"GROUP_ID")%>" <%=selStr%>><%=listRet.getFieldValue(i,"DESCRIPTION")%></option>	
<%
				}
			}	
%>
	       	    	</Select>
	       	    </td>
	    </tr> 
	    <tr>
	    <th width="20%" align="left">News Type*<%=newsType%></th>
	    <td width="80%">
		<Select name="newsType" style="width:50%" id=FullListBox>
			<Option value="">--Select Purchase Area--</Option>
<%
			if(newsType==null) 
				newsType="";
			else 
				newsType = newsType.trim();
			String key="",value="";
			while(enumaration.hasMoreElements())
			{
				selStr="";
				key=(String)enumaration.nextElement();
				value=(String)typrHash.get(key);
				if(newsType.equals(key)) selStr="selected";
%>
				<Option value="<%=key%>" <%=selStr%> ><%=value%></Option>		
<%
			}
%>
		</Select>
	    </td>
  </tr> 
</table>
    
<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="Click Here To Back Page" title="Click Here For Previous Page" border=none style="cursor:hand" onClick="javascript:history.go(-1)">
	<img  src=../../Images/Buttons/<%= ButtonDir%>/save.gif  alt="Click Here To Edit News" title="Click Here To Save News Details" style="cursor:hand" border=no onClick="funEditSave()">
	<img  src=../../Images/Buttons/<%= ButtonDir%>/clear.gif  alt="Click Here To Clear Fields" title="Click Here To Clear Fields" style="cursor:hand" border=no onClick="javascript:document.myForm.reset()">
</Div>
	
</Form>
</body>
</html>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%//@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<%@ include file="../../../Includes/JSPs/News/iEditNews.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
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
<%String display_header = "Edit News";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
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
			<%=getDateImage("newsStrtDate")%>
		    </td>
	    </tr> 
	    <tr>
	    	    <th width="20%" align="left">News End Date*</th>
	   	    <Td width="80%">
	   	    	<input type="text" class=InputBox  name="newsEndDate" style="width:50%"  maxlength="12" size="12" value="<%=enddate%>" readonly>
	   	    	<%=getDateImage("newsEndDate")%>
	   	    </td>
	    </tr>  
 
	    <tr>
	    <th width="20%" align="left">News Type*<%=newsType%></th>
	    <td width="80%">
		<Select name="newsType" style="width:50%" id=FullListBox>
			<Option value="">--Select Purchase Area--</Option>
<%
			String selStr = "";
			if(newsType==null) 
				newsType="";
			else 
				newsType = newsType.trim();
			String key="",value="";
			while(enum1aration.hasMoreElements())
			{
				selStr="";
				key=(String)enum1aration.nextElement();
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
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Save");
		buttonMethod.add("funEditSave()");
		//buttonName.add("Clear");
		//buttonMethod.add("document.myForm.reset()");
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	
	<!--<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="Click Here To Back Page" title="Click Here For Previous Page" border=none style="cursor:hand" onClick="javascript:history.go(-1)">
	<img  src=../../Images/Buttons/<%= ButtonDir%>/save.gif  alt="Click Here To Edit News" title="Click Here To Save News Details" style="cursor:hand" border=no onClick="funEditSave()">
	<img  src=../../Images/Buttons/<%= ButtonDir%>/clear.gif  alt="Click Here To Clear Fields" title="Click Here To Clear Fields" style="cursor:hand" border=no onClick="javascript:document.myForm.reset()">-->
</Div>
<Div id="MenuSol"></Div>	
</Form>
</body>
</html>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%//@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<%@ include file="../../../Includes/JSPs/News/iEditNews.jsp"%>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
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
	 	document.myForm.action = "ezListNews.jsp";
	 	document.myForm.submit();
	 }
</Script>

</head>

<body scroll="no">
<form name="myForm" method="POST">
<input type="hidden" name="newsId" value="<%=newsid%>">
<input type="hidden" name="syskey" value="<%=syskey%>"> 
 <%
 String display_header	= "  Edit News  ";
 
 %>

 <%@ include file="../Misc/ezDisplayHeader.jsp" %>
 
  <BR>
    <table width="70%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	   	    	    
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
	    <th width="20%" align="left">News Type* </th>
	    <td width="80%">
		<Select name="newsType" style="width:50%" id=FullListBox>
			<Option value="">--  Select  --</Option>
<%
			String selStr = "";
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
    <tr>
  		    <th width="20%" align="left">News*</th>
  		    <td width="40%">
  		    	<input type=text name='news' value='<%=news%>' class=InputBox size=100 width=100% value="<%=news%>" maxlimit='249'>
  	    	    </Td>
	    </tr>
</table>
    
<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("funSubmit()");
		buttonName.add("Save");
		buttonMethod.add("funEditSave()");
		//buttonName.add("Clear");
		//buttonMethod.add("document.myForm.reset()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	
	
</Div>
	
</Form>
</body>
</html>
<Div id="MenuSol"></Div>

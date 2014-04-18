<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%//@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsList.jsp"%>
<%@ include file="../../../Includes/JSPs/News/iNewsTypes.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%
	/*
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		ReturnObjFromRetrieve retObjPAs   = (ReturnObjFromRetrieve)sysManager.getPurchaseAreas(sparams);
	*/	
	
	
	String news = "",newsStrtDate = "",newsEndDate = "",syskey="",newsType="";
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey ="/";
	
	if(request.getParameter("news")!=null)
		news = request.getParameter("news");
	if(request.getParameter("newsStrtDate")!=null)
		newsStrtDate = request.getParameter("newsStrtDate");
	if(request.getParameter("newsEndDate")!=null)
		newsEndDate = request.getParameter("newsEndDate");
	if(request.getParameter("syskey")!=null)
		syskey = request.getParameter("syskey");
	if(request.getParameter("newsType")!=null)
		newsType = request.getParameter("newsType");
%>
<html>
<head>
	<Title>Edit News Details -- Powered By Answerthink India Ltd.</Title>
<!--<Script src="../../Library/JavaScript/ezConvertDates.js"></Script>-->
<Script src="../../Library/JavaScript/News/ezNews.js"></Script>
<Script>
	function getDefaultsFromTo()
	{
		<%if(newsStrtDate != null && newsEndDate != null && !"null".equals(newsStrtDate) && !"".equals(newsStrtDate) ){%>
			document.myForm.newsEndDate.value   = "<%=newsEndDate%>"
			document.myForm.newsStrtDate.value = "<%=newsStrtDate%>"
		<%}else{%>
			toDate = new Date();
			today = <%= cDate%>;
			thismonth = <%= cMonth%>+1;
			thisyear = <%= cYear%>;
			if(today < 10)
				today = "0"+today;
			if(thismonth < 10)
				thismonth = "0" + thismonth;
			//document.myForm.newsEndDate.value = thismonth+"<%=forkey%>"+today+"<%=forkey%>"+thisyear;
			if(thismonth < 4)
				fyear=(new Date().getYear()-1);
			else
				fyear=(new Date().getYear());
			if(parseInt(fyear)<1900)
				fyear=parseInt(fyear)+1900;
			//document.myForm.newsStrtDate.value = "04<%=forkey%>01<%=forkey%>"+fyear
		<%}%>
	}
	 function funAddSave()
	 {
	 	var flag = funValidations();
	 	if(flag)
	 	{
			//document.myForm.newsStrtDate.value = ConvertDateFormat(document.myForm.newsStrtDate.value,'7','/');
			//document.myForm.newsEndDate.value = ConvertDateFormat(document.myForm.newsEndDate.value,'7','/');
		
			document.myForm.action = "ezAddSaveNews.jsp";
			document.myForm.submit();
		}	
	 }

	 function funSubmit()
	 {
	 	document.myForm.action = "ezAddNews.jsp";
	 	document.myForm.submit();
	 }
</Script>

</head>

<body scroll=no onLoad="getDefaultsFromTo()">
<form name="myForm"  method="POST">
<%String display_header = "Add News";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

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
		    <td width="80%"><input type="text" class=InputBox  name="newsStrtDate" style="width:50%"  maxlength="10" size="12" value="<%=newsStrtDate%>" readonly>&nbsp;<%=getDateImage("newsStrtDate")%>
		    </td>
	    </tr> 
	    <tr>
	    	    <th width="20%" align="left">News End Date*</th>
	   	    <Td width="80%">
	   	    	<input type="text" class=InputBox  name="newsEndDate" style="width:50%"  maxlength="10" size="12" value="<%=newsEndDate%>" readonly>
	   	    	<%=getDateImage("newsEndDate")%>
	   	    </td>
	    </tr>  
	
	    
	<!--    <tr>
	    <th width="20%" align="left">Purchase Area</th>
	    <td width="80%">
		<Select name="syskey" style="width:50%" id=FullListBox>
			<Option value="">--Select Purchase Area--</Option>
<%
		/*
		if(retObjPAs!=null && retObjPAs.getRowCount()>0)
		{
			retObjPAs.sort(new String[]{"ESKD_SYS_KEY"},true);
			for(int i=0;i<retObjPAs.getRowCount();i++)
			{
				if(syskey.equals(retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")))
				{
				
%>
					<option value="<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>" selected><%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY_DESC")%></option>	
<%
				}
				else
				{
%>
					<option value="<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY_DESC")%></option>						
<%
				}
			}	
		}
		*/
%>
		</Select>
		
	    </td>
  	  </tr> -->
  	  
	    <tr>
	    <th width="20%" align="left">News Type*</th>
	    <td width="80%">
		<Select name="newsType" style="width:50%" id=FullListBox>
			<Option value="">--Select Purchase Area--</Option>
<%
			String key="",value="",defaultKey="G",selStr="";
			while(enum1aration.hasMoreElements())
			{
				selStr="";
				key=(String)enum1aration.nextElement();
				value=(String)typrHash.get(key);
				if(defaultKey.equals(key)) selStr="selected";
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
	buttonMethod.add("funAddSave()");
	//buttonName.add("Clear");
	//buttonMethod.add("document.myForm.reset()");
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
<!--	<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="Click Here To Back Page" title="Click Here To Back Page" border=none style="cursor:hand" onClick="javascript:history.go(-1)">
	<img src=../../Images/Buttons/<%= ButtonDir%>/save.gif  alt="Click Here To Add News" title="Click Here To Save News Details" style="cursor:hand"  border=no onClick="funAddSave()">
	<img src=../../Images/Buttons/<%= ButtonDir%>/clear.gif  alt="Click Here To Clear Fields" title="Click Here To Clear Fields" style="cursor:hand" border=no onClick="javascript:document.myForm.reset()">-->
</Div>
<Div id="MenuSol"></Div>
</body>
</html>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iCalendar.jsp"%> 
<%@ include file="../../../Includes/JSPs/News/iListNews.jsp"%>
<%
	java.util.HashMap hashCat= new java.util.HashMap();
	
	hashCat.put("PL","Price list downloads");
	hashCat.put("PS","Periodic Statement");
	hashCat.put("PSPEC","Product Specification");
	hashCat.put("NP","New products/Product line");
	hashCat.put("DP","Discontinued Products");
	hashCat.put("PCA","Price change Announcements");
	hashCat.put("PA","Promotion Announcements");
	hashCat.put("SLOB","SLOB/Specials");
	
	java.util.HashMap hashType= new java.util.HashMap();
		
	hashType.put("I","Informative");
	hashType.put("T","Tracking");
	hashType.put("TA","Track & Ack");
	
	
	//out.println(hashCat);
%>
<html>
<head>

<script type="text/javascript">
function funAdd(flag)
{
	if(flag=='A')
	{
		document.myForm.action="ezConfigureNews.jsp?Area=C";
		document.myForm.submit();
	}	
}
function funGetAttach(newsId,sysKey)
{
	//alert("newsId:::::"+newsId+":::::sysKey::::::"+sysKey)
	url = "ezViewDocs.jsp?newsId="+newsId+"&sysKey="+sysKey;
	var hWnd	=	window.open(url,"UserWindow","width=300,height=200,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;	
	
}
function funGetAuthUsers(soldTo,ShipTo)
{
	alert(soldTo+":::::"+ShipTo)

}
function funSubmit()
{

	var fromDate=document.myForm.fromDate.value
	var toDate=document.myForm.toDate.value
	
	fromDate = fromDate.split("/")[1]+"/"+fromDate.split("/")[0]+"/"+fromDate.split("/")[2];
	toDate   = toDate.split("/")[1]+"/"+toDate.split("/")[0]+"/"+toDate.split("/")[2];	


	document.myForm.action="ezNewsList.jsp?fromDate="+fromDate+"&toDate="+toDate; 
	document.myForm.submit();

}
function funNewsTrack(id,type)
{
	url = "ezNewsTracker.jsp?type="+type+"&id="+id
	var hWnd	=	window.open(url,"UserWindow","width=500%,height=350,left=100,top=100,resizable=no,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;	
	

}
function getDefaultsFromTo()
{
<%	if(fromDate != null && toDate != null && !"null".equals(fromDate) && !"".equals(toDate) )
	{
%>		document.myForm.fromDate.value   = "<%=fromDate.split("/")[1]+"/"+fromDate.split("/")[0]+"/"+fromDate.split("/")[2]%>"
		document.myForm.toDate.value 	 = "<%=toDate.split("/")[1]+"/"+toDate.split("/")[0]+"/"+toDate.split("/")[2]%>"				
<%
	}
	else
	{

		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
	
		today.setDate(today.getDate()-30);
		ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
%> 
		document.myForm.fromDate.value = "<%=format.getStringFromDate(today,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		document.myForm.toDate.value = "<%=format.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
	
<%
	}
%>	
}
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script> 
<script src="../../Library/JavaScript/ezSortTableData.js"></script> 
</head>
<BODY onLoad="scrollInit(),getDefaultsFromTo()" onResize = "scrollInit()" scroll="no">
<form name=myForm method=post>

	<br>
 	<Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	    	<Th>From</Th>
		<Td><nobr><input type=text class = "InputBox" name="fromDate" id="fromDate" size=11 value="<%=fromDate%>" readonly>
        		 &nbsp;<%=getDateImage("fromDate")%>
		</nobr></Td>
		<Th>To</Th>
		<Td><nobr><input type=text class = "InputBox" name="toDate" id="toDate" size=11 value="<%=toDate%>" readonly>
        		&nbsp;<%=getDateImage("toDate")%>
		</nobr></Td>
		<Td><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" height="20" style="cursor:hand" onClick="funSubmit()"></Td>
	  </Tr>
	</Table>
	<br>
<%
if (myNewsRetCnt>0 ) 
{
%>  	
	<div id="theads" >
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  	<Tr align="left">
    		<Th width="5%" align='center'> &nbsp; </Th>
    		<Th width="10%" align='center'> Description </Th>
    		<Th width="10%" align='center'> News Text </Th>
    		<Th width="10%" align='center'> News Type </Th>
    		<Th width="10%" align='center'> From Date</Th>
    		<Th width="10%" align='center'> End Date</Th>
    		<Th width="10%" align='center'> Category</Th>
    		<Th width="10%" align='center'> Auth.Area(s) </Th>
    		<!--<Th width="10%" align='center'> Auth.User(s)</Th>-->
    		<Th width="10%" align='center'> Attachments</Th>
    		<Th width="10%" align='center'> Tracking </Th>
    		
  	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%	
	/*
	 0 Field Name : EZN_ID ----> Field Value : 104
	 1 Field Name : EZN_SYSKEY ----> Field Value : All
	 2 Field Name : EZN_SOLDTO ----> Field Value : 
	 3 Field Name : EZN_SHIPTO ----> Field Value : 
	 4 Field Name : EZN_CREATED_DATE ----> Field Value : 2012-02-29 01:38:24.713
	 5 Field Name : EZN_CREATED_BY ----> Field Value : ASTADMIN
	 6 Field Name : EZN_MODIFIED_BY ----> Field Value : ASTADMIN
	 7 Field Name : EZN_MODIFIED_DATE ----> Field Value : 2012-02-29 01:38:24.713
	 8 Field Name : EZN_START_DATE ----> Field Value : 2012-01-30 01:00:00.0
	 9 Field Name : EZN_END_DATE ----> Field Value : 2012-02-29 01:00:00.0
	 10 Field Name : EZN_CATEGORY ----> Field Value : PS
	 11 Field Name : EZN_NEWS_TYPE ----> Field Value : I 
	 12 Field Name : EZN_ROLE ----> Field Value : 
	 13 Field Name : EZN_NEWS_TEXT ----> Field Value : test
	 14 Field Name : EZN_SUBJECT ----> Field Value : PS
	 15 Field Name : EZN_ATTACHMENTS ----> Field Value : Y
	 16 Field Name : EZN_AUTH ----> Field Value : A
	 17 Field Name : EZN_GROUP ----> Field Value : 
	 18 Field Name : EZN_EXT1 ----> Field Value : 
	 19 Field Name : EZN_EXT2 ----> Field Value : 
	 20 Field Name : EZN_EXT3 ----> Field Value : 
	 21 Field Name : EUD_UPLOAD_NO ----> Field Value : 100029
	 22 Field Name : EUD_SYSKEY ----> Field Value : All
	 23 Field Name : EUD_OBJECT_TYPE ----> Field Value : News
	 24 Field Name : EUD_OBJECT_NO ----> Field Value : 104
	 25 Field Name : EUD_STATUS ----> Field Value :  
	 26 Field Name : EUD_CREATED_ON ----> Field Value : 2012-02-29 01:38:24.84
	 27 Field Name : EUD_CREATED_BY ----> Field Value : ADMIN
	 28 Field Name : EUF_UPLOAD_NO ----> Field Value : 100029
	 29 Field Name : EUF_TYPE ----> Field Value : News
	 30 Field Name : EUF_CLIENT_FILE_NAME ----> Field Value : Design Document.docx
	 31 Field Name : EUF_SERVER_FILE_NAME ----> Field Value : ADMIN\News\2012\2\1330497504646_Design Document.docx*/
	
	
	String newsId="",newsSyskey="",assiSoldTo="",assiShipTo="",createdOn="",createdBy="",startDate="",endDate="",newsCat="",
	       newsType="",newsText="",newsSub="",newsAuth="",attachFlag="",docUpNO="",uploadSyskey="",uploadObjNo="",fileName="",serverPath="";
	
	java.util.Hashtable docHash = new java.util.Hashtable();
	String tempFileName="";
	String fileServerPath="";
	for (int j=(myNewsRet.getRowCount()-1);j>=0;j--)
	{
		newsId		= myNewsRet.getFieldValueString(j,"EZN_ID");
		fileName	= myNewsRet.getFieldValueString(j,"EUF_CLIENT_FILE_NAME");
		serverPath	= myNewsRet.getFieldValueString(j,"EUF_SERVER_FILE_NAME");
		fileServerPath	= fileName+"*"+serverPath;
		
		if(docHash.containsKey(newsId))
		{
			//out.println("Rowiddddd::::::::::::::::::::::::"+i);
			tempFileName=(String)docHash.get(newsId);
			tempFileName=tempFileName+"$"+fileServerPath;
			docHash.put(newsId,tempFileName);
			myNewsRet.deleteRow(j);
		}	
		else
			docHash.put(newsId,fileServerPath);	
	
	
	}

	for(int i=0;i<myNewsRet.getRowCount();i++)
	{
		newsId		= myNewsRet.getFieldValueString(i,"EZN_ID");
		newsSyskey	= myNewsRet.getFieldValueString(i,"EZN_SYSKEY");
		assiSoldTo	= myNewsRet.getFieldValueString(i,"EZN_SOLDTO");
		assiShipTo	= myNewsRet.getFieldValueString(i,"EZN_SHIPTO");
		createdOn	= GlobObj.getFieldValueString(i,"EZN_CREATED_DATE");	//myNewsRet.getFieldValueString(i,"EZN_CREATED_DATE");
		createdBy	= myNewsRet.getFieldValueString(i,"EZN_CREATED_BY");
		startDate	= GlobObj.getFieldValueString(i,"EZN_START_DATE");	//myNewsRet.getFieldValueString(i,"EZN_START_DATE");
		endDate		= GlobObj.getFieldValueString(i,"EZN_END_DATE");	//myNewsRet.getFieldValueString(i,"EZN_END_DATE"); 
		newsCat		= myNewsRet.getFieldValueString(i,"EZN_CATEGORY");
		newsType	= myNewsRet.getFieldValueString(i,"EZN_NEWS_TYPE");
		newsText	= myNewsRet.getFieldValueString(i,"EZN_NEWS_TEXT");
		newsSub		= myNewsRet.getFieldValueString(i,"EZN_SUBJECT");
		newsAuth	= myNewsRet.getFieldValueString(i,"EZN_AUTH");
		attachFlag	= myNewsRet.getFieldValueString(i,"EZN_ATTACHMENTS");
		docUpNO		= myNewsRet.getFieldValueString(i,"EUD_UPLOAD_NO");
		uploadSyskey	= myNewsRet.getFieldValueString(i,"EUD_SYSKEY");
		uploadObjNo	= myNewsRet.getFieldValueString(i,"EUD_OBJECT_NO");
		fileName	= myNewsRet.getFieldValueString(i,"EUF_CLIENT_FILE_NAME");
		serverPath	= myNewsRet.getFieldValueString(i,"EUF_SERVER_FILE_NAME");
		
				
%>

		<Tr>
			<Td width="5%" align=left><input type='radio' name="newsId" value="<%=newsId%>>"></Td>
			<Td width="10%" align=left><%=newsSub%>&nbsp;</Td>
			<Td width="10%" align=left><%=newsText%>&nbsp;</Td>
			<Td width="10%" align=center><%=hashType.get(newsType.trim())%>&nbsp;</Td>
			<Td width="10%" align=center><%=startDate%>&nbsp;</Td>
			<Td width="10%" align=center><%=endDate%>&nbsp;</Td>
			<Td width="10%" align=center><%=hashCat.get(newsCat)%>&nbsp;</Td>
			<Td width="10%" align=center><%=newsSyskey%>&nbsp;</Td>
			<!--<Td width="10%" align=center><a href="javascript:funGetAuthUsers('<%=assiSoldTo%>','<%=assiShipTo%>')" >View</a>&nbsp;</Td>-->
			<Td width="10%" align=center><a href="javascript:funGetAttach('<%=newsId%>','<%=newsSyskey%>')" >View</a>&nbsp;</Td>
			<Td width="10%" align=center><a href="javascript:funNewsTrack('<%=newsId%>','<%=newsType%>')">Track</a>&nbsp;</Td>
		</Tr>			

<%			
	}
	//out.println("docHash:::::::"+docHash);
	//out.println("myNewsRet:::::::"+myNewsRet.toEzcString());
%>

		    	

	</Table>
	</div>
	
<%
}
else
{
%>

	<br>
	<div id="ButtonDiv" align="right" style="position:absolute;top:30%;width:50%;left:23%">

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader">No Reports to List</Td>
	</Tr>
	</Table><br>
	</div>
<%}
%>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    		<a href="javascript:funAdd('E')"> <img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none ></a>
    		<a href="javascript:funAdd('A')"> <img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none ></a>
    		<a href="javascript:funAdd('D')"> <img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif"   border=none ></a>	
	</div>
	
</form>
</body>
</html>

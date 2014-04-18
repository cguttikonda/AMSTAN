<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>



<%
	java.util.Hashtable newsCat= new java.util.Hashtable();
	
	newsCat.put("PL","Price list downloads");
	newsCat.put("PS","Periodic Statement");
	newsCat.put("PSPEC","Product Specification");
	newsCat.put("NP","New products/Product line");
	newsCat.put("DP","Discontinued Products");
	newsCat.put("PCA","Price change Announcements");
	newsCat.put("PA","Promotion Announcements");
	newsCat.put("SLOB","SLOB/Specials");
	
	String desc		=	request.getParameter("Desc");
	String newsText		=	request.getParameter("newsText");
	String fromDate		=	request.getParameter("fromDate");
	String toDate		=	request.getParameter("toDate");
	String category		=	request.getParameter("category");
	String WebSysKey	=	request.getParameter("WebSysKey");
	String newsType		=	request.getParameter("newsType");
	String viewAuth		=	request.getParameter("viewAuth");
	String selSol		=	request.getParameter("selectedSol");
	String selShip		=	request.getParameter("selectedShip");
	String attachString	=	request.getParameter("attachString");
	String attachFlag	=	"";
	//out.println("attachString:::::::::::::::::"+attachString);
	if(attachString!=null && attachString!="" && !"null".equals(attachString) && !"".equals(attachString))
		attachFlag="Y";
		
	String displayMsg	=	"";
	boolean insertFlag	= 	true;
	
	
	//out.println("desc::::"+desc+":::::fromDate:::::"+fromDate+":::::toDate:::"+toDate+":::category::"+category+"::::::newsType:::"+newsType+"::::viewAuth:::"+viewAuth+"::::category::::"+category+":::::::::::::::::::::selSo::::::::::::"+selSol+"::::::::::::selShip::::::::::::::::"+selShip);
	//EZN_CATEGORY,EZN_NEWS_TYPE,EZN_ROLE,EZN_NEWS_TEXT,EZN_SUBJECT,EZN_ATTACHMENTS,EZN_AUTH,EZN_GROUP,EZN_EXT1,EZN_EXT2,EZN_EXT3

	// This call is to store attachments information in UPLOAD DOC TABLES
	java.util.StringTokenizer fileToken	= null;
	java.util.StringTokenizer userToken	= null;
	ezc.eznews.params.EziNewsParams 		newsParams		=	new ezc.eznews.params.EziNewsParams();
	ezc.eznews.params.EziNewsUploadDocFilesTable 	docTableParams		=	null;
	ezc.eznews.params.EziNewsAssignTable	 	userAssignTable		=	null;
	ezc.ezparam.ReturnObjFromRetrieve addNewsRet = null;	
	ezc.eznews.params.EziNewsUploadDocFilesTableRow rowParams = null;
	ezc.eznews.params.EziNewsAssignTableRow	 assiRowParams = null;
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager= new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsUploadDocsParams uDocsParams = new ezc.eznews.params.EziNewsUploadDocsParams();
	
	newsParams.setNewsSyskey(WebSysKey);
	newsParams.setNewsSoldTo(selSol);
	newsParams.setNewsShipTo(selShip);
	newsParams.setNewsCreatedBy("ASTADMIN");
	newsParams.setNewsModifiedBy("ASTADMIN");
	newsParams.setNewsStartDate(fromDate);
	newsParams.setNewsEndDate(toDate);
	newsParams.setNewsCategory(category);
	newsParams.setNewsType(newsType);
	newsParams.setNewsRole("");
	newsParams.setNewsText(newsText);
	newsParams.setNewsSubject(desc);
	newsParams.setNewsAttach(attachFlag);
	newsParams.setNewsAuth(viewAuth);
	newsParams.setNewsGroup("");
	newsParams.setNewsExt1("");
	newsParams.setNewsExt2("");
	newsParams.setNewsExt3("");
	myParams.setObject(newsParams);
	//out.println("inboxPath::::::"+inboxPath+session.getId());
	
	userAssignTable = new ezc.eznews.params.EziNewsAssignTable();
	if(!"A".equals(viewAuth))
	{
		if(selSol!=null && !"".equals(selSol))
		{
			userToken = new StringTokenizer(selSol,"*");
			while(userToken.hasMoreElements())
			{
				String assiUser = (String)userToken.nextToken();

				assiRowParams	 = new ezc.eznews.params.EziNewsAssignTableRow();
				assiRowParams.setSysKey(WebSysKey);
				assiRowParams.setSoldTo(assiUser);
				assiRowParams.setShipTo("");
				userAssignTable.appendRow(assiRowParams);
				//out.println("1111111111111111111");


			}
		}	
		if(selShip!=null && !"".equals(selShip))
		{
			userToken = new StringTokenizer(selShip,"*");
			while(userToken.hasMoreElements())
			{
				String assiUser = (String)userToken.nextToken();
				if("A".equals(viewAuth))assiUser="A";
				assiRowParams	= new ezc.eznews.params.EziNewsAssignTableRow();
				assiRowParams.setSysKey(WebSysKey);
				assiRowParams.setSoldTo("");
				assiRowParams.setShipTo(assiUser);
				userAssignTable.appendRow(assiRowParams);
				//out.println("2222222222222222222222");


			}
		}		
	}
	else
	{
		assiRowParams	 = new ezc.eznews.params.EziNewsAssignTableRow();
		assiRowParams.setSysKey(WebSysKey);
		assiRowParams.setSoldTo("A");
		assiRowParams.setShipTo("A");
		userAssignTable.appendRow(assiRowParams);	
	}	
	
	myParams.setObject(userAssignTable);
	 
	uDocsParams.setUploadDirectory(inboxPath+session.getId());	
	uDocsParams.setSysKey(WebSysKey);
	uDocsParams.setCreatedBy("ADMIN");
	uDocsParams.setObjectType("News");
		
	
	myParams.setObject(uDocsParams);
	
	myParams.setLocalStore("Y");
	//out.println("attachString::::::::::::::::::::"+attachString);
	fileToken = new StringTokenizer(attachString,",");
	docTableParams = new ezc.eznews.params.EziNewsUploadDocFilesTable();
	
	while(fileToken.hasMoreElements())
	{
		String finalfile = (String)fileToken.nextToken();
		rowParams	 = new ezc.eznews.params.EziNewsUploadDocFilesTableRow();
		rowParams.setType("News");
		rowParams.setClientFileName(finalfile);
		docTableParams.appendRow(rowParams);
	}
	myParams.setObject(docTableParams);
	
	Session.prepareParams(myParams);
	try
	{
		System.out.println("before uploadDoc:");					
		newsManager.ezAddNews(myParams);
				
	}
	catch(Exception e)
	{
		insertFlag=false;
		System.out.println("Exception Occured while Uploading docs:"+e);
	}
	if(insertFlag)
		displayMsg="News has been successfully added.";
	else
		displayMsg="Error while inserting data.";
		
%>
<Html>
<Script>
function getList()
{
	document.myForm.action="ezConfigureNews.jsp?Area=C"
	document.myForm.submit()

}
</Script>
<body>
<form name="myForm" method="post">
	<div id="ButtonDiv" align="right" style="position:absolute;top:30%;width:50%;left:23%">

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader"><%=displayMsg%></Td>
	</Tr>
	</Table><br>
	</div>
	
<div id="ButtonDiv" align="right" style="position:absolute;top:60%;width:50%">
    	<a href="javascript:getList()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none  ></a>
    	
</div>	
</form>
</body>
</Html>
	
	
	

<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String desc		=	request.getParameter("Desc");
	String newsText		=	request.getParameter("newsText");
	String fromDate		=	request.getParameter("fromDate");
	String toDate		=	request.getParameter("toDate");
	String category		=	request.getParameter("category");
	String WebSysKey	=	request.getParameter("WebSysKey");
	String newsType		=	request.getParameter("newsType");
	String viewAuth		=	request.getParameter("viewAuth");
	String selSol		=	request.getParameter("checkSolds");
	String selShip		=	request.getParameter("selectedShip");
	String attachString	=	(String)session.getValue("ATTACHFILES");//request.getParameter("attachString");
	String attachFlag	=	"";
	viewAuth	= viewAuth.trim();
	//out.println("attachString:::::::::::::::::"+attachString);
	//out.println("selSol^^^^^^^^^^^^^^^^^********"+selSol);
	if(attachString!=null && !"null".equals(attachString) && !"".equals(attachString)) attachFlag="Y";

	String displayMsg	=	"";
	boolean insertFlag	= 	true;

	//out.println("desc::::"+desc+":::::fromDate:::::"+fromDate+":::::toDate:::"+toDate+":::category::"+category+"::::::newsType:::"+newsType+"::::viewAuth:::"+viewAuth+"::::category::::"+category+":::::::::::::::::::::selSo::::::::::::"+selSol);
	//out.print("LENGTH:::::::::::::::"+viewAuth.length());
	//EZN_CATEGORY,EZN_NEWS_TYPE,EZN_ROLE,EZN_NEWS_TEXT,EZN_SUBJECT,EZN_ATTACHMENTS,EZN_AUTH,EZN_GROUP,EZN_EXT1,EZN_EXT2,EZN_EXT3

	// This call is to store attachments information in UPLOAD DOC TABLES
	java.util.StringTokenizer fileToken	= null;
	java.util.StringTokenizer userToken	= null;
	ezc.eznews.params.EziNewsParams 		newsParams	=	new ezc.eznews.params.EziNewsParams();
	ezc.eznews.params.EziNewsUploadDocFilesTable 	docTableParams	=	null;
	ezc.eznews.params.EziNewsAssignTable	 	userAssignTable	=	null;
	ezc.ezparam.ReturnObjFromRetrieve 		addNewsRet 	= null;	
	ezc.eznews.params.EziNewsUploadDocFilesTableRow rowParams 	= null;
	ezc.eznews.params.EziNewsAssignTableRow	 	assiRowParams 	= null;
	ezc.ezparam.EzcParams 	myParams = new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager= new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsUploadDocsParams uDocsParams = new ezc.eznews.params.EziNewsUploadDocsParams();

	newsParams.setNewsSyskey(WebSysKey);
	newsParams.setNewsSoldTo("");//selSol
	newsParams.setNewsShipTo("");//selShip
	newsParams.setNewsCreatedBy(Session.getUserId());
	newsParams.setNewsModifiedBy(Session.getUserId());
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
	if(!"A".equals(viewAuth)||!"I".equals(viewAuth))
	{
		if(selSol!=null && !"".equals(selSol))
		{
			//selSol = "&"+selSol;

			//userToken = new StringTokenizer(selSol,"&Chk=");
			//while(userToken.hasMoreElements())

			String[] selSolSplit = selSol.split("¥");

			for(int sp=0;sp<selSolSplit.length;sp++)
			{
				//String assiUser = (String)userToken.nextToken();
				String assiUser = selSolSplit[sp];
				if(assiUser!=null && !"null".equals(assiUser) && !"".equals(assiUser))
				{
					assiRowParams = new ezc.eznews.params.EziNewsAssignTableRow();
					assiRowParams.setSysKey(WebSysKey);
					assiRowParams.setSoldTo(assiUser);
					assiRowParams.setShipTo("");
					userAssignTable.appendRow(assiRowParams);
				}
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
			}
		}
	}
	if("A".equals(viewAuth))
	{
		assiRowParams	 = new ezc.eznews.params.EziNewsAssignTableRow();
		assiRowParams.setSysKey(WebSysKey);
		assiRowParams.setSoldTo("A");
		assiRowParams.setShipTo("A");
		userAssignTable.appendRow(assiRowParams);	
	}
	if("I".equals(viewAuth))
	{
		assiRowParams	 = new ezc.eznews.params.EziNewsAssignTableRow();
		assiRowParams.setSysKey(WebSysKey);
		assiRowParams.setSoldTo("I");
		assiRowParams.setShipTo("I");
		userAssignTable.appendRow(assiRowParams);
	}

	myParams.setObject(userAssignTable);

	uDocsParams.setUploadDirectory(inboxPath+session.getId());	
	uDocsParams.setSysKey(WebSysKey);
	uDocsParams.setCreatedBy(Session.getUserId());
	uDocsParams.setObjectType("News");

	myParams.setObject(uDocsParams);
	myParams.setLocalStore("Y");
	//out.println("attachString::::::::::::::::::::"+attachString);
	if(attachString!=null && !"null".equals(attachString) && !"".equals(attachString))
	{
		fileToken = new StringTokenizer(attachString,"$$");
		docTableParams = new ezc.eznews.params.EziNewsUploadDocFilesTable();

		while(fileToken.hasMoreElements())
		{
			String finalfile = (String)fileToken.nextToken();
			rowParams	 = new ezc.eznews.params.EziNewsUploadDocFilesTableRow();
			rowParams.setType("News");
			rowParams.setClientFileName(finalfile);
			docTableParams.appendRow(rowParams);
		}
	}

	myParams.setObject(docTableParams);
	Session.prepareParams(myParams);
	

	try
	{
		ezc.ezcommon.EzLog4j.log("before uploadDoc:","D");
		newsManager.ezAddNews(myParams);
	}
	catch(Exception e)
	{
		insertFlag=false;
		ezc.ezcommon.EzLog4j.log("Exception Occured while Uploading docs:"+e,"E");
	}
	if(insertFlag)
		displayMsg="News has been added successfully.";
	else
		displayMsg="Error: Exception occurred while adding news.";

	session.putValue("EzMsg",displayMsg);
	session.removeValue("ATTACHFILES");
	response.sendRedirect("../Sales/ezOutMsg.jsp");
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
</form>
</body>
</Html>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	uploadFilePathDir = "j2ee/"+uploadFilePathDir;
	String qcfNum = request.getParameter("QcfNumber");
	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+(String) session.getValue("SYSKEY")+"QCF"+qcfNum+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);
	try
	{
		retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	int noOfDocs = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
		
	}
	ezc.ezparam.ReturnObjFromRetrieve fileListRet = null;
	String fstring = "";
	String sfstr = "";

	if(noOfDocs>0)
	{
		for(int i=0;i<noOfDocs;i++)
		{
			fileListRet=(ezc.ezparam.ReturnObjFromRetrieve)retUploadDocs.getFieldValue(i,"FILES");
			for(int j=0;j<fileListRet.getRowCount();j++)
			{
				fstring = fstring+fileListRet.getFieldValueString(j,"CLIENTFILENAME")+"§";
				sfstr = sfstr+fileListRet.getFieldValueString(j,"SERVERFILENAME")+"µ";
			}
		}	
	}	

	java.util.Vector clientFiles	= new java.util.Vector();
	java.util.Vector serverFiles	= new java.util.Vector();

	java.util.StringTokenizer clientStk	= null;
	java.util.StringTokenizer serverStk	= null;

	if(fstring!= null)
		clientStk	= new java.util.StringTokenizer(fstring,"§");
	if(sfstr!= null)	
		serverStk	= new java.util.StringTokenizer(sfstr,"µ");

	while(clientStk.hasMoreElements())
	{
		clientFiles.addElement(clientStk.nextToken());
		serverFiles.addElement(serverStk.nextToken());
	}	
	
%>
<html>
<head>
<Title>Attached Files -- Powered by EzCommerce India(An Answerthink Company)</Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

	<script>
	
		function funOpenFile(serverFileInd)
		{
		
			//alert("serverFileInd:"+serverFileInd)
			serverFile = eval("document.myForm.upFile"+serverFileInd).value
			var fVal = serverFile.split('*')
			sFile="";
			for(var i=0;i<fVal.length;i++)
			{
				sFile = sFile+fVal[i]+"/"
			}
			sFile = sFile.substring(0,sFile.length-1)
			window.open("/<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")
		}

	</script>

</head>
<body>
<form name="myForm">
<%
	if(noOfDocs>0)
	{
%>
	<DIV style="position:absolute;overflow:auto;width:100%;height:60%;top:10%">
		<Table align="center" style="width:100%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<Tr>
				<Th width="100%" colspan=2>List Of Attached Files For QCF_NUMBER : <%=qcfNum%></Th>
			</Tr>
<%
			for(int i=0;i<clientFiles.size();i++)
			{
%>
				<tr>
					<td align="left">
						<input type='hidden' name='upFile<%=i%>' value='<%=(String)serverFiles.get(i)%>'>
						<a href='javascript:funOpenFile(<%=i%>)'><%=(String)clientFiles.get(i)%></a>
						<input type="hidden"   value="" name="serverfile">
					</td>	
				</tr>
<%
			}
%>	
		</Table>
	</Div>					
<%
	}
	if(noOfDocs==0)
	{
%>
		<DIV style="position:absolute;width:100%;height:40%;top:50%">
			<Table align="center" style="width:60%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th width="50%">There is no attached files.</Th>
				</Tr>
			</Table>
		</Div>	
<%
	}
%>	
<DIV style="position:absolute;width:100%;top:90%">
<Table align="center" style="width:100%">	
	<Tr>
		<Td class='blankcell' align='center'><img src="../../Images/Buttons/<%=ButtonDir%>/close.gif" border=none style="cursor:hand" border=none onClick="JavaScript:window.close()"></Td>
	</Tr>
</Table>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

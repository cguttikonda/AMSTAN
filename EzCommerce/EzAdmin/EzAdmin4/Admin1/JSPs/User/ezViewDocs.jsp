<//%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<Html>
<Head>
<Script type="text/javascript">

function funViewDoc(filePath)
{
	var dbClickOnFlNm = filePath
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../User/ezViewNewsFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=300,height=300,left=100,top=30,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");
	}

}


</Script>
</Head>
<%

	String newsId	= request.getParameter("newsId");
	String sysKey	= request.getParameter("sysKey");
	String objectType	= "News";
	//out.println("newsId::::::"+newsId+":::::sysKey:::"+sysKey);
	String setVal=sysKey+objectType+newsId;
	int uploadDocRetCnt=0;
	ezc.ezparam.ReturnObjFromRetrieve uploadDocRet=null;
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
	ezc.ezupload.client.EzUploadManager uploadManager= new ezc.ezupload.client.EzUploadManager();
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	ezc.ezparam.ReturnObjFromRetrieve uploadDocs =null;
	
	uDocsParams.setObjectNo("'"+setVal+"'");
	myParams.setObject(uDocsParams);
	myParams.setLocalStore("Y");
	Session.prepareParams(myParams);
	try
	{
		System.out.println("before uploadDoc:");					
		uploadDocRet= (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
		uploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadDocRet.getFieldValue(0,"FILES");
		if(uploadDocRet!=null)
			uploadDocRetCnt=uploadDocRet.getRowCount();		
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while Uploading docs:"+e);
	}
	
	
	String fileName="";
	String tempPath="";
	String serverPath="";


	if(uploadDocs!=null && uploadDocs.getRowCount()>0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
				<Th colspan="2">
					<div align="center"> List</div>
				</Th>
		</Tr>
<%		
		for(int i=0;i<uploadDocs.getRowCount();i++)
		{
			fileName=uploadDocs.getFieldValueString(i,"CLIENTFILENAME");
			tempPath=uploadDocs.getFieldValueString(i,"SERVERFILENAME");
			
%>
		
		<Tr>
			<Td >
				<a href="javascript:funViewDoc('<%=tempPath%>')" ><%=fileName%></a>
			</Td>
    		</Tr>
			
<%			
		}	
	
	
%>
		</Table>
		
<%		
	
	}
	else
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
				<Th colspan="2">
					<div align="center"> No documents attached</div>
				</Th>
		</Tr>
		</Table>
<%
	}
%>	
	<div id="ButtonDiv" align="center" style="position:absolute;top:75%;width:100%">
    		<a href="javascript:window.close()"> <img src="../../Images/Buttons/<%= ButtonDir%>/close.gif"   border=none ></a>
    		
	</div>
</body>
</Html>	

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ page import = "java.io.*,java.util.*"%>

<%
String pathName=request.getParameter("pathName");
//out.println(pathName);
%>
<Html>
<Head>
<Title>VIew Attachments</Title>
<Script>
	function funOpenFile(fileStr)
	{
		//window.open("http://192.168.1.35:8080/j2ee/Uploads/<%=pathName%>/"+fileStr,'','');
		
		//popupWindow = window.open("http://<%=request.getServerName()%>:8080/j2ee/Uploads/<%=pathName%>/"+fileStr,'popUpWindow','height=400,width=200,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
	}
</Script>
</Head>
<Body>
<Form>
<% 
	
	File folder = new File(inboxPath+pathName);
	File[] listOfFiles = folder.listFiles();
	//out.println(listOfFiles);
	if(listOfFiles == null)
	{
		out.println("<br><br><br><br><br><h3 style='color:red;' align='center'>No files to display</h3>");
	}
	else
	{ 
		if(listOfFiles.length > 0)
		{
%>	
		<br><br><br>
		<table align=center width='100%' border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<tr>
			<th width=100%>
				Click on the below file link to View or Save.
			</th>	
		</tr>	
<%
		
			for (int i = 0; i < listOfFiles.length; i++) 
			{
				if (listOfFiles[i].isFile() && !"Thumbs.db".equals(listOfFiles[i].getName())) 
				{
%>
				<tr>
					<th width=100% align='left'>
						<a href="ezFileDownload.jsp?listoffiles=<%=listOfFiles[i].getName()%>&&pathName=<%=pathName%>" target=_blank><h5 align='center'><%=listOfFiles[i].getName()%></a>					
					</th>	

				</tr>		
<%

				} 
			}
		
%>
		</table>
<%
		}
		else
		{
			%>
			<br><br><br><br><br>
			<table align="center">
			<tr>
			<td>
				<h3 style='color:red;' align='center'>No Files to Display</h3>
			</td>
			</tr>
			<tr>
			<td align="center">
				<input type="button" value="close" onClick="window.close();">
			</td>
			</tr>
			</table>
			<%
		}
	}    
%>

<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">


</div>
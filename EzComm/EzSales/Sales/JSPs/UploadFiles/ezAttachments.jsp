<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/UploadFiles/iGetUploadTempDir.jsp" %>
<%@ include file="../../../Includes/JSPs/UploadFiles/iShowAttchdFiles.jsp" %>
<html>
<head>

	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script>
	
		function funOpenFile(serverFileInd)
		{
		
			//alert("serverFileInd:"+serverFileInd)
			serverFile = eval("document.myForm.upFile"+serverFileInd).value
			
			var dotPos 		= serverFile.lastIndexOf('.');
			var fileExt	= serverFile.substring(dotPos+1,serverFile.length);
			
			var fVal = serverFile.split('*')
			sFile="";
			for(var i=0;i<fVal.length;i++)
			{
				sFile = sFile+fVal[i]+"/"
			}
			sFile = sFile.substring(0,sFile.length-1)
			
			//if(fileExt == "xls")
			//{
				window.open("ezViewOrSaveFile.jsp?fileName="+sFile,"newWin","titlebar=yes");
			//}
			//else
			//{
			//	window.open("/<%=uploadFilePathDir%>"+sFile,"newWin","titlebar=yes")
			//}	
		}
		
		function deleteFile(delFlName)
		{
			document.myForm.deleteFileName.value = delFlName;
	
			if(confirm("Are you sure of deleting selected file?"))
			{
				document.myForm.action="ezDeleteUploadedFile.jsp";
				document.myForm.submit();
			}	
		}	
		
	</script>

</head>
<body >
<form name="myForm">
<input type="hidden" name="docNum" value="<%=docNum%>">
<input type="hidden" name="docType" value="<%=docType%>">
<input type="hidden" name="fromQCF" value="Y">
<input type=hidden name="deleteFileName">
<%
	boolean showDelete = false;
	boolean showRadioButton = false;
	
	String workFlowStatus = request.getParameter("workFlowStatus");
	String requestFrom = request.getParameter("requestFrom");
	String fontSize = "2";
	if("OFFLINE".equals(requestFrom))
		fontSize = "3";
		
	if(!"APPROVED".equals(workFlowStatus))
		showRadioButton = true;	//This is for if a QCF/PO/Con is approved then we should not show the file remove option.
	
	if(noOfDocs>0)
	{
%>
	<Div style="position:absolute;width:100%;height:100%;top:0%;left:0%">
	<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellSpacing=1>
	<tr>
		<Th>
			Attached By		
		</Th>
		<Th colspan=2>
			Attached File
		</Th>
	</Tr>
<%
			String loginUser=Session.getUserId().trim();
			for(int i=0;i<clientFiles.size();i++)
			{
				if(userNames.get(i).equals(loginUser))
				{
					showDelete = true;
				}
				else
				{
					showDelete = false;
				}
					
%>
				<tr>
					<Td>
						<%=userNames.get(i)%>
					</Td>	
					<td align="left" >
						<input type='hidden' name='upFile<%=i%>' value='<%=(String)serverFiles.get(i)%>'>
						<a href='javascript:funOpenFile(<%=i%>)'><Font size=<%=fontSize%> style="text-decoration:none"><%=(String)clientFiles.get(i)%></Font></a>
						<input type="hidden"   value="" name="serverfile">
					</td>
<%
				if(showDelete && showRadioButton)
				{
%>
					<td align="center" width="5%" >
						<a href="javascript:deleteFile('<%=(String)upldNumbers.get(i)+"ее"+(String)clientFiles.get(i)+"ее"+(String)serverFiles.get(i)%>')"><Font color="Red">Delete</Font></a>
					</Td>
<%
				}
%>
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
			<Table align="center" style="width:60%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th width="50%">No attachments.</Th>
				</Tr>
			</Table>
<%
	}
%>
</form>
</body>
</html>

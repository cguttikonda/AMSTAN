<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListFolders.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<Title>List Folders -- Powered By Answerthink India Pvt Ltd.</Title>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="50%"
 	   	  function delSub()
 	   	  {
 	   	  	if(CheckSelect())
 	   	  	{
 	   	  		document.myForm.action = "ezDelFolders.jsp";
 	   	  		document.myForm.submit();
 	   	  	}	
 	   	  }
 	   	  function ezHref(event)
		  			{
		  				document.location.href = event;
		}

	</Script>
	<script src="../../Library/JavaScript/Inbox/ezListFolders.js"></script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll=no >
<form name=myForm method=post >

<% String display_header="List Of Folders";%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	if (foldRows < 1)
	{
%>
		<br><br>
		<Table  width="100%" height=50% align=center >
			<Tr align="center">
				<Td align=center class=displayalert >There are no folders to list</Td>
			</Tr>
		</Table>
		<br>
		<center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add Folder");
			buttonMethod.add("funAdd()");
			buttonName.add("Inbox");
			buttonMethod.add("goInbox()");
			out.println(getButtonStr(buttonName,buttonMethod));	
%>
		</center>
<%
	}
	else
	{
%>
		<Div id="theads">
		<Table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Td align=left>
				
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Delete Folder");
			buttonMethod.add("delSub()");
			out.println(getButtonStr(buttonName,buttonMethod));	
%>
			</td>
			<Td align=right>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add Folder");
			buttonMethod.add("funAdd()");
			out.println(getButtonStr(buttonName,buttonMethod));	
			
%>				
			</Td>
			</Tr>
			<Tr align="center" valign="middle">
				<Th width="15%"><%= getLabel("SELECT") %></Th>
				<Th width="85%"><%= getLabel("FLDS") %> </Th>
			</Tr>
		</Table>
		</Div>
    
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:50%;left:2%">
		<Table  id="InnerBox1Tab"   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width=100%>
<%
		String foldID = null;
		String foldName = null;
		String foldDisable = null;
		for (int i = 0 ; i < foldRows; i++)
		{
			foldDisable = "";
			if((retFoldList.getFieldValue(i,FOLDER_ID)) != null)
			{
				foldID = retFoldList.getFieldValue(i,FOLDER_ID).toString();
			}
			foldName = retFoldList.getFieldValueString(i,FOLDER_NAME);
			foldName = foldName.trim();
			
			if ( foldName.equalsIgnoreCase("INBOX") )
			{
				foldDisable = "disabled";
			}
%>
			<Tr align="center">
				<Td width="15%">
					<input type="checkbox" name= "CheckBox" value="<%=foldID %>" <%=foldDisable%> >
				</Td>
				<Td width="85%">
					<a href='ezListPersMsgs.jsp?FolderID=<%=foldID%>&FolderName=<%=foldName%>&type=all' <%=statusbar%>>
						<%=foldName%>
					</a>
				</Td>
			</Tr>
<%
		}//End for
%>
		</Table>
		</Div>
		<Div id="buttonDiv" style="position:absolute;top:90%;width:100%;" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
		<Div>
<%
	}//End if
%>
</form>
</body>
<Div id="MenuSol"></Div>
</body>
</html>

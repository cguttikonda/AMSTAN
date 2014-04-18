<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iListFolders_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListFolders.jsp"%>
<html>
<head>
	
	<script>
		var ruSureDelFol_L = '<%=ruSureDelFol_L%>';
		var plzSelFolDel_L = '<%=plzSelFolDel_L%>';


	</script>
	<script src="../../Library/JavaScript/Inbox/ezListFolders.js"></script>
	<Title>List Folders</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="50%"
 	  	  function funSubmit()
		  {
			var pCount=0;
			var selCount=0;

			pCount = document.myForm.CheckBox.length;

			var i = 0;

			if(document.myForm.CheckBox.checked)
			{
			  selCount=selCount+1;
			}
			for ( i = 0 ; i < pCount; i++ )
			{
				if(document.myForm.CheckBox[i].checked)
				{
					selCount = selCount + 1;
				}
			}
			if(selCount<1)
			{
				alert('<%=plzOneFolDel_L%>');
				document.returnValue = false;
			}
			else
			{

				setMessageVisible();
		  		document.myForm.submit();
			}		  
		  		
		  }
		  function ezHref(param)
	          {
		  		setMessageVisible();
		  		document.myForm.action = param;
		  		document.myForm.submit();
		  		
		  }
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll=no >
<form name=myForm method=post action="ezDelFolders.jsp" onSubmit="return CheckSelect()">


<%

	int foldRows = retFoldList.getRowCount();
	if ( foldRows < 1 )
		{
%>
<% String noDataStatement =noFolToList_L;%>
<!--<Table  width="95%" height=50% align=center border=1>

	<Tr align="center">
	<Td align=center class=displayalert >There are no folders to list</Td>
	</Tr>
</Table> -->
<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<br>

	    <!-- <a style="text-decoration:none"  class=subclass href='Javascript:funAdd()'> <img src = "../../Images/Buttons/<%= ButtonDir%>/addfolder.gif" name="Add" value="Add Folder"  border=none  title="Click here to add a New Folder"  <%=statusbar%>  ></a>
	    <a style="text-decoration:none"  class=subclass href='Javascript:goInbox()'> <img src = "../../Images/Buttons/<%= ButtonDir%>/inbox.gif"  title="Click here to go to Inbox"  <%=statusbar%>   border=none></a>   -->
	    <div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
	    <%
	    		
	    		buttonName = new java.util.ArrayList();
	    		buttonMethod = new java.util.ArrayList();
	    		
	    		buttonName.add("Add Folder");
	    		buttonMethod.add("funAdd()");
	    		
	    		buttonName.add("Inbox");
	    		buttonMethod.add("goInbox()");
	    		out.println(getButtonStr(buttonName,buttonMethod));
	    %>
	    </div>
	     <%@ include file="../Misc/AddMessage.jsp" %>
	


<%
		}
	else
		{
%>

<% String display_header=listOfFolders_L;%>

<!-- <Table  width=40%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="center" >
			List Of Folders
		</Th>
	</Tr>
	</Table> -->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>
<div id="theads">

<Table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
<Td colspan=2>
</Td>
</Tr>
		<Tr align="center" valign="middle">
      		<Th width="15%"><%=select_L%></Th>
      		<Th width="85%"><%=folder_L%></Th>
    		</Tr>
</Table>
</div>
    
     <DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:50%;left:2%">
     <Table  id="InnerBox1Tab"   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width=100%>
<%
		String foldID = null;
		String foldName = null;
		String foldDisable = null;
		//ezc.ezutil.EzSystem.out.println("Number Of folders: " + foldRows);
		for (int i = 0 ; i < foldRows; i++)
			{
            		foldDisable = "";
			if((retFoldList.getFieldValue(i,FOLDER_ID)) != null)
				{
				//Folder ID
				foldID = retFoldList.getFieldValue(i,FOLDER_ID).toString();
				//ezc.ezutil.EzSystem.out.println("Folder ID: " + foldID);
				}
			// Folder Name
			foldName = retFoldList.getFieldValueString(i,FOLDER_NAME);
			foldName = foldName.trim();
			if ( foldName.equalsIgnoreCase("INBOX") )
				{
				foldDisable = "disabled";
				}
			//ezc.ezutil.EzSystem.out.println("Folder Name: " + foldName);
%>
		<Tr align="center">
      		<Td width="15%">
                <input type="checkbox" name= "CheckBox" value="<%=foldID %>" <%=foldDisable%> >
 		</Td>
      		<Td width="85%">
			<a href='ezListPersMsgs.jsp?FolderID=<%=foldID%>&FolderName=<%=foldName%>&type=all' <%=statusbar%>>
				<%=foldName.toUpperCase()%>
			</a>
     		</Td>
    		</Tr>
<%
			}//End for
%>
</Table>

</div>
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;" align="center">

 <!-- <a style="text-decoration:none"  class=subclass href='JavaScript:history.go(-1)'><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" tabindex=7 border=none  title="Click here to go to Previous Page"  <%=statusbar%>></a>
 <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/delete.gif" name="Delete Folder" value="Delete Folder"  border=none  title="Click here to delete a Folder"  >
 <a href="javascript:funAdd()"><img src = "../../Images/Buttons/<%= ButtonDir%>/addfolder.gif" name="Add" value="Add Folder"  title="Click here to add a New Folder" border=none  <%=statusbar%>></a>
 <a style="text-decoration:none"  class=subclass href='ezListPersMsgs.jsp'> <img src = "../../Images/Buttons/<%= ButtonDir%>/inbox.gif"  title="Click here to go to Inbox"  <%=statusbar%>   border=none></a> -->
 <%
 		
 		buttonName = new java.util.ArrayList();
 		buttonMethod = new java.util.ArrayList();
 		
 		
 		
 		buttonName.add("Delete");
 		buttonMethod.add("funSubmit()");
 		
 		buttonName.add("Add Folder");
 		buttonMethod.add("funAdd()");
 		
 		buttonName.add("Inbox");
 		buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
 		
 		out.println(getButtonStr(buttonName,buttonMethod));
 %>
 

</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<%
	}//End if
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

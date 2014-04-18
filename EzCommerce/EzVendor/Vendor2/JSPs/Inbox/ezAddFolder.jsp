<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<%@ include file="../../../Includes/JSPs/Labels/iAddFolder_Labels.jsp"%>



<html>
  <head>
  	
  	<Script>
  		var plzAddFolder_A = '<%=plzAddFolder_A%>';
  		var foldAlpNumber_A = '<%=foldAlpNumber_A%>';
  		function isValidChar (c)
		{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")) ||(c==" "))
		}
		
		function checkFolder(s)
		{
		    var i;
		    // Search through string's characters one by one
		    // until we find a non-numeric character.
		    // When we do, return false; if we don't, return true.
		
		    for (i = 0; i < s.length; i++)
		    {   
		        // Check that current character is number.
		        var c = s.charAt(i);
		        if (!isValidChar(c)) return false;
		    }
		
		    	// All characters are numbers or alphabets.
		    	return true;
		
		}
		
		function VerifyEmptyFields() 
		{
			if (document.forms[0].FolderName.value == "" )
			{
				alert(plzAddFolder_A);
				document.myForm.FolderName.focus();
				document.returnValue = false;
			}else{
				document.returnValue = true;
			}
		
			if ( document.returnValue )
			{
				if ( !checkFolder(document.myForm.FolderName.value) )
				{
					alert(foldAlpNumber_A);
					document.returnValue = false;
					document.myForm.FolderName.focus();
				}
				else
				{	
					document.returnValue = true;
				}
			}
		}
		function ezHref(param)
			          {
				  		setMessageVisible();
				  		document.myForm.action = param;
				  		document.myForm.submit();
				  		
		  }
		

  	</Script>
	<!-- <script src="../../Library/JavaScript/Inbox/ezAddFolder.js" > -->
	</script>
	<Title>Add Folder</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script>
	function funAddfolder()
	{
		VerifyEmptyFields();
		var a = document.returnValue;
		if(a==true)
		{
			setMessageVisible();
			document.myForm.submit();
		}
		
        }
        function funClear()
	{
		document.myForm.reset();
		document.myForm.FolderName.focus();
        }
        </script>
  </head>
  <body onLoad="document.myForm.FolderName.focus()" scroll=no>

<form name=myForm method=post action="ezSaveFolderName.jsp" >

<% String display_header=addFolder_L;%>

  <!--<TABLE width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <td class="displayheader">Add Folder</td>
  </tr>
</table> -->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<br><br>

<Table  width=100% height=50% align=center cellPadding=0 cellSpacing=0 >
<Tr>
	<Td class="blankcell">
	      <Table valign=center align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	      <Tr>
		      <Th  height="27" ><%=folderDesc_L%></Th>
		      <Td  height="27" ><input type=text class = "InputBox" name="FolderName" size="20" maxlength="128"></Td>
	      </Tr>
       	      </Table>
        </Td>
</Tr>
</Table>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;left:40%;visibility:visible"><br>
	    <!-- <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/addfolder.gif" name="Submit" value="Add Folder"  title="Click here to add a New Folder" onClick="VerifyEmptyFields(); return document.returnValue">
	    <a href="javascript:document.myForm.reset();document.myForm.FolderName.focus()"><img src="../../Images/Buttons/<%= ButtonDir%>/clear.gif"  title="Click here to clear Folder name" border=none   <%=statusbar%>  ></a>
	    <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  title="Click here to go to Previous Page" border=none   <%=statusbar%>  ></a>  -->
	    <%
	    		
	    		buttonName = new java.util.ArrayList();
	    		buttonMethod = new java.util.ArrayList();
	    		
	    		buttonName.add("Add Folder");
	    		buttonMethod.add("funAddfolder()");
	    		
	    		buttonName.add("Clear");
	    		buttonMethod.add("funClear()");
	    		
	    		buttonName.add("Inbox");
	    		buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
	    		    		
	    		out.println(getButtonStr(buttonName,buttonMethod));
	    %>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<script Language="JavaScript">
var folderExists_A= '<%=folderExists_A%>';
<%
	String fName = request.getParameter("Folder");
	if ( fName != null )
	{
%>
		alert(folderExists_A);
		document.forms[0].FolderName.value='<%=fName%>';
<%
	 }
%>
		document.forms[0].FolderName.focus();
</script>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

	  <%@ include file="../../Library/Globals/errorPagePath.jsp"%>
	  <%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
	  <%@ include file="../../../Includes/JSPs/EzcSFA/iUserList.jsp"%>
	  <%@ include file="../../../Includes/Lib/ezUtilMethods.jsp"%>
	  <html>
	  <head>
	  	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	  	<Script>
	  	function checkFields()
	  	{
	  		if(document.myForm.UserId.selectedIndex == -1 || document.myForm.UserId.selectedIndex == 0)
	  		{
	  			alert("Please select User Name");
	  			document.myForm.UserId.focus()
	  			return;
	  		}
	  		/*var checkFlag = false
	  		var checkCount = document.myForm.synchtype.length
	  		for(i=0;i<checkCount;i++)
	  		{
	  			if(document.myForm.synchtype[i].checked)
	  				checkFlag = true
	  		}
	  		if(!checkFlag)
	  		{
	  			alert("Please select data to synch");
	  			return;
	  		}*/
	  		document.myForm.action='ezSaveSynchRequest.jsp'
	  		document.myForm.submit()
	  	}
	  	</Script>
	  </head>
	  <body topmargin=0 leftmargin=0 rightmargin=0 onresize="scrollInit()" scroll=no>
	  <form name="myForm" method="post">
	  <input type="hidden" name="synchtype" value="PS">
	  <br><br><br><br>
	  <Table width="20%" border=1 align="center" borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	  <Tr>
	  <Th width="40%" align="left">User </th>
	  <Td width="60%">
	  	<select name="UserId" style="width:100%" id="FullListBox">
	  	<option value="">--Select--</option>
	  	<option value="ALL">ALL</option>
	  	
	  <%
	   		for(int i=0;i<userCount;i++)
	   		{
	   		
	  %>
	  			<option value="<%=userList[i]%>"><%=userList[i]%></option>			
	  <%
	   		}
	  %>
	  	</select>
	  </Td>
	  </Tr>
	  </Table>
	  <br><br>
	  
	  <Table width="50%" border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	  	<Tr align="center" valign="middle">
	  		<Td class='blankcell' align="center">
	  				<a href='javascript:checkFields()'><img src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif"  border="none" valign="center"></a>
	  		</Td>
	  	<Tr>
	  <Table>
	  </form>
	  </body>
	  </html>
	  
	  

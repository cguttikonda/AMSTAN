<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iUpdateBusAreas.jsp"%>
<html>
<head>
	<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
	<script src="../../Library/JavaScript/Config/ezUpdateBusAreas.js">
	</script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script>
	leftAdj = 7
	  	function foci()
	  	{
	  	   document.myForm.SysKeyDesc.focus();
	  	}
	</script>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<BODY onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezUpdateSaveBusAreas.jsp">

<br>
 <%
	String sortArr[] = {"ESKD_SYS_KEY"};
	ret.sort(sortArr,true);
	int sysRows = ret.getRowCount();

	if ( sysRows > 0 )
	{
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr align="center">
		    <Td class="displayheader">Update <%=areaLabel%> Description</Td>
	  	</Tr>
	</Table>
	<div id="theads">
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	  	 <Tr>
	      		<Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
	      		<Th width="20%" height="2" align="center"><nobr><%=areaLabel%></nobr>
	      	</Th>
	      		<Th width="75%" height="2" align="center">Description</Th>
	    	</Tr>
	</Table>
 	</div>
	 <div id="InnerBox1Div">
	 <Table  id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

<%

	for ( int i = 0 ; i < sysRows; i++ )
	{
%>

    		<Tr align="center">
			<label <label for="cb_<%=i%>">
     			 
    			  <Td width="5%">
				<input type="checkbox" name="chk1" id="cb_<%=i%>" value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>#<%=ret.getFieldValue(i,SYSTEM_KEY_DESC_LANGUAGE)%>" unchecked>
    			  </Td>
    			  <Td align="center" width="20%">
    			  <a style="text-decoration:none" href = "ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValue(i,SYSTEM_KEY)%>">
				<%=ret.getFieldValue(i,SYSTEM_KEY)%>
			  </a>
    			  </Td>
      
    			  <Td align="center" width="75%">
				<input type=text style = "width:100%" class = "InputBox" size="70" maxlength="128" name="SysKeyDesc" value="<%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%>" >
    			  </Td>
    		</label>
    		</Tr>

<%
	}//End for

%>
  		<input type="hidden" name="Area" value="<%=areaFlag%>">
  	</Table>
   	</div>
      	

 		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">

			<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="funCheckBoxModify();return document.returnValue;">
 		     	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  		</div>
<%
	}//End If
	else
	{
%>
		<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%" >
		  <Tr align="center">
			    <Th>There are No <%=areaLabel%>s Currently</Th>
		  </Tr>
	</Table>
<br>
	<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
     <% }%>
</form>
<%
	String saved = request.getParameter("saved");
	String areaF = request.getParameter("Area");
	String areaDesc = "";
	if ( saved != null && saved.equals("Y") )
	{
		if ( areaF.equals("C") ) areaDesc = "Sales Area";
		if ( areaF.equals("V") ) areaDesc = "Purchase Area";
		if ( areaF.equals("S") ) areaDesc = "Service Area";
%>
		<script language="JavaScript">
			alert('<%=areaDesc%> description(s) updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>

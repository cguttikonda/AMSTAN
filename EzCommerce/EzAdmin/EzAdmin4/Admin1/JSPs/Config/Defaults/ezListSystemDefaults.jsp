<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iListSystemDefaults.jsp"%>
<html>
<head>

<Script src="../../../Library/JavaScript/Config/Defaults/ezListSystemDefaults.js"></Script>
<Script src="../../../Library/JavaScript/ezTabScroll.js"></Script>
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%></head>

<BODY onLoad='scrollInit()' onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="">

<br>
<%
if(numCatArea > 0){
%>
   <Table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <Tr>
      <Th width="20%" height="9" class="labelcell"><nobr>Business Area:</nobr></Th>
      <Td width="80%" height="9">
		<select name="SystemKey" Style="width:100%" onChange = "myalert()"  id = "FullListBox">
		<option value="sel" >--Select Business Area--</option>
<%
		retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for ( int i = 0 ; i < numCatArea; i++ ){
		String checkFlag = retsyskey.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
		String areaDesc = (String)retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
		String areaKey = retsyskey.getFieldValueString(i,SYSTEM_KEY);
		String selArea = "";
		if ( areaKey.equals(sys_key) )selArea="selected";
		checkFlag = checkFlag.trim();
%>
	    	<option <%=selArea%> value=<%=(retsyskey.getFieldValue(i,SYSTEM_KEY))%> >
			<%=areaDesc%> (<%=areaKey%>)
		</option>
<%
}
%>
        </select>
</Td>


  </Tr>
</Table>
<%
	if(sys_key!=null && !sys_key.equals("sel"))
	{
	   int defRows = ret.getRowCount();
           if ( defRows > 0 )
           {
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		  <Tr align="center">
		    <Td class="displayheader">List of Master Defaults</Td>
		  </Tr>
		</Table>
		<div id="theads">
		<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
		    <Tr align="left">
		      <Th width="43%">Default</Th>
		      <Th width="53%">Description</Th>
		    </Tr>
		 </Table>
		 </div>

<div id="InnerBox1Div">
<Table  id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%


				for ( int i = 0 ; i < defRows; i++ ){
				String defDescription = (String)ret.getFieldValue(i,DEFAULTS_DESC);

%>

		    <Tr align="left">
		      <Td width="45%">
				<%=ret.getFieldValue(i,DEFAULTS_KEY)%>
			</Td>
      <Td width="55%">&nbsp;
<%
			if ( defDescription != null){
%>
			      <%=defDescription%>
<%
			}
%>
		</Td>
 	   </Tr>
<%
	}//End for
    }//End If
    else
    {
%>
   <br><br><br><br>
          <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	  	 <Tr align="center">
	  	    <Td class="displayheader">No Defaults to List</Td>
	  	 </Tr>
	  </Table>
<%

    }
%>
  </Table>
  </div>


  
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<a href="javascript:funAdd()"> <img src="../../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none></a>
      <a href="javascript:funEdit()"> <img src="../../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none></a>
	<!-- a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a -->

</div>
  <%
}
else
{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>Please Select Bussiness Area  to continue.</b></div>
		</Td>
	</Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
}
}//end if
else
{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Th>There are No Business Areas Currently</Th>
  </Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
}
%>
</form>
</body>
</html>


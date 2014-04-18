<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListSystemAuth.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script src="../../Library/JavaScript/Config/ezListSystemAuth.js">
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<br>
<body onLoad="funFoucs();scrollInit()" bgcolor="#FFFFF7"  onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezUpdateSystemAuth.jsp">

<%
if(numSystem > 0){
%>

<Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

    <Tr>
      <Th width="35%" class="labelcell">System:</Th>
      <Td width="65%" bordercolor="#999999" bgcolor="#FFFFF7">
      <select name="SystemNumber" onChange = "myalert()" style="width:100%" id = FullListBox>
      <option value="sel">--Select System-- </option>
<%

		for ( int i = 0 ; i < numSystem ; i++ ){
				if(Sys_Num!=null && !"sel".equals(Sys_Num))
				{
					if(Sys_Num.equals(retsys.getFieldValueString(i,SYSTEM_NO)))
					{
						String sysDesc = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
%>
		   				<option value=<%=(retsys.getFieldValue(i,SYSTEM_NO))%> selected>
	        			<%=retsys.getFieldValue(i,SYSTEM_NO)%>( <%=sysDesc%> )
	        			</option>
<%
	        		}
	        		else
	        		{
	        			String sysDesc = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
%>
		   				<option value=<%=(retsys.getFieldValue(i,SYSTEM_NO))%> >
	        			<%=retsys.getFieldValue(i,SYSTEM_NO)%> (<%=sysDesc%>)
	        			</option>
<%
	        		}
	        	}
	        	else
	        	{
						String sysDesc = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
%>
		   				<option value=<%=retsys.getFieldValue(i,SYSTEM_NO)%> >
	        			<%=retsys.getFieldValue(i,SYSTEM_NO)%>( <%=sysDesc%> )
	        			</option>
<%
	        	}


		}


%>
</select>
</Td>
<!-- Td width="10%" align="center">
	  <a href="javascript:myalert()"><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif"  border=none></a>
	</Td -->
    </Tr>
  </Table>
<%
  if(Sys_Num!=null && !"sel".equals(Sys_Num))
  {
%>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
    <Td class="displayheader">Add System Authorizations</Td>
  </Tr>
</Table>

    <%
int authRows = ret.getRowCount();
//Get Authorizations for the System
EzcSysConfigParams sparams2 = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
snkparams2.setLanguage(language);
snkparams2.setSystemNumber(Sys_Num);
sparams2.setObject(snkparams2);
Session.prepareParams(sparams2);
retauth = (ReturnObjFromRetrieve)sysManager.getSystemAuth(sparams2);
retauth.check();
String[] sortArr = { AUTH_DESC };
retauth.sort( sortArr, true );
ret.sort( sortArr, true );

int Rows = retauth.getRowCount();
if ( authRows > 0 )
{
%>

 <!-- Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <Tr>       <Th colspan="2"> Following Are Admin Authorizations
        <br>

          </Th>
      </Tr>
 </Table -->
<div id="theads">
   <Table id="tabHead" width=89% align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0">
     <Tr>
      <Th width="8%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
      <Th width="92%" align="center"> Authorization Description </Th>
    </Tr>
    </Table>
</div>
    
<div id="InnerBox1Div">
	<Table  id="InnerBox1Tab" width=99% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >


<%
	int aCnt = 0;
	for ( int i = 0 ; i < authRows ; i++ )
	{
	String component = ret.getFieldValueString(i,"EUAD_COMPONENT").trim();
	if ( component.equalsIgnoreCase("ROLE") )continue;

%>

    <Tr align="center">
      <label for="cb_<%=i%>">
      <Td width=8%>
<%
	String DelFlag = (String)ret.getFieldValue(i,AUTH_DEL_FLAG);
	if (retauth != null  && retauth.find(SYSAUTH_KEY, ((String)ret.getFieldValue(i,AUTH_KEY)).trim()))
	{
%>

	      	<input type="checkbox" name="Check" id="cb_<%=i%>" value="<%=ret.getFieldValue(i,AUTH_KEY)%>#<%=ret.getFieldValue(i,AUTH_DESC)%>" checked>
	      	<input type="hidden" name="Stat" value="<%=ret.getFieldValue(i,AUTH_KEY)%>#<%=ret.getFieldValue(i,AUTH_DESC)%>">
<%
	} else{
%>

	      	<input type="checkbox" align="center"  id="cb_<%=i%>" name="Check" value="<%=ret.getFieldValue(i,AUTH_KEY)%>#<%=ret.getFieldValue(i,AUTH_DESC)%>" unchecked>
<%
	}
%>
</Td>


      <Td align="left" width=92%>

	<%=ret.getFieldValue(i,AUTH_DESC)%>
	<input type="hidden" name="AuthKey" value=<%=ret.getFieldValue(i,AUTH_KEY)%> >
	<input type="hidden" name="AuthDesc" value=<%=ret.getFieldValue(i,AUTH_DESC)%> >

</Td>
    </label>
    </Tr>

<%
	aCnt++;
	}//End for
%>
	<input type="hidden" name="TotalCount" value=<%=aCnt%> >



  </Table>
  </div>
  
 <div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
      		
        	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/update.gif" onClick="checkAll(<%= authRows %>);return document.returnValue;" >
        	<img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" style = "cursor:hand" onClick = "document.myForm.reset()">
        	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  			</div>

<%
}
else
{
%>
	<div align="center">No Authorizations available</div>
<%
}//End If
%>
</form>
  <%
}
else
{
%>
	<br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Th>Please Select The System  to Continue.</Th>
	  </Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
<%
}
}//end if

else{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Th>There are No Systems Created Currently.</Th>
  </Tr>
</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>



<%	}//end else

		String saved = request.getParameter("saved");
		String sysNum = request.getParameter("sysnum");
		if ( saved != null && saved.equals("Y") )
		{
%>
		<script language="JavaScript">
			alert('Authorizations updated successfully for system <%=sysNum%>');
		</script>
<%
	} //end if
%>

</body>
</html>

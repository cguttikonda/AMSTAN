<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iChangeGroupDesc.jsp"%>
<html>
<head>
<Title>ezChangeGroupDesc</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
	<script src="../../Library/JavaScript/Catalog/ezChangeGroupDesc.js"></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<%
	if(numCatArea==0)
	{
%>
		<BODY>
<%
	}
	else
	{
%>
		<BODY onLoad="scrollInit();setFocus()" onResize = "scrollInit()" scroll="no">
<%
	}
%>
<form name=myForm method=post onSubmit="return submitForm()">

 <%
   if(numCatArea==0)
    {
      if(numCatArea==0) //if no sales areas to list
       {
 %>
 	<br><br><br><br>
     	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
         <Tr align="center">
     		    <Td class="displayheader">There are No Sales Areas To List</Td>
        </Tr>
        </Table>
 <%
        }
 %>
      <center>
       <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

     </center>
 <%
      return;
    }
 %>

<br>
   <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	     <Tr bgcolor="#FFFFF7" bordercolor="#999999">
	       <Th width="15%" class="labelcell"><nobr>Sales Area</nobr></Th>
	       	<Td width="55%">
      		 <select name="SystemKey" style="width:100%" id = FullListBox onChange="funSubmit()">
      			<option value="sel" >--Select Sales Area--</option>

 <%
		 String val=null,checkFlag=null,syskeyDesc=null;
		retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);         
		for (int i = 0 ; i < numCatArea ; i++ )
		{
		   val = retsyskey.getFieldValueString(i,SYSTEM_KEY);
		   checkFlag = retsyskey.getFieldValueString(i,"ESKD_SYNC_FLAG");
		   checkFlag = checkFlag.trim();
		   syskeyDesc = retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
		   if(checkFlag.equals("Y"))
		   {
			val = val.toUpperCase();
			val = val.trim();
			if(val.equals(sys_key))
			{
 %>
 		 	  <option selected value=<%=val%> > <%=syskeyDesc%> (<%=val%>)
 <%
 			}
 		   else
 		   {
 %>
 		   <option value=<%=val%>><%=syskeyDesc%> (<%=val%>)

 <%
 	           }
         	  }
 		}
 %>

  		</select>
  	 </Td>
     </Tr>
   </Table>


 <%
  if(sys_key==null)
   {
 %>
     <br><br><br><br><Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
           <Tr align="center">
      	    <Td class="displayheader">Select Sales Area to continue.</Td>
            </Tr>
       </Table>
       <center>
        <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

      </center>
<%
   }

   if(ret!= null)
   {
     if (ret.getRowCount() > 0)
     {
%>
	 <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	 <Tr align="center">
	  <Td class="displayheader">Group Description</Td>
	 </Tr>
	</Table>

	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr>
		<Th width="10%">&nbsp;</Th>
		<Th width="26%" align="center"> Group</Th>
		<Th width="30%" align="center"> Description </Th>
		<Th width="34%" align="center"> Web Description</Th>
		</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	    for ( int i = 0 ; i <ret.getRowCount(); i++ )
	    {
%>
	    <Tr align="center" >
	    <label for="cb_<%=i%>">
		    <Td width="10%">
		      <input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=ret.getFieldValue(i,PROD_GROUP_NUMBER)%>#<%=i%>">
		    </Td>
		    <Td align="left"  width="26%">
		     <%=ret.getFieldValue(i,PROD_GROUP_NUMBER)%>
		    </Td>
		    <Td align="left" width="30%">
			<%=ret.getFieldValue(i,PROD_GROUP_DESC)%>
		    </Td>
		    <Td align="left" width="34%">
			<input type=text class = "InputBox" size="25" maxlength="120" name="WebDesc" value="<%=ret.getFieldValue(i,PROD_GROUP_WEB_DESC)%>">
		    </Td>
	    </label>
	    </Tr>
<%
	    }//End for
%>

	</Table>
	</div>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	    <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="ChangeDesc" value="Update" onClick="setOption(2)">
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>
<%
		if (ret.getRowCount() > 1)
		{
%>
		<script language="JavaScript">
			document.myForm.WebDesc[0].focus();
		</script>
<%
		}
		else //if only one record is available
		{
%>
		<script language="JavaScript">
			document.myForm.WebDesc.focus();
		</script>
<%
	        }

	  }//if(ret.getRowCount()>0)
	   else
	   {
%>
		<br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
		<Th>
		 There are no group descriptions
		</Th>
		</Tr>
		</Table>
		<center>
		 <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>

	<%
	    }//else
   }//if(ret!= null)

  String saved = request.getParameter("saved");
  	if ( saved != null && saved.equals("Y") )
  	 {
%>
		<script language="JavaScript">
			alert("Group description(s) changed successfully");
		</script>
<%
 	 } //end if
%>
</form>
</body>
</html>

<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iModifySystemDefaults.jsp"%>
<html>
<head>
<Script src="../../../Library/JavaScript/CheckFormFields.js"></Script>
<script src="../../../Library/JavaScript/Config/Defaults/ezModifySystemDefaults.js">
</script>
<Script>
function funFocus()
{
	if(document.myForm.SystemKey!=null)
	{
		document.myForm.SystemKey.focus()
	}
}
</Script>
<script src="../../../Library/JavaScript/ezTabScroll.js">
</script>
</head>

<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%>
<BODY onLoad="funFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveModifySystemDefaults.jsp">

<%
	if(numCatArea==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		<Th>There are No Business Areas Currently</Th>
		</Tr>
		</Table>
		<br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>

<%
	return;
	}
%>
<br>
<%
	if(numCatArea >0)
	{
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
	<Th width="30%" class="labelcell">Business Area:</Th>
	<Td width="70%" >
	<select name="SystemKey" style="width:100%" id=FullListBox onChange="myalert()">
	<option value="sel" >--Select Business Area--</option>
<%
	retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
	for ( int i = 0 ; i < numCatArea; i++ )
		{
		String checkFlag = retsyskey.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
		String areaDesc = (String)retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
		String areaKey = retsyskey.getFieldValueString(i,SYSTEM_KEY);
		String selArea = "";
		if ( areaKey.equals(sys_key) )selArea="selected";
			checkFlag = checkFlag.trim();
%>
	     	<option <%=selArea%> value=<%=retsyskey.getFieldValue(i,SYSTEM_KEY)%> >
			<%=areaDesc%>  (<%=areaKey%>)</option>
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
%>
<%

		defRows = ret.getRowCount();
		if ( defRows > 0 )
			{
%>
<div id="theads">
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		  	<Tr align="center">
		    	<Td class="displayheader">Update Master Defaults</Td>
		  	</Tr>
			</Table>
			</div>
<div id="InnerBox1Div">
			<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		    	<Tr>

		      	<Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main'  onClick="selectAll()"></Th>
		      	<Th width="20%" align="left">
		        <div align="center">Default</div>
		      	</Th>
		      	<Th width="50%" align="left">
		        <div align="center">Description </div>
		      	</Th>
		      	<Th width="25%" align="left">
		        <div align="center">Type </div>
		      	</Th>
		    	</Tr>
<%
		for ( int i = 0 ; i < defRows; i++ )
			{
%>
    			<Tr align="center">
			<label for="cb_<%=i%>">
    		  	<Td>
  			<input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=ret.getFieldValue(i,DEFAULTS_KEY)%>" unchecked>
    	  		</Td>
    	  		<Td align="left">
	  	   	<%=ret.getFieldValue(i,DEFAULTS_KEY)%>
			<input type="hidden" name="DefKey" value="<%=ret.getFieldValue(i,DEFAULTS_KEY)%>" onChange="setCheck('<%=i%>');return document.returnValue"
      			</Td>
      			<Td align="left">
<%
			String defDesc = (String)(ret.getFieldValue(i,DEFAULTS_DESC));

			if(defDesc != null)
				{
				defDesc = defDesc.trim();
%>
				<input type=text style = "width:100%" class = "InputBox" size="20" maxlength="128" name="DefDesc" value="<%=defDesc%>" onChange="setCheck('<%=i%>');return document.returnValue" >
<%
				}
			else
				{
%>
				<input type=text style = "width:100%" class = "InputBox" size="20" maxlength="35" name="DefDesc" value=" " onChange="setCheck('<%=i%>');return document.returnValue"  >
<%
				}
%>
      		</Td>
      		<Td align="left">
<%
		//Defaults Type
		int typeRows = retdeftype.getRowCount();
		if ( typeRows > 0 )
			{
%>
		 	<div id ="listBoxDiv<%=i%>"><select name="DefType" onChange="setCheck('<%=i%>');return document.returnValue" >
<%
			defType = (String)ret.getFieldValue(i,"EUDD_DEFAULT_TYPE");
			for ( int j = 0 ; j < typeRows ; j++ )
				{
				String val1 = ((String)retdeftype.getFieldValue(j,DEFAULT_TYPE));
				if(defType.equals(val1.trim()))
				{
%>
		        	<option selected value=<%=(String)retdeftype.getFieldValue(j,DEFAULT_TYPE)%> >
		        	<%=retdeftype.getFieldValue(j,DEFAULT_TYPE_DESC)%>
		        	</option>
<%
				}
				else
				{
%>
		        	<option value=<%=(String)retdeftype.getFieldValue(j,DEFAULT_TYPE)%> >
		        	<%=retdeftype.getFieldValue(j,DEFAULT_TYPE_DESC)%>
		        	</option>
<%
				}

			}//End for
%>
	        </select></div>
<%
		}
%>
		<input type="hidden" name="DefLang" value=<%=ret.getFieldValue(i,DEFAULTS_LANG)%> >
	      	</Td>
		</label>
		</Tr>
<%
	}//End for
%>
  	</Table>
	</div>

    	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    	<input type="image" src="../../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="checkAll();return document.returnValue;">
    	<a href="javascript:void(0)"><img src="../../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


    	</div>
<%
	}
else
	{
%>
	<div align="center">
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>There are no defaults to update</b></div>
		</Td>
	</Tr>
	</Table></div>
  	<br>
  	<center>
  		<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


  	</center>
<%
	}
}
else
	{
%>
	<br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th>
			 Please Select Bussiness Area  to continue.
		</Th>
	</Tr>
	</Table>
  	<br>
  	<center>
  		<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
<%
	}
}
%>
</form>
</body>
</html>

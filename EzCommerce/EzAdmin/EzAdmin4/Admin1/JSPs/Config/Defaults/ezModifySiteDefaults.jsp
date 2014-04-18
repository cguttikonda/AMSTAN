<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iModifySiteDefaults.jsp"%>
<html>
<head>
<script src="../../../Library/JavaScript/CheckFormFields.js"></script>
<script src="../../../Library/JavaScript/Config/Defaults/ezModifySiteDefaults.js"></script>
<script src="../../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%>
<BODY onLoad="setFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveModifySiteDefaults.jsp">
<br>
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	<Td class="displayheader">Update Site Defaults</Td>
  	</Tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
      	<Th width="8%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
      	<Th width="25%" align="center">Default</Th>
      	<Th width="40%" align="center"> Description </Th>
      	<Th width="30%" align="center">Default Type </Th>
    	</Tr>
<%
	int fixRows = retfixed.getRowCount();
	if ( fixRows > 0 )
	{
		for ( int k = 0;  k < fixRows; k++ )
		{
%>
			<Tr align="center">
				<label for="cb_<%=k%>">
				<Td>

				<input type="checkbox" name="CheckBox" id="cb_<%=k%>" value="<%= retfixed.getFieldValue(k,DEFAULTS_KEY)%>" unchecked>

     				</Td>
      				<Td align="left">
<%
				String fixedDef = (String)(retfixed.getFieldValue(k,DEFAULTS_KEY));
%>
				<%=fixedDef%>
					<input type="hidden" name="DefKey" value="<%= fixedDef%>" >
      				</Td>
      				<Td align="left">
<%
					String defDesc = ((String)(retfixed.getFieldValue(k,DEFAULTS_DESC))).trim();
					if(defDesc != null)
					{
%>
						<input type=text style = "width:100%" class = "InputBox" size="20" maxlength="100" name="DefDesc" value="<%=defDesc%>"> <!--onChange="setCheck('<%=k%>');return document.returnValue" > -->
<%
					}
					else
					{
%>
						<input type=text style = "width:100%" class = "InputBox" size="20" maxlength="100" name="DefDesc" value=" "> <!-- onChange="setCheck('<%=k%>');return document.returnValue" > -->
<%		
					}
%>
      				</Td>
      				<Td align="left">
<%
	//Defaults Type
					retfixtype.sort(new String[]{DEFAULT_TYPE_DESC},true);
					int typeRows = retfixtype.getRowCount();
				  	if ( typeRows > 0 )
				  	{
%>

        				<select name="DefType" style = "width:100%" id="FullListBox" onChange="setCheck('<%=k%>');return document.returnValue" >
 <%
					defType = (String)retfixed.getFieldValue(k,"EUDD_DEFAULT_TYPE");
						for ( int l = 0 ; l < typeRows ; l++ )
						{
						String val2 = ((String)retfixtype.getFieldValue(l,DEFAULT_TYPE));
							if(defType.equals(val2.trim()))
							{
%>
						        <option selected value=<%=((String)retfixtype.getFieldValue(l,DEFAULT_TYPE))%> >
						        <%=((String)(retfixtype.getFieldValue(l,DEFAULT_TYPE_DESC)))%>
						        </option>
<%	
							}
							else
							{
%>

	        					<option  value=<%=((String)retfixtype.getFieldValue(l,DEFAULT_TYPE))%> >
	        					<%=((String)(retfixtype.getFieldValue(l,DEFAULT_TYPE_DESC)))%>
	        					</option>
<%	
							}
						}//End for
%>	

        				</select>
<%
					}//End if
%>
							<input type="hidden" name="DefLang" value=<%=retfixed.getFieldValue(k,DEFAULTS_LANG)%> >
      				</Td>
    				</label>
    				</Tr>
<%
			}//End for
		}//End If

%>
	  	</Table>
	  	</div>

		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<input type="image" src="../../../Images/Buttons/<%= ButtonDir%>/save.gif"  onClick="checkAll();return document.returnValue;" >
		<a href="javascript:void(0)"><img src="../../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


		</div>
	</form>
<%
		String saved = request.getParameter("saved");
			if ( saved != null && saved.equals("Y") )
			{
%>
			<script language="JavaScript">
				alert('Site Defaults Updated Successfully');
			</script>
<%
			} //end if
%>
	</body>
</html>

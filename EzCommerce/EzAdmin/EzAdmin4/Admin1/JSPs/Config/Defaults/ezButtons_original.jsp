<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iAddSystemDefaults.jsp"%>
<html>
<head>
<script src="../../../Library/JavaScript/Config/Defaults/ezAddSystemDefaults.js"></script>
<script src="../../../Library/JavaScript/buttonScript.js"></script>
<Title>Add Defaults</Title>
<%@ include file="../../../Library/Styles/Theme1.jsp"%>
</head>
<body>
<form name=myForm method=post action="ezSaveDefaultsDesc.jsp">
<br>
<%
	if(numCatArea > 0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr align="center">
    			<Td class="displayheader">Add New Master Defaults</Td>
  		</Tr>
		</Table>
 		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
 	   	<Tr>
      			<Th width="100%" colspan="2" height="12">
        			<div align="center">For adding a new master default enter the following
          			information</div>
      			</Th>
    		</Tr>
    		<Tr>
      		<Td width="43%" class="labelcell">
        		<div align="right">Business Area :</div>
      		</Td>
      		<Td width="57%">
      		<div id = listBoxDiv>
      		<select name="SysKey">
	  	<option value="sel" >Select Bussiness Area</option>
<%
		for ( int i = 0 ; i < numCatArea; i++ )
		{
			String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
			String areaDesc = (String)retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
%>
	   		<option value=<%=retsyskey.getFieldValue(i,SYSTEM_KEY)%> >
<%
			if(checkFlag.equals("V"))
			{
%>
		     		(Purchase Area -> <%= areaDesc%> )
<%
			}
			else
			{
%>
		       		(Sales Area -> <%=areaDesc%> )
<%
			}
%>
			</option>
<%
		}
%>
        	</select>
        	</div>
      		</Td>
    	</Tr>
    	<Tr>
      		<Td width="43%" class="labelcell">
        		<div align="right">Default Level:</div>
      		</Td>
      		<Td width="57%">
<%

		int typeRows = retdeftype.getRowCount();
		if ( typeRows > 0 )
		{
%>
      			<div id = listBoxDiv1><select name="DefType">
      		  	<option value="sel">Select Defect Level</option>
 <%
  			for ( int i = 0 ; i < typeRows ; i++ )
  			{
 %>
			       	<option  value=<%=retdeftype.getFieldValue(i,DEFAULT_TYPE)%> >
				        <%=retdeftype.getFieldValue(i,DEFAULT_TYPE_DESC)%>
	        		</option>
<%
			}
%>
			</select>
			</div>
<%
		}
%>
      		</Td>
    	</Tr>
    	<Tr>
      		<Td width="43%" class="labelcell">
        		<div align="right">Language:</div>
      		</Td>
      		<Td width="57%">
        		<%@ include file="../../../../Includes/Lib/ListBox/LBLanguage.jsp"%>
      		</Td>
    	</Tr>
    	<Tr>
      		<Td width="43%" class="labelcell">
        		<div align="right">Default:*</div>
      		</Td>
      		<Td width="57%"> 
        		<input type=text class = "InputBox" name=key size="16" maxlength="16" >
        	</Td>
    	</Tr>
    	<Tr>
      		<Td width="43%" class="labelcell">
    		    	<div align="right">Description:*</div>
    	  	</Td>
    	  	<Td width="57%"> 
    		    	<input type=text class = "InputBox" name=Desc size="25" maxlength="100" >
    	    	</Td>
    	</Tr>
  	</Table>
  	<br>
	<Table  cellspacing="5" cellpadding="5" align = center>
	<Tr>
		<Td class=btnoff onMouseOver="changeClass(this,'btnup')" onMouseOut="changeClass(this,'btnoff')" onClick="javascript:history.go(-1)">
			Add
		</Td>
		<Td class=btnoff onMouseOver="changeClass(this,'btnup')" onMouseOut="changeClass(this,'btnoff')" onClick="javascript:history.go(-1)">
			Reset
		</Td>
		<Td class=btnoff onMouseOver="changeClass(this,'btnup')" onMouseOut="changeClass(this,'btnoff')" onClick="javascript:history.go(-1)">
			Back
		</Td>
	</Tr>
	</Table>
<%
	}
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
		<Table  cellspacing="5" cellpadding="5" align = center>
		<Tr>
		<Td class=btnoff onMouseOver="changeClass(this,'btnup')" onMouseOut="changeClass(this,'btnoff')" onClick="javascript:history.go(-1)">
			Back
		</Td>
		</Tr>
	</Table>
<%
	}
%>
</form>
</body>
</html>

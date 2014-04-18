<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iAddCatalogNumber.jsp"%>
<html>
<head>
	<Title>ezAddCatalogNumber</Title>
	<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/Catalog/ezAddCatalogNumber.js"></script>


</head>
<%
	if(numCatArea==0)
	{
%>
		<body>
<%
	}
	else
	{
%>
		<body onLoad="document.myForm.SystemKey.focus();scrollInit()" onResize = 'scrollInit()' scroll="no">
<%
	}
%>

<form name=myForm method=post onSubmit="return submitForm()">

<br>
<%
if(numCatArea > 0)
{
%>
    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th width="30%" class="labelcell" bordercolor="#CCCCCC">Sales Area</Th>
      <Td width="70%" bordercolor="#CCCCCC">
      <select name="SystemKey" id = "FullListBox" style="width:100%" onChange="funSubmit()">
	<option value="sel" >--Select Sales Area--</option>

<%
     String val=null,syskeyDesc=null;
     retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
     for (int i = 0 ;i<numCatArea;i++ )
     {
	     val = retsyskey.getFieldValueString(i,SYSTEM_KEY);
	     syskeyDesc = retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
	     val = val.toUpperCase();
	     val = val.trim();
	    if(sys_key.equals(val))
	     {
%>
	  	  <option selected value="<%=val%>"><%=syskeyDesc%> (<%=val%>)</option>
<%
	     }
	     else
	     {
%>
	  	  <option value="<%=val%>"><%=syskeyDesc%> (<%=val%>)</option>
<%  	     }

     }//for close
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
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");
	int iTotalCells = retobj.getRowCount();
	if (ret!= null)
	{
		int Rows = ret.getRowCount();
		if ( Rows > 0 )
		{

%>
		    <Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%">
		    <Tr>

		      <Th width="30%"  class="labelcell" bordercolor="#CCCCCC">
		      	<nobr>Catalog Description*</nobr>
		      </Th>
		      <Td width="70%"  colspan="3" bordercolor="#CCCCCC">
		        <input type=text class = "InputBox" name="CatalogName" style="width:100%" maxlength="120">
		      </Td>
		    </Tr>
		  </Table>
		  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
		  <Tr align="center">
		    <Td class="displayheader">Create Catalog</Td>
		  </Tr>
		  </Table>

		<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  	        <Tr>
		      <Th valign="middle" align="left" width="85%" colspan="<%=iTotalCells%>"> Product Group</Th>
		      <Th valign="middle" align="center" width="15%"> Main Index</Th>
		</Tr>
		</Table>
		</div>
		
<div id="InnerBox1Div">
<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>


<%
	         int level=0,offset=0;
	         String stroffset=null,chkname=null;
		for ( int i = 0 ; i <  Rows; i++ )
		{
			 level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
			// Get the offset for a particular level
			 stroffset = retobj.getFieldValueString((level-1), "OFFSET");
			 offset = (new Integer(stroffset)).intValue();

			chkname = ret.getFieldValueString(i,PROD_GROUP_NUMBER);

%>
			<Tr bgcolor="#E1E1FF">
			<label for="cb_<%=i%>">
<%
			for ( int j = 0 ; j < (level -1); j++ )
			{
				if (level != 1)
				{
%>					<Td>&nbsp;</Td>
<%
				}
			}

%>
    			<Td align="left" >

			<input type="checkbox" name="CheckBox" id="cb_<%=i%>" value='<%=chkname%>' unchecked onClick ="SelectChk( '<%=i%>', this, (this.value).substring(1,<%=(offset+1)%>) , '<%=offset%>', '<%=String.valueOf(level)%>')" >
			<%=(ret.getFieldValue(i,PROD_GROUP_WEB_DESC))%>
			</A>
			</Td>
<%
			for ( int k = 0 ; k < (iTotalCells - level)  ; k++ )
			{
%>				<Td>&nbsp;</Td>
<%
			}
%>
			<Td valign="top" align="center" width="15%" >
				<input type="checkbox" name="<%=chkname%>"  value="Selected" unchecked>
				<input type="hidden" name="GroupLevel" value=<%=ret.getFieldValue(i,PROD_GROUP_LEVEL)%> >
			</Td>
	      		</label>
	      		</Tr>
<%
		}


%>
	   	</Table>
		</div>
	  	
		<input type="hidden" name="TotalCount" value=<%=Rows%> >
		<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
		    <input type = "image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Add" onClick="setOption(2)">
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
	           <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>
		<script>
	        	document.forms[0].CatalogName.focus()
	        </script>

<%
		}
		else
		{
%>
		  <div align="center"><br>
		  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		  	<Tr>
		  		<Td class = "labelcell">
		  			<div align="center"><b> This Sales Area is not synchronized</b></div>
		  		</Td>
		  	</Tr>
                      </Table>
		  </div>
		  <center>
		   <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

                  </center>
<%
		}
	 }//if (ret!= null)
     }//if(sys_key!=null && !sys_key.equals("sel"))
   else
  {

%>
		<br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select SalesArea to continue.</b></div>
				</Td>
			</Tr>
		</Table>
		<center>
		 <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

               </center>

<%
  }
%>
</form>
<%
     }//if(numCatArea > 0)
     else
     {
%>		<BR><BR>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		  <Tr align="center">
		    <Th>There are No Sales Areas Defined  Currently</Th>
		  </Tr>
		</Table>
		<center>
		 <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

              </center>

<%
	}//end if Cat Areas >0
%> </p>
</body>
</html>

<%@ include file="../../../Includes/JSPs/Catalog/iShowCatalog.jsp"%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>ezshowCatalog</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
function myalert()
{
  	document.myForm.submit()
}
</script>
</head>
<BODY onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
<form name=myForm method=post>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  	<Tr align="center">
    		<Td class="displayheader">Show Catalog</Td>
  	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
      	<Th class="labelcell">Catalog:</Th>
      	<Td>
<%
	String displCatalogDesc = catalog_desc;

	String catalog_desc1 = catalog_desc.replace('\u0020','+');
	if(catalog_desc1.charAt(0) != '\"')
	{
		catalog_desc1 = "\""+catalog_desc1+"\"";
		displCatalogDesc = "\"" + catalog_desc + "\"";
	}
%>

	<%=catalog_desc+"("+catalog_number+")"%>
      	</Td>
      	<Th height="25" class="labelcell"><nobr>Business Area:</nobr></Th>
      	<Td height="25" bordercolor="#666666" bgcolor="#FFFFF7">
      		<%@ include file="../../../Includes/Lib/ListBox/LBCatalogArea.jsp"%>
      	</Td>
      	</Tr>
      	</Table>
<%
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");
	int iTotalCells = retobj.getRowCount();
%>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
        <Th  align="left" width="100%" colspan="<%=iTotalCells+1%>">
        	If you would like to add more product groups from different Sales Areas
          	<a class = "subclass"  href="ezModifyCatalog.jsp?CatalogNumber=<%=catalog_number%>&SystemKey=<%=sys_key%>">click here</a>
        </Th>
        <Tr>
        <Th width="85%" colspan="<%=iTotalCells%>" align="center"> Product Group</Th>
        <Th width="15%"  align="center"> Main Index</Th>
        </Tr>
	</Table>
	</div>
	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	String curGroupNum = null,stroffset=null;
	String lastGroupNum  = null,mainIndex=null,groupSelected=null;
	int level=0,offset=0;
	if (ret!= null)
	{
		int Rows = ret.getRowCount();
		for ( int i = 0 ; i <  Rows; i++ ) 
		{
	
			mainIndex = (String)(ret.getFieldValue(i,CATALOG_INDEX_INDICATOR));
			level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
			groupSelected = (String)(ret.getFieldValue(i,CATALOG_GROUP_CHECKED));
			curGroupNum = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
			if(curGroupNum.length() < 17)
				curGroupNum=curGroupNum + "                                                ";

			if(!(groupSelected.equals("Y")))
				continue;

			stroffset = (String)retobj.getFieldValue(0, "OFFSET");
			offset = (new Integer(stroffset)).intValue();
%>
			<Tr bgcolor="#E1E1FF" >
<%		
			for(int j = 0 ; j < (level -1); j++) 
			{
				if (level != 1 && mainIndex != "Y")
					out.println("<Td>&nbsp;</Td>");
			}
%>

	    		<Td align="left"> 
        		<input type=checkbox disabled name=CheckBox value=Selected  checked>
			
			<%= ret.getFieldValue(i,PROD_GROUP_WEB_DESC) %> </A>
			</Td>
<%
			for(int k = 0 ; k < (iTotalCells - level); k++) 
			{
%>			
				<Td>&nbsp;</Td>
<%				
			}
%>
			<Td valign=top align=center width=15% > 
<%		
			if (mainIndex.equals("Y"))
			{
%>			
		     		<input type=checkbox disabled name=MainIndex value=Selected checked>
<%		     	
			} else{
%>			
		     		<input type=checkbox disabled name=MainIndex value=Selected>
<%		     	
			}
%>			
	
			</Td>
      			</Tr>
<%      			
			lastGroupNum = curGroupNum.substring(0,offset);
		}// End for Rows
	}//End If
%>
	</Table>
	</div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</div>
	<input type=hidden name="CatNumber" value="<%=catalog_number%>">	
</form>
</body>
</html>

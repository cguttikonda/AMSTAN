<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/Catalog/iDisplayGroups.jsp"%>
<%! String GroupNum = ""; %>
<html>
<head>
<Title>ezDisplayGroups</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Catalog/ezDisplayGroups.js"></script>

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
		<BODY onLoad="scrollInit();document.myForm.SystemKey.focus()"  onResize = "scrollInit()" scroll="no">
<%
	}
%>
<form name=myForm method=post onSubmit="return submitForm()">

<br>
<%
  //Following include will bring sales areas and languages list
%>
 <%@ include file="../../../Includes/Lib/ListBox/LBSalesArea.jsp"%>

 <%
    if(sys_key==null)
    {
 %>
      <br><br><br><br>
      <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
 	<Tr>
 		<Td class = "labelcell">
 			<div align="center"><b>Please Select Sales Area to continue.</b></div>
 		</Td>
 	</Tr>
     </Table>
     <center>
      <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

    </center>
 <%
     }
     if(ret!=null)
     {
	if(ret.getRowCount()!=0)
	{
 %>
  <div id="theads">
 <Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
    <Tr align="left">
      <Th  colspan="3" align = "center">Product Group</Th>
    </Tr>
</Table>
</div>

<DIV id="InnerBox1Div">

<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");
	retobj.check();
	//Total levels in the catalog
	int iTotalCells = retobj.getRowCount();
	int level=0;
      for ( int i = 0 ; i < ret.getRowCount(); i++ )
      {
		level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
		GroupNum = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
		GroupNum = GroupNum.trim();
%>
		<Tr bgcolor="#E1E1FF">
<%
		for ( int j = 0 ; j < (level -1); j++ )
		{
			if (level != 1)
			{
%>
			<Td>&nbsp;</Td>
<%
			}
		}

	if ((ret.getFieldValue(i,PROD_GROUP_TERMINAL_FLAG).toString()).equals("Y"))
	{
%>
	    	<Td align="left">
			<A HREF = "javascript:openWin('<%=GroupNum%>')">
				<%=(ret.getFieldValue(i,PROD_GROUP_WEB_DESC))%>
			</A>
			<input type="hidden" name="ProductGroup" value=<%=ret.getFieldValue(i,PROD_GROUP_NUMBER)%> >
			</Td>
<%
	}else
	{
%>
	    	<Td align="left">
		 	<%=(ret.getFieldValue(i,PROD_GROUP_WEB_DESC))%>
		 	<input type="hidden" name="ProductGroup" value=<%=ret.getFieldValue(i,PROD_GROUP_NUMBER)%> >
			</Td>
<%
	}//End if Terminal flag

	for ( int k = 0 ; k < (iTotalCells - level)  ; k++ )
	{
%>
			<Td>&nbsp;</Td>
<%
	}
%>
      		</Tr>
<%
   }// End for Rows

%>
</Table></div>

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
  <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>

<script>
function openWin(groupNum)
{
		var url = "ezChangeProdDesc.jsp?ProductGroup=" + groupNum + "&SystemKey=" + "<%=sys_key%>" + "&Language=" +"<%=lang%>"+  "&target=products"
		window.open(url,"UserWindow","width=790,height=500, left = 0 top = 0 resizable=no, menubar = no locationbar = no scrollbars=yes");
}
</script>

<%
 }//if(ret.getRowCount()!=0)
else
 {
%>

<br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>No Product Groups Synchronized in this Sales Area</b></div>
		</Td>
	</Tr>
</Table>
<center>
 <br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>

<%
 }
}//if(ret!=null)
%>
</form>
</body>
</html>

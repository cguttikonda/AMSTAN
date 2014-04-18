<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListReports.jsp"%> 
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script type="text/javascript">


function funAdd()
{
	document.myForm.action="ezAddReports.jsp";
	document.myForm.submit();
}
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script> 
<script src="../../Library/JavaScript/ezSortTableData.js"></script> 
</head>
<BODY onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<form name=myForm method=post>
<%
if ( listRet.getRowCount()>0) 
{
%>
	<br>
	<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" ellPadding=2 cellSpacing=0  width="89%">
  	<Tr align="center">
    		<Td class="displayheader">List of Reports</Td> 
  	</Tr>
	</Table>
	<div id="theads" >
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  	<Tr align="left">
    		<Th width="20%" align='center'> Report </Th>
    		<Th width="20%" align='center'> Description </Th>
    		<Th width="20%" align='center'> Report Url</Th>
    		<Th width="15%" align='center'> Authorised</Th>
  	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div">
	<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	
	
	
	
	
	
<%	
	//for ( int i = 0 ; i < listRet.getRowCount(); i++ )
	//{		
%>
  	<Tr align="left">
		<Td width="20%">&nbsp;Cutomer Sales
			
    		</Td>  	
 		 <Td width="20%">&nbsp;Provides the sales details of the cutomers. 
			
    		</Td> 
 		 <Td width="20%">&nbsp;/AST/EzAdmin/JSPs/Analytics/ezCustSalesRep.jsp
			
    		</Td>     		
    		
    		
    		<Td width="15%" align ="center">
    		
			<select name="AssTo" id=ListBoxDiv >
				<option value='I' selected>Internal Only</option>
				<option value='E'>External Only</option>
				<option value='B'>Both</option>
			</select>	
    		</Td>
	    	
  	</Tr>
  	  	<Tr align="left">
			<Td width="20%">&nbsp;Weekly Sales
				
	    		</Td>  	
	 		 <Td width="20%">&nbsp;Provides the weekly sales details of the cutomers. 
				
	    		</Td> 
	 		 <Td width="20%">&nbsp;/AST/EzAdmin/JSPs/Analytics/ezWeeklySalesRep.jsp.
				
	    		</Td>     		
	    		
	    		
	    		<Td width="15%" align ="center">
	    		
				<select name="AssTo" id=ListBoxDiv>
					<option value='I' selected>Internal Only</option>
					<option value='E'>External Only</option>
					<option value='B'>Both</option>
				</select>	
	    		</Td>
		    	
  	</Tr>
<%
	//}//End for
%>	
	

	</Table>
	</div>
	
<%
}
else
{
%>

	<br>
	<div id="ButtonDiv" align="right" style="position:absolute;top:30%;width:50%;left:23%">

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader">No Reports to List</Td>
	</Tr>
	</Table><br>
	</div>
<%}
%>

	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    		<a href="javascript:funAdd()"> <img src="../../Images/Buttons/<%= ButtonDir%>/save.gif"   border=none ></a>
	</div>
</form>
</body>
</html>
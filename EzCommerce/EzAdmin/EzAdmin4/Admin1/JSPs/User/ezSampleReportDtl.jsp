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
    		<Td class="displayheader">List of Configured News</Td> 
  	</Tr>
	</Table>
	<div id="theads" >
	<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
  	<Tr align="left">
    		<Th width="5%" align='center'> &nbsp; </Th>
    		<Th width="15%" align='center'> Description </Th>
    		<Th width="15%" align='center'> From Date</Th>
    		<Th width="15%" align='center'> End Date</Th>
    		<Th width="15%" align='center'> Category</Th>
    		<Th width="15%" align='center'> Authorized User(s)</Th>
    		<Th width="15%" align='center'> Authorized SalesArea(s) </Th>
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
		<Td width="5%" align="center"><input type='checkbox', name="" value=''></Td>  	
 		<Td width="15%">&nbsp;Display of new products</Td> 
 		<Td width="15%">&nbsp;02/12/2012 09:00AM EST</Td>     		
		<Td width="15%">&nbsp;02/16/2012 06:00PM EST</Td>
		<Td width="15%">&nbsp;New Products</Td> 
 		<Td width="15%">&nbsp;All</Td>     		
		<Td width="15%">&nbsp;All</Td>
	    	
  	</Tr>
	<Tr align="left">
		<Td width="5%" align="center"><input type='checkbox', name="" value=''></Td>  	
 		<Td width="15%">&nbsp;Changes in specs of fauctes </Td> 
 		<Td width="15%">&nbsp;02/01/2012 09:00AM EST	</Td>     		
		<Td width="15%">&nbsp;03/01/2012 06:00AM EST</Td>
		<Td width="15%">&nbsp;Spec. Changes</Td> 
 		<Td width="15%">&nbsp;Canada Users</Td>     		
		<Td width="15%">&nbsp;Canada SalesAreas </Td>
	    	
  	</Tr>
	<Tr align="left">
		<Td width="5%" align="center"><input type='checkbox', name="" value=''></Td>  	
 		<Td width="15%">&nbsp;Discontinued Green T Towel Bar</Td> 
 		<Td width="15%">&nbsp;01/01/2012 09:00AM EST</Td>     		
		<Td width="15%">&nbsp;06/01/2012 09:00AM EST</Td>
		<Td width="15%">&nbsp;Discontinued Products</Td> 
 		<Td width="15%">&nbsp;US Users	</Td>     		
		<Td width="15%">&nbsp;SalesArea 1001</Td>
	    	
  	</Tr>
	<Tr align="left">
		<Td width="5%" align="center"><input type='checkbox', name="" value=''></Td>  	
 		<Td width="15%">&nbsp;Code of Conduct.</Td> 
 		<Td width="15%">&nbsp;01/01/2012 09:00AM EST	</Td>     		
		<Td width="15%">&nbsp;12/31/2012 09:00AM EST</Td>
		<Td width="15%">&nbsp;Announcement</Td> 
 		<Td width="15%">&nbsp;All</Td>     		
		<Td width="15%">&nbsp;All</Td>
	    	
  	</Tr>
	<!--<Tr align="left">
		<Td width="5%" align="center"><input type='checkbox', name="" value=''></Td>  	
 		<Td width="15%">&nbsp;</Td> 
 		<Td width="15%">&nbsp;	</Td>     		
		<Td width="15%">&nbsp;</Td>
		<Td width="15%">&nbsp;</Td> 
 		<Td width="15%">&nbsp;	</Td>     		
		<Td width="15%">&nbsp;</Td>
	    	
  	</Tr>  	-->
		    	

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
    		<a href="javascript:funAdd()"> <img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif"   border=none ></a>
    		<a href="javascript:funAdd()"> <img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none ></a>
    		<a href="javascript:funAdd()"> <img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif"   border=none ></a>	
	</div>
	
</form>
</body>
</html>

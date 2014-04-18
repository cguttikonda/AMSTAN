
<HTML>
<HEAD>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<style>

   A  {text-decoration: none;
       color: black}
  .folderStyle{
       font-family: Verdana, Arial, sans-serif;
	   	font-size: 11px;
	   	font-weight: bold;
	    color: #336699;
      }
   .docStyle{
	       font-size: 11px;
	  	   font-family: verdana,helvetica;
	  	   text-decoration: none;
	  	   white-space:nowrap;
	       color: blue;
      }
</style>
<script>

	function funSubmit()
	{
		document.myForm.action = "ezDrillDownReport.jsp"
		document.myForm.submit();
	}

</script>
</Head>

<%
	String[] monthsNo={"0","1","2","3","4","5","6","7","8","9","10","11"};
	String[] monthsDesc={"January","February","March","April","May","June","July","August","September","October","November","December"};
	String CurrentMonth=null,CurrentYear=null;
	String execType="C";
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int Year 	= cdObj.get(Calendar.YEAR);
	int Month 	= cdObj.get(Calendar.MONTH);
	

	if (Month==0)
	{
		CurrentMonth	= monthsNo[11];
		CurrentYear	= String.valueOf(Year-1);
	}
	else if(Month==1)
	{
		CurrentMonth	= monthsNo[0];
		CurrentYear	= String.valueOf(Year);
	}
	else
	{
		CurrentMonth	= monthsNo[Month-1];
		CurrentYear	= String.valueOf(Year);
	}

	String selMonth 	= request.getParameter("selMonth");
	String selYear  	= request.getParameter("selYear");
	
	if(selMonth==null) selMonth=CurrentMonth;
	if(selYear==null) selYear=CurrentYear;
	
	if(Integer.parseInt(CurrentYear)-Integer.parseInt(selYear)==0)
	{
		if(Integer.parseInt(CurrentMonth)-Integer.parseInt(selMonth)>2)
			execType="P";
	}		
	else
		execType="P";
%>
<Body scroll=NO>
<Form name="myForm" method="post">
<input type="hidden" name="execType" value="<%=execType%>">
<Div id =titleDiv>
	<Table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<Tr>
			<Td height="35" class="displayheader"  width="100%"><Center>Catalog&nbsp;</Center></Td>
		</Tr>
	</Table>
</Div>
<Div width="100%" >
<Table align=center border="0" cellpadding="0" cellspacing="0"  height="92%" width="100%" >
 
<Tr>

<Td id='tdTree' width='25%' height='100%' >
	<table   height='100%' border=1 borderColorDark=#ffffff borderColorLight=#660000 cellPadding=2 cellSpacing=0 >
		<tr height='5%'>
			<th class=displayalert align ="center">Product Groups</th>
		</tr>
		<tr height='95%' VALIGN=TOP >	
			<td >
				<IFrame id="treeFrame" name="treeTab" src="ezDrillDownTree.jsp" width='100%' height='100%' frameborder=0 scrolling="no"></IFrame>
			</td>	
		</tr>
	</table>
	
</Td>
<Td width='75%' id='tdGrid' height='100%'>
	<IFrame id="gridFrame" name="dispTab" src="ezDrillDownDisplay.jsp" width='100%' height='100%' frameborder=0 scrolling="no"></IFrame>
</Td>
</Tr>
</Table>
</Div>	
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<html>
<head>
    <script>
         function validate()
         {   
         	if(document.myForm.reportType.selectedIndex==0)
		{
			alert("Please select Report Type")
         	}
         	else if(document.myForm.timePeriod.selectedIndex==0)
         	{
         		alert("Please select Time Period")
         	}
         	else
         	{
         		var timePeriod = document.myForm.timePeriod[document.myForm.timePeriod.selectedIndex].value
         		var reportType = document.myForm.reportType[document.myForm.reportType.selectedIndex].value;
     			obj = window.open('ezReport.jsp?timePeriod='+timePeriod+'&reportType='+reportType,"timePeriod","resizable=no,left=0,top=10,height=600,width=950,status=no,toolbar=no,menubar=no,location=no , scrollbars = yes");       			       			       			     		
     		}	
         }
    </script>
</head>
<body scroll=no>
<form name="myForm" method="post">
<%
	String display_header = "";
%>	

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br><br>

<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

<Tr>
      <Th>Select Type</Th>
      <Td>
	<select name=reportType>
		<option value=''>--Select ReportType--</option>
		<option value='VENREQ'>Vendor-Request Report</option>
		<option value='VENRES'>Vendor-Response Report</option>
		<option value='VENWIN'>Vendor-Win Report</option>
	</select>
      </Td>		
      <Th>Select TimePeriod</Th>
      <Td>
	<select name=timePeriod>
		<option value=''>--Select TimePeriod--</option>
		<option value=6>Last 6 Months</option>
		<option value=12>Last 1 Year</option>
		<option value=18>Last 1.5 Years </option>
		<option value=24>Last 2 Years</option>
	</select>
      </Td>		
      <Td>
        <img src="../../Images/Buttons/<%= ButtonDir%>/Go.gif" style="cursor:hand" onClick="validate()" border="none">
      </Td>
   </Tr>
</Table>
</form>
<Div id="MenuSol"></Div>
</body> 
</html>
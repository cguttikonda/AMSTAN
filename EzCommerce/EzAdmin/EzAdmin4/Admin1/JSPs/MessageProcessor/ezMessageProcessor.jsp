<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/MessageProcessor/iMessageProcessor.jsp"%>


<html>
<head>
<script LANGUAGE="JavaScript">
function VerifyParameterValues() {
	var start = document.MessageProcessor.starttime.value;
	var end = document.MessageProcessor.endtime.value;
	var inttime = document.MessageProcessor.interval.value;
	if ((start < 0) || (start > 2400))
	{
		alert("Please enter a start time beween 0000 hrs and 2400 hrs ");
		document.MessageProcessor.starttime.focus();
		document.returnValue = false;
	}
	else
	{
		if ((end < 0) || (end > 2400)){
			alert("Please enter an end time beween 0000 hrs and 2400 hrs ");
			document.MessageProcessor.endtime.focus();
			document.returnValue = false;
		}
		else
		{
			if (start > end)
			{
				alert("Please enter an end time later than the start time ");
				document.MessageProcessor.endtime.focus();
				document.returnValue = false;
			}
			else
			{
				if (((start>0) ||(end>0)) && (inttime <= 0))
				{
					alert("Please enter a valid interval ");
					document.MessageProcessor.interval.focus();
					document.returnValue = false;
				}
				else
					document.returnValue = true;
			}
		}
	}
	
}

</script>

<Title>Processing Messages</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Enter parameters for Message Processing</Td>
  </Tr>
</Table>
<form method="post" action="ezSetParameters.jsp" name="MessageProcessor">
  <Table  width="80%" border="1" cellpadding="5" cellspacing="1" align="center">
    <Tr> 
      <Th colspan="2">Please enter the following information: </Th>
    </Tr>
    <Tr> 
      <Td width="34%" class="labelcell">Interval:</Td>
      <Td width="66%"> 
        <input type=text class = "InputBox" name=interval value=<%=var_interval%> >
      </Td>
    </Tr>
    <Tr> 
      <Td width="34%" class="labelcell">Start Time:</Td>
      <Td width="66%"> 
        <input type=text class = "InputBox" name=starttime value=<%=var_starttime%> >
      </Td>
    </Tr>
    <Tr> 
      <Td width="34%" class="labelcell">End Time:</Td>
      <Td width="66%"> 
        <input type=text class = "InputBox" name=endtime value=<%=var_endtime%> >
      </Td>
    </Tr>
    <Tr>
      <Td width="34%" class="labelcell">TestMode</Td>
      <Td width="66%">
        <input type="checkbox" name=testMode value="checkbox">
      </Td>
    </Tr>
  </Table>  
  <div align="center"> 
    <input type="submit" name= "Submit" value="Set Parameters" onClick="VerifyParameterValues(); return document.returnValue">
    <br>
  </div>
</form>
</body>
</html>

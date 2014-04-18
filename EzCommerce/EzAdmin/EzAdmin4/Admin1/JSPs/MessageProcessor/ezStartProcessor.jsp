<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%

	try{
		long var_interval = new Long(request.getParameter("interval")).longValue();
		long var_starttime = new Long(request.getParameter("starttime")).longValue();
		long var_endtime = new Long(request.getParameter("endtime")).longValue();

		ezc.eztransmessage.processor.EzScheduleParameters schparams = new ezc.eztransmessage.processor.EzScheduleParameters();
		schparams.setEndTimeofSchedule(var_endtime);
		schparams.setStartTimeofSchedule(var_starttime);
		schparams.setTimeInterval(var_interval);
	
		ezRmi.setScheduleParameters(null,schparams);
		ezRmi.startScheduler(null,schparams,request.getParameter("clientid"));
		
	}catch(Exception e){
		ezc.ezutil.EzSystem.out.println("Unable to Get the RMI Server Reference :: " + e);
	}
	
%>

<html>
<head>


<Title>Processing Messages</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script language="JavaScript">

function setFlag(){
	alert("Inside Fn");
	alert("Flag Value: " + document.forms[0].processflag.value);
	document.forms[0].processflag.value = 'Y';
	alert("Flag Value: " + document.forms[0].processflag.value);
	document.returnValue = true;
}

function processMessage()
{
	document.returnValue = true;
}

</script>
</head>
<body>
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Process Messages</Td>
  </Tr>
</Table>

<form method="post" action="ezStopProcessor.jsp" name="" >
  <Table  width="80%" border="1" cellpadding="5" cellspacing="1" align="center">
    <Tr> 
      <Th colspan="2">Please enter the message ID you wish to process: </Th>
    </Tr>
    <Tr> 
      <Td width="34%" class="labelcell">Message:</Td>
      <Td width="66%">
	<input type=text class = "InputBox" name=message >
      </Td>
    </Tr>
    
    
    <Tr> 
      <Td width="34%" class="labelcell">Client ID:</Td>
      <Td width="66%"> 

        <input type=text class = "InputBox" name=clientid >
        <input type="submit" name="Submit" value="Start Processor" >
      </Td>
    </Tr>
  </Table>  
  <div align="center">
    <input type="hidden" name="processflag" value="stopprocessor" >
    <input type="submit" name="Submit2" value="Stop processor" onClick="setFlag();return document.returnValue">
    <br>
  </div>
</form>
</body>
</html>

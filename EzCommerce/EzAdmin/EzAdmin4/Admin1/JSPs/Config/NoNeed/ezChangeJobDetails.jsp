<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iChangeJobDetails.jsp"%>

<html>   
<head>
<script language = "javascript">
function trim( inputStringTrim) 
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
		ch = inputStringTrim.charAt(x);
 		if ((ch != " ") || (lastCh != " ")) 
 		{ fixedTrim += ch; }
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ") 
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); 
	}
	return fixedTrim;
}   

function checkAll() {
	var form = document.forms[0]
	for (i = 0; i < form.elements.length; i++) 
	{
		if (form.elements[i].type == "text" && trim(form.elements[i].value) == "")
            	{ 
			alert("Please fill out all the fields.")
		      	form.elements[i].focus();
			document.returnValue = false;
			return;
		}
		else
		{
			document.returnValue = true;
		}//End if
	}//End for

      	if ( !isDate( form.elements["jobdate"].value ) )
      	{
         	alert('Invalid Job Creation Date! Correct it');
	   	form.elements["jobdate"].focus();
         	form.elements["jobdate"].select();
	   	document.returnValue = false;
         	return;
       	}

      	if ( !isDate( form.elements["expiredate"].value ) )
      	{
         	alert('Invalid Expiration Date! Correct it');
	   	form.elements["expiredate"].focus();
         	form.elements["expiredate"].select();
	   	document.returnValue = false;
         	return;
       	}

      	if ( form.elements["expiredate"].value < form.elements["jobdate"].value )
      	{
         	alert('Expiration Date Should be greater than or equal to Job Creation Date');
	   	form.elements["expiredate"].focus();
         	form.elements["expiredate"].select();
	   	document.returnValue = false;
         	return;
       	} 
       	
       
       if ( !isTime(form.elements["jobtime"].value) )
       {
       		 alert('Invalid Time Format! Correct it');
	         form.elements["jobtime"].select();       		
	         form.elements["jobtime"].focus();
		   document.returnValue = false;
		   return;
       		
       }
       
       if ( isNaN(form.elements["timeintreval"].value) )
       {
       		alert('Time Intreval should be numeric');
         	form.elements["timeintreval"].select();       		
	        form.elements["timeintreval"].focus();
	   	document.returnValue = false;
		return;
       }
       else
       {
       		document.returnValue = true;
	}
       

}//end function


function isTime(sValue)
{
	if ( sValue.length < 8 ) 
	{
		return false;
	}

	if ( sValue.charAt(2) != ':'  ) 
	{
		return false;
	}
	if ( sValue.charAt(5) != ':'  ) 
	{
		return false;
	}

	var str1 = sValue.substring(0,2);
	if ( isNaN(str1) || str1 < 0 || str1 > 23 ) return false;	
	var str2 = sValue.substring(3,5);
	if ( isNaN(str2) || str2 < 0 || str2 > 59 ) return false;	
	var str3 = sValue.substring(6,8);
	if ( isNaN(str3) || str3 < 0 || str3 > 59 ) return false;	
	return true;
	
}

function isDate(sValue)
{
	// Checks for the following valid date formats:
	// MM/DD/YY   MM/DD/YYYY   MM-DD-YY   MM-DD-YYYY
	// Also separates date into month, day, and year variables

	// To require a 2 digit year entry, use this line instead:
	var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;

	// To require a 4 digit year entry, use this line instead:
	//var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

	var matchArray = sValue.match(datePat); // is the format ok?
	if (matchArray == null)
	{
		msgString ="Date is not in a valid format.";
		return false;
	}
	month = matchArray[1]; // parse date into variables
	day = matchArray[3];
	year =parseInt(matchArray[4]);
	if (month < 1 || month > 12)
	{
		// check month range
		msgString ="Month must be between 1 and 12.";
		return false;
	}

	/*if (year < 1900  || year > 2050)
	{
		// checkYear range
		msgString="Year must be between 1900  and 2050.";
		return false;
	}*/
	if (day < 1 || day > 31)
	{
		msgString="Day must be between 1 and 31.";
		return false;
	}
	if ((month==4 || month==6 || month==9 || month==11) && day==31)
	{
		msgString="Month "+month+" doesn't have 31 days!";
		return false;
	}
	if (month == 2)
	{
		// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			msgString ="February of Year" + year + " doesn't have " + day + " days!";
                        return false;
		}
	}
		return true;  // date is valid
} //end isDate


function FormAction()
{
    document.ChangeJob.action = "ezSaveChangeJobDetails.jsp?jobid="+document.ChangeJob.jobid.value+
                                "&client="+document.ChangeJob.client.value;
    //document.ChangeJob.submit();
    document.returnValue=true;
}

function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "jobid=" + document.ChangeJob.jobid.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;

}
</script>

<Title>Change Job Information</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7">
<Table  width="50%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Change Job Information</Td>
  </Tr>
</Table>
<%
if(numJobs > 0){

     //To Preselect subscription, confirmation and completion from the query
     String subY = "";   //subscription Yes
     String subN = "";   //subscription No
     String conY = "";   //Confirmation Yes
     String conN = "";   //Confirmation No
     String comY = "";   //Completion Yes
     String comN = "";   //Completion No
     String subscription = (String) retinfo.getFieldValue(0,SUBSCRIPTION);
     String confirmation = (String) retinfo.getFieldValue(0,CONFIRMATION);
     String completion = (String) retinfo.getFieldValue(0,COMPLETION);
     
     String HH="";
     String MM="";
     String SS="";
     String timeU = retinfo.getFieldValueString(0,"EJC_TIME_UNIT").trim();
     if ( timeU.equals("HH") )HH="selected";
     if ( timeU.equals("MM") )MM="selected";
     if ( timeU.equals("SS") )SS="selected";

     subY = ( subscription.equals("Y") )?"selected":"";
     subN = ( subscription.equals("N") )?"selected":"";
     conY = ( confirmation.equals("Y") )?"selected":"";
     conN = ( confirmation.equals("N") )?"selected":"";
     comY = ( completion.equals("Y") )?"selected":"";
     comN = ( completion.equals("N") )?"selected":"";

%>
<form method="post" action="ezSaveChangeJobDetails.jsp" name="ChangeJob"> 
  <Table  width="50%" border="2" align="center">
    <Tr> 
      <Td width="49%" class="labelcell">Job Id:</Td>
      <Td width="51%" class="blankcell"> <%@ include file="../../../Includes/Lib/ListBox/LBJob.jsp"%>
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  width="67%" align="center">
    <Tr> 
      <Td valign="top" align="left" width="100%" class="blankcell" colspan="2"> 
        <div align="left"></div>
        <Table  width="102%" border="0" hspace="15" align="left">
          <Tr> 
            <Td width="35%" height="16" class="labelcell">Client Id:</Td>
            <Td width="65%" height="16"><%	out.println(retinfo.getFieldValue(0,CLIENT));
%></Td>
          </Tr>
          <Tr> 
            <Td width="35%" height="16" class="labelcell">Job Description:</Td>
            <Td width="65%" height="16"> <%	out.println(retinfo.getFieldValue(0,TRANSACTION));
%> </Td>
          </Tr>
          <Tr> 
            <Td width="35%" height="35" class="labelcell">Job Type:</Td>
            <Td height="35" width="65%"> <%	out.println(retinfo.getFieldValue(0,JOB_TYPE));
%> </Td>
          </Tr>
          <Tr> 
            <Td width="35%" height="37" class="labelcell">Transaction:</Td>
            <Td height="37" width="65%"> <%	out.println(retinfo.getFieldValue(0,TRANSACTION));
%> </Td>
          </Tr>
          
<%
String crDate = retinfo.getFieldValueString(0,"EJC_CREATION_DATE").trim();
if ( crDate.length() == 5 )crDate="0"+crDate;
crDate = crDate.substring(0,2)+"/"+crDate.substring(2,4)+"/"+crDate.substring(4,6);

String crTime = retinfo.getFieldValueString(0,"EJC_CREATION_TIME").trim();
if ( crTime.length() == 5 )crTime="0"+crTime;
if ( crTime.length() == 4 )crTime="00"+crTime;
if ( crTime.length() == 3 )crTime="000"+crTime;
if ( crTime.length() == 2 )crTime="0000"+crTime;
if ( crTime.length() == 1 )crTime="00000"+crTime;
if ( crTime.length() == 0 )crTime="000000"+crTime;

crTime = crTime.substring(0,2)+":"+crTime.substring(2,4)+":"+crTime.substring(4,6);

String scDate = retinfo.getFieldValueString(0,"EJC_START_DATE").trim();
if ( scDate.length() == 5 )scDate="0"+scDate;
scDate = scDate.substring(0,2)+"/"+scDate.substring(2,4)+"/"+scDate.substring(4,6);

String scTime = retinfo.getFieldValueString(0,"EJC_START_TIME").trim();
if ( scTime.length() == 5 )scTime="0"+scTime;
if ( scTime.length() == 4 )scTime="00"+scTime;
if ( scTime.length() == 3 )scTime="000"+scTime;
if ( scTime.length() == 2 )scTime="0000"+scTime;
if ( scTime.length() == 1 )scTime="00000"+scTime;
if ( scTime.length() == 0 )scTime="000000"+scTime;
scTime = scTime.substring(0,2)+":"+scTime.substring(2,4)+":"+scTime.substring(4,6);

String exDate = retinfo.getFieldValueString(0,"EJC_EXPIRY_DATE").trim();
if ( exDate.length() == 5 )exDate="0"+exDate;
exDate = exDate.substring(0,2)+"/"+exDate.substring(2,4)+"/"+exDate.substring(4,6);


%>
          
          <Tr> 
            <Td width="35%" height="35" class="labelcell">Job Schedule Date:</Td>
            <Td height="35" width="65%"> 
              <input type=text class = "InputBox" name="jobdate" size="8" maxlength="8" value="<%= scDate %>">
              (mm/dd/yy) </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Job Schedule Time:</Td>
            <Td width="65%"> 
              <input type=text class = "InputBox" name="jobtime" size="8" maxlength="8" value="<%= scTime %>">
              (hh:mm:ss) </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Time Intreval:</Td>
            <Td width="65%"> 
              <input type=text class = "InputBox" name="timeintreval" size="8" maxlength="6" value="<%= retinfo.getFieldValue(0,"EJC_TIME_INTREVAL") %>">
              </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Time Unit:</Td>
            <Td width="65%"> 
                    <select name="timeunit" size="1">
                      <option value="HH" <%=HH%>>Hours</option>
                      <option value="MM" <%=MM%>>Minutes</option>
                      <option value="SS" <%=SS%>>Seconds</option>
                    </select>
          </Tr>
          
          <Tr> 
            <Td width="35%" class="labelcell"> Input File Path:</Td>
            <Td width="65%"> 
              <input type=text class = "InputBox" name="inputfilepath" size="25" maxlength="255" value="<%= retinfo.getFieldValue(0,FILE_PATH) %>">
            </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Subscription:</Td>
            <Td width="65%"> 
              <select name="subscription" size="1">
                <option value="Y" <%= subY %>>Yes</option>
                <option value="N" <%= subN %>>No</option>
              </select>
            </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Confirmation:</Td>
            <Td width="65%"> 
              <select name="confirmation" size="1">
                <option value="Y" <%= conY %>>Yes</option>
                <option value="N" <%= conN %>>No</option>
              </select>
            </Td>
          </Tr>
          <Tr> 
            <Td width="35%" height="23" class="labelcell">Completion:</Td>
            <Td width="65%"> 
              <select name="completion" size="1">
                <option value="Y" <%= comY %>>Yes</option>
                <option value="N" <%= comN %>>No</option>
              </select>
            </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Expiration Date:</Td>
            <Td width="65%"> 
              <input type=text class = "InputBox" name="expiredate" size="8" maxlength="8" value="<%= exDate %>">
              (mm/dd/yy) </Td>
          </Tr>
          <Tr> 
            <Td width="35%" class="labelcell">Priority Code:</Td>
            <Td width="65%"> 
              <input type=text class = "InputBox" name="priority" size="5" maxlength="2" value="<%= retinfo.getFieldValue(0,PRIORITY) %>">
            </Td>
          </Tr>
          <Tr>
            <Td width="35%" class="labelcell">&nbsp;</Td>
            <Td width="65%">
              <input type="hidden" name="client" value="<%= retinfo.getFieldValue(0,CLIENT) %>">
            </Td>
          </Tr>
        </Table>
        <br>
      </Td>
    </Tr>
  </Table>
  <div align="center"><input type="submit" name="Submit" value="Change Job" onClick="checkAll();return document.returnValue"></div>
</form>
<%
}else{
%> <br>
<br>
<br>
<Table  width=60% align="center">
  <Tr align="center"> 
    <Td><font size="4" style="bold">There are no Jobs to be changed.</font></Td>
</Tr>
</Table>
<%
}//end if number of Jobs > 0
%>
</body>
</html>

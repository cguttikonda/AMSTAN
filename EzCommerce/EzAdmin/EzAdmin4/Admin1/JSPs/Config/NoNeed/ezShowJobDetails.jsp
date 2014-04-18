<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iShowJobDetails.jsp"%>

<html> 
<head>
<Title>Show Job Information</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7">
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Job Information</Td>
  </Tr>
</Table>
<br>
<Table  width="100%" border="0" height="486" align="center" cellpadding="0" cellspacing="0">
  <Tr> 
    <Td height="189" valign="top" colspan="2" align="center" class="blankcell"> 
      <form method="post" action="" name="ShowJobDetails">
        <Table  width="61%" border="1" align="center">
          <Tr> 
            <Td valign="top" align="left" width="100%" class="blankcell" colspan="2"> 
              <div align="left"></div>
              <Table  width="102%" border="0" hspace="15" align="center">
                <Tr> 
                  <Td width="32%" height="16" class="labelcell">Client Id:</Td>
                  <Td width="68%" height="16"> <%
	out.println(retinfo.getFieldValue(0,CLIENT));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" height="35" class="labelcell">Job Id:</Td>
                  <Td height="35" width="68%"><%
	out.println(retinfo.getFieldValue(0,JOB_ID));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" height="35" class="labelcell">Job Type:</Td>
                  <Td height="35" width="68%"><%
	out.println(retinfo.getFieldValue(0,JOB_TYPE));
%> </Td>
                </Tr>
                <Tr> 
                  <Td width="32%" height="35" class="labelcell">Job Description:</Td>
                  <Td height="35" width="68%"><%
	out.println(retinfo.getFieldValue(0,TRANSACTION));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" height="35" class="labelcell">Transaction:</Td>
                  <Td height="35" width="68%"><%
	out.println(retinfo.getFieldValue(0,TRANSACTION));
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
                  <Td width="32%" class="labelcell">Job Creation Date:</Td>
                  <Td width="68%"><%
	out.println(crDate);
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell">Job Creation Time:</Td>
                  <Td width="68%"><%
	out.println(crTime);
%></Td>
                </Tr>
              
                <Tr> 
                  <Td width="32%" class="labelcell">Job Schedule Date:</Td>
                  <Td width="68%"><%
	out.println(scDate);
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell"> Job Schedule Time:</Td>
                  <Td width="68%"><%
	out.println(scTime); 
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell"> Time Intreval:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValueString(0,"EJC_TIME_INTREVAL")); 
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell"> Time Unit:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValueString(0,"EJC_TIME_UNIT")); 
%></Td>
                </Tr>
                
                <Tr> 
                  <Td width="32%" class="labelcell">Input File Path:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValue(0,FILE_PATH));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell">Subscription :</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValue(0,SUBSCRIPTION));
%> </Td>
                </Tr>
                <Tr> 
                  <Td width="32%" height="23" class="labelcell">Confirmation:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValue(0,CONFIRMATION));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell">Completion:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValue(0,COMPLETION));
%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell">Expiration Date:</Td>
                  <Td width="68%"><%
	out.println(exDate);
%><%%></Td>
                </Tr>
                <Tr> 
                  <Td width="32%" class="labelcell">Priority Code:</Td>
                  <Td width="68%"><%
	out.println(retinfo.getFieldValue(0,PRIORITY));
%><%%></Td>
                </Tr>
              </Table>
            </Td>
          </Tr>
        </Table>
      </form>
    </Td>
  </Tr>
</Table>
</body>
</html>
<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/Config/iListAuth.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<html>
<head>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script src="../../Library/JavaScript/WorkFlow/ezWFDocList.js"></script>
<Title></Title>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
</head>

<body onLoad="document.myForm.SysKey.focus()">
<form name=myForm method=post action="ezDisplayWFDocList.jsp" onSubmit="return checkAll()">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=95%>
<Tr>
	<Td class="displayheader" align=center colspan=6>Document List</Td>
</Tr>
 <Tr>
    <Td class=labelcell>Auth Key</Td>
    <Td><div id="ListBoxDiv1">
       	<select name="authKey" style="width:100%">
	<option value="">Select Auth Key</option>
<%

	for(int i=0;i<ret.getRowCount();i++)
	{
%>
	<option value='<%= ret.getFieldValue(i,"EUAD_AUTH_KEY") %>'> <%= ret.getFieldValue(i,"EUAD_AUTH_DESC") %></option>
<%
	}
%>
</select></div>
	</Td>
    <Td class=labelcell>Sys Key</Td>
    <Td><input type=text class = "InputBox" size=12     name="SysKey" value=""></Td>

	</Td>

    <Td class=labelcell>Status</Td>
    <Td><input type=text class = "InputBox" size=12     name="Status" value="">
</Td>
 </Tr>
 <Tr>
    <Td class=labelcell>Step</Td>
    <Td><input type=text class = "InputBox" size=12     name="Step" value=""></Td>
    <Td class=labelcell>Participant</Td>
    <Td><input type=text class = "InputBox" size=12     name="Participant" value=""></Td>
    <Td class=labelcell>Participant Type</Td>
    <Td><input type=text class = "InputBox" size=12     name="ParticipantType" value=""></Td>
  </Tr>
   <Tr>
    <Td class=labelcell>Created By</Td>
    <Td><input type=text class = "InputBox" size=12     name="CreatedBy" value=""></Td>
    <Td class=labelcell>Modified By</Td>
    <Td ><input type=text class = "InputBox" size=12     name="ModifiedBy" value=""></Td>

      <Td class=labelcell>DOC ID</Td>
    <Td><input type=text class = "InputBox" size=12     name="DocId" value=""></Td>

  </Tr>
  <Tr>
  </Tr>
  <Tr>
    <Td class=labelcell>Ref1</Td>
    <Td><input type=text class = "InputBox" size=12     name="Ref1" value=""></Td>
    <Td class=labelcell>Ref2</Td>
    <Td><input type=text class = "InputBox" size=12     name="Ref2" value=""></Td>
     <Td class=labelcell>Doc Date</Td>
  <Td ><nobr><input type=text class = "InputBox" size=12     name="DocDate" readonly>
      <a href="javascript:showCal('document.myForm.DocDate',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></nobr>
    </Td>
  </Tr>
   <Tr>
       <Td class=labelcell>Created On</Td>
       <Td><nobr><input type=text class = "InputBox" size=12     name="CreatedOn1" readonly>
      <a href="javascript:showCal('document.myForm.CreatedOn1',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></nobr>
      </Td>
      <Td><nobr>
      <input type=text class = "InputBox" size=12     name="CreatedOn2" readonly>
      <a href="javascript:showCal('document.myForm.CreatedOn2',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></nobr>
      </Td>
      <Td class=labelcell>Modified On</Td>
      <Td><nobr><input type=text class = "InputBox" size=12     name="ModifiedOn1" readonly>
      <a href="javascript:showCal('document.myForm.ModifiedOn1',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></nobr>
      </Td><Td><nobr>
      <input type=text class = "InputBox" size=12     name="ModifiedOn2" readonly>
      <a href="javascript:showCal('document.myForm.ModifiedOn2',80,250)"><img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a></nobr>
      </Td>
  </Tr>
  <Tr>
      <Th class=labelcell colspan=6>Group By</Th>
  </Tr>
  <Tr><Td colspan=6>
  	<Table  width=100%>
  	<Tr>
      <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_AUTH_KEY">AuthKey</Td>
      <Td width=14%><input type="checkbox" name="chk1" value=" EWDHH_SYSKEY">SysKey</Td>
      <Td width=13%><input type="checkbox" name="chk1" value="EWDHH_WF_STATUS">Status</Td>
      <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_CURRENT_STEP">Step</Td>
      <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_NEXT_PARTICIPANT">Participant</Td>
      <Td width=17%><input type="checkbox" name="chk1" value="EWDHH_PARTICIPANT_TYPE"><nobr>Participant Type<nobr></Td>
      <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_CREATED_BY">Created By</Td>
      </Tr>
      </Table>
      </Td>
 </Tr>
 <Tr><Td colspan=6>
   	<Table  width=100%>
        <Tr>
            <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_MODIFIED_BY">ModifiedBy</Td>
            <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_DOC_DATE">Doc Date</Td>
            <Td width=13%><input type="checkbox" name="chk1" value="EWDHH_DOC_ID">Doc Id</Td>
            <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_CREATED_ON">Created On</Td>
            <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_MODIFIED_ON">Modified On</Td>
            <Td width=17%><input type="checkbox" name="chk1" value="EWDHH_REF1">Ref1</Td>
	    <Td width=14%><input type="checkbox" name="chk1" value="EWDHH_REF2">Ref2</Td>

      </Tr>
      </Table>
      </Td>

</Table><br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=no  >
</center>
</form>
</body>
</html>

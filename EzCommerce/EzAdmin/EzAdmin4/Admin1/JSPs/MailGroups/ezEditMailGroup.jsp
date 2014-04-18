<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/MailGroups/iEditMailGroup.jsp"%>

<html>
<head>
    	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
    	<%@ include file="ezTabScript.jsp"%>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
    	<script src = "../../Library/JavaScript/MailGroups/ezEditMailGroup.js"></script> 	
    
<script>
var activeTabIndex=0;
function funHeader()
{
	activeTabIndex=1
	tabfun(1,4,"document.myForm")
	document.getElementById("ID1").style.visibility="visible"
	document.getElementById("ID2").style.visibility="hidden"
	document.getElementById("ID3").style.visibility="hidden"
	document.getElementById("ID4").style.visibility="hidden"
	document.getElementById("ButtonDiv1").style.visibility="visible"
	document.getElementById("ButtonDiv2").style.visibility="hidden"
}
function funIncoming()
{
	activeTabIndex=2
	tabfun(2,4,"document.myForm")
	document.getElementById("ID1").style.visibility="hidden"
	document.getElementById("ID2").style.visibility="visible"
	document.getElementById("ID3").style.visibility="hidden"
	document.getElementById("ID4").style.visibility="hidden"
	document.getElementById("ButtonDiv1").style.visibility="visible"
	document.getElementById("ButtonDiv2").style.visibility="hidden"
}
function funOutgoing()
{
	activeTabIndex=3
	tabfun(3,4,"document.myForm")
	document.getElementById("ID1").style.visibility="hidden"
	document.getElementById("ID2").style.visibility="hidden"
	document.getElementById("ID3").style.visibility="visible"
	document.getElementById("ID4").style.visibility="hidden"
	document.getElementById("ButtonDiv1").style.visibility="visible"
	document.getElementById("ButtonDiv2").style.visibility="hidden"
}
function funAsynchronous()
{
	activeTabIndex=4
	tabfun(4,4,"document.myForm")
	document.getElementById("ID1").style.visibility="hidden"
	document.getElementById("ID2").style.visibility="hidden"
	document.getElementById("ID3").style.visibility="hidden"
	document.getElementById("ID4").style.visibility="visible"
	document.getElementById("ButtonDiv1").style.visibility="hidden"
	document.getElementById("ButtonDiv2").style.visibility="visible"
}

function funNext(val)
{

	if(val==1) funIncoming()
	if(val==2) funOutgoing()
	if(val==3) funAsynchronous()
	
}

function funBack(val)
{

	if(val==1)
	{
	history.go(-1);
	}
	if(val==2) funHeader()
	if(val==3) funIncoming()
	if(val==4) funOutgoing()
}

</script>
</head>

<body onLoad="document.myForm.groupDesc.focus();funHeader()" scroll="no">
<form name="myForm" method=post onSubmit="return checkField()">

<div id="totDiv" style="position:absolute;top:8%;width:89%;height:65%;left:4%">
<Table  border=0 cellPadding=0 cellSpacing=0  width="80%" align=center>
<TBODY>
<Tr>
	<Td  align=center>
	<Table  id="tabs" cellSpacing=0 cellPadding=0 width=100% border=0>
	<TBODY>
	    <Tr>
			 <Td vAlign=bottom width=100%  class=blankcell>
			 <Table  cellSpacing=0 cellPadding=0 border=0 >
			 <TBODY>
			 <Tr>
			 	<Td class=blankcell width=10 ><IMG height=27 name=startBack  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15 border=0></Td>
				<Td class=blankcell id='tab1_1'  background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif><a  href="javascript:funHeader()" title="Header" style="text-decoration:none" class=tabclass> &nbsp;&nbsp; Header &nbsp;&nbsp; </font></b></a></Td>
				<Td class=blankcell width=10><IMG height=27 name='tab1_2'  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=10><IMG height=27 name='tab1_3'  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif" width=15  border=0></Td>
			     			   
			     	<Td class=blankcell  id='tab2_1' background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a href="javascript:funIncoming()" title="Incoming"  style="text-decoration:none" class=tabclass>&nbsp;&nbsp;&nbsp;&nbsp; Incoming &nbsp;&nbsp;&nbsp;&nbsp;  </b></a></Td>
				<Td class=blankcell width=10><IMG height=27  name='tab2_2' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=12><IMG height=27  name='tab2_3' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=12 border=0></Td>

				<Td class=blankcell id='tab3_1' background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="javascript:funOutgoing()"  title="Outgoing" style="text-decoration:none" class=tabclass>&nbsp;&nbsp;&nbsp;&nbsp; Outgoing &nbsp;&nbsp;&nbsp;&nbsp;</b></a></Td>
				<Td class=blankcell width=10><IMG height=27 name='tab3_2' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
				<Td class=blankcell width=12><IMG height=27  name='tab3_3' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=12 border=0></Td>

				<Td class=blankcell id='tab4_1' background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="javascript:funAsynchronous()"  title="Asynchronous" style="text-decoration:none" class=tabclass>&nbsp;&nbsp;&nbsp;&nbsp; Asynchronous &nbsp;&nbsp;&nbsp;&nbsp;</b></a></Td>
				<Td class=blankcell width=10><IMG height=27 name='tab4_2' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
				<Td class=blankcell width=10><IMG height=27 name='tab4_3' src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif" width=15 border=0></Td>

 			</Tr>
	 	    </TBODY>
		 	</Table >
			</Td>
			<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
 		</Tr>
	</TBODY>
	</Table >
	</Td>
</Tr>
</Table >
<div id="head"  align=center style="width:100%">
<Table  width=80% cellPadding=0 cellSpacing=0 >
<tr><td width=98%>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0 width="99%">
<Tr>
	  <Td align="center" class="displayheader"> Edit Mail Group</Td>
</Tr>
</Table>
</td>
<td class=blankcell>&nbsp;</td>
</tr>
</table>
</div>
<div id="ID1"  style="overflow:auto;position:absolute;height:100%;width:100%">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<Tr>
	<Th align=right width="30%">GroupId:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"GROUPID")%></Td>
	<Th align=right width="30%">Description:*</Th>
	<Td width="20%"><input type=text class = "InputBox" name="groupDesc" maxlength=50 value='<%=mailGroupObj.getFieldValueString(0,"GROUPDESC")%>'></Td>

</Tr>

<Tr>
	<Th align=right width="30%">Host:*</Th>
	<Td width="20%"><input type=text class = "InputBox" name="host" value='<%=mailGroupObj.getFieldValueString(0,"HOST")%>'></Td>
	<Th align=right width="30%">From:*</Th>
	<Td width="20%"><input type=text class = "InputBox" name="from" maxlength=30 value='<%=mailGroupObj.getFieldValueString(0,"FROM1")%>'></Td>
</Tr>
<Tr>
	<Th align=right width="30%">Exception Listener:*</Th>
	<Td width="20%"><input type=text class = "InputBox" name=listener maxlength=50 value='<%=mailGroupObj.getFieldValueString(0,"EXLISTENER")%>'></Td>
	<Th align=right width="30%">Logfile:*</Th>
	<Td width="20%"><input type=text class = "InputBox" name=logfile maxlength=50 value='<%=mailGroupObj.getFieldValueString(0,"LOGFILE")%>'></Td>
</Tr>
<Tr>
<label for="cb_<%=0%>">
	
	<Th align=right width="30%">Authent. Req:</Th>
	<Td width="20%">
<%
	  if("Y".equals((mailGroupObj.getFieldValueString(0,"ISAUTHREQ")).trim()))
	  {
	 %> 
	    <input type=checkbox name="authRequired" checked>
	 <%
	   }
	   else
	   {
	 %>
	    <input type=checkbox id="cb_<%=0%>" name="authRequired">
	  <%
	   }
	  %>
	
</label>
</Td>
<label for="cb_<%=1%>">
	<Th align=right width="30%">Debug:</Th>
<Td width="20%">

<%
	  if("Y".equals((mailGroupObj.getFieldValueString(0,"DEBUG")).trim()))
	  {
	 %> 
	    <input type=checkbox id="cb_<%=1%>" name="debug" checked>
	 <%
	   }
	   else
	   {
	 %>
	    <input type=checkbox name="debug">
	  <%
	   }
	  %>
	
</label>
</Tr>

<Tr>
	<Th align=right width="30%">User Name:</Th>
	<Td width="20%">

<%
if("null".equals(mailGroupObj.getFieldValueString(0,"USERID"))||"".equals(mailGroupObj.getFieldValueString(0,"USERID")))
{
%>
<input type="text" class = "InputBox" name="user" maxlength=30></Td>
<%
}
else
{
%>
<input type="text" class = "InputBox" name="user" maxlength=30 value='<%=mailGroupObj.getFieldValueString(0,"USERID")%>'></Td>
<%
}
%>
</Td>
	<Th align=right width="30%">Password:</Th>
	<Td width="20%">
<%
if("null".equals(mailGroupObj.getFieldValueString(0,"PASSWORD"))||"".equals(mailGroupObj.getFieldValueString(0,"PASSWORD")))
{
%>
<input type="password" class = "InputBox" name="pass" maxlength=30 value=""></Td>
<%
}
else
{
%>
<input type="password" class = "InputBox" name="pass" maxlength=30 value="********"></Td>
<%
}
%>
</Tr>
</Table>
</div>

<div id="ID2"  style="overflow:auto;position:absolute;height:100%;width:100%">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<Tr>
<Th align=right colspan=2>
   Support Incomming Mail:</Th>
 <Td colspan=2>

 <%
     if("Y".equals((mailGroupObj.getFieldValueString(0,"SUPPORTIN")).trim()))
     {
   %>  
     <input type="checkbox" name="supportInMail" checked>  
   <%
     }
     else
     {
   %>
     <input type="checkbox" name="supportInMail">  
  <%
     }
   %>  
 </Td></Tr>
<Tr>
	<Th align=right width="30%">Protocol:</Th>
	        <Td width="19%"> 
              <div id = "listBoxDiv"> <select name="inProtocol" onChange="funChange()">
		<option value="IMAP" value="143" selected>IMAP</option>
		<option value="POP3">POP3</option>
		</select></div>
	</Td>

<script>
	   for(i=0;i<document.myForm.inProtocol.length;i++)
	   {
	     if(document.myForm.inProtocol.options[i].value=='<%=(mailGroupObj.getFieldValueString(0,"INPROTOCOL")).trim()%>')
	      {
	        document.myForm.inProtocol.selectedIndex=i
	        break
	      } 
	   }
	</script>	
	
	        <Th align=right width="29%">Port:*</Th>
	        <Td width="22%">
<%
if("null".equals(inPort)||"".equals(inPort))
{
%> 
             <input type=text class = "InputBox" name="inPort" size  = 15 maxlength=6 value='143'></Td>
<%
}
else
{
%>
              <input type=text class = "InputBox" name="inPort" size  = 15 maxlength=6 value='<%=inPort%>'></Td>
<%
}
%>
</Tr>
</table>
</div>
 
<div id="ID3"  style="overflow:auto;position:absolute;height:100%;width:100%">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<Tr>
<Th align=right colspan=2>
   Support Outgoing Mail:</Th>
    <Td colspan=2>
<%
      if("Y".equals((mailGroupObj.getFieldValueString(0,"SUPPORTOUT")).trim()))
      {
 %>
     <input type="checkbox" name="supportOutMail" checked>  
 <%
     }
     else
     {
  %> 
         <input type="checkbox" name="supportOutMail">   
   <%
     }
   %>  


 </Td></Tr>
 
	<Tr>
		<Th align=right  colspan=2>Port:*</Th>
	        <Td colspan=2 width="51%"> 
              <input type=text class = "InputBox" name="outPort" maxlength=6 value='<%=outPort%>'></Td>
	</Tr>
</table>
</div>

<div id="ID4"  style="overflow:auto;position:absolute;height:100%;width:100%">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<Tr>
<label for="cb_<%=0%>">
<Th align=right colspan=2>
   JMS Enabled:</Th>
 <Td colspan=2>
<%
   if("Y".equals((mailGroupObj.getFieldValueString(0,"JMSENABLED")).trim()))
    {
  %>
     <input type="checkbox" name="JMSEnabled" checked>  
 <%
    }
    else
    {
  %>
      <input type="checkbox" id="cb_<%=0%>" name="JMSEnabled">  
   <%
     }
   %>  

 </Td>
 </label>
 </Tr>
<Tr>
		<Th width="28%" align=right >Destination Type:</Th>
		<Td width="18%"> 
		<select name="destType">
		<option value="T">Topic</option>
		<option value="Q">Queue</option>
		</select>
		</Td>
 <script>
	   for(i=0;i<document.myForm.destType.length;i++)
	   {
	     if(document.myForm.destType.options[i].value=='<%=(mailGroupObj.getFieldValueString(0,"DESTTYPE")).trim()%>')
	      {
	        document.myForm.destType.selectedIndex=i
	        break
	      } 
	   }
</script>  
     

            <Th  align="right" width="18%">Topic Name:*</Th>
            <Td width="36%"> 
              <input type=text class = "InputBox" name="destName" size = 25 maxlength=50 value='<%= destName %>'></Td>
</Tr>
<Tr>
            <Th width="28%" align=right >Destination Factory:*</Th>
            <Td width=18%> 
              <input type=text class = "InputBox" name="destFactory" size = 15 maxlength="50" value='<%= destFact %>'>
            <Th width="18%" align=right >Provider URL:*</Th>
            <Td width=36%> 
              <input type=text class = "InputBox" name="providerURL" size = 25 maxlength="50" value='<%= providerURL %>'>
</Tr>
<Tr>
            <Th width="28%" align=right >Context Factory:*</Th>
<Td colspan=3><input type=text class = "InputBox" name="contextFactory" maxlength="255" size=55 value='<%= ctxFact%>'>
</Tr>
</table>
</div>
</div>
<div id="ButtonDiv1" style="position:absolute;top:85%;width:89%;left:4%">
	<center>
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none>
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/next.gif" border=none onClick='funNext(activeTabIndex)'></a>
		<a href='javascript:funBack(activeTabIndex)'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
</div>
<div id="ButtonDiv2" style="position:absolute;top:85%;width:89%;left:4%">
	<center>
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none>
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href='javascript:funBack(activeTabIndex)'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
</div>

<input type=hidden name="groupId" value='<%=mailGroupObj.getFieldValueString(0,"GROUPID")%>'>
</form>
</body>
</html>


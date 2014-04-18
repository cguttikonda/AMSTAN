<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/MailGroups/iEditMailGroup.jsp"%>
<html>
<head>
    	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>    
    	<%@ include file="ezTabScript.jsp"%>

   
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

	if(val==1) history.go(-1);
	if(val==2) funHeader()
	if(val==3) funIncoming()
	if(val==4) funOutgoing()
}

</script>

</head>
<body onLoad="funHeader()" scroll="no">
<form name="myForm" method=post>
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
	  <Td class="displayheader"> 
        <div align="center">Mail Group Details</div>
      </Td>

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
	<Th align=right width="30%">Description:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"GROUPDESC")%></Td>

</Tr>

<Tr>
	<Th align=right width="30%">Host:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"HOST")%></Td>
	<Th align=right width="30%">From:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"FROM1")%></Td>
</Tr>
<Tr>
	<Th align=right width="30%">Exception Listener:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"EXLISTENER")%></Td>
	<Th align=right width="30%">Logfile:</Th>
	<Td width="20%"><%=mailGroupObj.getFieldValueString(0,"LOGFILE")%></Td>
</Tr>
<Tr>
	<Th align=right width="30%">Authent. Req:</Th>
	<Td width="20%">
<%
	  if("Y".equals((mailGroupObj.getFieldValueString(0,"ISAUTHREQ")).trim()))
	  {
	 %> 
	    <input type=checkbox name="authRequired" checked disabled>
	 <%
	   }
	   else
	   {
	 %>
	    <input type=checkbox name="authRequired" disabled>
	  <%
	   }
	  %>
	
</Td>
	<Th align=right width="30%">Debug:</Th>
<Td width="20%">

<%
	  if("Y".equals((mailGroupObj.getFieldValueString(0,"DEBUG")).trim()))
	  {
	 %> 
	    <input type=checkbox name="debug" checked disabled>
	 <%
	   }
	   else
	   {
	 %>
	    <input type=checkbox name="debug" disabled>
	  <%
	   }
	  %>
	
</Tr>

<Tr>


	<Th align=right width="30%">UserName:</Th>
<%
if("null".equals(mailGroupObj.getFieldValueString(0,"USERID")))
{
%>
<Td width="30%" colspan=3>&nbsp;</Td>
<%
}
else
{
%>
	<Td width="30%" colspan=3>&nbsp; <%=mailGroupObj.getFieldValueString(0,"USERID")%></Td>
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
     <input type="checkbox" name="supportInMail" checked disabled>  
   <%
     }
     else
     {
   %>
     <input type="checkbox" name="supportInMail" disabled>  
  <%
     }
   %>  
 </Td></Tr>
 <Tr>
	<Th align=right width="30%">Incoming Mail Protocol:</Th>
	        <Td width="19%"> &nbsp; 
              <%=(mailGroupObj.getFieldValueString(0,"INPROTOCOL")).trim()%>
	</Td>

	        <Th align=right width="29%">Incoming Mail Port:</Th>
	        <Td width="22%"> &nbsp; 
             <%=inPort%></Td>
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
     <input type="checkbox" name="supportOutMail" checked disabled>  
 <%
     }
     else
     {
  %> 
         <input type="checkbox" name="supportOutMail" disabled>   
   <%
     }
   %>  


 </Td></Tr>
 
 	<Tr>
		<Th align=right  colspan=2>Outgoing Mail Port:</Th>
	        <Td colspan=2 width="51%"> &nbsp; 
              <%=outPort%></Td>
	</Tr>
 </table>
</div>

<div id="ID4"  style="overflow:auto;position:absolute;height:100%;width:100%">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
<Tr>
<Th align=right colspan=2>
   JMS Enabled:</Th>
 <Td colspan=2>
<%
   if("Y".equals((mailGroupObj.getFieldValueString(0,"JMSENABLED")).trim()))
    {
  %>
     <input type="checkbox" name="JMSEnabled" checked disabled>  
 <%
    }
    else
    {
  %>
      <input type="checkbox" name="JMSEnabled" disabled>  
   <%
     }
   %>  

 </Td></Tr>
 <Tr>
		<Th width="28%" align=right >Destination Type:</Th>
		<Td width="18%"> &nbsp; 
		<%=(mailGroupObj.getFieldValueString(0,"DESTTYPE")).trim()%>	
		</Td>
            <Th  align="right" width="18%">Topic Name:</Th>
            <Td width="36%"> &nbsp; 
              <%= destName %></Td>
</Tr>
<Tr>
            <Th width="28%" align=right >Destination Factory:</Th>
            <Td width=18%> &nbsp; 
              <%= destFact %>
            <Th width="18%" align=right >Provider URL:</Th>
            <Td width=36%> &nbsp; 
              <%= providerURL %>
</Tr>
<Tr>
            <Th width="28%" align=right >Context Factory:</Th>
<Td colspan=3>&nbsp; <%= ctxFact%>
</Tr>
</table>
</div>

</div>
<div id="ButtonDiv1" style="position:absolute;top:85%;width:89%;left:4%">
	<center>
		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/next.gif" border=none onClick='funNext(activeTabIndex)'></a>
		<a href='javascript:funBack(activeTabIndex)'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
</div>
<div id="ButtonDiv2" style="position:absolute;top:85%;width:89%;left:4%">
	<center>
		<a href='javascript:funBack(activeTabIndex)'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
</div>

</form>
</body>
</html>


<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@page import="ezc.ezutil.FormatDate,java.util.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iListMaterialRequest.jsp" %>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>


function formEvents(evnt)
{
   document.myForm.action=evnt
   document.myForm.submit();
}

function formEventDelete(evnt)
{
   ans = window.confirm("All relevant responses from Vendors will also be deleted.")
   if(ans)
   {
       document.myForm.action=evnt
       document.myForm.submit();
   }

}

function formEventUpdate(evnt,fla)
{

  var chkValue
  var len = document.myForm.chk1.length

  if(!isNaN(len))
  {
      for(var j=0;j<len;j++)
      {
     	 if(document.myForm.chk1[j].checked)
      	 {
      	 	chkValue = document.myForm.chk1[j].value
      	 }
      }
  }
  else
  {
      chkValue = document.myForm.chk1.value
  }

  var str = chkValue.split("#")
  stat = str[1]

  if(fla=='A')
  {
     if(fla==stat)
     {
	alert("The request is already active")
     }
     else
     {
        ans = window.confirm("Vendors will now be able to see the request.")
        if(ans)
        {
             document.myForm.action=evnt
	     document.myForm.submit();
        }
     }

  }
  else if(fla=='S')
  {

     if(fla==stat)
     {
	alert("The request is already suspended")
     }
     else
     {
        ans = window.confirm("Vendors will not be able to see the material now.")
        if(ans)
        {
             document.myForm.action=evnt
	     document.myForm.submit();
        }
     }

  }
}

</script>


<script>

function formEventResponse(evnt)
{

  var chkValue
  var len = document.myForm.chk1.length

  if(!isNaN(len))
  {
      for(var j=0;j<len;j++)
      {
     	 if(document.myForm.chk1[j].checked)
      	 {
      	 	chkValue = document.myForm.response[j].value
      	 }
      }
  }
  else
  {
      chkValue = document.myForm.response.value
  }

  if(chkValue=='0')
  {

  	alert("There are no responses for this request.")
  }
  else
  {
        document.myForm.action=evnt
        document.myForm.submit();
  }

}


function funSubmit()
{
	document.myForm.action="ezListMaterialsInternal.jsp"
	document.myForm.submit();
}

function funOnLoad()
{
	var statusType= '<%=statusType%>'
	for(var i=0;i<document.myForm.statusType.length;i++)
	{
		if(document.myForm.statusType.options[i].value==statusType)
		{
			document.myForm.statusType.options[i].selected=true;
		}
	}
}
</script>


<Script>
var tabHeadWidth=95
var tabHeight="45%"
</Script>

<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezSortTableData.js"></script>
</head>
<body bgcolor="#FFFFFF" onLoad="funOnLoad(),ezInitSorting(),scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<%
//if(ret.getRowCount()>0)
//{
%>
  	<table width="35%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
  	<tr>
  	 	<%
			if(type.equals("N"))
			{
		%>
			<td class="displayheader" align=center>List of New Material Requirements</td>
	        <%
	        	}else {
	        %>
			<td class="displayheader" align=center>List of Materials for Disposal</td>

	        <%      }  %>
 	</tr>
  	</table>
<%
//}
%>


  <Table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr>
  <Th width="50%">
  	Select Request Status
  </Th>
  <Td width="50%">
	<select name="statusType" style="width:100%;" onChange="funSubmit()" id="listBoxDiv">
 		<option value="A">Active</option>
 		<option value="IA">InActive</option>
 		<option value="All">All</option>
	</select>
  </Td>
  </Tr>
  </Table>
<br>


<%
       if(ret.getRowCount()==0)
       {
%>
	  <br><br><br><br>
	  <table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
	  <tr>
	  	<%
	  		if(type.equals("N"))
	  		{
	        %>
			  <th align=center>No New <%=statusDisplay%> Material Requirements Exist.</th>
	        <%
	        	}else {
	        %>
	        	  <th align=center>No <%=statusDisplay%> Materials for Disposal Exist.</th>
	        <%      }  %>
	  </tr>
	  </table><br><br><br>
	  <center><img src="../../Images/Buttons/<%=ButtonDir%>/addnew.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezAddMaterialRequest.jsp')"></center>

<%     }else { %>

<%
	if(statusType!=null && statusType.equals("All"))
	{
%>
					<div align=right>
						<img src="../../Images/Buttons/<%=ButtonDir%>/active.gif">&nbsp;Active &nbsp;<img src="../../Images/Buttons/<%=ButtonDir%>/deactive.gif">&nbsp;Inactive
					</div>
<%
	}
%>
	<DIV id="theads">
	<Table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

	<tr>
        <th width="4%">&nbsp;</th>
        <th width="30%" style="cursor:hand"  onClick="ezSortElements(1)">Material Description</th>

        <th width="7%">UOM</th>
        <th width="10%">Qty</th>
	<%
	   if(type.equals("N"))
	   {
	%>
		<th width="13%" >Required Date</th>
                <th width="12%" style="cursor:hand" onClick="ezSortElements(5)" >Responses</th>
	<% }else{%>
                <th width="12%" style="cursor:hand" onClick="ezSortElements(4)" >Responses</th>
        <% }
        %>

<%
		if(statusType!=null)
		{
			if(statusType.equals("A"))
			{
%>
        		<th width="17%" >Activation Date</th>
<%
			}
			else if(statusType.equals("IA"))
			{
%>
				<th width="17%" >DeActivation Date</th>
<%			}
			else if(statusType.equals("All"))
			{
%>
				<th width="17%" >Activation/ DeActivation Date</th>
<%
			}
		}
		else
		{
%>
			<th width="17%" >Activation Date</th>
<%
		}
		if(statusType!=null && statusType.equals("All"))
		{
%>
        		<th width="7%" >Status</th>

<%
		}
%>

	</tr>
        </Table>
       	</DIV>


       	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >


<%
   FormatDate formatDate = new FormatDate();
   String date="";
   String date1="";
   String activationdate="";
   String status="";
   String refDoc="";

   int Count = ret.getRowCount();
   for(int i=0;i<Count;i++)
   {
   	if(!ret.getFieldValueString(i,"CLOSINGDATE").equals("null"))
   	{
   	    date=formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"CLOSINGDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
   	    date1=date;
   	}
   	else
   	{
   	    date1="-";
	    date="";
   	}

   	activationdate=formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"ACTIVATIONDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
   	status = ret.getFieldValueString(i,"CURRENTSTATUS");
	refDoc = ret.getFieldValueString(i,"REFDOCNO");

%>
      <tr>
      <td width="4%">
	<%
      if(i==0)
      {
      %>
             <input type="radio" name="chk1" checked value="<%=ret.getFieldValueString(i,"REQUESTID")%>#<%=status%>#<%=formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"ACTIVATIONDATE"),".",FormatDate.DDMMYYYY)%>#<%=date1%>#<%=refDoc%>">
      <%}else{ %>
              <input type="radio" name="chk1" value="<%=ret.getFieldValueString(i,"REQUESTID")%>#<%=status%>#<%=formatDate.getStringFromDate((java.util.Date)ret.getFieldValue(i,"ACTIVATIONDATE"),".",FormatDate.DDMMYYYY)%>#<%=date1%>#<%=refDoc%>">
      <%}%>
      </td>
      <td width="30%"><%=ret.getFieldValueString(i,"MATERIALDESC")%></td>
      <td width="7%" align="center"><%=ret.getFieldValueString(i,"UOM")%></td>
      <td width="10%" align="right"><%=ret.getFieldValueString(i,"REQUIREDQTY")%></td>
      <%
	   if(type.equals("N"))
	   {
	   	String reqDate=ret.getFieldValueString(i,"EXT1");
		int mm=Integer.parseInt(reqDate.substring(3,5));
		int dd=Integer.parseInt(reqDate.substring(0,2));
		int yy=Integer.parseInt(reqDate.substring(6,10));
		GregorianCalendar DocDate=new GregorianCalendar(yy,mm-1,dd);	   
	   
       %>
      		<td width="13%" align="center"><%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>&nbsp;</td>
      <%   } %>
      <td width="12%" align="right"><%=ret.getFieldValueString(i,"RESPCOUNT")%>
      <input type="hidden" name="response" value="<%=ret.getFieldValueString(i,"RESPCOUNT")%>">
      </td>
      <%
      if(status.equals("A")){
      %>
		<td width="17%" align="center"><%=activationdate%>&nbsp;</td>
<%
		if(statusType!=null && statusType.equals("All"))
		{
%>
	     		<td align=center width="7%"><img  src="../../Images/Buttons/<%=ButtonDir%>/active.gif"></td>
<%
		}
%>

      <%}else{%>
		<td width="17%" align="center"><%=date%>&nbsp;</td>
<%
		if(statusType!=null && statusType.equals("All"))
		{
%>
		        	<td align=center width="7%"><img src="../../Images/Buttons/<%=ButtonDir%>/deactive.gif"></td>
<%
		}
%>
			
      <%}%>
        <script>
	  	rowArray=new Array()
		rowArray[0]=" "
		rowArray[1]='<%=ret.getFieldValueString(i,"MATERIALDESC")%>'
		rowArray[2]=" "
		rowArray[3]=" "
                <%
	        if(type.equals("N"))
	        {
                %>
		        rowArray[4]=" "
		        rowArray[5]="<%=ret.getFieldValueString(i,"RESPCOUNT")%>"
		        rowArray[6]=" "
                        rowArray[7]=" "
		        dataArray[<%=i%>]=rowArray
                <%}else{%>
		        rowArray[4]="<%=ret.getFieldValueString(i,"RESPCOUNT")%>"
		        rowArray[5]=" "
		        rowArray[6]=" "
		        dataArray[<%=i%>]=rowArray
                <%}%>
		</script>
   </tr>

  <%}%>
  </table>
  </div>

  <div id="buttons" align=center style="position:absolute;top:87%;width:100%;visibility:visible">
  <img src="../../Images/Buttons/<%=ButtonDir%>/addnew.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezAddMaterialRequest.jsp')">
  <img src="../../Images/Buttons/<%=ButtonDir%>/moredetails.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezViewMaterialRequest.jsp')">
 <!-- <img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" style="cursor:hand" border=none onClick="formEventDelete('../Materials/ezDeleteMaterialRequest.jsp')"> -->
 
<%
	if(!setStatusType.equals("A"))
	{
%>
  		<img src="../../Images/Buttons/<%=ButtonDir%>/activate.gif" style="cursor:hand" border=none onClick="formEventUpdate('../Materials/ezUpdateMaterialRequest.jsp','A')">
<%
	}
	if(!setStatusType.equals("S"))
	{
%>
		<img src="../../Images/Buttons/<%=ButtonDir%>/deactivate.gif" style="cursor:hand" border=none onClick="formEventUpdate('../Materials/ezUpdateMaterialRequest.jsp','S')">
<%
	}
%>
  <img src="../../Images/Buttons/<%=ButtonDir%>/responses.gif" style="cursor:hand" border=none onClick="formEventResponse('../Materials/ezListMaterialResponses.jsp')">
  </div>

        <div align=center style="position:absolute;top:95%;width:100%">
        <Table align="center"><Tr><Td class="blankcell">
        Click on Material Description or Responses column to Sort the Data.
        </Td></Tr></Table>
        </div>

  <%  }  %>


<input type="hidden" name="Type" value="<%=type%>">

</form>
<Div id="MenuSol"></Div>
</body>
</html>

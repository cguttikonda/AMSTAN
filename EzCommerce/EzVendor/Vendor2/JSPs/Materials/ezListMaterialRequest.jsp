<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iListMaterialRequest.jsp" %>
<%@ page import="ezc.ezutil.*,java.util.*" %>
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
</script>

<Script>
var tabHeadWidth=95
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
 function init()
 {
 <%
 	if(ret.getRowCount()>0)
 	{
%>
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
<%
	}
%>
}
</script>
</head>

<body bgcolor="#FFFFFF" onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name="myForm" method="post">
<%
	int count=ret.getRowCount();
	if(count==0)
	{
%>	  <br><br><br><br>	
	  <table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
	  <tr>
	  	<%
	  		if(type.equals("N"))
	  		{
	        %>
			  <th align=center>No New Material Requirements</td>
	        <%
	        	}else {
	        %>
	        	  <th align=center>No Materials for Disposal.</td>
	        <%      }  %>
	  </tr>
	  </table>
<%
		return;
	}
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
	<br>

    <DIV id="theads">
    <Table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
      <th width="5%">&nbsp;</th>
      <th width="25%">Material Description</th>
      <th width="8%">UOM</th>
      <th width="15%">Qty</th>
       <%
	   if(type.equals("N"))
	   {
	%>
      <th width="17%">Required Date</th>
      <%  } %>
      <th width="20%">Created By</th>
     <%	if(flag1==null){ %>	
      	<th width="10%">Responded</th>
     <%  }  %>
    </tr>
    </Table>
    </DIV>


      <DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
      <TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
     <%
	for(int i=0;i<count;i++)
	{
%>
    	<tr>
    	  <td width="5%">
 	  <%
             if(i==0)
             {
          %>
          	   <input type="radio" name="chk1" checked value="<%=ret.getFieldValueString(i,"REQUESTID")%>#<%=ret.getFieldValueString(i,"REFDOCNO")%>">
          <% }else{ %>
                   <input type="radio" name="chk1" value="<%=ret.getFieldValueString(i,"REQUESTID")%>#<%=ret.getFieldValueString(i,"REFDOCNO")%>">
          <% } %>

   	  </td>
    	  <td width="25%">
    	  <%=ret.getFieldValueString(i,"MATERIALDESC")%>

    	  </td>
    	  <td width="8%" align=center>
    	  <%=ret.getFieldValueString(i,"UOM") %>

    	  </td>
    	  <td width="15%" align="right">
    	  <%=ret.getFieldValueString(i,"REQUIREDQTY")%>

    	  </td>

	<%
	   if(type.equals("N"))
	   {
	   	String reqDate=ret.getFieldValueString(i,"EXT1");
		int mm=Integer.parseInt(reqDate.substring(3,5));
		int dd=Integer.parseInt(reqDate.substring(0,2));
		int yy=Integer.parseInt(reqDate.substring(6,10));
		GregorianCalendar DocDate=new GregorianCalendar(yy,mm-1,dd);	   
	%>
	  <td width="17%" align="center">
    	  <%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>
    	  </td>
        <% } %>
	  <td width="20%" align=center>
    	  <%=ret.getFieldValueString(i,"CREATEDBY")%>
    	  </td>
	<%  if(flag1==null){ %>	
	  <td width="10%" align=center>
    	  <% 
		 if(ret.getFieldValueString(i,"RESPCOUNT").equals("0")){ 
			out.println("No");
		 }else{
			out.println("Yes");
		 }
	  %>
   	  </td>
     <%  }  %>	
    	</tr>
<%
	}
	
%>
   </table>

  </div>
  <div id="buttons" align=center style="position:absolute;top:90%;width:100%;visibility:visible">
  <img src="../../Images/Buttons/<%=ButtonDir%>/viewdetails.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezViewMaterialRequest.jsp')">
  </div>
<input type=hidden name="Type" value="<%=type%>">
  </form>
  <Div id="MenuSol"></Div>
</body>
</html>

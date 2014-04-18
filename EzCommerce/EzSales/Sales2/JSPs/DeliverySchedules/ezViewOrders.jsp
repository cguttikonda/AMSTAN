
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iViewDispatchInfo_Lables.jsp"%>

<%@ include file="../../../Includes/JSPs/DeliverySchedule/iViewOrders.jsp"%>
<html>
<head>
	<title>view Dispatch Info</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>  
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/ezSalesScroll.js"></Script>

	<script>
	function movetoHome(){
		
		document.location.replace("../Misc/ezWelcome.jsp")
	}
 	function adjustWidth()
	{
			if (document.Orders.SalesOrder!=null){
			if (isNaN(document.Orders.SalesOrder.length))
				document.Orders.SalesOrder.checked=true
			else
				document.Orders.SalesOrder[0].checked=true
		}
	}
	function pageSubmit()
	{
		if(document.forms[0].onceSubmit.value!=1){
		   document.forms[0].onceSubmit.value=1
		   document.body.style.cursor="wait"
		  document.forms[0].action="ezViewDispatchInfo.jsp"
		 
		   document.forms[0].submit();
               }
	}
	</script>
</head>
<body onLoad="adjustWidth();scrollInit()" onresize="scrollInit()" scroll=no>

<form  method=post  name="Orders" onSubmit="return false">
	<input type="hidden" name="Stat" value="<%=Stat%>" >


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" width="40%"></td>
    <td height="35" class="displayheaderback"  width="60%">
    		<% if ("R".equals(Stat)){%>
				<%=preDispList_L %>
			<%}else if ("D".equals(Stat)){%>
				<%=newDispList_L%>
		<%}%>
    </td>
</tr>
</table>


	<%

	if ((retobj!=null)&&(retobj.getRowCount()>0)){
	%>

	<Div id="theads">
	<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="10%"><%=select_L%></Th>
	<!-- 	<Th width="30%"><%=soNo_L%></Th> -->
        	<Th width="30%"><%=salesOrdNo_L%></Th>
		<Th width="30%"><%=weorno_L%></Th>
		<Th width="30%"><%=poNo_L%></th>
	</Tr>
	</Table>
	</Div>
		
        	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
		<Table align=center  id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

	<%
	ArrayList SONos=new ArrayList();
	for(int i=0;i<retobj.getRowCount();i++)
	{
		if (! SONos.contains(retobj.getFieldValueString(i,"EZDI_SO_NUM")))
		{
			String sonum = retobj.getFieldValueString(i,"EZDI_SO_NUM");
			String webnom = retobj.getFieldValueString(i,"WEB_NO");
		%>
			<Tr>
			<Td width='10%' align="center"><input type=radio name="SalesOrder" value="<%=retobj.getFieldValueString(i,"SO_NUM")%>"></Td>
			<Td width='30%'><%try{out.println(Long.parseLong(sonum));}catch(Exception e){out.println(sonum);}%></Td>
			<Td width='30%'><% try{out.println(Long.parseLong(webnom));}catch(Exception e){out.println(webnom);} %></Td>
			<Td width='30%'><%=retobj.getFieldValueString(i,"PO_NUM")%></Td>
			</Tr>
		<%
			SONos.add(retobj.getFieldValueString(i,"EZDI_SO_NUM"));
		}
	}
	%>
	</Table>
		</Div>
		
	<%
	}
	else
	{%>	<br><br><br>
		<Table  align=center border=0 >
		<Tr>
			<Td class=displayalert align="center">
			<% if ("R".equals(Stat)){%>
				<%=noPreDispList_L%>.
			<%}else if ("D".equals(Stat)){%>
				<%=noNewDisp_L%>.
			<%}%>
			</Td>
		</Tr></Table>
	<%}
	%>
	<div align="center" style="position:absolute;top:85%" align="center">
	<Table align="center" width="100%"><TR><TD class="blankcell" align="center">
	<font color="#006666">
	<% if (("R".equals(Stat))&&(retobj.getRowCount()>0)){%>
		<%=selPreDispMade_L%>.
	<%}else if (("D".equals(Stat))&&(retobj.getRowCount()>0)){%>
		<%=selNewDispMade_L%>.
	<%}%>
	</font>
	</td></Tr></Table>
	</div>

	<div id="buttonDiv" style="position:absolute;top:90%;" align="center">
	<table align="center" width="100%">
	<tr>
	<td class="blankcell" align="center">
	<%if (retobj.getRowCount()!=0){%>
		<a style="text-decoration:none"  class=subclass href='Javascript:pageSubmit()'><img src="../../Images/Buttons/<%= ButtonDir%>/viewdeliveries.gif" border="none" <%=statusbar%>></a>
	<%}%>
		<a style="text-decoration:none"  class=subclass href='Javascript:movetoHome()'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border="none" <%=statusbar%>></a>
	</td></tr></table>
	</div>
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

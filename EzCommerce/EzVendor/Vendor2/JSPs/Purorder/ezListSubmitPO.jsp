<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Purorder/iListBlockedPO.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListBlockedPO_Labels.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
	<title>List of Purchase Orders</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
var tabHeadWidth=96
var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
function checkVal()
{
   	var count=0;
	var len = document.myForm.chk1.length;

	if(!isNaN(len))
	{
		for(var i = 0; i < len; i++)
		{
		   if(document.myForm.chk1[i].checked)
		   {
		      count = count + 1;
		   }
		}
	}
	else
	{
		if(document.myForm.chk1.checked)
		{
		   count = count + 1;
		}

	}

	if(count<1)
       	{
		alert("<%=selBlockedPo_L%>");
       	}
	else
        {
        	document.myForm.action="ezSubmitPurchaseOrder.jsp";
		document.myForm.submit();
	}
}

</script>

</head>
<%
	String display_header = "";
%>	

	
	
	<div id="nocount" style="position:absolute;top:0%;width:100%;visibility:hidden">
	
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<br><br><br><br>
	<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr align="center">
	<th>
          There is no to be submitted POs
	</th>
	</tr></table>
	</div>

<%
	int n=0;
	if(Count==0)
	{
%>		
		<script>
			document.getElementById("nocount").style.visibility="visible" 
	        </script>
<%
	}
	else
	{
		display_header = "To be Submitted POs";
%>	
		<body bgcolor="#FFFFF7" onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')" scroll=no>
		<form name="myForm" method="post">
		
			<%@ include file="../Misc/ezDisplayHeader.jsp"%>
		
		<div id="theads">
		<table  id="tabHead"  width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		  <tr align="center" valign="middle">
		     	<th width="10%">&nbsp;</th>
		     	<th width="30%"> <%=poNo_L%></th>
		    	<th width="30%"> <%=ordDate_L%></th>
			<th width="30%"> Blocked Date</th>
				
		  </tr>
		</Table>
		</div>
		
		<DIV id="InnerBox1Div">
		<Table  id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		
		
		
		
		 <%
		 	
		  	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
		        String poNum = "";
			for(int i=0;i<Count;i++)
		     	{
				if(ret.getFieldValueString(i,"actionStat").equals("SUBMITTED"))	
				{
		
				    poNum = ret.getFieldValueString(i,"DOCNO");
		 %>
			 	<tr>
		     		<td width="10%"><input type="checkbox" name=chk1 value="<%=poNum%>"></td>
			     	<td width="30%" align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></td>
		    		<td width="30%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></td>
					<td width="30%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%></td>
			    	</tr>
		 <%		  n=n+1;	
				}
			}
		 %>
		
		</table>
		</div>
	<div id="back" style="position:absolute;top:87%;left:40%;visibility:visible">
	<img src="../../Images/Buttons/<%=ButtonDir%>/submitorders.gif" bordor=none style="cursor:hand" onClick="checkVal()"> 
	</div>
	<script>
  	if('<%=n%>'==0)
   	{
   		if(document.getElementById("InnerBox1Div")!=null)
		  document.getElementById("InnerBox1Div").style.visibility="hidden"

   		if(document.getElementById("InnerBox1Tab")!=null)
		  document.getElementById("InnerBox1Tab").style.visibility="hidden"

   		if(document.getElementById("theads")!=null)
		  document.getElementById("theads").style.visibility="hidden"
		  
   		if(document.getElementById("tabHead")!=null)
		  document.getElementById("tabHead").style.visibility="hidden"

   		if(document.getElementById("back")!=null)
 	 	 document.getElementById("back").style.visibility="hidden"

   		if(document.getElementById("header")!=null)
	  	  document.getElementById("header").style.visibility="hidden"

   		document.getElementById("nocount").style.visibility="visible"

   	}
	</script>

<%

  }
%>



</form>
<Div id="MenuSol"></Div>
</body>
</html>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iAcCopy_Lables.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/SelfService/iAcCopy.jsp"%>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	  var tabHeadWidth=95
	  var tabHeight="45%"
</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script language="javascript">
	function formSubmit()
	{
		y = chkDates();
		if(eval(y)){
			document.myForm.submit();
		}
	}
	function gotoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
	function chkDates()
	{
		fd = document.myForm.FromDate.value;
		td = document.myForm.ToDate.value;

		if(fd=="")
		{
			alert("Please Select From Date");
			return false;
		}
		else if(td=="")
		{
			alert("Please Select To Date");
			return false;
		}


		a=fd.split('<%=forkey%>');
		b=td.split('<%=forkey%>');
		fd1=new Date(a[2],a[0]-1,a[1])
		td1=new Date(b[2],b[0]-1,b[1])
		if(fd1 > td1)
		{
			alert("<%=fromLessTo_A%>");
			document.myForm.FromDate.focus();
			return false;
		}
		return true;
	}

	
</script>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form  method="post" name="myForm"  action="ezAcCopy.jsp">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center  width="100%"><%=statAC_L%></td>
</tr>
</table>
 <Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
 <Tr>
	<Th><%=fromDate_L%></Th>
	<Td>
		<input type=text name="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%>
	</Td>
	<Th><%=toDate_L%></Th>
	<Td>
		<input type=text name="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%>
	</Td>
	<Td class="blankcell">
<%

	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Go");
	buttonMethod.add("formSubmit()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>

	</Td>
</Tr>
</Table>


<%	
			if(lineItemsCount > 0)
			{
%>
				<Div id="theads">
				<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<tr>

<%
				for(int k=0;k<dispColumns.size();k++)
				{
					out.println("<Th width=" + dispSizes.get(k) +" align=center>" + dispLabels.get(k)  + "</Th>");
				}
%>					
				</Tr>
				</Table>
				</Div>
        			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
				<Table align=center id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%				for(int i=0;i<lineItemsCount;i++)
				{
					myValues = (Hashtable)myIndex.get(i+"");
%>					
					<Tr>
<%
						for(int k=0;k<dispColumns.size();k++)
						{
							out.println("<Td width=" + dispSizes.get(k) +" "+  dispAlign.get(k) +">" + myValues.get(dispColumns.get(k))  + "&nbsp;</Td>");
						}
%>
					</Tr>
<%
				}	
%>
				</Table>
				</Div>
		
<%
			}else{
%>
				<br><br><br>
				<Table  align=center ><Tr><Td align=center class=displayalert><%=acNoEnter_L%></Td></Tr></Table>
<%
			}
%>

<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


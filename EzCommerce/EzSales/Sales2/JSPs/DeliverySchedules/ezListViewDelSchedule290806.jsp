<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iDeliverySchedules.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddDelSchedule_Lables.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%
   String[] matDesc 	= request.getParameterValues("matdesc");
   String[] lineNo 	= request.getParameterValues("lineNo");

   String fromDate 	= request.getParameter("FromDate");  
   String toDate 	= request.getParameter("ToDate");
   String newFilter 	= request.getParameter("newFilter");
%>
<html>
<head>
	<title>Delivery Schedules Details</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="55%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

<script src="../../Library/JavaScript/Misc/ezSniffer.js"></script>

	<script>
	function displayWindow(fieldName)
	{
		newWindow = window.open("ezDateEntry.jsp","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
		newWindow.name="parent.opener."+fieldName
	}
	function ezBack()
		{
			<%
				String status = request.getParameter("status");
			%>
			document.forms[0].action="../Sales/ezBackEndSODetails.jsp?SONumber=<%=soNum%>&status=<%=status%>"
			document.forms[0].submit();
		}
	</script>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form name="generalForm" method="post">
<input type="hidden" name="chkBrowser" value="0">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type=hidden name="newFilter"  value="<%=newFilter%>">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=expDeliSchSONo_L%>: <%= Integer.parseInt(backEndOrNo) %> </td>
</tr>
</table>

<%
	int count =delivShedules.getRowCount();
if( count >0)
{


Vector types = new Vector();
types.addElement("date");
types.addElement("date");
EzGlobal.setColTypes(types);

Vector names = new Vector();
names.addElement("ReqDate");
names.addElement("GiDate");
EzGlobal.setColNames(names);
ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(delivShedules);
	
%>

   <Div id="theads">
	<Table width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
	<Th  width="13%">Product Code</Th>
	<Th width="30%"><%=proddesc_L%></Th>
	<Th width="5%"><%=uom_L %></Th>
	<Th width="12%"><%=reqQty_L%></Th>
	<Th  width="14%"><%=reqDate_L%> </Th>
	<Th  width="12%"><%=confQty_L%></Th>
	<Th  width="14%"><%=expDelvDate_L%></Th>
   </Tr>
</Table>
	</Div>

        	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
		<Table align=center id="InnerBox1Tab"   class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%
	String item="0",matStr="",matCode="",materialDesc="";
	java.util.StringTokenizer st = null;
	for(int j=0;j<delivShedules.getRowCount();j++)
	{
	
		matStr	= (String)matdesc.get(delivShedules.getFieldValueString(j,"ItmNumber")); 
		
		if(matStr!=null)
		{
			st	= new java.util.StringTokenizer(matStr,"###");
			if(st!=null){
				matCode		= st.nextToken();
				materialDesc	= st.nextToken();
			}
		}
%>
		<Tr>
			<Td width="13%" align="left"><%=matCode%>&nbsp;</Td>
			<Td width="30%"><%=materialDesc%>&nbsp;</Td>
			<Td width="5%" align='center'><%=delivShedules.getFieldValueString(j,"BaseUom")%>&nbsp;</Td>
<%
			String confirmQty = delivShedules.getFieldValueString(j,"ConfirQty");
%>			
			<Td align="right"  width="12%">
<%
			String reqQty = delivShedules.getFieldValueString(j,"ReqQty");
			if(("0.000").equals(reqQty))
			{
				out.println("");
			}else{
			 	out.println(eliminateDecimals(reqQty));
			}
%>			&nbsp;</Td>
<%			if(("0.000").equals(reqQty)){
				out.println("<td>&nbsp;</td>");
			}else{
%>
			<Td  width="14%" align="center"><%=ret.getFieldValueString(j,"ReqDate")%>&nbsp;</Td>
<%
				item=delivShedules.getFieldValueString(j,"ItmNumber");
			}
%>
			<Td align="right"  width="12%"><%
				if(("0.000").equals(confirmQty))
				{
					out.println("");
				}else{
				 	out.println(eliminateDecimals(confirmQty));
				}
			%>
			&nbsp;</Td>
			<Td  width="14%" align="center"><%
				if(("0.000").equals(confirmQty))
				{
					out.println("");
				}else{
					out.println(ret.getFieldValueString(j,"GiDate"));
				}
			          %>
			
			&nbsp;</Td>
		</Tr>
<%
	}
%>
</Table>
		</Div>
		
<%
} // end of count > 0
else
{
%>
	<br><br><br><br>
	<Table align="center">
	    <Tr>
		<Th> <%=noDelSch_L%> <%= backEndOrNo%> </Th>
	    </Tr>
	</Table>
<%
}
%>
<div id="buttonDiv" align=center style='position:absolute;width:100%;top:90%'>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("ezBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

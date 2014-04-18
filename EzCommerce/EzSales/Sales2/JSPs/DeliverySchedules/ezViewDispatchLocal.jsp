
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iViewDispatchInfo_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iViewOrders.jsp"%>

<%
    String header="";
    
    if("D".equals(Stat))
    	header="To be Acknowledged List";
    else if("R".equals(Stat))
    	header="Acknowledged List";
%>
<head>
	<title>view Dispatch Info</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
function movetoHome(){
	document.location.replace("../Misc/ezWelcome.jsp")
}

function pageSubmit()
{

		if (isNaN(document.forms[0].disptchNo.length))
		{
			if(document.forms[0].disptchNo.checked)
			{
				chkValue=document.forms[0].disptchNo.value;
				
			}
		}else{
			for(j=0;j<document.forms[0].disptchNo.length;j++)
			{
				if(document.forms[0].disptchNo[j].checked)
				{
					chkValue=document.forms[0].disptchNo[j].value;
					break;
				}
			}
		}
		document.forms[0].dispNo.value=	chkValue
  		document.body.style.cursor="wait"
		document.forms[0].action="ezViewDespDetailsLocal.jsp"

		document.forms[0].submit()

}
function radioChk()
{
<%
if ((retobj!=null)&&(retCount>0))
{
%>
		if (isNaN(document.forms[0].disptchNo.length))
				document.forms[0].disptchNo.checked=true
			else
				document.forms[0].disptchNo[0].checked=true
<%}%>
}
</script>
</head>
<body onLoad="scrollInit();radioChk()" onresize="scrollInit()" scroll=no>
<form   method="post" name="DispatchInfo">
<%
	String display_header = header; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<%
	
	if ((retobj!=null)&&(retCount>0))
	{%>
		<Div id="theads">
		<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width='8%'>Select</Th>
		<Th width='15%'>Shipment No</Th>
		<Th width='15%'>Shipment Date</Th>
		<Th width='15%'>Tracking number</Th>
		<Th width='25%'>Carrier</Th>
		</Tr>
		</table>
		</Table>
		</Div>
		
        	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
		<Table align=center  id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
		<%
		
		String dispatchNo="";
		ArrayList DocNo=new ArrayList();
		for (int i=0;i < retCount;i++)
		{
				
			dispatchNo=retobj.getFieldValueString(i,"EZDI_DELIVERYNO");
			if(! DocNo.contains(dispatchNo))
			{
		%>		<TR>
					<Td width='8%' align="center"><input type=radio name="disptchNo" value="<%=dispatchNo%>" checked></Td>
					<Td width='15%'><%try{out.println(Long.parseLong(dispatchNo));}catch(Exception e){out.println(dispatchNo);}%></Td>					
					<Td width='15%' align=center><%=retGlobal.getFieldValueString(i,"EZDI_DC_DATE")%></Td>
					<Td width='15%'><%=retobj.getFieldValueString(i,"EZDI_LR_RR_AIR_NR")%></Td>
					<Td width='25%'><%=retobj.getFieldValueString(i,"EZDI_CARRIER")%></Td>
				  </TR>
		<%
			DocNo.add(dispatchNo);
			}
		}
		%>
		</Table>
			</Div>
			
	<%}else{%>
			<br><br><br><br><table  align=center border=0 >
			<tr>
	       		<Td class=displayalert align="center">No Acknowledged Shipments to view </Td>
		</tr></table>
	<%}%>
<input type=hidden name ="dispNo" value="">	
<input type=hidden name ="stat" value="<%=Stat%>">
<div id="buttonDiv" style="position:absolute;top:90%;left:40%" align="center">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if ((retobj!=null)&&(retCount>0)){
			buttonName.add("Dispatch Details");
			buttonMethod.add("pageSubmit()");
		}
			//buttonName.add("Back");
			//buttonMethod.add("movetoHome()");
		
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


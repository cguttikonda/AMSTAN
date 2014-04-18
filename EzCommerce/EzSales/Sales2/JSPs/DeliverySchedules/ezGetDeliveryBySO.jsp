<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iGetDeliveryBySO.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iGetDeliveryBySO_Lables.jsp" %>
<%
	String status = request.getParameter("status");
	String fromDate = request.getParameter("FromDate");  // don't delete
	String toDate = request.getParameter("ToDate");
	String newFilter = request.getParameter("newFilter");
%>
<html>
<head>
	<Title>Add delivery schedule</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="55%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	function callSchedule(sono)
	{
                if(document.forms[0].onceSubmit.value!=1){

                document.forms[0].onceSubmit.value=1
		document.body.style.cursor="wait"
		document.forms[0].action="../Sales/ezSOPaymentDetails.jsp?selList="+sono;
                document.forms[0].submit();
                }
        }
	function displayDetails(delno)
	{
		document.forms[0].action="ezViewDeliveryDetails.jsp?DeliveryNo="+delno+"&status=<%=status%>"
		document.forms[0].submit();
	}
	function displayDetails1(aa){
		document.forms[0].action="ezViewReceivedDel.jsp?DeliveryNo="+aa+"&status=<%=status%>"
		document.forms[0].submit();
	}
	function ezBack()
	{

		document.forms[0].action="../Sales/ezBackEndSODetails.jsp?SONumber=<%=soNo%>&status=<%=status%>"
		document.forms[0].submit();
	}
	</script>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form  method="post" name="DispatchInfo" onSubmit="return false">
<input type="hidden" name="from" value="ezGetDeliveryBySO">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type=hidden name ="soNo" value="<%=soNo%>">
<input type=hidden name ="SalesOrder" value="<%=soNo%>">
<input type=hidden name ="status" value="<%=status%>">

<%
	try
	{
		soNo = Integer.parseInt(soNo)+"";
	}
	catch(Exception e){}
	
	String display_header = dispInfoSoNo_L+":"+soNo;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<br>
<%
	FormatDate fd=new FormatDate();

	if((soNo!=null) && (delivHead != null && delivHead.getRowCount()>0))
	{
%>
		<Div id="theads">
		<Table width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width="15%"><%=delNo_L%></Th>
		<Th width="15%">Delivery Date</Th>
		<!--Th width="14%">Tracking number</Th>
		<Th width="12%">Tracking Date</Th>
		<Th width="14%">Carrier Name</Th-->
		<Th width="30%"><%=status_L%></Th>
		<!--<Th width="40%">Tracking</Th>-->
		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
		<Table align=center id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
		int c=0;
		String  formatkey=(String)session.getValue("formatKey");
		for (int i=0;i<delivHead.getRowCount();i++)
		{
			String delno=delivHead.getFieldValueString(i,"DelivNumb");
			String lrno =delivHead.getFieldValueString(i,"Refdoc");
			String bol =delivHead.getFieldValueString(i,"BillOfLading");
			if(bol==null)bol="";
			int flag=-1;

			for (int j=0;j<retDel.getRowCount();j++)
			{
				if (delno.equals(retDel.getFieldValueString(j,"DELIVERYNO"))){
					flag=j;
					break;
				}
			}

			if (flag==-1)
			{
				c++;
%>	
			<Tr>
			<Td width="15%">
			<a href='JavaScript:displayDetails("<%=delno%>")' <%=statusbar%>>
<%
			try
			{
				out.println(Long.parseLong(delno));
			}
			catch(Exception e){out.println(delno);}
%>
			</a>
			</Td>
			<Td width="15%" align='center'>
<%
			 String delDate = FormatDate.getStringFromDate((Date)delivHead.getFieldValue(i,"DelivDate"),formatkey,fd.MMDDYYYY);
			 out.println(delDate);
%>				
			&nbsp;</Td>

			<%--<Td width="14%"><%=lrno%>&nbsp;</Td>
			<Td width="12%" align="center">
<%
			String docdate = FormatDate.getStringFromDate((Date)delivHead.getFieldValue(i,"Docdate"),formatkey,fd.MMDDYYYY);
			if(docdate!=null)
			{
				if(docdate.length() ==10)
					out.println(docdate);
			}
%>	
			&nbsp;</Td>
			<Td width="14%" align="center"><%= delivHead.getFieldValue(i,"Ext1")%>&nbsp;</Td>
			--%>					
			<Td width="30%">
<%
			if(lrno== null || "null".equals(lrno) || lrno.trim().length()==0)
				out.println(dispatchPlant_L);
			else
				out.println("Dispatched");
%>
			&nbsp;</Td>
			<!--<Td width="40%"><%=bol%>&nbsp;</Td>-->
			</Tr>
<%
			}
			else
			{
				String stat=null;
				String s=retDel.getFieldValueString(flag,"STATUS");
				if("D".equals(s)) 
					stat="Dispatched";
				else if("R".equals(s)) 
					stat="Acknowledged";
					
				if (("D".equals(s))||("R".equals(s)))
				{
%>
					<Tr>
					<Td width='15%'><a href='JavaScript:displayDetails1("<%=retDel.getFieldValue(flag,"DELIVERYNO")%>")' <%=statusbar%>><% try{ out.println(Long.parseLong(retDel.getFieldValueString(flag,"DELIVERYNO")));}catch(Exception e){out.println(retDel.getFieldValueString(flag,"DELIVERYNO"));}%></a>&nbsp;</Td>
					<Td width='14%'><% try{ out.println(Long.parseLong(retDel.getFieldValueString(flag,"DC_NR")));}catch(Exception e){ out.println(retDel.getFieldValueString(flag,"DC_NR"));}%>&nbsp;</Td>
					<Td width='12%' align="center">
<%
					String dcdate = fd.getStringFromDate((Date)retDel.getFieldValue(flag,"DC_DATE"),".",FormatDate.DDMMYYYY);
					if(dcdate.length() ==10)
						out.println(dcdate);
%>
					&nbsp;</Td>
					<Td width='14%' align="center">
<%
					String shdate = fd.getStringFromDate((Date)retDel.getFieldValue(flag,"SHIPMENT_DATE"),".",FormatDate.DDMMYYYY);
					if(shdate.length() ==10)
						out.println(shdate);
%>	
					&nbsp;</Td>					
					<Td width='25%'>
<%
					ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
					String sold=soldto;
					String ship=retDel.getFieldValueString(flag,"SHIPTO");

					ReturnObjFromRetrieve listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(sold);

					String  Name=ship;
					String City="";

					for ( int j = 0 ; j < listShipTos.getRowCount(); j++ )
					{
						if(listShipTos.getFieldValueString(j,"EC_PARTNER_NO").equals(ship))
						{
							Name = listShipTos.getFieldValueString(j,"ECA_NAME");
							City=listShipTos.getFieldValueString(j,"ECA_CITY");
						}
					}
					if ("".equals(City))
						out.println(Name);
					else
						out.println(Name+"/"+City);
%>
					&nbsp;</Td>
					<Td width='20%'><%=stat%>&nbsp;</Td>
					</Tr>
<%
				}
			}
		}
%>
		</Table>
		</Div>
		
<%
	}
	else if(delivHead!=null && delivHead.getRowCount()==0)
	{
		String noDataStatement = urOrderProceYet_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	}
	else
	{
%>	
		<br><br>
		<table  align=center border=0  ><tr><td class=displayalert  align="center" ><%=selSalesOrdCli_L%></td></tr></table>
<%
	}
%>

<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align='center'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if (delivHead.getRowCount()>0)
	{
		//if(status.equals("C"))
		{
			buttonName.add("Back");
			buttonMethod.add("ezBack()");
		}
		/*else
		{
			buttonName.add("Back");
			buttonMethod.add("callSchedule(\""+soNo+"\")");
		}*/	
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("ezBack()");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
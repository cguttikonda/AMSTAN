<%@ include file="../../Library/Globals/ezErrorPagePath.jsp" %>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>

<%@ include file="../../../Includes/JSPs/Lables/iAddDelSchedule_Lables.jsp"%>
<html>
<head>
	<Title>Add delivery schedule</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="45%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	
	function setBack()
	{
		document.location.replace("../Misc/ezWelcome.jsp"); //remove top by kp
	}

	
	function displayDetails(delno)
	{	
		document.forms[0].action="ezAddDelSchedule.jsp?DeliveryNo="+delno 
		document.forms[0].submit();
	}
	function SubmitIt()
	{
	
		if(document.DispatchInfo.SalesOrder.options[document.DispatchInfo.SalesOrder.selectedIndex].value=='')
		{
			alert("<%=plzSelList_A%>");

		}
		else
		{
                    // document.body.style.cursor="wait"
		    document.forms[0].action="ezGetDeliveryNos.jsp" 
		    document.forms[0].submit();
		}
	} 

	</script>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form  method="post" name="DispatchInfo" onSubmit="return false">
<%
	String display_header = addDispInf_L; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	
<%
	String cust=(String)session.getValue("AgentCode");
	StringTokenizer stoken=new StringTokenizer(cust,",");
	if (stoken.countTokens()>1)
	{%>
		<Br><Br><Br><Br>
		<Table  align=center border=0 ><Tr><Td class=displayalert align=center>
		<%=uHaveSel_L%> <a href="../Misc/ezSalesHome.jsp" target="_top"><%=here_L%></a>
		</Td></Tr></Table>

	<%}
	else
	{ %>
	<%@ include file="../../../Includes/JSPs/DeliverySchedule/iGetDeliveryNos.jsp"%>    
	<%@ include file="../../../Includes/JSPs/DeliverySchedule/iDelHeader.jsp"%>
	<input type=hidden name ="soNo" value="<%=soNum%>">
	<input type=hidden name ="poNo" value="<%=poNum%>">
	<input type=hidden name ="soDate" value="<%=soDate%>">
	<%
	FormatDate fd=new FormatDate();
	%>
	<Div id='inputDiv' style='position:relative;align:center;width:80%;left:10%'>
	<Table width="70%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
	
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>
	
		<Table  align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0>
		<Tr align=center>
		<Th><%=selSalNo_L%></Th>
		<Td align='center'>
		<select name="SalesOrder">
		<Option value=""><%=selList_L%></option>
		<%	 
		ArrayList v=new ArrayList();
		for(int i=0;i<orderList.getRowCount();i++)
		{
			String dtype=orderList.getFieldValueString(i,"DocType").trim();
			if (! v.contains(orderList.getFieldValueString(i,"SdDoc"))){
			%>
			<Option value="<%=orderList.getFieldValueString(i,"SdDoc")%>|<%=orderList.getFieldValueString(i,"PurchNo")%>|<%=FormatDate.getStringFromDate((Date)orderList.getFieldValue(i,"DocDate"),".",FormatDate.DDMMYYYY)%>"><%=Integer.parseInt(orderList.getFieldValueString(i,"SdDoc"))%></option>
			<%
			v.add(orderList.getFieldValueString(i,"SdDoc"));
			}
		}
		%>
		</select>
		</td>
		<td align=center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Go");
			buttonMethod.add("SubmitIt()");
						
			out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</tr>
		</Table>
		</td>
		
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
</Table>
</Div>			
		
		
	<script>
		for(i=0;i<document.forms[0].SalesOrder.options.length;i++)
		{
			if(document.forms[0].SalesOrder.options[i].value=="<%=request.getParameter("SalesOrder")%>")
			{		
				document.forms[0].SalesOrder.selectedIndex=i;
				break;
			}
		}
	</script>
		<br>
	<%
	if ((soNum!=null) &&(delivHead != null))
	{
	%>
		<Div id="theads">
		<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width="15%"><%=deliveryNo_L%></Th>
		<!--<Th width="15%"><%=dcNo_L%></Th>
		<Th width="12%"><%=dcDate_L%></Th>-->
		<Th width="15%">Delivery Challan No</Th>
		<Th width="15%">Delivery Challan Date</Th>
		<Th width="35%"><%=shipTo_L%></Th>
		<Th width="8%"><%=status_L%></Th>
		<Th width="12%"><%=delDate_L%></Th>
		</Tr></Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
		<Table  id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
		<%	

		int c=0;
		for (int i=0;i<delivHead.getRowCount();i++)
		{
			String delno=delivHead.getFieldValueString(i,"DelivNumb");
			int flag=0;
			for (int j=0;j<retDel.getRowCount();j++)
			{
				if (delno.equals(retDel.getFieldValueString(j,"DELIVERYNO"))){	
					flag++;break;
				}
			
			}
			if (flag==0)
			{c++;
				String DelivNumb = delivHead.getFieldValueString(i,"DelivNumb");
			%>	<Tr>
				<Td width="15%">
				<a href='JavaScript:displayDetails("<%=DelivNumb%>")' <%=statusbar%>><% try{out.println(Long.parseLong(DelivNumb));}catch(Exception e){ out.println(DelivNumb); }%></a>&nbsp;</Td>
				<Td width="15%"><%=delivHead.getFieldValue(i,"Refdoc")%>&nbsp;</Td>
				<Td width="15%" align="center">
					<%
						String DelivDate = FormatDate.getStringFromDate((Date)delivHead.getFieldValue(i,"DelivDate"),".",fd.DDMMYYYY);
						if(DelivDate.length() == 10)
							out.println(DelivDate);
					%>&nbsp;</Td>
				<Td width="35%">
				<%
				String sold=delivHead.getFieldValueString(i,"SoldToParty");
				String ship=delivHead.getFieldValueString(i,"ShipToParty");

				ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
				ReturnObjFromRetrieve listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(sold);				
				String  Name=ship;
				String City="";
				//out.println(sold+"********"+ship+"*********"+listShipTos.toEzcString());
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
				%>&nbsp;</Td>
				<Td width="8%"><%=new_L%>&nbsp;</Td>
				<%   String tempDate = FormatDate.getStringFromDate((Date)delivHead.getFieldValue(i,"Docdate"),".",fd.DDMMYYYY); %>
				<Td width="12%" align="center"><%=(tempDate==null || tempDate.length() >10)?"":tempDate%>&nbsp;</Td>
				
				</Tr>
								
				<%}
			}
			if ((c==0)&&delivHead.getRowCount()>0)
			{%>
				<Tr><Td align='center' colspan=6><%=allMatDeli_L%>. </Td></Tr>
			<%}
			else if (delivHead.getRowCount()==0)	
			{%>
				<Tr><Td align='center' colspan=6><%=noDeli_L%>.</Td></Tr>
			<%}
		%>
		</Table>
		</Div>
	<%}
	else
	{%>	<br><br>
		<table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 ><tr><td class=displayalert  align="center" ><%=selSalOrd_L%></td></tr></table>
	<%}%>
<%}%>
	<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
	<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
							
				out.println(getButtonStr(buttonName,buttonMethod));
	%>
	
	</div>
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html> 

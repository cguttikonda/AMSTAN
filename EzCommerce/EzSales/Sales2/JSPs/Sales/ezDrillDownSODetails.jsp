<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iBackEndSODetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetWebOrderNo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<html>
<head>
	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	  var tabHeadWidth=95
 	  var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
	function displayreason(fieldName)
	{
		newWindow = window.open("ezReason.jsp?reasonForRejection=None","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
	}
	var retlen = 0
	var log = 0
	function setcwidth()
	{
		var cwidth=screen.availWidth;
		var cheight = screen.availHeight;
		if( (cwidth >800) &&(cheight > 572))
		{
			document.getElementById("conditionDetailsDiv").style.top="14%"
		}
	}
	onresize=setcwidth
	function showTab(tabToShow)
	{
		if(tabToShow==1)
		{
			document.getElementById("headDetailsDiv").style.visibility="visible"
			document.getElementById("buttonMainDiv").style.visibility="visible"
			document.getElementById("conditionDiv").style.visibility="hidden"
			document.getElementById("conditionDetailsDiv").style.visibility="hidden"
			document.getElementById("buttonDiv").style.visibility="hidden"
			if(document.getElementById("InnerBox1Div") != null)
			{
				document.getElementById("theads").style.visibility="visible"
				document.getElementById("InnerBox1Div").style.visibility="visible"
			}
		}
		else if(tabToShow==2)
		{
			document.getElementById("headDetailsDiv").style.visibility="hidden"
			document.getElementById("buttonMainDiv").style.visibility="hidden"
			document.getElementById("conditionDiv").style.visibility="visible"
			document.getElementById("conditionDetailsDiv").style.visibility="visible"
			document.getElementById("buttonDiv").style.visibility="visible"
			if(document.getElementById("InnerBox1Div")!=null)
			{
				document.getElementById("theads").style.visibility="hidden"
				document.getElementById("InnerBox1Div").style.visibility="hidden"
			}
		}
	}

	function showSpan(spId)
	{
		spanStyle=document.getElementById(spId).style
		if(spanStyle.display=="none")
			spanStyle.display="block"
		else
			spanStyle.display="none"

	}
	function callSchedule(file)
	{
		if (file=="EZPRINT"){

<%	
			String role=(String)session.getValue("UserRole");
			String webNo ="";
			if(webRetObjCount>0)	 webNo = webRetObj.getFieldValueString(0,"WEB_ORNO");
			if("null".equals(webNo)) webNo=webNo.trim();
			
			String status = request.getParameter("status");
			String orderType=request.getParameter("orderType");
			if ("RC".equals(status)|| "RO".equals(status)){
				if("CU".equals(role)){
%>					file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzLocalSales"
<%				}else{
%>					file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzLocalSalesInternal"
<%				}
%>
			
<%			}else if((("C".equals(status))||("O".equals(status))||("'TRANSFERED'".equals(status)))&&("CU".equals(role))){
%>			
				file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzSalesOrder"
<%			}else{
%>
				file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzSalesOrder"
				//file="ezPrint.jsp"
<%			}
%>
			}
		document.generalForm.display.value="y"
		document.generalForm.action=file;
		document.generalForm.submit();
		}
function select1()
{
	document.generalForm.display.value="N"
	showTab(1);
	setcwidth();
}
function back1()
{

	if(document.generalForm.display.value=="N")
	{
		document.body.style.cursor='wait'
		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
		document.generalForm.submit();
	}
}


function ezBack()
{
	parent.document.location.href="../Misc/ezWelcome.jsp";
}
</script>
</head>
<body  onLoad="scrollInit(10);select1()" onresize="scrollInit(10)" scroll=no>
<form method="post" name="generalForm">
<input type="hidden" name ="display" 	value="N">
<input type="hidden" name="SalesOrder" 	value="<%=strSalesOrder%>">
<input type="hidden" name="selList" 	value="<%=strSalesOrder%>">
<input type="hidden" name="status" 	value="<%=status%>">
<input type="hidden" name="orderStatus" value="<%=status%>">
<input type="hidden" name="urlPage">
<input type="hidden" name="onceSubmit" 	value="0">
<input type="hidden" name="FromForm" 	value="ClosedOrderList">
<input type="hidden" name="FromDate" 	value="<%=fromDate%>">
<input type="hidden" name="ToDate" 	value="<%=toDate%>">
<input type=hidden name="newFilter"  	value="<%=newFilter%>">
<input type=hidden name="orderType"  	value="<%=orderType%>">

<div id="headDetailsDiv" style="visibility:visible:width:100%">
<Table  id='table1'  width='95%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center">
    <Th colspan="6"><%=sorderSONO_L%>:<%=Integer.parseInt(strSalesOrder)%></Th>
</Tr>
<%
if(webRetObjCount >0)
{
%>
	<Tr >
		<Th class="labelcell" align="left"><%=webOrdNo_L%></Th>
		<Td><%= webRetObj.getFieldValue(0,"WEB_ORNO") %></Td>
		<Th class="labelcell" align="left"><%=webOrdDate_L%></Th>
		<Td><%= retWeb.getFieldValue(0,"ORDER_DATE") %></Td>
		<Th class="labelcell" align="left"><%=creBy_L%></Th>
		 <Td><%= webRetObj.getFieldValue(0,"CREATE_USERID") %> </Td>
	</Tr>
<%}else{%>
	<Tr >
		<Th class="labelcell" align="left"><%=webOrdNo_L%></Th>
		<Td>N/A</Td>
		<Th class="labelcell" align="left"><%=webOrdDate_L%></Th>
		<Td>N/A</Td>
		<Th class="labelcell" align="left"><%=creBy_L%></Th>
		 <Td>N/A </Td>
	</Tr>
<%}%>
	<Tr>
		<Th class="labelcell" align="left"><%=poNo_L%></Th>
		<Td><%=retHeader.getFieldValue(0,"PO_NO")%>&nbsp;</Td>
	       <Th class="labelcell" align="left"><%=poDate_L%></Th>
	       <Td>
<%
			String poDate = ret.getFieldValueString(0,"PO_DATE");
			if((poDate.length() <=10) &&(poDate!=null))
				out.println(poDate);
			else
				out.println("&nbsp;");
%>
	       </Td>
	       <Th class="labelcell" align="left"><%=curr_L%></Th>
	       <Td><%=retHeader.getFieldValue(0,"CURRENCY")%></Td>
	</Tr>
	<Tr>
		<Th class="labelcell" align="left"><%=soldto_L%> </Th>
		<Td>
<%
			for(int par=0;par<retPartners.getRowCount();par++)
			{
				String rol = retPartners.getFieldValueString(par,"ROLE");
				if("AG".equals(rol.trim()))
				{
					String patnam = (String)session.getValue("Agent");//retPartners.getFieldValueString(par,"PARTNER_NAME");
					String patno = (String)session.getValue("AgentCode");
%>
					<%=patnam%><input type="hidden" name="soldTo" value="<%=patno%>">
<%
					break;
				}
			}
%>	
		</Td>
		<Th class="labelcell" align="left"><%=shipto_L%> </Th>
		<Td>
<%
			for(int par=0;par<retPartners.getRowCount();par++)
			{
				String rol = retPartners.getFieldValueString(par,"ROLE");
				if("WE".equals(rol.trim()))
				{
					String patnam = (String)session.getValue("Agent");//retPartners.getFieldValueString(par,"PARTNER_NAME");
%>
					<%=patnam%>
<%
					break;

				}
			}
%>
		</Td>
		<Th class="labelcell" align="left"><%=estNetVal_L%></Th>
		<Td><%=ret.getFieldValueString(0,"NET_VALUE")%></Td>
	</Tr>
</Table>
</div>

<Div id='theads'>
<Table  width='95%'  id='tabHead'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<Th colspan="7"  width="75%"> <%=proDetails_L%></Th>
	</Tr>
	<Tr align="center" valign="middle">
		<Th width="45%" nowrap><%=prodDesc_L%>	</Th>
		<Th width="5%"  nowrap><%=uom_L%>	</Th>
		<Th width="10%" nowrap><%=quanti_L%>	</Th>
		<Th width="10%" nowrap><%=price_L%>[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		<Th width="15%" nowrap><%=val_L%>[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		<Th width="15%" nowrap><%=requireDate_L%></Th>
	</Tr>
</Table>
</div>

<DIV id='InnerBox1Div' bgcolor="blue" style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>
<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
	int count = retItems.getRowCount();
	for(int i=0;i<count;i++)
	{
		String rejectionres 		= retItems.getFieldValueString(i,"REJREASON");
		String matno			= retItems.getFieldValueString(i,"ITEM_NO");
		try{
			matno=String.valueOf(Long.parseLong(matno));
		}catch(Exception e){ }
		
		
		String requireddate = ret1.getFieldValueString(i,"REQUIREDDATE");
		if(requireddate.trim().length() >10) requireddate = "";
					
		
		if("00".equals(rejectionres.trim()))
		{
%>		
			<Tr align="center" bgcolor="#FF8080">
<%		  
		}else
		{
%>
			<Tr align='center' title="<%=matno%>---><%=retItems.getFieldValueString(i,"ITEM_DESC")%>">
<%
		}
%>
			<Td width="45%" align=left nowrap><%=retItems.getFieldValueString(i,"ITEM_DESC")%>&nbsp;</Td>
			<Td width="5%" align=left><%=retItems.getFieldValueString(i,"UOM")%></Td>
			<Td width="10%" align=right><%=retItems.getFieldValue(i,"QTY")%></Td>
			<Td width="10%" align=right><%=ret1.getFieldValueString(i,"NET_PRICE")%></Td>
			<Td width="15%" align=right><%=ret1.getFieldValueString(i,"VALUE")%></Td>
			<Td width="15%"><%=requireddate%>&nbsp;</Td>
		</Tr>
<%
	}

%>
</Table>
</Div>

<%
	String Ha="";
	String Hb="";
	String Hc="";
	String Hd="";
	String He="";
	String Hf="";
	String Hg="";
	String Hh="";
	for(int k=0;k<retLineText.getRowCount();k++)
	{
		String textLineS = retLineText.getFieldValueString(k,"ITEM_NO");
		String text = retLineText.getFieldValueString(k,"TEXT");
		String textid  = retLineText.getFieldValueString(k,"TEXT_NO");
		if(textLineS != null)
		{
			if(textLineS.trim().length() ==10)
			{
				if("ZE20".equals(textid))
					Ha=Ha + text +"<br>";
				else if("0010".equals(textid))
					Hb=Hb + text +"<br>";
				else if("0003".equals(textid))
					Hc=Hc + text +"<br>";
				else if("Z014".equals(textid))
					Hd=Hd + text +"<br>";
				else if("Z011".equals(textid))
					He=He + text +"<br>";
				else if("Z012".equals(textid))
					Hf=Hf + text +"<br>";
				else if("0006".equals(textid))
					Hg=Hg + text +"<br>";
				else if("0015".equals(textid))
					Hh=Hh + text +"<br>";
			}
		}

	}
	Ha = (Ha.trim().length() == 0)?"None":Ha;
	Hb = (Hb.trim().length() == 0)?"None":Hb;
	Hc = (Hc.trim().length() == 0)?"None":Hc;
	Hd = (Hd.trim().length() == 0)?"None":Hd;
	He = (He.trim().length() == 0)?"None":He;
	Hf = (Hf.trim().length() == 0)?"None":Hf;
	Hg = (Hg.trim().length() == 0)?"None":Hg;
	Hh = (Hh.trim().length() == 0)?"None":Hh;

%>
<div id="conditionDiv" style="visibility:hidden;position:absolute;top:10%;left:1%;width:98%">
<Table width="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
    <Th colspan="2" align="center"> <b><%=tCondition_L%></b></Th>
  </Tr>
</Table>
</div>

<div id="conditionDetailsDiv" style="overflow:auto;visibility:hidden;position:absolute;top:17%;left:1%;width:98%;height:76%">
<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<Tr>
	<Th width=20% align="left" id="PackingInstructionsTh"><%=packInstruct_L%></Th>
	<Td ><%= Hb %></Td>
</Tr>
<Tr>
	<Th width=20% align="left" id="LabelInstructionsTh"><%=labInstruct_L%></Th>
	<Td><%= Hc %></Td>
</Tr>
<Tr>
	<Th width=20% align="left"  id="InspectionClausesTh"><%=insClause_L%></Th>
	<Td><%= Hd %></Td>
</Tr>
<Tr>
	<Th width=20% align="left" id="HandlingSpecificationsTh"><%=handSpec_L%></Th>
	<Td><%= He %></Td>
</Tr>
<Tr>
	<Th width=20% align="left" id="RegulatoryReqTh"><%=reguRequire_L%></Th>
	<Td><%= Hf %></Td>
</Tr>
<Tr>
	<Th width=20% align="left" id="DocumentsTh"><%=docRequire_L%></Th>
	<Td> <%= Hg %></Td>
</Tr>
<Tr>
	<Th width=20% align="left" id="OthersTh"><%=others_L%></Th>
	<Td><%= Hh %></Td>
</Tr>
<Tr>
	<Th align="center" colspan=2>Remarks</Th>
</Tr>
<Tr>
	 <Td colspan=2><%= Ha %></Td>
</Tr>
</Table>
</div>

<input type="hidden" name="decideParameter" value="DispDet">
<input type="hidden" name="DisplayFlag" 	value="FromSo">
<!--dont delete above hidden field.It is using in dispatchinfo-->

<div id="buttonMainDiv" style="visibility:visible;Position:Absolute;top:85%">
<Table align="center" width="100%">
	<Tr>
		<Td align="center" class="blankcell"><font color="#006666"><%=taxDutiedAppli_L%></font></Td>
	</Tr>
	<Tr>
		<Td class="blankcell"  align="center">

<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("ezBack()");
	buttonName.add("Remarks");
	buttonMethod.add("showTab(\"2\")");
	buttonName.add("Print");
	buttonMethod.add("callSchedule(\"EZPRINT\")");	
	buttonName.add("Expected Date");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezListViewDelSchedule.jsp\")");	
	buttonName.add("Dispatch Details");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezGetDeliveryBySO.jsp\")");	
	buttonName.add("Billing Details");
	buttonMethod.add("callSchedule(\"ezSOPaymentDetails.jsp\")");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
  		</Td>
	</Tr>
	</Table>
</div>

<div align=center id="buttonDiv" style="visibility:hidden;position:absolute;top:85%;width:100%;">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("showTab(\"1\")");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iBackEndSODetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetWebOrderNo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<html>
<head>
	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="40%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script> 
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>

	var MValues = new Array();
	
	MValues[0] =new EzMList("poNo","PO Number");
	MValues[1] =new EzMList("poDate","PO Date");
	MValues[2] =new EzMList("requiredDate","Req Deliv Date");
	
	function verifyQty(field,targetval)
	{	
		var fValue=field.value	
		if(isNaN(fValue)){
			alert("Please enter valid quantity");
			field.value="0";
			field.focus();
		}else {
			if(fValue==""){
				field.value="0";
			}else if(parseFloat(fValue)>parseFloat(targetval)){
				alert("Required Quantity should be less than or equals to target quantity");
				field.focus();
			}
			
			
		}
		
		return true;
	}
		


	function EzMList(fldname,flddesc)
	{
		this.fldname=fldname;
		this.flddesc=flddesc;
	}
	function chk()
	{
		
		for(c=0;c<MValues.length;c++)
		{
			if(funTrim(eval("document.generalForm."+MValues[c].fldname+".value")) == "")
			{
				alert("<%=plzEnter_A%>"+MValues[c].flddesc);
				if(c=="0")
					eval("document.generalForm."+MValues[c].fldname+".focus()")
				return false;
			}
			fd = eval("document.generalForm."+MValues[1].fldname+".value");
			td = eval("document.generalForm."+MValues[2].fldname+".value");
			
			

			a=fd.split("/");
			b=td.split("/");

			fd1=new Date(a[2],a[0]-1,a[1])
			td1=new Date(b[2],b[0]-1,b[1])

			if(fd1 > td1)
			{
				alert("PO Date date must be less than Req.Deliv. Date");
				return false;
			}
			
			
			var qtyObj=document.generalForm.Reqqty;
			
			
			if(isNaN(qtyObj.length)){
				if(qtyObj.value==0)
				{
					alert("Required should be greater than 0");
					return false;
				}	
			}else{
				var chk=false;
				for(i=0;i<qtyObj.length;i++){
					if(qtyObj[i].value!=0)
					chk=true;
				}
				if(!chk){
					alert("Please enter required quantity to atleast one product");
					return false;
				}	
			}
			
		}
		return true;

	}	



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
	function formEvents(formEv)
	{
		document.generalForm.action=formEv;
		document.generalForm.submit();
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
function getBack()
{
	document.body.style.cursor="wait"
	document.generalForm.action="ezBackEndContractList.jsp";
	document.generalForm.submit();
}
function setBack()
{
	document.body.style.cursor="wait"
	document.generalForm.action="ezBackEndSOList.jsp";
	document.generalForm.submit();
}
	
function ezBack()
{
	<%
		if("C".equals(status))
		{
	%>

			document.generalForm.urlPage.value="ClosedBackEndList"
	<%
		}else if("O".equals(status))
		{
	%>
			document.generalForm.urlPage.value="OpenBackEndList"
	<%
		}if("RC".equals(status))
		{
	%>
			document.generalForm.urlPage.value="ClosedReturnBackEndList"
	<%
		}else if("RO".equals(status))
		{
	%>
			document.generalForm.urlPage.value="OpenReturnBackEndList"
	<%
		}else if("fO".equals(status))
		{
	%>
			document.generalForm.urlPage.value="OpenFRSBackEndList"
	<%
		}else if("'TRANSFERED'".equals(status) || "'RETTRANSFERED'".equals(status) || "'RETCMTRANSFER'".equals(status) || "'RETTRANSFERED','RETCMTRANSFER'".equals(status) )
		{
	%>
				document.generalForm.urlPage.value="listPage"
	<%
		}
	%>
		

		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
		document.generalForm.submit();

}

function CheckSelect() {
	var pCount=0;
	var selCount=0;
	
	if(document.generalForm.chk!=null)
	{
		if(isNaN(document.generalForm.chk.length))
		{
			selCount = 1			
		}
		else 
		{
			selCount = document.generalForm.chk.length
		}
	}	
	if(selCount<1){
		alert("Sorry,there are no products");
		document.returnValue = false;
	}else{ 
		document.generalForm.action="../ShoppingCart/ezAddCart.jsp"
		document.generalForm.submit();
	}
}

function setCreateOrder()
{
	if(chk()){
		document.generalForm.action="ezAddSaveSalesOrderFromContract.jsp"
		document.generalForm.submit();
	}	
}
</script>
</head>
<body  onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=no>
<form method="post" name="generalForm">

<input type="hidden" name="TotalCount" value="<%=retItems.getRowCount()%>">
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
<input type=hidden name="soldTo"  	value="<%=customer%>">
<input type=hidden name="fromDetails"  	value="Y">


<%
	String temp = "";	
	try
	{
		temp=Integer.parseInt(strSalesOrder)+"";
	}
	catch(Exception e)
	{
		temp=strSalesOrder;
	}	
	String display_header = "Contract details for Document No:"+temp;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>



<div id="headDetailsDiv" style="visibility:visible:width:100%">
<Table  id='table1'  width='95%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center">
    <Th colspan="6">Header Details</Th>
</Tr>
<%
String patno = "";
if(webRetObjCount >0)
{
%>
	<Tr >
		<!--
		<Th class="labelcell" align="left">Contract No</Th>
		<Td><%//= temp %></Td>
		-->
		
		<Th class="labelcell" align="left">Start Date</Th>
		<Td><%= retHeader.getFieldValue(0,"CT_VALID_F") %></Td>
		<Th class="labelcell" align="left">End Date</Th>
		 <Td><%= retHeader.getFieldValue(0,"CT_VALID_T") %> </Td>
		<Th class="labelcell" align="left"><%=curr_L%></Th>
		<Td><input type="hidden" name="currency" value="<%=retHeader.getFieldValue(0,"CURRENCY")%>"><%=retHeader.getFieldValue(0,"CURRENCY")%> </Td>
	</Tr>
<%}else{%>
	<Tr >
		<!--
		<Th class="labelcell" align="left">Contract No</Th>
		<Td><%//= temp %></Td>
		-->
		<Th class="labelcell" align="left">Start Date</Th>
		<Td><%= ret.getFieldValue(0,"CT_VALID_F")%></Td>
		<Th class="labelcell" align="left">End Date</Th>
		<Td><%= ret.getFieldValue(0,"CT_VALID_T")%></Td> 
		<Th class="labelcell" align="left"><%=curr_L%></Th>
		<Td><input type="hidden" name="currency" value="<%=retHeader.getFieldValue(0,"CURRENCY")%>"><%=retHeader.getFieldValue(0,"CURRENCY")%> </Td>
	</Tr>
<%}%>
	<Tr>
		<Th class="labelcell" align="left"><%=poNo_L%></Th>
		<Td><input type="text" class="InputBox" name="poNo" value="<%=retHeader.getFieldValue(0,"PO_NO") %>"></Td>
	       <Th class="labelcell" align="left"><%=poDate_L%></Th>
	       
	       <Td>
	       
<%
			String poDate = ret.getFieldValueString(0,"PO_DATE");
			
			if(poDate == null || "null".equals(poDate))
				poDate = "";
			
			
%>
	       <input type="text" class="InputBox" name="poDate" value="<%=poDate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImage("poDate")%>
	       </Td>
	       <Th class="labelcell" align="left">Req.Deliv.Date</Th>
	       <Td><input type="text" class="InputBox" name="requiredDate" value="" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("requiredDate")%></Td>
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
					String patnam = retPartners.getFieldValueString(par,"PARTNER_NAME");//(String)session.getValue("Agent");
					patno = retPartners.getFieldValueString(par,"PARTNER_NO");//(String)session.getValue("AgentCode");
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
					String patnam = retPartners.getFieldValueString(par,"PARTNER_NAME");//(String)session.getValue("Agent");
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
		<Th width="14%" nowrap>Product Code</Th>
		<Th width="32%" nowrap>Product Desc</Th>
		<Th width="5%"  nowrap><%=uom_L%></Th>
		<Th width="10%" nowrap>Target Qty</Th>
		<Th width="14%" nowrap>Required Qty</Th>
		<Th width="10%" nowrap><%=price_L%>[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		
		<Th width="15%" nowrap><%=val_L%>[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		
	   </Tr>
</Table>
</div>

<DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>
<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
	int count = retItems.getRowCount();
	for(int i=0;i<count;i++)
	{
		String rejectionres 		= retItems.getFieldValueString(i,"REJREASON");
		String matno			= retItems.getFieldValueString(i,"ITEM_NO");
		String price			= ret1.getFieldValueString(i,"NET_PRICE");
		String myFinalPrice		= retItems.getFieldValueString(i,"NET_PRICE");
		
		try
		{
			if(price!=null && !"null".equals(price) && "0.00".equals(price.trim()))
			{
				double subtot = Double.parseDouble(retItems.getFieldValueString(i,"VALUE"));
				double subqty = Double.parseDouble(retItems.getFieldValueString(i,"TARGET_QTY"));
				java.math.BigDecimal obj = new java.math.BigDecimal(subtot/subqty);
				price = obj.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";;	
				myFinalPrice=price;
			}
		}
		catch(Exception e){price ="0.00";myFinalPrice="0.00"; }
		
		try{
			matno=String.valueOf(Long.parseLong(matno));
		}catch(Exception e){ }
		
		
		String requireddate = ret1.getFieldValueString(i,"REQUIREDDATE");
		
		if(requireddate == null || "null".equals(requireddate))
			requireddate = "";
		
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
			<Td width="14%" align=left nowrap><%=matno%>&nbsp;
			
			<input type="hidden" name="CheckBox" value="" >
			<input type="hidden" name="chk" value="" >
			<input type="hidden" name="lineNo" value="<%=retItems.getFieldValueString(i,"LINE_NO")%>">
			<input type="hidden" name="Product" value="<%=retItems.getFieldValueString(i,"ITEM_NO")%>">
			
			
			</Td>
			<Td width="32%" align=left nowrap><%=retItems.getFieldValueString(i,"ITEM_DESC")%>&nbsp;</Td>
			<Td width="5%" align=center><%=retItems.getFieldValueString(i,"UOM")%></Td>
			<Td width="10%" align=right>
			<%=eliminateDecimals(retItems.getFieldValueString(i,"TARGET_QTY"))%>
			<input type="hidden" name="targetQty" value="<%=eliminateDecimals(retItems.getFieldValueString(i,"TARGET_QTY"))%>">
			</Td>
			
			<Td width="14%" align=right>
			<input type="text" class="InputBox" name="Reqqty" onBlur='verifyQty(this,<%=eliminateDecimals(retItems.getFieldValueString(i,"TARGET_QTY"))%>)' size="10" maxlength="15" STYLE="text-align:right" value="<%=eliminateDecimals(retItems.getFieldValueString(i,"TARGET_QTY"))%>">
			</Td>
			
			<Td width="10%" align=right><input type="hidden" name="requiredPrice" value="<%=myFinalPrice%>"><%=price%></Td>
			<Td width="15%" align=right><%=ret1.getFieldValueString(i,"VALUE")%></Td>
			
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
<%--
<div id="conditionDiv" style="visibility:hidden;position:absolute;top:10%;left:1%;width:98%">
<Table width="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
    <Th colspan="2" align="center"> <b><%=tCondition_L%></b></Th>
  </Tr>
</Table>
</div>
--%>
<div id="conditionDiv" style="visibility:hidden;position:absolute;top:10%;left:1%;width:98%"></div>
<div id="conditionDetailsDiv" style="overflow:auto;visibility:hidden;position:absolute;top:17%;left:1%;width:98%;height:76%">
<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%--
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
--%>
<Tr>
	<Th align="center" colspan=2>Remarks</Th>
</Tr>
<Tr>
	 <Td colspan=2><%= Ha %></Td>
</Tr>
</Table>
</div>
<%

	session.setAttribute("SONumber",strSalesOrder);
	session.setAttribute("FromDate",fromDate);
	session.setAttribute("ToDate",toDate);
	session.setAttribute("SoldTo",patno);
	session.setAttribute("status",status);
	session.setAttribute("back","O");
	


%>
<input type="hidden" name="decideParameter" value="DispDet">
<input type="hidden" name="DisplayFlag" value="FromSo">
<input type="hidden" name="back" value="O">
<!--dont delete above hidden field.It is using in dispatchinfo-->

<div id="buttonMainDiv" style="visibility:visible;Position:Absolute;top:85%">
<Table align="center" width="100%">

<Tr>
	<Td class="blankcell"  align="center">

<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Place Order");
  	buttonMethod.add("setCreateOrder()");
  	
	/*buttonName.add("Add To Cart");
  	buttonMethod.add("CheckSelect()");
  	
		
	buttonName.add("Remarks");
	buttonMethod.add("showTab(\"2\")");
	buttonName.add("Print");
	buttonMethod.add("formEvents(\"ezPrint.jsp\")");	
	buttonName.add("Expected Date");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezListViewDelSchedule.jsp\")");	
	buttonName.add("Shipment Details");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezGetDeliveryBySO.jsp\")");	
	buttonName.add("Billing Details");
	buttonMethod.add("callSchedule(\"ezSOPaymentDetails.jsp\")");	*/
	
	
	buttonName.add("Back");
	buttonMethod.add("getBack()");
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
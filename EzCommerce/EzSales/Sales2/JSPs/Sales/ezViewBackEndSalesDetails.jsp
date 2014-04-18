<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
        String fromDate		= request.getParameter("FromDate");  // don't delete
	String toDate 		= request.getParameter("ToDate");
	String orderStatus	= request.getParameter("status");
	String newFilter	= request.getParameter("newFilter");
 %>
<%@ include file="../../../Includes/JSPs/Sales/iWebBackEndSalesDetails.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%
	/************************Files Attached******************************************/

	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String soNum = "";
	String uploadFilePathDir="";

	ResourceBundle site=null;
	try
	{
		uploadFilePathDir = site.getString("UPLOADFILEPATHDIR");
		uploadFilePathDir = uploadFilePathDir.replace('\\','/');
	}
	catch(Exception e)
	{
		System.out.println("Got Exception while getting Upload Temp Dir "+e);
	}

	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	int noOfDocs = 0;
	
	if(sdHeader!=null)
	{
		soNum = sdHeader.getFieldValueString(0,"WEB_ORNO");
	
		uploadFilePathDir = "j2ee/"+uploadFilePathDir;
		ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
		ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
		ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
		uDocsParams.setObjectNo("'"+salesAreaCode+"SO"+soNum+"'");
		myParams.setObject(uDocsParams);
		Session.prepareParams(myParams);
		try
		{
			retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured while getting Upload docs:"+e);	
		}
		
		if(retUploadDocs!= null)
		{
			noOfDocs = retUploadDocs.getRowCount();
		}
	}
	
	/************************Files Attached******************************************/	
	
	if(sdHeader!=null)
	{

		ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
		FormatDate formatDate = new FormatDate();
		java.util.Date webOrderDate=(java.util.Date)sdHeader.getFieldValue(0,"ORDER_DATE");

		String StatusButton = sdHeader.getFieldValueString(0,"STATUS").trim();
		String UserRole = (String)session.getValue("UserRole");
		String Reason = sdHeader.getFieldValueString(0,"RES2");
		if( (Reason==null)||(Reason.trim().length() == 0)||("null").equals(Reason) )
			Reason="None";
		else
			Reason = Reason.trim();
%>

		<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp"%>
		<%@ include file="../../../Includes/JSPs/Lables/iViewBackEndSDetails_Lables.jsp" %>
		<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp" %>
<%

		String SAPno = sdHeader.getFieldValueString(0,"BACKEND_ORNO");

		if((SAPno==null)|| (SAPno.trim().length()==0) ||("null").equals(SAPno))
		   SAPno="Not-Available";
			String netValue = sdHeader.getFieldValueString(0,"NET_VALUE");
			String DisCash = sdHeader.getFieldValueString(0,"DISCOUNT_CASH");
			String DisPer =sdHeader.getFieldValueString(0,"DISCOUNT_PERCENTAGE");
			String Freight=sdHeader.getFieldValueString(0,"FREIGHT");
			String carrierName = sdHeader.getFieldValueString(0,"REF1");
				
			if(carrierName==null || "null".equals(carrierName))
			{
				carrierName  = "";  
			}

		if( (DisCash == null)||(DisCash.trim().length()==0)||("null".equals(DisCash) )  )
			DisCash="0";
		if( (DisPer == null)||(DisPer.trim().length()==0)||("null".equals(DisPer)) )
			DisPer="0";
		if( (Freight == null)||(Freight.trim().length()==0)||("null".equals(Freight)) )
			Freight="0";
%>
<html>
<head>
	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="30%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
	var retlen
	var log
	<%
	if( retLines.getRowCount()>=8)
	{
  	  out.println("retlen=1");
	}
	else
	{
	  out.println("retlen=0");
	}
	 if( (("CU").equals(UserRole)||("AG").equals(UserRole) || ("CM").equals(UserRole) )&&(!("Transfered").equalsIgnoreCase(StatusButton)))
	{
	  out.println("log=1");
	}
	else
	{
	 out.println("log=0");
	}
	%>



	function showTab(tabToShow)
	{

	obj1=document.getElementById("div1")
	obj2=document.getElementById("div4")
	obj3=document.getElementById("theads")
	obj4a=document.getElementById("InnerBox1Div")
	obj6=document.getElementById("div6")
	obj7=document.getElementById("buttonDiv" )


		if(tabToShow==1)
		{
			obj1.style.visibility="visible"
			obj2.style.visibility="visible";
			obj3.style.visibility="visible";

			obj4a.style.visibility="visible";
			obj6.style.visibility="hidden"
			obj7.style.visibility="hidden"
			scrollInit();

		}
		else if(tabToShow==2)
		{
			obj1.style.visibility="hidden"
			obj2.style.visibility="hidden"
			obj6.style.visibility="visible"
			obj7.style.visibility="visible"
			obj3.style.visibility="hidden";
			obj4a.style.visibility="hidden";
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
	  if(document.generalForm.onceSubmit.value!=1){
   	    document.generalForm.onceSubmit.value=1
   	    document.body.style.cursor="wait"
	    document.generalForm.display.value="y"
      	    document.generalForm.action=file;
            document.generalForm.submit();
           }
        }

function back1()
{
	if(document.generalForm.display.value=="N")
	{
		document.body.style.cursor='wait'
		//document.generalForm.target="_top"
		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
		document.generalForm.submit();
	}
}
	function displayreason()
	{
		newWindow=window.open("ezReason.jsp?reasonForRejection=<%=Reason%>","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no");
	}
	function select1()
	{
	document.generalForm.display.value="N"
	showTab(1);
	}

function openNewWindow(obj,i)
{
	deldate=eval("document.generalForm.del_sch_date_" + i);
	delqty = eval("document.generalForm.del_sch_qty_"+ i);
	waste = eval("document.generalForm.waste_"+ i);
	obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value+"&matdesc="+waste.value

	newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
}
function ezBack()
{
	<%
		String status = request.getParameter("status");
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
		document.generalForm.action="ezBackEndSOList.jsp"
		document.generalForm.submit();

}
	</script>
</head>
<body onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=yes>
<form method="post" name="generalForm">
<%
	String orderType1=request.getParameter("orderType");
	String customer1=request.getParameter("soldTo");

%>
<input type="hidden" name ="display" value="N">
<input type=hidden name="urlPage">
<input type=hidden name="chkBrowser"  value="0">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type="hidden" name="orderStatus" value="<%=orderStatus%>">
<input type="hidden" name="AgentCode" value="<%=request.getParameter("AgentCode")%>">
<input type=hidden name="orderType"  	value="<%=orderType1%>">
<input type=hidden name="soldTo"  	value="<%=customer1%>">

<%
	String backend = "";
	if(("Transfered").equalsIgnoreCase(StatusButton))
	{
		backend=sdHeader.getFieldValueString(0,"BACKEND_ORNO");
		try{
			backend = String.valueOf(Long.parseLong(backend));
		}catch(Exception e){}	
	}	
	String display_header = sOrdSoNo_L +backend;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<input type="hidden" name="selList" value="<%= sdHeader.getFieldValueString(0,"BACKEND_ORNO") %>|<%= sdHeader.getFieldValueString(0,"RES1")%>" >
<input type="hidden" name="SalesOrder" value="<%= sdHeader.getFieldValueString(0,"BACKEND_ORNO") %>">
<input type="hidden" name="fromPage" value="SalesOrder">
<input type="hidden" name="flag1" value="flag1">
<div id="div1" style="visibility:visible:width:100%">
<%
String  formatkey=(String)session.getValue("formatKey");
%>
<Table  id='table1'  width='95%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr align="center">
    <th colspan="6"><%=genInfo_L%></th>
</tr>

<Tr >
        <Th class="labelcell" align="left"><%=webOrd_L%></Th>
        <Td><%= sdHeader.getFieldValueString(0,"WEB_ORNO")%></Td>
        <Th class="labelcell" align="left"><%=webOrdDt_L%></Th>
        <Td><%= formatDate.getStringFromDate(webOrderDate,formatkey,FormatDate.MMDDYYYY)%>	</Td>
	<Th class="labelcell" align="left"><%=createdby_L%></Th>
	<Td><%= sdHeader.getFieldValueString(0,"CREATE_USERID") %></Td>
</Tr>


<Tr>
        <Th class="labelcell" align="left"><%=poNo_L%></Th>
        <Td><%=sdHeader.getFieldValueString(0,"PO_NO")%>&nbsp;</Td>
	<Th class="labelcell" align="left"><%=poDate_L%></Th>
	<Td><%= sdHeader.getFieldValue(0,"RES1") %></Td>
	<Th class="labelcell" align="left">Shipping Type</Th>
<%
	String shippingTypeDesc = (String)ezShippingTypes.get(carrierName);
	if(shippingTypeDesc==null || "null".equals(shippingTypeDesc))
		shippingTypeDesc = "&nbsp";
	
%>
	<Td><%=shippingTypeDesc%></Td>
</Tr>
<Tr>
        <Th class="labelcell" align="left"><%=soldTo_L%> </Th>
	<Td>
		<%
			String soNa = sdSoldTo.getFieldValueString(0,"SOTO_NAME");
			soNa = (soNa.length() >15)?soNa.substring(0,15)+"..":soNa;
			out.println(soNa);
		%>
	<input type="hidden" name="soldTo" value="<%=sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE")%>"></td>
	<Th class="labelcell" align="left"><%=shipto_L%> </Th>
  	<Td>
		<%
			String shNa =  sdShipTo.getFieldValueString(0,"SHTO_NAME") ;
			shNa = (shNa.length() >15)?shNa.substring(0,15)+"..":shNa;
			out.println(shNa);

		%>
	</Td>
	<Th class="labelcell" align="left"><%=estNetVal_L%></Th>
	<Td><%=myFormat.getCurrencyString(netValue)%></Td>
</Tr>
<%-- <Tr>
        <Th class="labelcell" align="left"><%=disCash_L%> </Th>
	<Td><%=DisCash%></Td>
	<Th class="labelcell" align="left"><%=discount_L%>(%) </Th>
  	<Td><%=DisPer%></Td>
	<Th class="labelcell" align="left"><%=friCharg_L%></Th>
	<Td><%=Freight%></Td>
</Tr> --%>

</TABLE>
</div>
<Div id='theads'>
<Table  width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

  <tr align="center">
    <th colspan="8"  width="75%"> <%=poDet_L%></th>
  </tr>

<tr>
	<th rowspan=2 width="10%">Product Code</th>
	<th rowspan=2 width="10%">Customer Material</th>
	<th rowspan=2 width="30%"><%=prodDesc_L%> Desc</th>
	<!--<th rowspan=2 width="5%"><%=uom_L%></th>-->
	<th rowspan=2 width="10%"><%=quan_L%></th>
	<th rowspan=2 width="10%"><%=price_L%>[<%= sdHeader.getFieldValueString(0,"DOC_CURRENCY")%>]</th>
	<Th width="10%" nowrap><%=value_L%>[<%= sdHeader.getFieldValueString(0,"DOC_CURRENCY")%>]</Th>
	<th rowspan=2 width="20%">Required Delivery Date</th>

  </Tr>
<%--
  <Tr>
	<Th  width="10.5%"><%=requi_L%></Th>
	<Th  width="10.5%"><%=conf_L%></Th>
   </Tr>
--%>

 <%
	out.println("</Table>");
	out.println("</div>");

	out.println("<DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>");
	out.println("<Table id='InnerBox1Tab'  width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >");


	log4j.log("retLinesretLinesretLines::","W");
	//log4j.log(retLines.toEzcString(),"W");
	log4j.log("retLinesretLinesretLines::","W");

   String reqDateString=null,proDateString=null;
   int rl=0,r2=0;
   for(int i=0;i<retLines.getRowCount();i++)
   {

	reqDateString=retLines.getFieldValueString(i,"REQ_DATE");
	proDateString=retLines.getFieldValueString(i,"PROMISE_FULL_DATE");
	if(reqDateString==null)
	reqDateString="";
	if(proDateString==null)
	proDateString="";
	int chkcount =0;
	
	String custMat = retLines.getFieldValueString(i,"CUST_MAT");
	
	if(custMat == null || "null".equals(custMat))
		custMat = "";


	String delSchQty="";
	String delSchDates="";
	String delProdLine="";

	rl=reqDateString.indexOf(" ");
	r2=proDateString.indexOf(" ");

	reqDateString=(rl!=-1)?formatDate.getStringFromDate(java.sql.Date.valueOf(reqDateString.substring(0,rl)),formatkey,FormatDate.MMDDYYYY):" ";
	proDateString=(r2!=-1)?formatDate.getStringFromDate(java.sql.Date.valueOf(proDateString.substring(0,r2)),formatkey,FormatDate.MMDDYYYY):" ";
	String desc = retLines.getFieldValueString(i,"PROD_DESC");
	String ProdLine = retLines.getFieldValueString(i,"SO_LINE_NO");
	String prodNo = retLines.getFieldValueString(i,"PROD_CODE");
	try{
	prodNo = String.valueOf(Long.parseLong(prodNo));
	}
	catch(Exception e){}

	for(int k=0;k<retDeliverySchedules.getRowCount();k++)
	{
		delProdLine = retDeliverySchedules.getFieldValueString(k,"EZDS_ITM_NUMBER");
		if(ProdLine.equals(delProdLine))
		{
			if(delSchDates.trim().length() == 0)
				delSchDates=retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_DATE");
			else
				delSchDates=delSchDates+"@@"+retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_DATE");
			if(delSchQty.trim().length() == 0)
				delSchQty = retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY");
			else
				delSchQty = delSchQty+"@@"+retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY");

			if(! ("0").equals(retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY") ))
			{
				chkcount++;
			}
		}
	}
	
	String qtyStr="",priceStr="",totalStr="0";	
	qtyStr		= eliminateDecimals(retLines.getFieldValueString(i,"COMMITED_QTY"));
	priceStr	= retLines.getFieldValueString(i,"COMMIT_PRICE");
	
	if(Double.parseDouble(qtyStr)>0 && Double.parseDouble(priceStr)>0)
		totalStr	= (Double.parseDouble(qtyStr) * Double.parseDouble(priceStr))+"";		

%>
	<tr align="center" valign="middle" >
	<td align="left"  width="10%"><%=prodNo %></td>
	<td align="left"  width="10%"><%=custMat %>&nbsp;</td>
		<td align="left"  width="30%">
			&nbsp;<%= desc %>
		<input type="hidden" name="waste_<%=i%>" 	value="<%= desc %>">
		<input type="hidden" name="matdesc" 		value="<%= desc %>">
		<input type="hidden" name="lineNo" 		value="<%= ProdLine %>"></td>
     		<!--<td align="center"  width="5%"><%=retLines.getFieldValueString(i,"UOM") %></td>-->
		<td align="right"  width="10%"><%=qtyStr%></td>
		<td align="right"  width="10%"><%=myFormat.getCurrencyString(priceStr) %></td>
		<td align="right"  width="10%"><%=myFormat.getCurrencyString(totalStr) %></td>
		<td align="center"  width="20%" nowrap>
			<%
			if(chkcount >=2)
			{%>
				<a href='JavaScript:openNewWindow("ezDatesDisplay.jsp?ind=<%=i%>&itemNo=<%=ProdLine%>","<%=i%>")'><%=multiple_L%></a>
			<%}
			else
			{
				out.println(reqDateString);
			}%>

			<input type="hidden" name="del_sch_date_<%=i%>" value="<%=delSchDates%>">
			<input type="hidden" name="del_sch_qty_<%=i%>" value="<%=delSchQty%>">

		</td>


    </tr>
<%}%>
</Table>
</Div>
<input type="hidden" name="decideParameter" value="DispDet">
<input type="hidden" name="DisplayFlag" value="FromSo">
<!--dont delete above hidden field.It is using in dispatchinfo-->

<div id="div4" style="visibility:visible;Position:Absolute;top:80%">
	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
<%
	if(noOfDocs>0)
	{
		String workFlowStatus = "APPROVED";
%>
		<Th align="center" >
			View Attached Files
		</Th>
	</Tr>
	<Tr>
		<Td borderColorDark=#ffffff width=40% align="center" class="blankcell">
			<iframe src="../UploadFiles/ezAttachments.jsp?docNum=<%=soNum%>&docType=SO&workFlowStatus=<%=workFlowStatus%>" frameborder=1 width=100% scrolling=auto scrolling=yes height="75"></iframe>
		</Td>
<%
	}
%>	
	</Tr>
	</Table>
<Table align="center" width="100%">
<Tr>
	<Td align="center" class="blankcell"><font color="#006666"><%=taxesDuties_L%></font></Td>
</Tr>
<Tr align="center"><Td class="blankcell" >
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Remarks");
	buttonMethod.add("showTab(\"2\")");
	buttonName.add("Back");
	buttonMethod.add("ezBack()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Td>
</Tr>
</Table>
</div>

<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;top:16%;left:1%;width:90%;height:70%">
<Table align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="95%">
<tr><th align=center>Remarks</th></tr>
<tr><td  align=center width=100%>
<%
		String t2=sdHeader.getFieldValueString(0,"TEXT2");
		t2=(t2==null || "null".equals(t2))?"None":t2;
		t2 = EzReplace.setNewLine(t2);
		out.println(t2);
%>
	</td></tr>

</table>
</div>

<div id="buttonDiv"  style="visibility:hidden;position:absolute;top:90%;width:100%;left:0%">
<table align="center">
<Tr>
<td align="center" class=blankcell valign=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("showTab(\"1\")");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Td>
</Tr>
</table>
</div>
<%
	}
%>
<input type="hidden" name="onceSubmit" value=0>
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
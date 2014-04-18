<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iBackEndSODetails.jsp"%> 
<%@ include file="../../../Includes/JSPs/Sales/iGetWebOrderNo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%@ page import="javax.xml.parsers.*,java.io.*,javax.xml.transform.*,javax.xml.transform.dom.*,javax.xml.transform.stream.*" %>
<%@ page import="org.w3c.dom.*,org.xml.sax.*" %>
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
	
	if(webRetObjCount>0)
	{
		soNum = webRetObj.getFieldValueString(0,"WEB_ORNO");
	
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
%>
<html>
<head>
	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="40%"
 	   	  var itemCountJS = '<%=retItemsCount%>'
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
			document.getElementById("showTot").style.visibility="visible"
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
			document.getElementById("showTot").style.visibility="hidden"
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
	function downloadXMLfun(file)
	{
		document.generalForm.action=file;
		document.generalForm.submit();		
	}
	function emailOrderfun(file)
	{
		document.generalForm.action=file;
		document.generalForm.submit();		
	}

	function callSchedule(file)
	{
		if (file=="EZPRINT")
		{
<%	
			String role=(String)session.getValue("UserRole");
			String webNo ="";
			if(webRetObjCount>0)	 webNo = webRetObj.getFieldValueString(0,"WEB_ORNO");
			if("null".equals(webNo)) webNo=webNo.trim();
			
			String status = request.getParameter("status");
			String orderType=request.getParameter("orderType");
			if ("RC".equals(status)|| "RO".equals(status))
			{
				if("CU".equals(role))
				{
%>
					file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzLocalSales"
<%				
				}
				else
				{
%>				
					file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzLocalSalesInternal"
<%				
				}
%>
			
<%			
			}
			else if((("C".equals(status))||("O".equals(status))||("'TRANSFERED'".equals(status)))&&("CU".equals(role)))
			{
%>			
				file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzSalesOrder"
<%			
			}
			else
			{
%>
				file="ezLocalDetailsPrint.jsp?SoldTo=<%=customer%>&status=<%=status%>&Back=<%=strSalesOrder%>&webOrdNo=<%=webNo%>&orderType=<%=orderType%>&xmlFileName=EzSalesOrder"
				//file="ezPrint.jsp"
<%			
			}
%>
		}
		document.generalForm.display.value="y"
		document.generalForm.action=file;
		document.generalForm.submit();
	}
function select1()
{
	if(parseFloat(itemCountJS) > 0)
	{
		document.generalForm.display.value="N"
		showTab(1);
		setcwidth();
	}
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
	document.generalForm.action="ezBackEndClosedSOList.jsp";
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

function setCreateOrder(){
	document.generalForm.action="ezCreateBackEndOrder.jsp"
	document.generalForm.submit();      
}
function funBack(){

	document.body.style.cursor="wait"
	document.generalForm.action="ezSubmittedOrdersList.jsp?orderStatus='TRANSFERED'&RefDocType=P";
	document.generalForm.submit();

}
function getTracking(id)
{
	window.open ("ezShowTrackData.jsp?id="+id,"Tracking","location=0,status=0,scrollbars=0,width=200,height=200"); 
}
</script>
</head>

<body  onLoad="select1()" scroll=yes>
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
	String display_header = sorderSONO_L+" :"+temp;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type="hidden" name="SO" 	value="<%=temp%>">


<%
if(retHeaderCount>0 && retItemsCount>0)
{
%>

<div id="headDetailsDiv" style="visibility:visible:width:100%">
<Table  id='table1'  width='98%'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
<Tr align="center">
    <Th width="15%"><%=poNo_L%></Th>
    <Th width="15%"><%=poDate_L%></Th>
    <Th width="15%"><%=estNetVal_L%></Th>
    <Th width="15%">Currency</Th>
    <Th width="20%">Required Delivery Date</Th>
    <Th width="20%">Order Status</Th>
</Tr>

<%
String patno = "";
String SOXML ="<?xml version=\"1.0\"?><SO>";

String shipToAddress = null;
String billToAddress = null;

String soldTo = null;
String shipTo = null;
SOXML = SOXML+"<Table_Orders><Order><orders_id>"+temp+"</orders_id>";      


if(retPartners!=null){
	//out.print(retPartners.toEzcString());
 	String partRole="",partner="",name ="",name2="",street="",city="",district="",region="",country="",postl="",tele="",fax="";
        String tempStr= "";
        
		
	for(int i=0;i<retPartners.getRowCount();i++){
	
		tempStr= "";
		partRole = retPartners.getFieldValueString(i,"ROLE");
		
		if("AG".equals(partRole) || "WE".equals(partRole)){
		
			partner = retPartners.getFieldValueString(i,"PARTNER_NO");
			name = retPartners.getFieldValueString(i,"PARTNER_NAME");
			name2 = retPartners.getFieldValueString(i,"PARTNER_NAME2");
			street = retPartners.getFieldValueString(i,"STREET");
			city = retPartners.getFieldValueString(i,"CITY");
			district = retPartners.getFieldValueString(i,"DISTRICT");
			region = retPartners.getFieldValueString(i,"REGION");
			country = retPartners.getFieldValueString(i,"COUNTRY");
			postl = retPartners.getFieldValueString(i,"POSTL_CODE");
			tele = retPartners.getFieldValueString(i,"TELEPHONE1");
			fax = retPartners.getFieldValueString(i,"FAX_NUMBER");
			
			//out.println(i+"::"+partRole+"::"+retPartners.getFieldValueString(i,"PARTNER_NAME")+"::"+name2+"::"+street+"::"+city+"::"+district);
			
			if(name==null || "null".equals(name)) name="";
			if(name2==null || "null".equals(name2)) name2="";
			if(street==null || "null".equals(street)) street="";
			if(city==null || "null".equals(city)) city="";
			if(region==null || "null".equals(region)) region="";
			if(postl==null || "null".equals(postl)) postl="";
			if(country==null || "null".equals(country)) country="";
			if(tele==null || "null".equals(tele)) tele="";
			if(fax==null || "null".equals(fax)) fax="";
			
			
			if(name!=null && !"null".equals(name) && !"".equals(name.trim()) )
			tempStr = tempStr + name +"<br>";
			if(name2!=null && !"null".equals(name2) && !"".equals(name2.trim()) )
			tempStr = tempStr + name2 +"<br>";
			if(street!=null && !"null".equals(street) && !"".equals(street.trim()) )
			tempStr = tempStr + street +"<br>";
			if(city!=null && !"null".equals(city) && !"".equals(city.trim()) )
			tempStr = tempStr + city +", ";
			//if(district!=null && !"null".equals(district) && !"".equals(district.trim()) ) 
			//tempStr = tempStr + district +"<br>";
			if(region!=null && !"null".equals(region) && !"".equals(region.trim()) )
			tempStr = tempStr + region +"&nbsp;";
			if(postl!=null && !"null".equals(postl) && !"".equals(postl.trim()) )
			tempStr = tempStr + postl +"<br>";
			if(country!=null && !"null".equals(country) && !"".equals(country.trim()) )
			tempStr = tempStr + country +"<br>";
			
			if(tele!=null && !"null".equals(tele) && !"".equals(tele.trim()) )   
			tempStr = tempStr +"Tel#:" + tele +"<br>";
			
			if(fax!=null && !"null".equals(fax) && !"".equals(fax.trim()) )
			tempStr = tempStr +"Fax#:"+ fax +"<br>";			
			
			
			if("AG".equals(partRole)){
				soldTo = partner;
				billToAddress  = tempStr;
				SOXML = SOXML+"<billing_name><![CDATA["+name+"]]></billing_name><billing_firstname><![CDATA["+name2+"]]></billing_firstname><billing_lastname><![CDATA[]]></billing_lastname><billing_company><![CDATA[]]></billing_company><billing_street_address><![CDATA["+street+"]]></billing_street_address><billing_suburb></billing_suburb><billing_city><![CDATA["+city+"]]></billing_city><billing_postcode>"+postl+"</billing_postcode><billing_state>"+region+"</billing_state><billing_country>"+country+"</billing_country><billing_tel>"+tele+"</billing_tel><billing_fax>"+fax+"</billing_fax>";
			}else{
				shipTo = partner;
				shipToAddress  = tempStr;
				SOXML = SOXML+"<delivery_name><![CDATA["+name+"]]></delivery_name><delivery_firstname><![CDATA["+name2+"]]></delivery_firstname><delivery_lastname><![CDATA[]]></delivery_lastname><delivery_company><![CDATA[]]></delivery_company><delivery_street_address><![CDATA["+street+"]]></delivery_street_address><delivery_suburb></delivery_suburb><delivery_city><![CDATA["+city+"]]></delivery_city><delivery_postcode>"+postl+"</delivery_postcode><delivery_state>"+region+"</delivery_state><delivery_country>"+country+"</delivery_country><delivery_tel>"+tele+"</delivery_tel><delivery_fax>"+fax+"</delivery_fax>";
			}
			
			
		}
		
		

	}

}
	        

%>

<Tr align="center" >
	<Td width="15%"><%=retHeader.getFieldValue(0,"PO_NO") %></Td>
	<Td width="15%">
<%
		String poDate = ret.getFieldValueString(0,"PO_DATE");

		if(poDate == null || "null".equals(poDate))
			poDate = "&nbsp;";

		if((poDate.length() <=10) &&(poDate!=null))
			out.println(poDate);
		else
			out.println("&nbsp;");
%>
	</Td>

	<Td width="15%"><%=ret.getFieldValueString(0,"NET_VALUE")%></Td>
	<Td width="15%"><%=retHeader.getFieldValue(0,"CURRENCY")%></Td>
<%
	String reqDelDT = ret.getFieldValueString(0,"REQ_DATE");
	if(reqDelDT == null || "null".equals(reqDelDT))
	reqDelDT = "&nbsp;";
	
%>
    <Td width="20" align='left'><%=reqDelDT%></Td>
    <Td width="20%"align='center'><font style="color:red"><strong><%=delivStatus%></strong></font></Td>
    
</Tr>

</Table>	
<%
SOXML = SOXML+"<po_num>"+retHeader.getFieldValue(0,"PO_NO")+"</po_num><date_purchased>"+poDate+"</date_purchased><orders_status>"+delivStatus+"</orders_status><currency>"+retHeader.getFieldValue(0,"CURRENCY")+"</currency><netvalue>"+ret.getFieldValueString(0,"NET_VALUE")+"</netvalue></Order></Table_Orders>";      
%>

<Table  id='table2'  width='98%'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
	<Td  width='20%' align="left" valign="top"><b>Shipping Address:</b> </Td>  
	<Td  width='30%' align="left" valign="top"><%=shipToAddress%></Td>  
	<Td  width='20%' align="left" valign="top"><b>Billing Address:</b> </Td>  
	<Td  width='30%' align="left" valign="top">
	<%=billToAddress%>
	<input type="hidden" name="soldTo" value="<%=soldTo%>">
	</Td>  
	
</Tr>
</Table>

<Table  width='98%'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
	
	<Tr align="center" valign="middle">
		<Th width="10%" >SAP Part#</Th> 
		<Th width="10%" >Ordered Part#</Th>
		<Th width="26%" nowrap>Product Description</Th>
		<!--<Th width="5%"  nowrap><%=uom_L%></Th>-->
		<Th width="8%" nowrap><%=quanti_L%></Th>
		<Th width="10%" nowrap><%=price_L%>[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		<Th width="13%" nowrap>Total Price[<%=retHeader.getFieldValue(0,"CURRENCY")%>]</Th>
		<Th width="18%" nowrap>Required Delivery Date</Th>
		<Th width="5%" nowrap>Track</Th>
	   </Tr>
</Table>
<Table width='98%' align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
<%
SOXML = SOXML+"<Table_Products>";
	int count = retItems.getRowCount();
	for(int i=0;i<count;i++)
	{
		SOXML = SOXML+"<Product>";
		String rejectionres 		= retItems.getFieldValueString(i,"REJREASON");
		String matno			= retItems.getFieldValueString(i,"ITEM_NO");
		String price			= ret1.getFieldValueString(i,"NET_PRICE");
		String custMat                  = retItems.getFieldValueString(i,"CUST_MAT");
		String zztext                   = retItems.getFieldValueString(i,"ZZTEXT");
		String itTax                    = retItems.getFieldValueString(i,"TAX");
		//zztext="test";
		if(zztext == null || "null".equals(zztext))
			zztext = "";
		else
			zztext = zztext.trim();
		if(custMat == null || "null".equals(custMat))
			custMat = "";
			
		try
		{
			totTax = totTax.add(new java.math.BigDecimal(itTax));
		}
		catch(Exception e)
		{
		
		}
		
		try
		{
			if(price!=null && !"null".equals(price) && "0.00".equals(price.trim()))
			{
				double subtot = Double.parseDouble(retItems.getFieldValueString(i,"VALUE"));
				double subqty = Double.parseDouble(retItems.getFieldValueString(i,"QTY"));
				java.math.BigDecimal obj = new java.math.BigDecimal(subtot/subqty);
				price = obj.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";;	
			}
		}
		catch(Exception e){price ="0.00"; }
		
		try{
			matno=String.valueOf(Long.parseLong(matno)); 
		}catch(Exception e){ }
		
		
		String requireddate = ret1.getFieldValueString(i,"REQUIREDDATE");
		
		if(requireddate == null || "null".equals(requireddate))
			requireddate = "";
		
		if(requireddate.trim().length() >10) requireddate = "";
					
		String colTone = "";
		if(i%2==0)
			colTone = "style='background-color:#EFEFEF'";
		
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
			<Td width="10%" align=left nowrap <%=colTone%>><%=matno%>&nbsp;
			
			<input type="hidden" name="CheckBox_<%=i%>" value="" >
			<input type="hidden" name="chk" value="" >
			<input type="hidden" name="Product_<%=i%>" value="<%=retItems.getFieldValueString(i,"ITEM_NO")%>">
			<input type="hidden" name="Reqqty_<%=i%>" value="<%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%>">
			<input type="hidden" name="ZZTEXT_<%=i%>" value="<%=zztext%>" >
			
			</Td>
			<Td width="10%" align=left <%=colTone%>><%=custMat%>&nbsp;</td>
			<Td width="26%" align=left <%=colTone%>><%=retItems.getFieldValueString(i,"ITEM_DESC")%>&nbsp;</Td>
			<!--<Td width="5%" align=center <%=colTone%>><%=retItems.getFieldValueString(i,"UOM")%></Td>-->
			<Td width="8%" align=right <%=colTone%>><%=eliminateDecimals(retItems.getFieldValueString(i,"QTY"))%></Td>
			<Td width="10%" align=right <%=colTone%>><%=price%></Td>
			<Td width="13%" align=right <%=colTone%>><%=ret1.getFieldValueString(i,"VALUE")%></Td>
			<Td width="18%" <%=colTone%>><%=requireddate%>&nbsp;</Td>
<%
			if(!"".equals(zztext))
			{
%>
				<Td width="5%" <%=colTone%>><a href="javascript:getTracking('<%=i%>')">Details</a></Td>
<%
			}
			else
			{
%>
				<Td width="5%" <%=colTone%>>&nbsp;</Td>
<%
			}
%>
		</Tr>
<%

		SOXML = SOXML+"<products_model>"+matno+"</products_model><products_name><![CDATA["+retItems.getFieldValueString(i,"ITEM_DESC")+"]]></products_name><products_price>"+price+"</products_price><products_shipping_time>"+requireddate+"</products_shipping_time><products_quantity>"+eliminateDecimals(retItems.getFieldValueString(i,"QTY"))+"</products_quantity>";
		SOXML = SOXML+"</Product>";	
	}
	totTax = totTax.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

	SOXML = SOXML+"</Table_Products><order_tax>"+totTax+"</order_tax><order_freightVal>"+freightVal+"</order_freightVal></SO>";
	
	SOXML=SOXML.replaceAll("<","&lt;");
	SOXML=SOXML.replaceAll(">","&gt;");
	SOXML=SOXML.replaceAll("&","&amp;");
	SOXML=SOXML.replaceAll("'","&apos;");
	SOXML=SOXML.replaceAll("\"","&quo;");
	

%>
</Table>
</Div>
<input type="hidden" name="orderXML" value="<%=SOXML%>">
<Div id="showTot" style="visibility:visible">
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="98%">
	<Tr>
		<Td width=54% class=blankcell>&nbsp;</Td>
		<Th width="10%" align=right>Freight</Th>
		<Td width="13%" align=right>&nbsp;<input type="text" name="freightVal" size="10" readonly class=tx value="<%=freightVal%>" style="text-align:right"></Td>
		<Td width=23% class=blankcell>&nbsp;</Td>
		
	</Tr>
	<Tr>
		<Td width=54% class=blankcell>&nbsp;</Td>
		<Th width="10%" align=right>Tax</Th>
		<Td width="13%" align=right>&nbsp;<input type="text" name="taxVal" size="10" readonly class=tx value="<%=totTax.toString()%>" style="text-align:right"></Td>
		<Td width=23% class=blankcell>&nbsp;</Td>
		
	</Tr>

	</Table>
</div>
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
				if("0001".equals(textid))
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

<div id="conditionDiv" style="visibility:hidden;position:absolute;top:10%;left:1%;width:98%"></div>
<div id="conditionDetailsDiv" style="overflow:auto;visibility:hidden;position:absolute;top:17%;left:1%;width:98%;height:76%">
<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >

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
	
	
	//out.println("======>retHeader======>"+retHeader.toEzcString());
	//out.println("======>retItems======>"+retItems.toEzcString());
	
	//out.println("======>retPartners======>"+retPartners.toEzcString());

%>
<input type="hidden" name="decideParameter" value="DispDet">
<input type="hidden" name="DisplayFlag" value="FromSo">
<input type="hidden" name="back" value="O">
<!--dont delete above hidden field.It is using in dispatchinfo-->

<div id="buttonMainDiv" style="visibility:visible;Position:Absolute">

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
<!--
<Tr>
	<Td align="center" class="blankcell"><font color="blue">Taxes extra as applicable</font></Td>
</Tr>
-->
<Tr>
	<Td class="blankcell"  align="center">

<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList(); 
	
			
	buttonName.add("Remarks");
	buttonMethod.add("showTab(\"2\")");
	buttonName.add("Print");
	buttonMethod.add("formEvents(\"ezPrint.jsp\")");	
	buttonName.add("Expected Date");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezListViewDelSchedule.jsp\")");	
	buttonName.add("Shipment Details");
	buttonMethod.add("callSchedule(\"../DeliverySchedules/ezGetDeliveryBySO.jsp\")");	
	buttonName.add("Billing Details");
	buttonMethod.add("callSchedule(\"ezSOPaymentDetails.jsp\")");	
	buttonName.add("Download To XML");
	buttonMethod.add("downloadXMLfun(\"ezDownloadOrderToXML.jsp\")");
	buttonName.add("Email Order");
	buttonMethod.add("emailOrderfun(\"ezEmailOrderAsXML.jsp\")");
	if((status.trim()).equalsIgnoreCase("C"))
	{
		buttonName.add("Back");
		buttonMethod.add("getBack()");
	}
	else if((status.trim()).equalsIgnoreCase("S"))
	{
	       buttonName.add("Back");
	       buttonMethod.add("funBack()");
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("setBack()");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
  		</Td>
	</Tr>
	</Table>
	


<div align=center id="buttonDiv" style="visibility:hidden;position:absolute;top:85%;width:100%;">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("showTab(\"1\")");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<%
}
else
{
	String noDataStatement = "No order lines present for selected order";
%>

<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<div align=center id="bacKButtonDiv" style="visibility:visible;position:absolute;top:85%;width:100%;">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if((status.trim()).equalsIgnoreCase("C"))
	{
		buttonName.add("Back");
		buttonMethod.add("getBack()");
	}
	else if((status.trim()).equalsIgnoreCase("S"))
	{
	       buttonName.add("Back");
	       buttonMethod.add("funBack()");
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("setBack()");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<%
}
%>
</form>
</body>
<Div id="MenuSol"></Div>
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
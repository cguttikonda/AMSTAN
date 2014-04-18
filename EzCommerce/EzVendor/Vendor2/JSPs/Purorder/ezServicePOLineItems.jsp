<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Purorder/iServicePOLineItems.jsp"%>
<%FormatDate formatDate = new FormatDate();%>
<%@ page import ="java.math.*" %>

<html>
<head>
<title>PO LINE Details</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="52%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script>
  	
  	function lastPODtlsWin(matNum)
	{
		var url="../Rfq/ezGetLastPODetails.jsp?matNumber="+matNum;
		var poDtlWin=window.open(url,"powin","width=850,height=650,left=100,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	
  	function ezBack()
	{
		document.myForm.action = 'ezListToBeDelivered.jsp'
		document.myForm.submit();
	}
	function formEvents(formEv)
	{
		if(formEv != "ezPrint.jsp")
			hideButton();
		document.myForm.action=formEv;
		document.myForm.submit();
	}
	function formEvents1(formEv)
	{		
		
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
	}

	function goToPlantAddr(plant)
	{
		window.open("../Misc/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,width=440,height=360,left=250,top=200");
	}
	function showHeaderText()
	{
		document.myForm.target = "PopUp";
		document.myForm.action= "ezShowHeaderText.jsp";
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
		document.myForm.target = "_self";
	}
	
	function showItemText(indx)
	{
		document.myForm.target = "PopUp";
		document.myForm.myIndx.value=indx;
		document.myForm.action= "ezShowItemText.jsp?myIndx="+indx;
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
		document.myForm.target = "_self";
	}
	
	
	
	function SAPView(num)
	{
		var url="../RFQ/ezQCFSAPPrint.jsp?qcfNumber="+num;
		var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}

	</script>

	</head>
	<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
	<%!
		String netOrderAmount="";
	%>
	<%
	int polines = dtlXML.getRowCount();
	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	String display_header = "";
	if (polines ==0)
	{
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>	

		<br><br><br><br><br>
		<TABLE width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th height="21">No Order Lines present for this Purchase Order</th>
		</tr>
		</table>
		
	<%
	}
	else
	{
		 netOrderAmount = request.getParameter("NetAmount");
		if (netOrderAmount==null)
			netOrderAmount = new String("0");

		String currency = request.getParameter("Currency");
		if (currency==null)
			currency = new String("INR");

		String orderType = request.getParameter("orderType");
		if(orderType == null)
			orderType="";
		//out.println("orderType:"+orderType);
		display_header = "Service Purchase Order Details";
	%>

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<form  name="myForm">
	<input type="hidden" name="myIndx">
	<input type="hidden" name="chkValue">
	<input type="hidden" name="orderType" value="<%=orderType%>">
	<table width="80%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr> 
		<th align="right">PO No </th>
		<td ><%=Long.parseLong(poNum)%><input type="hidden" value="<%=poNum%>" name="PurchaseOrder"></td>
		<th align="right">Order Date</th>
		<td ><%=formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%> </td>
		<input type="hidden" value="<%=formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%>" name="OrderDate">
		<th align="right">Net Value</th>
		<td ><%= myFormat.getCurrencyString(netOrderAmount)%>&nbsp;&nbsp;<input type="hidden" name="OrderValue" value="<%=netOrderAmount%>"><!--ADDED BY SOMA-->
		<input type="hidden" name="OrderValue" value="<%=netOrderAmount%>">
		</td>
		<th align="right">Currency</th>
		<td><%=currency%></td>
		
	</tr>
	
	<tr>
		<th align="right">Payment Terms</th>
		<td><%=payTerms%></td>
		<th align="right">Inco Terms1</th>
		<td><%=incoTerms1%></td>
		<th align="right">Inco Terms2</th>
		<td><%=incoTerms2%></td>
		<th align="right">Text</th>
		<td>
		<input type="hidden" name="hText" value="<%=headerText%>">
		<a href="javascript:onClick=showHeaderText()">
		<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
		</a>
		</td>
	</tr>
	<tr>
				<th align="right">QCF</th>
				<td colspan="7">
<%			
				if(!"N/A".equals(poconQCFNumber))
				{
%>
					<a href='javascript:SAPView(<%=poconQCFNumber%>)'><%=poconQCFNumber%></a>
<%
				}
				else
				{
					out.println(poconQCFNumber);
				}
%>			
				</td>
	</tr>
	</table>
		<input type="hidden" name="orderCurrency" value=<%=currency%>>

	<!-------------- This two hidden fields are required for shipment deails ------------>
	<input type="hidden" name="base" value="PurchaseOrder">
	<input type="hidden" name="baseValues" value="<%=poNum%>">
	<br>
	<input type="hidden" name="InvStat" value="P">
	<DIV id="theads">
	<table id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr align="center">
	<th width="6%" >Line</th>
      	<th width="10%">Material</th>
<%
	if("I".equals((String)session.getValue("VENDTYPE")))	      	
	{
%>
		<th width="10%">Vendor Material</th>
<%
	}
%>
      	<th width="20%">Description</th>
	<th width="5%">UOM</th>
      	<th width="8%">Qty</th>
      	<th width="8%">Price</th>
<%
	if("I".equals((String)session.getValue("VENDTYPE")))	      	
	{
%>
		<th width="8%">Value</th>
<%
	}else{
%>
		<th width="13%">Value</th>
<%

	}
%>      	
      
     	<th width="5%">Plant</th>
     	<th width="11%">Agmt No</th>
     	
      	<th width="10%">ED Date </th>
      	<th width="4%">Text</th>
    	</tr>

</Table>
</DIV>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	Hashtable ht = new Hashtable();
	Hashtable ht1= new Hashtable();

	for(int i=0; i<polines; i++){

		String lineNum = (String)dtlXML.getFieldValue(i, LINENO);
		String matNum = (String)dtlXML.getFieldValue(i, MATERIAL);
		String vendMatNum=(String)dtlXML.getFieldValue(i, "ITEMCODESYSTEM");
		
		String contract= dtlXML.getFieldValueString(i, "CONTRACT");
		String contractItem= dtlXML.getFieldValueString(i, "CONTRACTPOSITION");
		
		String myItemText=(String)itemTextHT.get(lineNum);
					
		if(myItemText==null || "null".equals(myItemText))
		myItemText="";
			
		

		if(contract==null || "null".equals(contract) ||"".equals(contract.trim())){
			contract="&nbsp;";
		}else{
			
			contract="<a href=../Rfq/ezGetAgrmtDetails.jsp?agmtNo="+contract+"&viewType=PO alt=View>"+contract+ "("+  contractItem + ")</a>";
		}
		
		
		if(vendMatNum==null) vendMatNum="";
		matNum = matNum.trim();
		String matDesc = (String)dtlXML.getFieldValue(i, MATDESC);
		matDesc = matDesc.trim();
		String uom = (String)dtlXML.getFieldValue(i, UOM);
		String qty = dtlXML.getFieldValueString(i, ORDQTY);
		String plant = dtlXML.getFieldValueString(i, "PLANT");
		ht.put(lineNum,matDesc);
			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
	
		

		String price = dtlXML.getFieldValueString(i, AMOUNT);// Soma --- Amount is mapped to price.
		if("JPY".equals(currency))
			price = (Double.parseDouble(price)*100)+"";		

		double amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"));
		BigDecimal BD = new BigDecimal(amnt);
		
		String netAmount =dtlXML.getFieldValueString(i, AMOUNT);


		Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
		String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	
		//for receipts details ezPoReceiptDetails.jsp?order=" + poNum + "&line=" + lineNum + "&desc=" + matDesc +">");

		// THE FOLLOWING CHECK IS DONE ON 27.10.2001

		/*if( (uom != null && !uom.equals("")) && (qty != null && !qty.equals("")))
		{*************/ // THIS CHECK IS REMOVED ON 29.10.2001
		%> 
 
    			<tr align="center"> 
		             <td width="6%"><%if(lineNum != null)out.println(lineNum); %><input type="hidden" name="line" value="<%=lineNum%>"></td>
			<td width="10%" align="center" title="Click here to view last 6 PO details for this material">
			<%try{
				matNum=String.valueOf(Long.parseLong(matNum));
			}catch(NumberFormatException nfe)
	     		{
			}
			ht1.put(lineNum,matNum);
			%>
			<a href="JavaScript:lastPODtlsWin('<%= matNum %>')"><%= matNum %>&nbsp;</a>
			&nbsp;</td>
<%
			if("I".equals((String)session.getValue("VENDTYPE"))){
%>
				<td width="10%"><%=vendMatNum%>&nbsp;</td>
<%
			}
%>			
			

			<td width="20%" align="left">
			
			<%=matDesc %>
			</td>
			<td width="5%"><%=uom %></td>
			<td width="8%" align="right"><%=qty.substring(0,qty.indexOf(".")+3)%></td>
			<td width="8%" align="right">
			<%=myFormat.getCurrencyString(price)%>
			</td>
<%
			if("I".equals((String)session.getValue("VENDTYPE"))){
%>
				<td width="8%" align="right">
<%
			}else{
%>
				<td width="13%" align="right">
<%
			}
%>				
			
			
			<%  String bd = BD.toString();
				out.println( myFormat.getCurrencyString(bd));
			%>
			</td>
			<td width="5%">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
			<%=plant%></a></td>
			
			<td width="11%" align="center"><%=contract%></td>
		    	<td width="10%" align="left">
			<%	
			if(edDate.length() == 10)
			{
				if(dtlXML.	getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
				{
		%>			<a href="ezDelDetPO.jsp?orderNum=<%=poNum%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
		<%		}
				else
				{
		%>			<%=edDate%>
		<%		}
			}
			%>
			</td>
			
			<td width="4%" align="center">
						
				<input type="hidden" name="iText" value="<%=myItemText%>">
				<a href="javascript:onClick=showItemText('<%=i%>')">
				<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
				</a>
						
						
			</td>
			
			
			
			
			
		  	</tr>  
			<%
			//	}  //end if (qty != null and uom != null)
	}//end for
	session.setAttribute("materialDesc",ht);
	session.setAttribute("materialNos",ht1);
	%>
	</table>
</div>
	<div align='center' style='position:absolute;top:88%;width:100%;'>
	<span id="EzButtonsSpan" >

<%
	if(request.getParameter("flag")!=null)
	{
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		butActions.add("ezBack()");
	}
	else
	{     
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		butActions.add("history.go(-1)"); 
	}

	butNames.add("&nbsp;&nbsp;Print Version&nbsp;&nbsp;&nbsp;");   
	butActions.add("formEvents('ezPrint.jsp')"); 
	butNames.add("&nbsp;&nbsp;Entry Sheets&nbsp;&nbsp;&nbsp;");   
	butActions.add("window.location.href='ezServiceEntrySheets.jsp?docNo="+poNum+"&selFlg=L'"); 
	if(!"NFI".equals((String)session.getValue("VENDTYPE"))){
		butNames.add("&nbsp;&nbsp;View Receipts&nbsp;&nbsp;&nbsp;");   
		butActions.add("formEvents('ezPoReceiptDetails.jsp')"); 
		butNames.add("&nbsp;&nbsp;Payment Details&nbsp;&nbsp;&nbsp;");   
		butActions.add("formEvents('ezWaitPOPaymentDetails.jsp')"); 
	}
	out.println(getButtons(butNames,butActions));

%>
	</span>
			<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
	</span> 
	</div>
	<div align='center' style='position:absolute;width:100%;top:95%'>
	<center><font size='2' color='black'> * The Order value is before Discounts,Taxes, Duties and Levies</font></center>
	</div>
<%
}//end if
%>
 <input type="hidden" name="NetAmount" value="<%=netOrderAmount%>">
 <input type="hidden" name="vendorNo" value="<%=soldTo%>">
 
</form>
<Div id="MenuSol"></Div>
</body>
</html>

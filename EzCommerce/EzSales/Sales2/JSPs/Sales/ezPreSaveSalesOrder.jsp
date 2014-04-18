<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezbasicutil.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="ezGetPricesFromSAP.jsp"%>
<%
	int cartcount		  = itemoutTable.getRowCount();
	String pageUrl 		  = request.getParameter("pageUrl");
	String SoldTo	  	  = request.getParameter("soldTo");
	String SoldToName  	  = request.getParameter("soldToName");
	String ShipTo	  	  = request.getParameter("shipTo");
	String ShipToName	  = request.getParameter("shipToName");
	String PODate 		  = request.getParameter("poDate");
	String requiredDate 	  = request.getParameter("requiredDate");
	Double grandTotal 	  = new Double("0");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();	
%>

<Html>
<Head>
<Script>
	var tabHeadWidth=95
 	var tabHeight="30%"
</Script>

<Script>
	function formSubmit(obj1,obj2)
	{
		buttonsSpan		=document.getElementById("EzButtonsSpan")
		buttonsMsgSpan		=document.getElementById("EzButtonsMsgSpan")
		buttonsSpanRem		=document.getElementById("EzButtonsRemarksSpan")
		buttonsMsgSpanRem	=document.getElementById("EzButtonsRemarksMsgSpan")
		
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display="none"
			buttonsSpanRem.style.display="none"
			buttonsMsgSpan.style.display="block"
			buttonsMsgSpanRem.style.display="block"
		}
		document.myForm.status.value=obj2;
		document.body.style.cursor="wait";
		document.myForm.target="_self";
		document.myForm.action=obj1;
		document.myForm.submit();
		
		
	}	
	
	function showTab(tabToShow)
	{
		obj1=document.getElementById("headDiv")
		obj2=document.getElementById("theads")
		obj3=document.getElementById("InnerBox1Div")	
		obj4=document.getElementById("showTot");
		obj5=document.getElementById("buttonDiv")
		obj6=document.getElementById("remDiv")
		obj7=document.getElementById("remButDiv")
		scrollInit('SHOWTOT');
		if(tabToShow=="1")
		{
			obj1.style.visibility="visible";
			obj2.style.visibility="visible";
			obj3.style.visibility="visible";			
			obj4.style.visibility="visible";
			obj5.style.visibility="visible";
			obj6.style.visibility="hidden";
			obj7.style.visibility="hidden";
		}
		else if(tabToShow=="2")
		{
			obj1.style.visibility="hidden";
			obj2.style.visibility="hidden";
			obj3.style.visibility="hidden";
			obj4.style.visibility="hidden";
			obj5.style.visibility="hidden";
			obj6.style.visibility="visible";
			obj7.style.visibility="visible";
		}
	}
	function ezBackMain()
	{
		document.body.style.cursor="wait"
<%		if("ezAddSales".equals(pageUrl) ){
%>			document.generalForm.action="ezPlaceOrder.jsp"
			document.generalForm.submit();
<%		}else if("shop".equals(pageUrl) || "contract".equals(pageUrl) || "reorder".equals(pageUrl)){
%>			document.generalForm.action="ezAddSalesSh.jsp"
			document.generalForm.submit();
<%		}else{
%>			top.history.back()
<%		}
%>	}
	
	
	
</Script>


	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>		
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</Head>
<Body onLoad="scrollInit('SHOWTOT');" onresize="scrollInit('SHOWTOT')" scroll=no>
<Form name="myForm" method="post">
<input type="hidden" name="status">
<%
	String display_header = COrderFor_L+" "+SoldToName;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	
	<Div id="headDiv" align="center" style="visibility:visible;width:100%">
	<Table width='95%' valign='top'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	      <Tr>
	        	<th class="labelcell" align="left"><%=pono_L%></th>
	        	<td><input type="hidden" name="poNo"  value="<%=PONO%>"><%=PONO%></td>
	        	<th class="labelcell" align="left"><%=podate_L%></th>
		        <td><input type="hidden" name="poDate" value="<%=PODate%>"><%=PODate%></td>
	        	<th class="labelcell" align="left"><%=rDate_L%></th>
		        <td><input type="hidden" name="requiredDate" value="<%=requiredDate%>"><%=requiredDate%></td>
	     </Tr>
	     <Tr>
		<Th class="labelcell" align="left"><%=soldto_L %> </Th>
		<Td>
			<input type="hidden" name="soldTo" value="<%=SoldTo%>">
			<input type="hidden" name="soldToName" value="<%=SoldToName%>">
			<%=SoldToName%>
		</Td>
		<Th class="labelcell" align="left"><%=shipto_L%> </Th>	
	     	<Td>
			<input type="hidden" name="shipTo" value="<%=ShipTo%>">
			<input type="hidden" name="shipToName" value="<%=ShipToName%>">
			<%=ShipToName%>
		</Td>
	        <Th class="labelcell" align="left"><%=curr_L%> </Th>
		<Td>
			<input type="hidden" name="docCurrency" value="<%=Currency%>">
			<input type="hidden" name="currency" value="<%=Currency%>">
			<%=Currency%>
		</Td>
       	    </Tr>
  </table>
  </div>
  <Div id='theads'>
	<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="15%" valign="top" nowrap>Product Code</Th>
	        <Th width="30%" valign="top" nowrap><%=prod_L%></Th>
		<Th width="7%"  valign="top"><%=uom_L%></Th>
		<Th width="14%" valign="top"><%=qty_L%></Th>
		<Th width="16%" valign="top"><%=price_L%> [<%=Currency%>]</Th>
	       	<Th width="16%" valign="top"><%=val_L%> [<%=Currency%>]</Th>
	</Tr>
</Table>
</div>	



<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:100%;height:30%;'>
<Table width='100%' id='InnerBox1Tab'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<%
	for(int i=0;i<cartcount;i++)
	{
		String itemoutProdCode = itemoutTable.getFieldValueString(i,"Material");
		String itemoutProdDesc = itemoutTable.getFieldValueString(i,"ShortText");
		String itemoutProdUom  = itemoutTable.getFieldValueString(i,"SalesUnit");
		String itemoutProdQty  = itemoutTable.getFieldValueString(i,"ReqQty");
		String subTot          = itemoutTable.getFieldValueString(i,"NetValue1");
		String ItemCat         = itemoutTable.getFieldValueString(i,"ItemCat");

		itemoutProdQty		= ((itemoutProdQty == null) || ("null").equals(itemoutProdQty)) ?"0":itemoutProdQty;
		subTot		= ((subTot == null) || ("null").equals(subTot)) ?"0":subTot;
		double obj 	= Double.parseDouble(subTot)/Double.parseDouble(itemoutProdQty);
		String pric     = String.valueOf(obj);
		pric		= (pric==null||"null".equals(pric)||pric.trim().length()==0 || "NAN".equals(pric))?"0":pric;

		String toolTip = "";
    		try{
        		toolTip = Integer.parseInt(itemoutProdCode)+"-->"+itemoutProdDesc;
           	}catch(Exception e)
           	{
           		toolTip = itemoutProdCode +"--->"+itemoutProdDesc;
           	}
           	
           	java.math.BigDecimal bUprice 	= new java.math.BigDecimal( pric );
		java.math.BigDecimal bPrice 	= null;
		java.math.BigDecimal bQty 	= new java.math.BigDecimal(itemoutProdQty.toString());
		bPrice = bQty.multiply(bUprice);
		grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
		String priceCurr = myFormat.getCurrencyString(bUprice.doubleValue());
		String valueCurr = myFormat.getCurrencyString(bPrice.doubleValue());
%>
		<Tr>
			<Td width="15%" align="left">&nbsp;<%=itemoutProdCode%> 
				<input type="hidden" name="product" value="<%= itemoutProdCode%>">
			</Td>
			<Td width="30%" align="left" title="<%=toolTip%>" >&nbsp;
				<input type="text" name="prodDesc" size="40" class="tx" readonly value="<%=itemoutProdDesc%>">		
			</Td>
			<Td width="7%" align="left">&nbsp;<%=itemoutProdUom%> </Td>
			<Td width="14%" align="right"><input type="hidden" name="del_sch_qty" value="<%=bQty%>"><%=myFormat.getCurrencyString(bQty)%></Td>
			<Td width="16%" align="right">
<% 			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
	   		{
				out.println("&nbsp;");
			}
			else
			{
				out.println(priceCurr);
			}
%>

			</Td>
			<Td width="16%" align="right">
<%			if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
			{
				out.println("&nbsp;");
			}
			else
			{
				out.println(valueCurr);
			}
%>		 	</Td>
	</Tr>
<%	}
%>
</Table>
</Div>	
<Div id="showTot" style="visibility:hidden">
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
	<Tr>
		<Td  width=68% class=blankcell>&nbsp;</Td>
		<Td  width=32% class=blankcell>
			<Table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
			<Tr>
				<Th width="50%" align=center><%=tot_L%></Th>
				<Td width="50%" align=right>&nbsp;<b><%=myFormat.getCurrencyString(grandTotal.doubleValue())%></b></Td>
			</Tr>
			</Table>
		</Td>			
	</Tr>
	</Table>
</Div>


<div id="remDiv" style="overflow:auto;visibility:hidden;position:absolute;left:2%;top:16%;height:70%;width:98%">
<Table align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="60%">
<Tr>
	<th>Remarks</th>
</Tr>
<Tr>
	<Td>
		<textarea cols="90" rows="10" style="overflow:auto;border:0" name="generalNotes1" class=txarea></textarea>
	</Td>
</Tr>
</Table>
</Div>




<Div id="buttonDiv"  style="visibility:visible;position:absolute;top:86%;width:100%">
<Table align="center" width="70%">
<Tr>
	<Td align="center" class="blankcell"><font color="blue"><%=taxDtyAppli_L%></font></Td>
</Tr>
<Tr>
	<Td class="blankcell" align="center"><nobr>
	<span id="EzButtonsSpan">
<%	if(cartcount > 0)
	{
	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");
		buttonName.add("Save");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit to SAP");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");	
		buttonName.add("Remarks");
		buttonMethod.add("showTab(\"2\")");	
		out.println(getButtonStr(buttonName,buttonMethod));
	}
	else
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");
		out.println(getButtonStr(buttonName,buttonMethod));	
	}
%>		
	</span>	
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
	<Tr>
		<Td class="labelcell">Your request is being processed. Please wait</Td>
	</Tr>
	</Table>
	</span>
</nobr>
</Td>
</Tr>
</Table>
</Div>


<Div id="remButDiv" align="center" style="visibility:hidden;position:absolute;top:86%;width:100%">
<Table align=center>

<Tr>
	<Td  class="blankcell" align="center">
	<span id="EzButtonsRemarksSpan">
<%	if(cartcount > 0)
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("showTab(\"1\")");
		buttonName.add("Save");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit to SAP");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");	
		out.println(getButtonStr(buttonName,buttonMethod));
	}
	else
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");		
		out.println(getButtonStr(buttonName,buttonMethod));	
	}
%>	</span>
	<span id="EzButtonsRemarksMsgSpan" style="display:none">
	<Table align=center>
	<Tr>
		<Td class="labelcell">Your request is being processed. Please wait</Td>
	</Tr>
	</Table>
	</span>
	</Td>
</Tr>
</Table>
</div>
<%
 	if("CREDIT_CHECK".equals(Message))
 	{
 %> 		<script>alert(<%=creditChk%>);</script>
 <% 	}
 %>

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>


	

<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: smaddipati
		Team:   EzcSuite
		Date:   30/09/2005
*****************************************************************************************--%>
<%@ page import = "ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezbasicutil.*"%>
<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.util.*"%> 
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>

<%@ include file="../../../Includes/Jsps/Rfq/iConfirmPOCreateFromRFQ.jsp"%>
<%@ include file="../../../Includes/Jsps/Rfq/iSelectIds.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>

<Html>
<Head>
<Title>Contract Creation From RFQ -- Powered By Answerthink.</Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>

<Script src="../../Library/JavaScript/Rfq/ezViewRFQDetails.js"></Script>
<Script>
	function createPO()
	{
	
		
		var arr = new Array();
		var len = '<%=rfqVendors.size()%>';
	
		if(len>1)
		{
			for(var i=0;i<len;i++)
			{
				var myVendor=document.myForm.vendor[i].value;
				if(document.myForm.docType[i].selectedIndex==0)
				{
					alert("Please Select Document Type For Vendor "+myVendor)
					document.myForm.docType[i].focus()
					return;
				}
				
				var cntrDate = eval("document.myForm.contractEndDate"+i);
				if(cntrDate.value=="")
				{
					alert("Please select End Date from calendar For Vendor "+myVendor)
					cntrDate.focus()
					return;
				}
				else
				{
					sDate = cntrDate.value;
					selDate = sDate.split(".");
					var sd = new Date();
					var td = new Date();
					var a1 = parseInt(selDate[1],10)-1;
	
					sd = new Date(selDate[2],a1,selDate[0]);
					var dd=td.getDate();
					var mm=td.getMonth();
					var yy=td.getYear();
	
					td  = new Date(yy,mm,dd);
	
					if(sd<td)
					{
						alert("End Date should be greater than or equals to today's date For Vendor "+myVendor)
						cntrDate.focus();
						return;
					}	
				}
				
				
				var cntrEndDate = eval("document.myForm.contractEndDate"+i);
				var cntrStrtDate = eval("document.myForm.contractStartDate"+i);
				
				var selEndDate = cntrEndDate.value;
				var selStrtDate = cntrStrtDate.value;
	
				var endDate = selEndDate.split(".");
				var strtDate = selStrtDate.split(".");
				var edDate = new Date();
				var srDate = new Date();
	
				var a1 = parseInt(endDate[1],10)-1;
				var b1 = parseInt(strtDate[1],10)-1;
	
				edDate = new Date(endDate[2],a1,endDate[0]);
				srDate = new Date(strtDate[2],b1,strtDate[0]);
	
	
				if(srDate >= edDate)
				{
					alert("Contract End Date should be greater than Contract Start Date For Vendor "+myVendor)
					cntrEndDate.focus();
					return;
				}
			
			}
		}
		else
		{
			
			if(document.myForm.docType.selectedIndex==0)
			{
				alert("Please Select Document Type")
				document.myForm.docType.focus()
				return;
			}
			
			if(document.myForm.contractEndDate0.value=="")
			{
				alert("Please select End Date from calendar")
				document.myForm.contractEndDate0.focus()
				return;
			}
			else
			{
				sDate = document.myForm.contractEndDate0.value;
				selDate = sDate.split(".");
				var sd = new Date();
				var td = new Date();
				var a1 = parseInt(selDate[1],10)-1;
	
				sd = new Date(selDate[2],a1,selDate[0]);
				var dd=td.getDate();
				var mm=td.getMonth();
				var yy=td.getYear();
	
				td  = new Date(yy,mm,dd);
	
				if(sd<td)
				{
					alert("End Date should be greater than or equals to today's date");
					document.myForm.contractEndDate0.focus();
					return;
				}
			}
			
			var selEndDate = document.myForm.contractEndDate0.value;
			var selStrtDate = document.myForm.contractStartDate0.value;
			
			var endDate = selEndDate.split(".");
			var strtDate = selStrtDate.split(".");
			var edDate = new Date();
			var srDate = new Date();
			
			var a1 = parseInt(endDate[1],10)-1;
			var b1 = parseInt(strtDate[1],10)-1;
			
			edDate = new Date(endDate[2],a1,endDate[0]);
			srDate = new Date(strtDate[2],b1,strtDate[0]);
			
			
			if(srDate >= edDate)
			{
				alert("Contract End Date should be greater than  Contract Start Date");
				document.myForm.contractEndDate0.focus();
				return;
			}
		
		}
		
		//Added By Boddu Jagan
		
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
			buttonsSpan.style.display	= "none"
			buttonsMsgSpan.style.display	= "block"
		}

			
		document.myForm.target = "_self";
		document.myForm.action="ezCreateRbxContractFromRFQ.jsp";
		document.myForm.submit();
	}
  
 
	function headerText(indx,flg)
	{
		var headText;
		var index;
		if(isNaN(document.myForm.headerText.length)){
		      if("H"==flg)
			headText=document.myForm.headerText.value;
		      else
			headText=document.myForm.shipmentText.value;


				}else{
		      if("H"==flg)
			headText=document.myForm.headerText[indx].value;
		      else
			headText=document.myForm.shipmentText[indx].value;




		}

		document.myForm.target = "PopUp";
		document.myForm.action= "../Rfq/ezGetHeaderText.jsp?headText="+headText+"&rowIndex="+indx+"&flag="+flg;
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();

	}
	
	
	function itemText(hdrIndx,itemIndx)
	{
		var itemText;
    		var index;
		
		if(isNaN(eval("document.myForm.itemText"+hdrIndx).length))
		{
			itemText=eval("document.myForm.itemText"+hdrIndx).value;
   		}else{
			itemText=eval("document.myForm.itemText"+hdrIndx)[itemIndx].value;
    		}

		document.myForm.target = "PopUp";
		document.myForm.action= "../Rfq/ezGetItemTextRFQPO.jsp?itemText="+itemText+"&hdrIndx="+hdrIndx+"&itemIndx="+itemIndx;
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
	}
	
	
	
	
	function checkQty(qtyObj,index,pendingQty)
	{
		var quantity = qtyObj.value;
		
		if(quantity != "")
		{
			if(isNaN(quantity))
			{
				
				alert("Please enter valid quantity");
				qtyObj.focus();
				return;
					
			}
			else if(parseFloat(quantity)<=0)
			{
				alert("Quantity should be greater than zero");
				qtyObj.focus();
				return;
			}else{
        
				
				
				if(parseFloat(quantity) > parseFloat(pendingQty))
				{
					alert("Contract quantity should be less than or equals to pending quantity : "+pendingQty);
					qtyObj.focus();
					return;
				}
				
				var docTypeObj=document.myForm.docType;
				var docType="";
				var len="<%=rfqVendors.size()%>";
        
				if(len==1){
					docType=docTypeObj.value;			
        
				}else {
						docType=docTypeObj[index].value;
				}
				
        			var poQtyObj=eval("document.myForm.poQty"+index);
				var poPriceObj=eval("document.myForm.price"+index);
				var targetValueObj=eval("document.myForm.targetValue"+index);
				var noOfLines=poQtyObj.length;
				
				if(isNaN(noOfLines)){
        			if(docType =='MK'){
						targetValueObj.value=poQtyObj.value;	
					}else if(docType =='WK'){
						targetValueObj.value=(poQtyObj.value*poPriceObj.value);	
					}else{
						targetValueObj.value="0.0";	
					}


				}else{
					for(i=0;i<noOfLines;i++)
					{
						if(docType =='MK'){

							targetValueObj[i].value=poQtyObj[i].value;	
						}else if(docType =='WK'){

							targetValueObj[i].value=(poQtyObj[i].value*poPriceObj[i].value);	
						}else{
							targetValueObj[i].value="0.0";	
						}
					}	

				}
				
			}
		
		}
		
	}
	
	
	
	function showTrgtValue(docTypeObj,indx)
	{
		
		var docType=docTypeObj.value;
		if(docType==""){
			alert("Please select valid document type");
			return;
		}
		
		var poQtyObj=eval("document.myForm.poQty"+indx);
		var poPriceObj=eval("document.myForm.price"+indx);
		var targetValueObj=eval("document.myForm.targetValue"+indx);
		
		var noOfLines=poQtyObj.length;
		
		if(isNaN(noOfLines)){
			if(docType =='MK'){
				targetValueObj.value=poQtyObj.value;	
			}else if(docType =='WK'){
				targetValueObj.value=(poQtyObj.value*poPriceObj.value);	
			}else{
				targetValueObj.value="0.0";	
			}
		
					
		}else{
			for(i=0;i<noOfLines;i++)
			{
				if(docType =='MK'){
				
					targetValueObj[i].value=poQtyObj[i].value;	
				}else if(docType =='WK'){

					targetValueObj[i].value=(poQtyObj[i].value*poPriceObj[i].value);	
				}else{
					targetValueObj[i].value="0.0";	
				}
			}	

		}
		
	}
	
		
</Script>
</Head>
<Body scroll="yes">
<%
  int docT = 0;
	if(rfqVendors.size()==0){
	
%>
		<br><br><br><br><br>
		<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<Tr align="center">
				<Th height="21">No Materials Approved to Create Purchase Order</Th>
			</Tr>
		</Table>

<Div id="back"  align="center" style="position:absolute;width:100%;top:90%;visibility:visible">		
<%
            butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
            butActions.add("history.go(-1)");
            out.println(getButtons(butNames,butActions));
%>
</Div>
<%
	
			return;
	}
%>
<form name="myForm" method="post">

<%
	
	String display_header = "Create Contract";
%>	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>
<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	java.util.Date today = new java.util.Date();
	
	ResourceBundle TaxC = ResourceBundle.getBundle("EzTaxCodes");
	java.util.TreeMap taxTM = new java.util.TreeMap();
	Enumeration taxEnu =TaxC.getKeys();
	while(taxEnu.hasMoreElements())
	{
		String s2=(String)taxEnu.nextElement();
		taxTM.put(s2,TaxC.getString(s2));
	}
	Iterator taxIterator = null;
 	Object taxObj = new Object();
  
	for(int i=0;i<rfqVendors.size();i++)
	{
		ReturnObjFromRetrieve newRetTemp=(ReturnObjFromRetrieve)venInfo.get((String)rfqVendors.get(i));
		String pnmtTerms=newRetTemp.getFieldValueString(0,"PAYMENT_TERMS");
		
		java.util.ResourceBundle PayT	= java.util.ResourceBundle.getBundle("EzPurPayTerms");
				
		try{
			if(pnmtTerms!=null && !"null".equals(pnmtTerms))
			pnmtTerms=PayT.getString(pnmtTerms.trim());
					
		}catch(Exception err){}
		
		
		if(pnmtTerms==null||"null".equals(pnmtTerms)||"".equals(pnmtTerms.trim()))
		pnmtTerms="N/A";
			
		
%>
		 <Fieldset style="border-width:3px;border-color:#000000;border-style:double;" >
		<Legend><b>Vendor: <%=(String)rfqVendors.get(i)%><input type="hidden" name="vendor" value="<%=(String)rfqVendors.get(i)%>"></b></Legend>
			<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width='98%'>
				<Tr>
					<Th width="20%">Document Type*</Th>
					<Th width="15%">Start Date*</Th>
					<Th width="15%">End Date*</Th>
					<Th width="20%">Payment Terms</Th>
					<Th width="17%">Header Text</Th>
          				<Th width="18%">Shipping Instructions</Th>
				</Tr>
				<Tr>
					<Td width="20%">
					
					
					<select name="docType" style="width:100%" id="CalendarDiv" onChange="showTrgtValue(this,'<%=i%>')">
						<option value="">-Select Document Type-</option>
						<Option value='WK'>WK - ValueContract</Option>
						<Option value='MK'>MK - QuantityContract</Option>
					</select>
					
					
					</Td>
					<Td width="15%" align="center">
						<input type="text" name="contractStartDate<%=i%>" class="InputBox" size=15 value="<%=fd.getStringFromDate(today,".",ezc.ezutil.FormatDate.DDMMYYYY)%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractStartDate<%=i%>",205,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >
					</Td>
					<Td width="15%" align="center">
						<input type="text" name="contractEndDate<%=i%>" class="InputBox" size=15 value="" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.contractEndDate<%=i%>",205,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") >
					</Td>
					<Td width="20%" align="center">
						<%=pnmtTerms%>
					</Td>
					<Td width="17%" align="center">
						  <input type="hidden" name="headerText" value=""><a href="javascript:onClick=headerText('<%=i%>','H')">
						  <img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>
					</Td>
					<Td width="18%" align="center">
						  <input type="hidden" name="shipmentText" value=""><a href="javascript:onClick=headerText('<%=i%>','S')">
						  <img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a>
						  </Td>
					</Tr>
			</Table>
			<br>
			<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width='98%'>
				<Tr>
					
					<Th width="10%">RFQ No</Th>
					<Th width="4%">Item</Th>
					<Th width="24%">Material</Th>
					<Th width="10%">Del.Date</Th>
					<Th width="8%">RFQ Qty</Th>
					<Th width="8%">Con.Qty</Th>
					<Th width="4%">UOM</Th>
					<Th width="6%">Price</Th>
					<Th width="4%">Curr</Th>
					<Th width="6%">Plant</Th>
					<Th width="12%">Target Value/Qty</Th>
					<Th width="4%">Text</Th>
				</Tr>
<%
				int rCount=0;
				
				
				
				for(int j=0;j<newRetTemp.getRowCount();j++)
				{
				
					String rfqNo=newRetTemp.getFieldValueString(j,"RFQ_NO");
         				String collRFQNo=newRetTemp.getFieldValueString(j,"COLLECTIVE_RFQ_NO");
					String rfqLine=newRetTemp.getFieldValueString(j,"LINE_NO");
					String delDate=fd.getStringFromDate((Date)newRetTemp.getFieldValue(j,"DELIVERY_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY);
					String material=newRetTemp.getFieldValueString(j,"MATERIAL");
					String matDesc=newRetTemp.getFieldValueString(j,"MATERIAL_DESC");
					String qty=newRetTemp.getFieldValueString(j,"QUANTITY");
					String price=newRetTemp.getFieldValueString(j,"PRICE");
					String plant=newRetTemp.getFieldValueString(j,"PLANT");
					String uom=newRetTemp.getFieldValueString(j,"UOM");
					String valType=newRetTemp.getFieldValueString(j,"VAL_TYPE");
					String taxCode=newRetTemp.getFieldValueString(j,"TAX_CODE");
					String currency=newRetTemp.getFieldValueString(j,"CURRENCY");
					
					if(currency==null||"null".equals(currency) ||"".equals(currency.trim())) currency="&nbsp";
					
					double actualRFQQtyDou=0;
					double consumedQtyDou=0;
					double pendingQtyDou=0;
					String myKey="";
					String myKeyVal="";
					if(rfqNo!=null&&rfqLine!=null){
						myKey=rfqNo.trim()+rfqLine.trim();
						myKeyVal=(String)consumedRFQQtyHT.get(myKey);
						if(myKeyVal!=null){
							try{
								consumedQtyDou=Double.parseDouble(myKeyVal);
							}catch(Exception err){consumedQtyDou=0;}
						}

					}

					try{
					actualRFQQtyDou=Double.parseDouble(qty);
					}catch(Exception err){actualRFQQtyDou=0;}

								pendingQtyDou=actualRFQQtyDou-consumedQtyDou;
					if(pendingQtyDou<0)
					pendingQtyDou=0;
					
%>

					<Tr>
										
						<Td width="10%" align="center"><input type="hidden" name="rfqNo<%=i%>" value="<%=rfqNo%>"><%=rfqNo%></Td>
						<Td width="4%" align="center"><input type="hidden" name="rfqLine<%=i%>" value="<%=rfqLine%>"><%=rfqLine%></Td>
						<Td width="24%"><input type="hidden" name="matNo<%=i%>" value="<%=material%>"><%=matDesc%></Td>
						<Td width="10%" align="center"><input type="hidden" name="delDate<%=i%>" value="<%=delDate%>"><%=delDate%></Td>
						<Td width="8%" align="center"><input type="hidden" name="rfqQty<%=i%>" value="<%=qty%>"><%=qty%></Td>
						<Td width="8%" align="center">
						<input type="hidden" name="collRFQNo<%=i%>" size="8" value="<%=collRFQNo%>">
						<input type="hidden" name="pendQty<%=i%>" size="8" value="<%=pendingQtyDou%>" >
						<input type="text" name="poQty<%=i%>" class="InputBox" size="8" value="<%=pendingQtyDou%>" onBlur="checkQty(this,'<%=i%>','<%=pendingQtyDou%>')">
						</Td>
						<Td width="4%" align="center"><%=uom%></Td>
						<Td width="6%" align="center"><input type="hidden" name="price<%=i%>" size="8" value="<%=price%>"><%=price%></Td>
						<Td width="4%" align="center"><%=currency%></Td>
						
						<Td width="6%" align="center">
<%
            
             					if(plant==null||"null".equals(plant)||"".equals(plant)||"-".equals(plant)){
%>
            					<select name="plant<%=i%>" style="width:100%" > 
            						<option value="">-Select-</option>
<%	  						
							for(int p=0;p<count;p++)
							{
%>	
								<option value="<%=ret.getFieldValueString(p,"CODE")%>"><%=ret.getFieldValueString(p,"CODE")%></option>
<%	   						
							}
%>  
            					</select>
<%
             					}else{
%>
                					<input type="hidden" name="plant<%=i%>" value="<%=plant%>"><%=plant%>                   
<%             
             					}
%>
              
            					</Td>
            					<Td width="12%">
            						<input type="text" name="targetValue<%=i%>" class="tx" size=15   value="0.0" readonly> 
            					</Td>
						<Td width="4%" align="center"><input type="hidden" name="itemText<%=i%>" value=""><a href="javascript:onClick=itemText('<%=i%>','<%=j%>')"><img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand"></a></Td>
					</Tr>
<%
					
				}
%>
			</Table>
			<br>
		</Fieldset>
		
<%
	}
%>
	<br>
	<Div id="buttonDiv" align=center style="position:absolute;visibility:visible;width:100%">
		<span id="EzButtonsSpan" >									
<%
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
          butNames.add("&nbsp;&nbsp;&nbsp;Create Contract&nbsp;&nbsp;&nbsp;");   
      	  butActions.add("history.go(-1)");
          butActions.add("createPO()");
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
	</Div>	
<%
	for(int c=0;c<collRFQCount;c++)
	{
	    String qcfStat=(String)openQCFHT.get(collectiveRFQNo[c]);
	    if(qcfStat==null||"null".equals(qcfStat)||"".equals(qcfStat))
	    qcfStat="Y";
	    else
	    qcfStat="N";
%>
		<input type="hidden" name="collRFQNo" value="<%=collectiveRFQNo[c]%>">
		<input type="hidden" name="collRFQStat" value="<%=qcfStat%>">
<%
	}
%>
	<input type =hidden value="<%=qcfCloseFlg%>" name="qcfCloseFlg">
	<input type =hidden value="" name="attachFlag">
	<input type =hidden value="" name="attachDocs">	
</Form>
</Body>
</Html>
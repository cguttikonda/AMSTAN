<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezbasicutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%
	Double grandTotal =new Double("0");
	ReturnObjFromRetrieve itemoutTable=(ReturnObjFromRetrieve)session.getValue("ITEMSOUT");
	int cartcount=itemoutTable.getRowCount();
	String from = request.getParameter("from");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();

        ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	
	String backFlag 	= request.getParameter("backFlag");
	String pageUrl 		= request.getParameter("pageUrl");
	String requiredDate 	= request.getParameter("requiredDate");
	String generalNotes 	= request.getParameter("generalNotes");
	String Agent		= request.getParameter("agent");
	String SoldTo		= request.getParameter("soldTo");
	String ShipTo		= request.getParameter("shipTo");
	String PONO 		= request.getParameter("poNo");
	String PODate 		= request.getParameter("poDate");
	String OrderDate 	= request.getParameter("orderDate");
	String Currency 	= request.getParameter("currency");
	String UserRole		= (String)session.getValue("UserRole");
	UserRole.trim();
	String agentName	= request.getParameter("soldToName");
	String ShipToName	= request.getParameter("shipToName");
	String formatkey	= (String)session.getValue("formatKey");
	String pGroupNumber 	= request.getParameter("ProductGroup");
	
	String shippingType 	= request.getParameter("shippingType");
	String shippingTypeDesc = request.getParameter("shippingTypeDesc1"); 
	String shippingTypeVal  = request.getParameter("shippingTypeVal");
	
	String carrierName = request.getParameter("carrierName"); 
	carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;

	if(session.getAttribute("pono_porder")!=null && !"null".equals(session.getAttribute("pono_porder")))
		session.removeAttribute("pono_porder");
		
	if(session.getAttribute("reqdate_porder")!=null && !"null".equals(session.getAttribute("reqdate_porder")))
		session.removeAttribute("reqdate_porder");
	if(session.getAttribute("carname_porder")!=null && !"null".equals(session.getAttribute("carname_porder")))
		session.removeAttribute("carname_porder");
	
	session.setAttribute("pono_porder",PONO);	
	session.setAttribute("reqdate_porder",requiredDate);	
	session.setAttribute("carname_porder",carrierName);
	
	int rowId = -1;
	if(listShipTos_ent!=null && listShipTos_ent.getRowCount()>0)
	{
		rowId = listShipTos_ent.getRowId("EC_PARTNER_NO",ShipTo);

	}
	
	String shipAddr1  = listShipTos_ent.getFieldValueString(rowId,"ECA_ADDR_1");
	String shipAddr2  = listShipTos_ent.getFieldValueString(rowId,"ECA_CITY");
	String shipState  = listShipTos_ent.getFieldValueString(rowId,"ECA_STATE");
	String shipZip    = listShipTos_ent.getFieldValueString(rowId,"ECA_PIN");
	
	shipAddr1 =(shipAddr1==null || "null".equals(shipAddr1))?"":shipAddr1;
	shipAddr2 =(shipAddr2==null || "null".equals(shipAddr2))?"":shipAddr2;
	shipState =(shipState==null || "null".equals(shipState))?"":shipState;
	shipZip =(shipZip==null || "null".equals(shipZip))?"":shipZip;
	
	log4j.log("pono_porderpono_porder:confirm:"+(String)session.getAttribute("pono_porder"),"W");
	log4j.log("pono_porderpono_porder:confirm:"+(String)session.getAttribute("reqdate_porder"),"W");
	log4j.log("pono_porderpono_porder:confirm:"+(String)session.getAttribute("carname_porder"),"W");
	
	
	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<!--<Script src="../../Library/JavaScript/ezCalValue.js"></Script>-->
<Script>
	var tabHeadWidth=95
 	var tabHeight="40%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

<Script>
/********
 	these variables are used in ezVerifyField.js changes will effect ezAddSalesSh.jsp
*********/
	var cannotbelessthan0	="<%=notLessthanZero_A%>"
	var entervalid		="<%=plzEnterValid_A%>"
	var inNumbers 		="<%=inNum_A%>"
</Script>
<Script src="../../Library/JavaScript/ezVerifyField.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<!---<Script src="../../Library/JavaScript/ezSelSelect.js"></Script>-->
<Script src="../../Library/JavaScript/ezChkATP.js"></Script>
<Script src="../../Library/JavaScript/ezConfirmOrder.js"></Script>
<Script src="../../Library/JavaScript/ezChkATP.js"></Script>

<Script>
	var today ="<%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY)%>" 
	var notesCount = new Array();
	function showMsg()
	{
		if(document.all)
		{
			retVal=showModalDialog('ezDea.jsp'," ",'center:yes;dialogWidth:25;dialogHeight:8;status:no;minimize:yes');
			if(retVal=='Y') 
				showSign()
		}
	}
	var retSign='N'
	function showSign()
	{
		if(document.all)
		{
			retSign=showModalDialog('ezSignature.jsp'," ",'center:yes;dialogWidth:35;dialogHeight:15;status:no;minimize:yes');
		}
	}
	function formSubmit(obj,obj2)  
	{
		document.generalForm.status.value=obj2;
		var deaValue ='<%=(String)session.getValue("DEANUMBER")%>'	
		var deaFlag  =true
		if(deaValue==null || deaValue=="" || deaValue==" ") 
		{
			deaFlag=false
			retSign='Y'	
		}	
		var flag;
		if(deaFlag)
		{
			flag=true
			var countDea=0
			var prdlen=document.generalForm.product.length
			if(!(isNaN(prdlen)))	
			{
				for(var t=0;t<document.generalForm.product.length;++t)
				{	
					if((funTrim(document.generalForm.product[t].value)=='PH-555555') || (funTrim(document.generalForm.product[t].value)=='PH-6501'))
					countDea++;
				}	
			}
			else		
			{
				if((funTrim(document.generalForm.product.value)=='PH-555555') || (funTrim(document.generalForm.product.value)=='PH-6501'))
					countDea++;				
			}
 			if(countDea>0)
			{
				flag=true
				//showMsg()
			}
		}
	
		if(retSign=='Y'||flag)
		{
			buttonsSpan=document.getElementById("EzButtonsSpan")
			buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
			buttonsSpanRem=document.getElementById("EzButtonsRemarksSpan")
			buttonsMsgSpanRem=document.getElementById("EzButtonsRemarksMsgSpan")
			if(buttonsSpan!=null)
			{
				buttonsSpan.style.display="none"
				buttonsSpanRem.style.display="none"
				buttonsMsgSpan.style.display="block"
				buttonsMsgSpanRem.style.display="block"
			}
			var y="true"
			//y=chkdate()

			if(eval(y))
			{	
				if(obj != "ezGetPricesSh.jsp" )
				{
				
					var z=document.generalForm.status.value
					if(z=="NEW")
					{
						 y=confirm("Do you want to Save into Local")
					}
					else if(z=="SUBMITTED")
					{
						 y=confirm("<%=subEnterApproval_A%>")
					}
					else if(z=="TRANSFERED")
					{
						 y=confirm("Do you want to Submit the Order to SAP")
					}
				}
			}
			if(eval(y))
			{			
				document.body.style.cursor="wait";
				document.generalForm.target="_self";
				document.generalForm.action=obj;
				document.generalForm.submit();
			}
			else
			{
				if(buttonsSpan!=null)
				{
				    buttonsSpan.style.display="block"
				    buttonsSpanRem.style.display="block"
				    buttonsMsgSpan.style.display="none"
				    buttonsMsgSpanRem.style.display="none"
				}
			}
		}
	}

	function chkdate()
	{
		for(i=0;i<total;i++)
		{
		        l=document.generalForm.desiredDate.length
		        if(l>1)
	        	{
	        		x=eval("document.generalForm.desiredDate["+i+"].value");
	       			if(funTrim(x) == "")
				{
					document.getElementById("desiredDate["+i+"]").className="labelcell"
				}
				else
				{
					document.getElementById("desiredDate["+i+"]").className=""
				}
			}
			else
			{
				x=eval("document.generalForm.desiredDate.value");
				if( funTrim(x) == "")
				{
					document.getElementById("desiredDate").className="labelcell"
				}else
				{
					document.getElementById("desiredDate").className=""
				}
			}
		}
		for(i=0;i<total;i++)
		{
		        if(l>1)
		        {
				if( funTrim(eval("document.generalForm.desiredDate["+i+"].value")) == "")
				{
					alert("<%=entDeliDts_A%>\n"+eval("document.generalForm.prodDesc["+i+"].value"));
					return false;
				}
			}else{
				if( funTrim(eval("document.generalForm.desiredDate.value")) == "")
				{
					alert("<%=entDeliDts_A%>\n"+eval("document.generalForm.prodDesc.value"));
					return false;
				}
			}
		}
		return true
	}
	
	function chk()
	{
		for(b=0;b<MValues.length;b++)
		{
			res= chkQty(MValues[b]);
			if(!res)
			{
				return false;
			}
		}
		for(b=0;b<MValues.length;b++)
		{
			y= chkQtyone(MValues[b]);
			if(eval(y))
			{
				alert("<%=plzEntQty_A%>");
				return false;
			}
		}
		for(c=0;c<MDate.length;c++)
		{
			if(total==1)
			{
		                if(funTrim(eval("document.generalForm.desiredQty.value")) != "")
		                {
					if( funTrim(eval("document.generalForm."+MDate[c]+".value")) == "")
					{
						alert("<%=plzEntReqDate_A%>");
						return false;
					}
					else
					{
						a=(funTrim(eval("document.generalForm."+MDate[c]+".value"))).split("<%=formatkey%>");
						b=(today).split("<%=formatkey%>");
						d1=new Date(a[2],(a[0]-1),a[1])
						d2=new Date(b[2],(b[0]-1),b[1])
						if(d1<d2)
						{
							alert("<%=compareReqDates_A%>");
							document.generalForm.desiredQty.focus();
							return false;
						}
					}
		     		}	
			}
			else if(total>1)
			{
				for(i=0;i<total;i++)
				{
				     	if(funTrim(eval("document.generalForm.desiredQty["+i+"].value")) != "")
				     	{
						if(funTrim(eval("document.generalForm."+MDate[c]+"["+i+"].value")) == "")
						{
							alert("<%=plzEntReqDate_A%>");
							return false;
						}
						else
						{
							a=(funTrim(eval("document.generalForm."+MDate[c]+"["+i+"].value"))).split("<%=formatkey%>");
							b=(today).split("<%=formatkey%>");
							d1=new Date(a[2],(a[0]-1),a[1])
							d2=new Date(b[2],(b[0]-1),b[1])
							if(d1<d2)
							{
								alert("<%=compareReqDates_A%>");
								eval("document.generalForm.desiredQty["+i+"].focus()")
							        return false;
							}
						}	
			      		}
		           	}
			}
		}
		return true;
	}
	function cartOrder()
	{
		document.generalForm.action="../Sales/ezAddSalesSh.jsp?bkpflg=<%=request.getParameter("bkpflg")%>"
		document.generalForm.submit();
	}
	function changeShipAdrs(status)
	{
		var addr1_js = document.generalForm.shipToAddress1.value;
		var city_js  = document.generalForm.shipToAddress2.value
		var state_js = document.generalForm.shipToState.value 	
		var pcode_js = document.generalForm.shipToZipcode.value 

		var arrangedValue = addr1_js+"¥"+city_js+"¥"+state_js+"¥"+pcode_js;


		respArray = new Array();
		var retVal = showModalDialog("ezChangeShipAddress.jsp?status="+status,arrangedValue,"center:yes;dialogWidth:40;dialogHeight:15;status:no;minimize:yes;help:no");
		if(retVal=='') return;
		else
		{
			respArray = retVal.split("¥");
			document.generalForm.shipToAddress1.value = respArray[0]
			document.generalForm.shipToAddress2.value = respArray[1]
			document.generalForm.shipToState.value = respArray[2]
			document.generalForm.shipToZipcode.value = respArray[3]
		}

	}
	function showATP(ind)
	{
			obj=document.generalForm;
		
			x =obj.prodDesc.length
			if(x>1)
			{
		        	schdate = obj.del_sch_date[ind]
				schqty = obj.del_sch_qty[ind]
			}else{
		
				schdate = obj.del_sch_date
				schqty = obj.del_sch_qty
			}
		
				prodCode = ""
				prodDesc =""
				reqDate =""
				reqQty =""
				uom=""
				plant=""
				custprodCode=""
		
				if (obj.product[ind]!=null)
				{
					prodCode = obj.product[ind].value
					prodDesc =obj.prodDesc[ind].value
					reqDate =schdate.value
			 		reqQty =schqty.value
			 		uom=obj.pack[ind].value
					plant=obj.plant[ind].value
		                        custprodCode =obj.custATPMat[ind].value
				}
				else
				{
					prodCode = obj.product.value
					prodDesc =obj.prodDesc.value
					reqDate =schdate.value
			 		reqQty =schqty.value
			 		uom=obj.pack.value
					plant=obj.plant.value
					custprodCode =obj.custATPMat.value
		
				}
		                   
			     if(custprodCode!=null && custprodCode!="")
			     {
			        alert("ATP not exist for this material")
			        return;
			     }
			     else
			     {
			        myurl ="ezGetATP.jsp?ProductCode="+prodCode+"&ProdDesc="+prodDesc+"&ReqDate="+reqDate+"&ReqQty="+reqQty+"&UOM="+uom+"&plant="+plant
			        //retVal=showModalDialog(myurl," ",'center:yes;dialogWidth:25;dialogHeight:14;status:no;minimize:yes')
			        retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=200,width=500,status=no,toolbar=no,menubar=no,location=no")
			     }
	}
	function ezBackMain()
	{
	
		document.body.style.cursor="wait"
		
		//alert('<%=backFlag%>')
		if("ADDDELETE"=='<%=backFlag%>')
		{
			//alert("111")
			document.generalForm.action="ezAddSalesOrder.jsp"
			document.generalForm.submit();
		}
		else
			top.history.back()
		
		
	}

	var MValues 	= new Array();
	var MDate 	= new Array();
	var UserRole 	= "<%=UserRole%>";
	var total 	= "<%=cartcount%>";
	
	MValues[0] 	= "desiredQty";
	MDate[0] 	= "desiredDate";
</Script>
</Head>
<body onLoad="scrollInit('SHOWTOT');" onresize="scrollInit('SHOWTOT')" scroll=no>
<form name="generalForm" method="post" onSubmit="return false">
<input type="hidden" name="obj123">
<input type="hidden" name="chkBrowser" value="0">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">
<input type="hidden" name="backFlag" value="<%=backFlag%>">

<%
	String display_header = COrderFor_L+" "+agentName;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type="hidden" name="agentName" value="<%=agentName%>">
<input type="hidden" name="shipToAddress1" 	value='<%=shipAddr1%>'>
<input type="hidden" name="shipToAddress2" 	value='<%=shipAddr2%>'>
<input type="hidden" name="shipToState" 	value='<%=shipState%>'>
<input type="hidden" name="shipToZipcode"    	value='<%=shipZip%>'>

<div id="div1" align="center" style="visibility:visible;width:100%">
<Table width='95%' valign='top'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
     <Tr>
     		<th class="labelcell" align="left"><%=pono_L%></th>
     		<td> <input type="hidden" name="poNo"  value="<%=PONO%>"><%=PONO%></td>
        	<th class="labelcell" align="left"><%=podate_L%></th>
        	<td><input type="hidden" name="poDate" value="<%=PODate%>"><%=PODate%></td>
        	<th class="labelcell" align="left">Req.Deliv.Date</th>
        	<td><input type="hidden" name="requiredDate" value="<%=requiredDate%>"><%=requiredDate%></td>
     </Tr>
     <Tr>
		<th class="labelcell" align="left"><%=soldto_L %> </th>
		<td>
			<input type="hidden" name="soldTo" value="<%=SoldTo%>">
			<input type="hidden" name="soldToName" value="<%=agentName%>">
			<%=agentName%>
		</Td>
		<Th class="labelcell" align="left"><%=shipto_L%></Th>
		<Td>
			<input type="hidden" name="shipTo" value="<%=ShipTo%>">
			<input type="hidden" name="shipToName" value="<%=ShipToName%>">
			
			<%=ShipToName%>
		</Td>
		<Th class="labelcell" align="left" >Shipping Type</Th>
		<Td nowrap>
			<%=shippingTypeDesc%>&nbsp;
		</Td>
			
			<input type="hidden" name="carrierName" value="<%=carrierName%>">
			<input type="hidden" name="docCurrency" value="<%= Currency %>">
			<input type="hidden" name="currency" value="<%= Currency %>">
			<input type="hidden" name="disCash"  value="0">
			<input type="hidden" name="disPercentage"  value="0">
			<input type="hidden" name="agent"     value="<%=Agent%>">
			<input type="hidden" name="orderDate"  value="<%=OrderDate%>">
			<input type="hidden" name="status">
			<input type="hidden" name="shippingType" value="<%=shippingType%>">
			<input type="hidden" name="shippingTypeDesc" value="<%=shippingTypeDesc%>">
			<input type="hidden" name="shippingTypeVal" value="<%=shippingTypeVal%>">
      </Tr>
</Table>
</div>

<Div id='theads'>
<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
	<th width="10%" valign="top" nowrap>Product</th>
        <th width="20%" valign="top" nowrap>Description</th>
        <th width="10%" valign="top" >Brand</th>
        <th width="10%" valign="top" >List Price</th>
	<th width="5%"  valign="top"><%=uom_L%></th>
	<th width="10%" valign="top"><%=qty_L%></th>
	<th width="10%" valign="top"><%=price_L%> [<%=Currency%>]</th>
	<Th width="10%" valign="top"><%=val_L%> [<%=Currency%>]</Th>
	<Th width="10%" valign="top"><%=delSchedue_L%></Th>
        <Th width="5%" valign="top">ATP</Th>
</Tr>
</Table>
</div>
<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:65%;left:2%'>
<Table width='100%' id='InnerBox1Tab'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
	//log4j.log("prices_prices_prices_prices_prices_:confirm:"+itemoutTable.toEzcString(),"W");
	String[] prodUnitQty = new String[cartcount];
	Hashtable selectdMet = (Hashtable)session.getAttribute("SELECTEDMET");
	
	
	log4j.log("selectdMet::::::::"+selectdMet,"W");
	itemoutTable.toEzcString();
	
	if(cartcount>0)
	{
		java.util.Hashtable itemQtys = (java.util.Hashtable)session.getValue("itemQtys");
		java.util.Hashtable itemCatalogs = (java.util.Hashtable)session.getValue("itemcatalog");
		
    		for(int i=0;i<cartcount;i++)
    		{
   			
   			if(selectdMet!=null)
   			{
      				//String metGroup=(String)selectdMet.get(itemoutTable.getFieldValueString(i,"Material"));
      				String metGroup=(String)selectdMet.get(itemoutTable.getFieldValueString(i,"MatEntrd"));
      				
      				String custMat =itemoutTable.getFieldValueString(i,"CustMat");
      				
      				if (custMat!=null && !"null".equals(custMat) && !"".equals(custMat.trim()))
      				metGroup = custMat;
      				
   				java.util.StringTokenizer   stoken=new java.util.StringTokenizer(metGroup,"¥");
   				metGroup=(String)stoken.nextElement();
				try{
   					prodUnitQty[i]=(String)stoken.nextElement();
				}catch(Exception e){ 
					prodUnitQty[i]="0";
				}
        		}
			String prodCode     = itemoutTable.getFieldValueString(i,"Material");
			String custprodCode = itemoutTable.getFieldValueString(i,"CustMat");
			String prodDesc     = itemoutTable.getFieldValueString(i,"ShortText");
			String prodUom      = itemoutTable.getFieldValueString(i,"SalesUnit");
			String prodQty      = itemoutTable.getFieldValueString(i,"ReqQty");
			String ItemCat      = itemoutTable.getFieldValueString(i,"ItemCat");
			String subTot       = itemoutTable.getFieldValueString(i,"NetValue1");
			String plant 	    = itemoutTable.getFieldValueString(i,"Plant");
			String itemVenCatalog ="";
			String tempItemStr="";
			String itemBrand="";
			String itemListPrice="";
			
			java.util.StringTokenizer itemSt = null;
			boolean custMatFlg =false;
			
			if(custprodCode!=null && !"null".equals(custprodCode) && !"".equals(custprodCode.trim()))
			{
			    tempItemStr = (String)itemCatalogs.get(custprodCode);
			    itemSt=new java.util.StringTokenizer(tempItemStr,"¥");
			    custMatFlg =true;
			}
			else
			{
			    tempItemStr = (String)itemCatalogs.get(prodCode);
			    itemSt=new java.util.StringTokenizer(tempItemStr,"¥");
			}
			
			while(itemSt.hasMoreTokens())
			{
			    try
			    {
			    	itemVenCatalog	 = itemSt.nextToken();
			   	itemBrand	 = itemSt.nextToken();	
			    	itemListPrice    = itemSt.nextToken();
			    	
			    	if(custMatFlg){
			    		subTot = String.valueOf(Double.parseDouble( prodQty ) * Double.parseDouble( itemListPrice ));
			    	}
			    }
			    catch(Exception e){ }
						
			}
			
			System.out.println("prodCodeprodCode>>>>"+prodCode);
			System.out.println("custprodCodecustprodCode>>>>"+custprodCode);
			System.out.println("itemVenCatalogitemVenCatalog>>>>"+itemVenCatalog);
			System.out.println("itemCatalogsitemCatalogs>>>>"+itemCatalogs);
			
			String tqty = prodQty;
	
			prodQty=( (prodQty == null) || ("null").equals(prodQty)) ?"0":prodQty;
			subTot=( (subTot == null) || ("null").equals(subTot)) ?"0":subTot;
			double obj = Double.parseDouble(subTot)/Double.parseDouble( prodQty );

			String prodDate = "";
			String pric = String.valueOf(obj);
			
			pric=(pric==null||"null".equals(pric)||pric.trim().length()==0 || "NAN".equals(pric))?"0":pric;
			prodDesc=prodDesc.replace('\'',' ');
			prodDesc=prodDesc.replace('\"',' ');
			
			String prodUQ=prodUnitQty[i].trim();
			prodDate=(prodDate == null)?"":prodDate;
			String commitedQty="";
			
			if(custprodCode!=null && !"null".equals(custprodCode) && !"".equals(custprodCode.trim()))
			{
			   commitedQty=(String)itemQtys.get(custprodCode);
			}
			else
			{
			   commitedQty=(String)itemQtys.get(prodCode);
			}
			
        		String a = "";
        		
        		
        		try{
        			a=Integer.parseInt(prodCode)+"-->"+prodDesc;
        		}catch(Exception e)
        		{
        			a=prodCode +"--->"+prodDesc;
        		}
        		try
        		{
        		   	tqty=tqty.substring(0,tqty.indexOf('.'));
           		}
           		catch(Exception e){}
%>
		<Tr>
<%
			java.math.BigDecimal bUprice = new java.math.BigDecimal( pric );
			java.math.BigDecimal bPrice = null;
			java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());
		
			bPrice = bQty.multiply(bUprice);
			grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
			String priceCurr = myFormat.getCurrencyString(bUprice.doubleValue());
			String valueCurr = myFormat.getCurrencyString(bPrice.doubleValue());
			boolean prflg = false;
			java.math.BigDecimal bUpricetemp = null;
			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_UP).doubleValue()==0 || "0.00".equals(priceCurr.trim()) )
			{
				bUpricetemp = new java.math.BigDecimal(Double.parseDouble(subTot)/Double.parseDouble(prodQty));
				prflg = true;
				priceCurr = bUpricetemp.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)+"";
				   			
			}
			
			String tPNo= "";
			
			if (custprodCode!=null && !"null".equals(custprodCode) && !"".equals(custprodCode.trim()))
			{
				try
				{
					tPNo = Integer.parseInt(custprodCode)+"";
				}
				catch(Exception e)
				{ 
					tPNo = custprodCode;
				}
			}
			else
			{
				try
				{
					tPNo = Integer.parseInt(prodCode)+"";
				}
				catch(Exception e)
				{ 
					tPNo = prodCode;
				}
		        }
			
%>
			<Td width="10%" align="left" title="<%=a%>"><%=tPNo%></Td>
			<Td width="20%" align="left" title="<%=a%>">
				&nbsp;<input type="text" name="prodDesc" size="25" class="tx" readonly value="<%=prodDesc%>">
				<input type="hidden" name="lineValue" value="<%= bPrice %>">
				<input type="hidden" name="product" value="<%= prodCode%>">
				<input type="hidden" name="prodCode" value="<%= tPNo%>">
				<input type="hidden" name="oldprodCode" value="<%= prodCode%>">
				<input type="hidden" name="custprodCode" value="<%= tPNo%>">
				<input type="hidden" name="custATPMat" value="<%= custprodCode%>">
				<input type="hidden" name="itemVenCatalog" value="<%=itemVenCatalog%>">
				<input type="hidden" name="vendCatalog" value="<%=itemVenCatalog%>">
				
				<%if(prflg){%>
					<input type="hidden" name="desiredPrice"  value="<%=bUpricetemp.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)%>">
				<%}else{%>
					<input type="hidden" name="desiredPrice"  value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
				<%}%>
				<input type="hidden" name="desiredQty" value="<%=prodQty%>">
				<input type="hidden" name="prodQty" value="<%=prodQty %>">
				<input type="hidden" name="commitedQty" value="<%=commitedQty%>">
				<input type="hidden" name="desiredDate" value="<%=requiredDate%>">
				<input type="hidden" name="pack" value="<%=prodUom%>">
				<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
				<input type="hidden" name="UomQty" value="<%=prodUnitQty[i]%>">
				<input type="hidden" name="plant" value="<%=plant%>">
			</Td>
			<Td width="10%" align="center">&nbsp;<%=itemBrand%></Td>
			<Td width="10%" align="center">&nbsp;<%="$"+itemListPrice%></Td>
			
			<Td width="5%" align="center">&nbsp;<%=prodUom%></Td>
			<Td width="10%" align="right"><input type="hidden" name="del_sch_qty" value="<%=commitedQty%>"><%=tqty%>
				<input type="hidden"  name="focVal" >
			</Td>
			<Td width="10%" align="right">
<% 			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_UP).doubleValue()==0 || "0.00".equals(priceCurr.trim()) )
	   		{
	   			
	   			out.println("&nbsp;"+bUpricetemp.setScale(4,java.math.BigDecimal.ROUND_HALF_UP));
	   			
			}
			else
			{
				out.println(priceCurr);
	   		}
%>			</Td>
			<Td width="10%" align="right">
<% 			if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
			{
				out.println("&nbsp;");
			}
			else
			{
				out.println(valueCurr);
			}
%></Td>

		<%
		if(!"TANN".equals(ItemCat))
		{%>
		<Td width="10%" align="center"  id="DesiredDate[<%=i%>]" >
			<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
				<a name="DD_<%= i %>"  id="DD_<%= i %>" href="JavaScript:void(0)" onClick='openNewWindow("ezAddDatesEntry.jsp?ind=<%= i %>&unitQty=<%=prodUQ%>","<%=i%>")'>
				<% if(i == 0) {%>
				<span id="selectG" style="display:''"><%=requiredDate%></span>
				<% }else{%>
					<%=requiredDate%>
				<%}%>
				</a>
		</td>
		<%}else{%>
			<Td width="10%" align="center"  id="DesiredDate[<%=i%>]" >
			<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
			Bonus
			</td>
		<%}%>

	<Td width="5%" align="center">
	<a href="JavaScript:showATP(<%= i %>)"><img src="../../Images/Buttons/BROWN/atp.gif" <%=statusbar%>  border="none" valign="center" ></a>
			</Td>
			
		</Tr>
<%   		}
	}
	else
	{
%>		<Tr>
			<Td colspan='6' align='center'>
<%			String msg = request.getParameter("msg");
			if(msg !=null && !"null".equals(msg) && msg.trim().length() !=0)
			 	out.println("Error:"+msg);
			else
				out.println("Prices not defined");
%>			</Td>
		</Tr>
<%
	}
%>
</Table>
</Div>

<Div id="showTot" style="visibility:hidden">
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="98%">
	<Tr>
		<Td  width=66% class=blankcell>&nbsp;</Td>
		<Td  width=20% class=blankcell>
		
		
		<Table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="48%" align=center><%=tot_L%></Th>
			<Td width="52%" align=right>&nbsp;<%=myFormat.getCurrencyString(grandTotal.doubleValue())%></Td>
		</Tr>
		</Table>
		</td>
			<Td  width=14% class=blankcell></td>
	</Tr>
	</Table>
</div>

<input type="hidden" name="total" value="<%=cartcount%>">

<div id="div5" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
<Table align=center>
<Tr>
	<Td align="center" class="blankcell"><font color="blue"><%=taxDtyAppli_L%></font></Td>
</Tr>
<Tr>
	<Td  class="blankcell" align="center">
	<span id="EzButtonsSpan">
<%	
	String mBack  = request.getParameter("mBack");

	if(cartcount > 0)
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Change Shipping Address");
		buttonMethod.add("changeShipAdrs(\"E\")");	
		buttonName.add("Save to Local");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit to SAP");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");	
		buttonName.add("Remarks");
		buttonMethod.add("showTab(\"2\")");
		if(mBack!=null && !"null".equals(mBack) && "C".equals(mBack))
		{
			buttonName.add("Back");
			buttonMethod.add("cartOrder()");
		}
		else
		{
			buttonName.add("Back");
			buttonMethod.add("ezBackMain()");
		}
		out.println(getButtonStr(buttonName,buttonMethod));
	}
	else
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if(mBack!=null && !"null".equals(mBack) && "C".equals(mBack))
		{
			buttonName.add("Back");
			buttonMethod.add("cartOrder()");
		}
		else
		{
			buttonName.add("Back");
			buttonMethod.add("ezBackMain()");
		}
		
		out.println(getButtonStr(buttonName,buttonMethod));	
	}
%>	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
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
<input type="hidden" name="delBlock">

<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;left:2%;top:16%;height:70%;width:98%">
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

<Div id="buttonDiv"  style="visibility:hidden;position:absolute;top:91%;width:100%">
<Table align="center" width="70%">
<Tr>
	<Td class="blankcell" align="center"><nobr>
	<span id="EzButtonsRemarksSpan">
<%	if(cartcount > 0)
	{
	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Save to Local");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit to SAP");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");	
		buttonName.add("Back");
		buttonMethod.add("showTab(\"1\")");
		out.println(getButtonStr(buttonName,buttonMethod));
	}	
%>		
	</span>	
	<span id="EzButtonsRemarksMsgSpan" style="display:none">
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

<%
 if(mBack!=null && !"null".equals(mBack) && "C".equals(mBack))
 {
%>
	<input type="hidden" name="mBack" value="C">
<%
 }
 String fromCart = request.getParameter("fromCart");
 if(fromCart!=null && "Y".equals(fromCart.trim()))
 {
%>
<input type="hidden" name="fromCart" value="<%=fromCart%>">
<%
}
%>
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="pageUrl" value=<%=pageUrl %>>
</div>
<% 		
	String creditChk=request.getParameter("creditChk");
	if("Yes".equals(creditChk))
	{
%>	<script>
		alert("Credit limit Exceeded.Kindly advice when payement may be \n forwarded so your order may be executed.");
	</script>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


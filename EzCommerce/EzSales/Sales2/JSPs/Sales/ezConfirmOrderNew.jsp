<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezbasicutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%@ page import="ezc.sales.material.params.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>
<%@ include file="../DrillDownCatalog/ezCountryStateList.jsp" %> 

<%
	Double grandTotal =new Double("0");
	ReturnObjFromRetrieve itemoutTable=(ReturnObjFromRetrieve)session.getValue("ITEMSOUT");
	int cartcount=itemoutTable.getRowCount();
	String from = request.getParameter("from");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();

        ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	ReturnObjFromRetrieve  listBillTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos((String)session.getValue("AgentCode"));
	
	
	
	
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
	
	String cartItems  = request.getParameter("cartItems"); 
	String frameFlg  = request.getParameter("frameFlg");
	
	
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
	
	
	String billAddr1          = listBillTos_ent.getFieldValueString(0,"ECA_ADDR_1");
	String billAddr2          = listBillTos_ent.getFieldValueString(0,"ECA_CITY");
	String billState 	  = listBillTos_ent.getFieldValueString(0,"ECA_STATE");
	String billZip    	  = listBillTos_ent.getFieldValueString(0,"ECA_PIN");
	String billTPZone	  = listBillTos_ent.getFieldValueString(0,"ECA_TRANSORT_ZONE");
	String billJurCode	  = listBillTos_ent.getFieldValueString(0,"ECA_JURISDICTION_CODE");
	
	if(billTPZone!=null)
	billTPZone = billTPZone.trim();
	
	if(billJurCode!=null)
	billJurCode = billJurCode.trim();
	

	billAddr1 =(billAddr1==null || "null".equals(billAddr1))?"":billAddr1;
	billAddr2 =(billAddr2==null || "null".equals(billAddr2))?"":billAddr2;
	billState =(billState==null || "null".equals(billState))?"":billState;
	billZip =(billZip==null || "null".equals(billZip))?"":billZip;
	
	String[] prodNo  = null;
	String[] mfrNr   = null;
	String[] mfrPart = null;
	String[] eanupc  = null;
	String[] matId   = null;
	ReturnObjFromRetrieve myObj =null;
	
	Vector atpMat        = new Vector();
	Hashtable atpMatHt   = new Hashtable();
	Hashtable atpMatQty  = new Hashtable();
	Hashtable atpMatDate = new Hashtable();

	
	if(cartcount>0)
	{
		   prodNo   = new String[cartcount];
		   
		   mfrNr    = new String[cartcount];
		   mfrPart  = new String[cartcount];
		   eanupc   = new String[cartcount];
		   matId    = new String[cartcount];
		   
		   for(int i=0;i<cartcount;i++)
		   {
			String prodCode_A     = itemoutTable.getFieldValueString(i,"Material");
			String custprodCode_A = itemoutTable.getFieldValueString(i,"CustMat");
			String mfrPart_A      = itemoutTable.getFieldValueString(i,"MfrPart");
			String matId_A        = itemoutTable.getFieldValueString(i,"MatId");
			String mfrNr_A        = itemoutTable.getFieldValueString(i,"MfrNr");
			String eanupc_A       = itemoutTable.getFieldValueString(i,"EanUPC");
			
			mfrNr[i]    = mfrNr_A;
			mfrPart[i]  = mfrPart_A;
			eanupc[i]   = eanupc_A;
			matId[i]    = matId_A;
			

			if (custprodCode_A!=null && !"null".equals(custprodCode_A) && !"".equals(custprodCode_A))
				prodNo[i]= custprodCode_A;
			else
				prodNo[i]= prodCode_A;
		   }	   
	}
	try{
		EzcMaterialParams ezMatParams = new EzcMaterialParams();
		EziMaterialParams eiMatParams = new EziMaterialParams();
		
		eiMatParams.setMatIds(matId);
		eiMatParams.setMaterialCodes(mfrPart);
		eiMatParams.setUPCNumbers(eanupc);
		eiMatParams.setVendorCodes(mfrNr); 
		//eiMatParams.setMaterialCodes(prodNo);
		eiMatParams.setMaterial("");
		eiMatParams.setUnit("");

		ezMatParams.setObject(eiMatParams);
		Session.prepareParams(ezMatParams);  


		EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
		myObj = (ReturnObjFromRetrieve) eoMatParams.getReturn();

	}catch(Exception e){

	}
	int myObjCount=0;
	String matNo="",status="",availableQty="",leadTime="",tempLeadTime="",cumQty="";
	String matIdTemp = ""; 
	String linkStr="N";
	
	Date tempDate = null;
	
	if(myObj!=null)
		myObjCount = myObj.getRowCount(); 
		
	for(int i=0;i<myObjCount;i++)
	{
		linkStr="N";
		matNo  = myObj.getFieldValueString(i,"MATERIAL");
		matIdTemp = myObj.getFieldValueString(i,"MATID");
		try{
		      matNo = Integer.parseInt(matNo)+"";
		}
		catch(Exception E){  }

		status              = myObj.getFieldValueString(i,"STATUS");
		availableQty        = myObj.getFieldValueString(i,"AVAIL_QTY");
		String availDateStr = myObj.getFieldValueString(i,"ENDLEADTME");
		Date availDate      = (Date)myObj.getFieldValue(i,"ENDLEADTME");
		
		if(atpMat.contains(matIdTemp))
			linkStr="Y";
		else
			atpMat.addElement(matIdTemp);
			
		if("A".equals(status))
		{
			if(atpMatQty.containsKey(matIdTemp)){
				cumQty =(String)atpMatQty.get(matIdTemp);

				try{
					//availableQty = (Double.parseDouble(availableQty)+Double.parseDouble(cumQty))+"";
					availableQty = (new java.math.BigDecimal(availableQty).add(new java.math.BigDecimal(cumQty))).toString();
					atpMatQty.put(matIdTemp,availableQty); 
				}catch(Exception e){  }
			}
			else
				atpMatQty.put(matIdTemp,availableQty);
		}
		if("O".equals(status) && availDate!=null)
		{
			if(atpMatDate.containsKey(matIdTemp)){
				tempDate =(Date)atpMatDate.get(matIdTemp); 

				if(tempDate.compareTo(availDate)<0)
				     atpMatDate.put(matIdTemp,availDate);
				else
				     atpMatDate.put(matIdTemp,tempDate);
			}
			else 
			     atpMatDate.put(matIdTemp,availDate);
		}
			
		Date atpDate     = (Date)atpMatDate.get(matIdTemp);
		String atpDateStr = FormatDate.getStringFromDate(atpDate,formatkey,FormatDate.DDMMYYYY);
		
		String atpQty    = (String)atpMatQty.get(matIdTemp);
		
		if(atpMatQty.containsKey(matIdTemp)){
			status ="A";
		}else if(atpMatDate.containsKey(matIdTemp)){
			status ="O"; 
		} 
		
		atpMatHt.put(matIdTemp,status+"¥"+atpQty+"¥"+atpDateStr+"¥"+linkStr);  
	}
	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<!--<Script src="../../Library/JavaScript/ezCalValue.js"></Script>-->
<Script>
	var tabHeadWidth=95
 	var tabHeight="30%"
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
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
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
	
	
	function validateAddress()
	{
		if(document.generalForm.shipToAddress1.value==""){
			alert("Please enter Address");
			document.generalForm.shipToAddress1.focus();
			return false;
		}
	        
		if(document.generalForm.shipToAddress2.value==""){
			alert("Please enter City");
			document.generalForm.shipToAddress2.focus();
			return false;
		}
		
		if(document.generalForm.shipToState.value==""){
			alert("Please enter State");
			document.generalForm.shipToState.focus();
			return false;
		}
			
		if(document.generalForm.shipToZipcode.value==""){
			alert("Please enter Postal Code");
			document.generalForm.shipToZipcode.focus();
			return false;
		}
		
		return true;
	
	}
	
	function formSubmit(obj,obj2)  
	{
		
		if(validateAddress()){
		
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
						 y=confirm("Do you want to Save the Order")
					}
					else if(z=="SUBMITTED")
					{
						 y=confirm("<%=subEnterApproval_A%>")
					}
					else if(z=="TRANSFERED")
					{
						 y=confirm("Do you want to Submit the Order")
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
	function showATPDetails(prodCode,prdDesc,vcode,matId,upc)
	{
		prodCode = prodCode.replace('#','@@@');   
		myurl ="../Sales/ezGetATPDetails.jsp?matId="+matId+"&vendCode="+vcode+"&upc="+upc+"&ProductCode="+prodCode+"&prdDesc="+prdDesc
		
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=400,width=500,status=no,toolbar=no,menubar=no,location=no")
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
<input type="hidden" name="frameFlg" value="<%=frameFlg%>">

<%
	String display_header = COrderFor_L+" "+agentName;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type="hidden" name="agentName" value="<%=agentName%>">

<div id="div1" align="center" style="visibility:visible;width:100%">
<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=0 >
     <Tr>
     		<th class="labelcell" align="left" width="10%" ><%=pono_L%></th>
     		<td width="15%"> <input type="hidden" name="poNo"  value="<%=PONO%>"><%=PONO%></td>
        	<th class="labelcell" align="left" width="10%" ><%=podate_L%></th>
        	<td width="15%"><input type="hidden" name="poDate" value="<%=PODate%>"><%=PODate%></td>
        	<th class="labelcell" align="left" width="10%" >Req.Deliv.Date</th>
        	<td width="15%"><input type="hidden" name="requiredDate" value="<%=requiredDate%>"><%=requiredDate%></td>
        	<Th class="labelcell" align="left" width="10%" >Ship Type</Th>
		<Td nowrap width="15%">
			<%=shippingTypeDesc%>&nbsp;
		</Td>
     </Tr>
     <Tr>
     		<th class="labelcell"   colspan = 4 ><%=soldto_L %> Address
			<input type="hidden" name="soldTo" value="<%=SoldTo%>">
			<input type="hidden" name="soldToName" value="<%=agentName%>">
     		</th>
     		<Th class="labelcell"  colspan = 4 cellPadding=3 cellSpacing=0 ><%=shipto_L%> Address
     		
			<input type="hidden" name="shipTo" value="<%=ShipTo%>">
			<input type="hidden" name="shipToName" value="<%=ShipToName%>">
     		
     		</Th>
      </Tr>
      <Tr>
		<Td align=right>Name:</Td>
		<td colspan = 3><%=agentName%></Td>
                <Td align=right>Name:</Td>
                <Td colspan = 3 ><%=ShipToName%></Td>
           		
      </Tr>
      <Tr>
      		<Td align=right>Address:</Td>
      		<td colspan = 3><%=billAddr1%></Td>
	        <Td align=right>Address*:</Td>
	        <Td colspan = 3 >
	        <input type="text"  class='InputBox' name="shipToAddress1"  maxlength="60" value='<%=shipAddr1%>'>
	        </Td>
                 		
      </Tr>
      <Tr>
      		<Td align=right>City:</Td>
      		<td colspan = 3><%=billAddr2%></Td>
                <Td align=right>City*:</Td>
                <Td colspan = 3 >
                	<input type="text"  class='InputBox' name="shipToAddress2"  maxlength="40" value='<%=shipAddr2%>'>
                </Td>
                 		
      </Tr>
      <Tr>
      		<Td align=right>State:</Td>
      		<td colspan = 3>
      		<%=billState%></Td>
                <Td align=right>State*:</Td>
                <Td colspan = 3 >
                
		<select name="shipToState" id ="ListBoxDiv1" style="width:37%">
		

<%
		Enumeration enum1S =  ezStates.keys();
		String enum1Key=null;
		String enum1Desc=null;

		while(enum1S.hasMoreElements())
		{
			enum1Key = (String)enum1S.nextElement();
			enum1Desc = (String)ezStates.get(enum1Key);
			if(enum1Key.equals(shipState))
			{
%>
			<option value="<%=enum1Key%>" selected><%=enum1Desc%>(<%=enum1Key%>)</Option>
<%
			}
			else
			{
%>
			<option value="<%=enum1Key%>"><%=enum1Desc%>(<%=enum1Key%>)</Option>
<%
			}
		}
%>				
		</select>
		
               <!-- <input type="text"  class='InputBox' size='3' name="shipToState"  maxlength="3" value='<%=shipState%>'>-->
                </Td>
                 		
      </Tr>
      <Tr>
		<Td align=right>Postal Code:</Td>
		<td colspan = 3>
			<%=billZip%>
			<input type ="hidden" name="billTPZone" value="<%=billTPZone%>">
			<input type ="hidden" name="billJurCode" value="<%=billJurCode%>"> 
		
		</Td>
		<Td align=right>Postal Code*:</Td>
		<Td colspan = 3 >
			<input type="text" class='InputBox' size = '10' name="shipToZipcode"  maxlength="10"  value='<%=shipZip%>'>
		</Td>
                       		
      </Tr>
     
     
     
			
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
      
</Table>
</div>

<Div id='theads'>
<Table width="95%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<Tr>
	<th width="10%" valign="top" nowrap>Product</th>
        <th width="20%" valign="top" nowrap>Description</th>
        <th width="10%" valign="top" >Brand</th>
        <th width="9%" valign="top" >List Price</th>
	<th width="4%"  valign="top"><%=uom_L%></th>
	<th width="9%" valign="top"><%=qty_L%></th>
	<th width="9%" valign="top"><%=price_L%> [<%=Currency%>]</th>
	<Th width="10%" valign="top"><%=val_L%> [<%=Currency%>]</Th>
	<Th width="8%" valign="top"><%=delSchedue_L%></Th>
        <Th width="12%" valign="top">ATP</Th>
</Tr>
</Table>
</div>
<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:65%;left:2%'>
<Table width='100%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
	//log4j.log("prices_prices_prices_prices_prices_:confirm:"+itemoutTable.toEzcString(),"W");
	String[] prodUnitQty = new String[cartcount];
	Hashtable selectdMet = (Hashtable)session.getAttribute("SELECTEDMET");
	
	
	log4j.log("selectdMet::::::::"+selectdMet,"W");
	//itemoutTable.toEzcString(); 
	
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
			String atpMatId     = itemoutTable.getFieldValueString(i,"MatId");
			String atpMfrPart   = itemoutTable.getFieldValueString(i,"MfrPart");
			String atpMfrNr     = itemoutTable.getFieldValueString(i,"MfrNr");
			String atpEanUPC     = itemoutTable.getFieldValueString(i,"EanUPC");	
			
		
			
			String itemVenCatalog ="";
			String tempItemStr="";
			String itemBrand="";
			String itemListPrice="";
			String atpDispStr  ="";
			String atpStatus   ="";
			String atpQty      ="";
			String atpLeadTime ="";
			String atpLinkStatus ="";
			
			String itemMfrPart ="";
			String itemMfrNr   ="";
			String itemEanUPC  ="";
			
			java.util.StringTokenizer itemSt = null;
			boolean custMatFlg =false;
			
			String sapPCode = (String)session.getValue("SAPPRDCODE");
			
			if(prodCode!=null && !"null".equals(prodCode) && prodCode.equals(sapPCode))
			{
			    tempItemStr = (String)itemCatalogs.get(atpMatId);
			    itemSt=new java.util.StringTokenizer(tempItemStr,"¥");
			    custMatFlg =true;
			}
			else
			{
			    tempItemStr = (String)itemCatalogs.get(atpMatId);
			    itemSt=new java.util.StringTokenizer(tempItemStr,"¥");
			}
			
			
			while(itemSt.hasMoreTokens())
			{
			    try
			    {
			    	itemVenCatalog	 = itemSt.nextToken(); 
			   	itemBrand	 = itemSt.nextToken();	
			    	itemListPrice    = itemSt.nextToken();
			    	itemMfrPart      = itemSt.nextToken();
			    	itemEanUPC       = itemSt.nextToken();
			    	itemMfrNr        = itemBrand;
			    	
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
			   commitedQty=(String)itemQtys.get(atpMatId);
			}
			else
			{
			   commitedQty=(String)itemQtys.get(atpMatId);
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
			String prodNoUD ="";
			
			if (custprodCode!=null && !"null".equals(custprodCode) && !"".equals(custprodCode.trim()))
			{
				try
				{
					prodNoUD = custprodCode;
					tPNo = Integer.parseInt(custprodCode)+"";
				}
				catch(Exception e)
				{ 
					tPNo = custprodCode;
					prodNoUD = custprodCode;
				}
			}
			else
			{
				try
				{
					tPNo = Integer.parseInt(prodCode)+"";
					prodNoUD = prodCode;
				}
				catch(Exception e)
				{ 
					tPNo = prodCode;
					prodNoUD = prodCode; 
				}
		        }
			
%>
			<Td width="10%" align="left" title="<%=a%>"><%=tPNo%></Td> 
			<Td width="20%" align="left" title="<%=a%>">
				&nbsp;<input type="text" name="prodDesc" size="25" class="tx" readonly value="<%=prodDesc%>">
				<input type="hidden" name="lineValue" value="<%= bPrice %>">
				<input type="hidden" name="product" value="<%= prodCode%>">
				<input type="hidden" name="prodCode" value="<%= prodNoUD%>">
				<input type="hidden" name="oldprodCode" value="<%= prodCode%>">
				<input type="hidden" name="custprodCode" value="<%= prodNoUD%>">
				<input type="hidden" name="custATPMat" value="<%= custprodCode%>">
				<input type="hidden" name="itemVenCatalog" value="<%=itemVenCatalog%>">
				
				<input type="hidden" name="itemMfrPart" value="<%=itemMfrPart%>">
				<input type="hidden" name="itemMfrNr"   value="<%=itemMfrNr%>">
				<input type="hidden" name="itemEanUPC" value="<%=itemEanUPC%>">
				<input type="hidden" name="itemMatId" value="<%=atpMatId%>"> 
				
				
				
				<input type="hidden" name="vendCatalog" value="<%=itemVenCatalog%>">
				
				<%if(prflg){%>
					<input type="hidden" name="desiredPrice"  value="<%=bUpricetemp.setScale(4,java.math.BigDecimal.ROUND_HALF_UP)%>">
				<%}else{%>
					<input type="hidden" name="desiredPrice"  value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
				<%}%>
				<input type="hidden" name="itemListPrice" value="<%=itemListPrice%>">
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
			<Td width="9%" align="center">&nbsp;<%="$"+itemListPrice%></Td> 
			
			<Td width="4%" align="center">&nbsp;<%=prodUom%></Td>
			<Td width="9%" align="right"><input type="hidden" name="del_sch_qty" value="<%=commitedQty%>"><%=tqty%>
				<input type="hidden"  name="focVal" >
			</Td>
			<Td width="9%" align="right">
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
		<Td width="8%" align="center"  id="DesiredDate[<%=i%>]" >
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
			<Td width="8%" align="center"  id="DesiredDate[<%=i%>]" >
			<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
			Bonus
			</td>
		<%}%>

	<Td width="12%" align="center">
	
		<!--<a href="JavaScript:showATP(<%= i %>)"><img src="../../Images/Buttons/BROWN/atp.gif" <%=statusbar%>  border="none" valign="center" ></a>-->
<%
	
	if(atpMatHt!=null){
	        
		String atpMatStr   = (String)atpMatHt.get(atpMatId);  
		try{
			StringTokenizer st = new StringTokenizer(atpMatStr,"¥");
			atpStatus      	   = (String)st.nextElement();
			atpQty             = (String)st.nextElement();
			atpLeadTime        = (String)st.nextElement();
			atpLinkStatus      = (String)st.nextElement();
			
		}catch(Exception e){ }
	}  
	atpQty=(atpQty==null || "null".equals(atpQty))?"":atpQty; 
	atpLeadTime=(atpLeadTime==null || "null".equals(atpLeadTime))?"":atpLeadTime;

	if("S".equals(atpStatus))
		atpDispStr = "Special";  
	else if("A".equals(atpStatus))
		atpDispStr = "In stock<br>"+atpQty;        
	else if("O".equals(atpStatus) && !"".equals(atpLeadTime))
		atpDispStr = "Available&nbsp;On<br>"+atpLeadTime;                       
	else 
		atpDispStr ="Out of stock";    
	
	
	if("N".equals(atpLinkStatus))
		out.println(atpDispStr);
	else{
		out.println(atpDispStr);
		
%>
	<br>
 	<a href="JavaScript:showATPDetails('<%=atpMfrPart%>','<%=prodDesc%>','<%=atpMfrNr%>','<%=atpMatId%>','<%=atpEanUPC%>')"> ATP</a>
 

<%
        } 
%>
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
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="98%">
	<Tr>
		<Td  width=66% class=blankcell>&nbsp;</Td>
		<Td  width=20% class=blankcell>
		
		
		<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
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

<div id="div5" align="center" style="overflow:auto;visibility:visible;position:absolute;top:86%;width:100%">
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
		
		//buttonName.add("Change Shipping Address");
		//buttonMethod.add("changeShipAdrs(\"E\")");	
		buttonName.add("Save as Unfinished");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit Order");
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
<Table align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="60%">
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
		
		buttonName.add("Save as Unfinished");
		buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");	
		buttonName.add("Submit Order");
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


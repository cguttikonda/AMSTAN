<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezbasicutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%@ page import="ezc.sales.material.params.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>
<%@ include file="../DrillDownCatalog/ezCountryStateList.jsp" %> 
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%@ page import="ezc.fedex.freight.params.*"%>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	Double grandTotal =new Double("0");
	String colTone = "class='tx'";
	ReturnObjFromRetrieve itemoutTable=(ReturnObjFromRetrieve)session.getValue("ITEMSOUT");
	int cartcount=itemoutTable.getRowCount();
	String from = request.getParameter("from");

        ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	ReturnObjFromRetrieve  listBillTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos((String)session.getValue("AgentCode"));
	
	String backFlag 	= request.getParameter("backFlag");
	String pageUrl 		= request.getParameter("pageUrl");
	String generalNotes 	= request.getParameter("generalNotes");
	String Agent		= request.getParameter("agent");
	String SoldTo		= request.getParameter("soldTo");
	String ShipTo		= request.getParameter("shipTo");
	String PONO 		= request.getParameter("poNo");
	String OrderDate 	= request.getParameter("orderDate");
	String Currency 	= request.getParameter("currency");
	String UserRole		= (String)session.getValue("UserRole");
	UserRole.trim();
	String formatkey	= (String)session.getValue("formatKey");
	String pGroupNumber 	= request.getParameter("ProductGroup");
	
	String PODate 		= FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	String requiredDate 	= FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	
	String cartItems  = request.getParameter("cartItems"); 
	String frameFlg  = request.getParameter("frameFlg");

	String isSubUser = (String)session.getValue("IsSubUser");
	String suAuth = (String)session.getValue("SuAuth");
	
	String[] shippingTypeDesc = new String[2];

	shippingTypeDesc[0]="02";
	shippingTypeDesc[1]="Mail";

	Enumeration enumShip =  ezShippingTypes.keys();
	String enumShipKey=null;
	String enumShipDesc=null;
	
	
	String carrierName = request.getParameter("carrierName"); 
	carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;

	int rowId = -1;
	if(listShipTos_ent!=null && listShipTos_ent.getRowCount()>0)
	{
		rowId = listShipTos_ent.getRowId("EC_PARTNER_NO",ShipTo);

	}
	
	String ShipToName 	= listShipTos_ent.getFieldValueString(rowId,"ECA_NAME");
	
	String shipAddr1  	= listShipTos_ent.getFieldValueString(rowId,"ECA_ADDR_1");
	String shipAddress2  	= listShipTos_ent.getFieldValueString(rowId,"ECA_ADDR_2");
	String shipAddr2  	= listShipTos_ent.getFieldValueString(rowId,"ECA_CITY");
	String shipState  	= listShipTos_ent.getFieldValueString(rowId,"ECA_STATE");
	String shipCountry  	= listShipTos_ent.getFieldValueString(rowId,"ECA_COUNTRY");
	String shipZip    	= listShipTos_ent.getFieldValueString(rowId,"ECA_PIN");
	String tpZone	  	= listShipTos_ent.getFieldValueString(rowId,"ECA_TRANSORT_ZONE");
	String jurCode	  	= listShipTos_ent.getFieldValueString(rowId,"ECA_JURISDICTION_CODE");
	String shPhone    	= listShipTos_ent.getFieldValueString(rowId,"ECA_PHONE");
	String shFax    	= listShipTos_ent.getFieldValueString(rowId,"ECA_WEB_ADDR");
	
	shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1))?"":shipAddr1;
	shipAddress2 	= (shipAddress2==null || "null".equals(shipAddress2))?"":shipAddress2;// for shipping address2
	shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2))?"":shipAddr2;// for city
	shipState 	= (shipState==null || "null".equals(shipState))?"":shipState;
	shipCountry 	= (shipCountry==null || "null".equals(shipCountry))?"":shipCountry.trim();
	shipZip 	= (shipZip==null || "null".equals(shipZip))?"":shipZip;
	
	tpZone =(tpZone==null || "null".equals(tpZone))?"":tpZone;
	jurCode =(jurCode==null || "null".equals(jurCode))?"":jurCode;
	shPhone =(shPhone==null || "null".equals(shPhone))?"":shPhone;
	shFax =(shFax==null || "null".equals(shFax))?"":shFax;
	
	String agentName  	= listBillTos_ent.getFieldValueString(0,"ECA_NAME");
	
	String billAddr1  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_1");
	String billAddress2  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_2");
	String billAddr2  	= listBillTos_ent.getFieldValueString(0,"ECA_CITY");
	String billState  	= listBillTos_ent.getFieldValueString(0,"ECA_STATE");
	String billCountry  	= listBillTos_ent.getFieldValueString(0,"ECA_COUNTRY");
	String billZip    	= listBillTos_ent.getFieldValueString(0,"ECA_PIN");
	
	String billTPZone	  = listBillTos_ent.getFieldValueString(0,"ECA_TRANSORT_ZONE");
	String billJurCode	  = listBillTos_ent.getFieldValueString(0,"ECA_JURISDICTION_CODE");

	if(billTPZone!=null)
	billTPZone = billTPZone.trim();

	if(billJurCode!=null)
	billJurCode = billJurCode.trim();

	billAddr1 	= (billAddr1==null || "null".equals(billAddr1))?"":billAddr1;
	billAddress2 	= (billAddress2==null || "null".equals(billAddress2))?"":billAddress2;//for address2
	billAddr2 	= (billAddr2==null || "null".equals(billAddr2))?"":billAddr2;//for city
	billState 	= (billState==null || "null".equals(billState))?"":billState;
	billCountry	= (billCountry==null || "null".equals(billCountry))?"":billCountry;
	billZip 	= (billZip==null || "null".equals(billZip))?"":billZip;
	
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
				
			Hashtable selMet= new Hashtable();
			
			selMet.put(prodCode_A,""+","+"1");
			
			session.putValue("SELECTEDMET",selMet);
		}
	}
	
	/*************************Freight Service Type - Start*****************************/
	
	int stCnt = 0;
	EziServiceTypeParams eziStParams = new EziServiceTypeParams();
	EzcParams params = new EzcParams(false);
	
	eziStParams.setType("GET_ALL_SERVICE_TYPES");
	eziStParams.setExt1("");
	params.setObject(eziStParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve stRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetType(params);
	
	if(stRet!=null)
		stCnt = stRet.getRowCount();
	
	String frInsVal = (String)session.getValue("FRINSVAL");
	
	/*************************Freight Service Type - End*******************************/
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
<Script src="../../Library/JavaScript/ezChkATP.js"></Script>
<Script src="../../Library/JavaScript/ezConfirmOrder.js"></Script>
<Script src="../../Library/JavaScript/UploadFiles/ezAttachment.js"></Script>
<Script src="../../Library/JavaScript/popup.js"></Script>
<Script>
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
	var today ="<%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY)%>" 
	var notesCount = new Array();
	
	function chkReqDate()
	{
		obj = eval("document.generalForm.requiredDate")
		reqdat= funTrim(obj.value)

		var today ="<%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) %>"

		a=reqdat.split(".");
		b=(today).split(".");
		d1=new Date(a[2],(a[1]-1),a[0])
		d2=new Date(b[2],(b[1]-1),b[0])

		if(d1<d2)
		{
			alert("Required date must be greater than or equal to todays date");
			obj.focus()
			return false;
		}
		else
		{
			return true
		}
	}	
	function validateAddress()
	{
		if(document.generalForm.poNo.value=="")
		{
			alert("Please enter PO number");
			document.generalForm.poNo.focus();
			return false;
		}
		if(document.generalForm.poDate.value=="")
		{
			alert("Please select PO Date");
			document.generalForm.poDate.focus();
			return false;
		}
		if(document.generalForm.requiredDate.value=="")
		{
			alert("Please select Required Date");
			document.generalForm.requiredDate.focus();
			return false;
		}
		
		y=chkReqDate();
		
		//var y = true;
		
		if(eval(y))
		{
			if(document.generalForm.fServType.value=="SP" && funTrim(document.generalForm.specialShIns.value)=="")
			{
				alert("Please enter special shipping instructions")
				document.generalForm.specialShIns.focus()
				return false;
			}
			if(document.generalForm.fServType.value!="SP")
				document.generalForm.specialShIns.value="";
		}

		if(document.generalForm.shipToName.value=="")
		{
			alert("Please enter name");
			document.generalForm.shipToName.focus();
			return false;
		}
		if(document.generalForm.shipToName.value=="")
		{
			alert("Please enter name");
			document.generalForm.shipToName.focus();
			return false;
		}
		/*if(document.generalForm.shipToAddress1.value=="")
		{
			alert("Please enter Room/ House No");
			document.generalForm.shipToAddress1.focus();
			return false;
		}*/
	        //streetName is for Street
		if(document.generalForm.streetName.value=="")
		{
			alert("Please enter Street");
			document.generalForm.streetName.focus();
			return false;
		}
		//shipToAddress2 is for city
		if(document.generalForm.shipToAddress2.value=="")
		{
			alert("Please enter City");
			document.generalForm.shipToAddress2.focus();
			return false;
		}
		if(document.generalForm.shipToState.value=="")
		{
			alert("Please enter State");
			document.generalForm.shipToState.focus();
			return false;
		}
		if(document.generalForm.shipToZipcode.value=="")
		{
			alert("Please enter Postal Code");
			document.generalForm.shipToZipcode.focus();
			return false;
		}
		if(funTrim(document.generalForm.weight.value)!="0" && document.generalForm.fServType.value=="")
		{
			alert("Please select a Freight Type");
			document.generalForm.fServType.focus();
			return false;
		}

		return true;
	}

	function formSubmit(obj,obj2)
	{
		if(validateAddress())
		{
			var zipShipCode = document.generalForm.shipToZipcode.value;
			var hideShipCode = document.generalForm.hideShipTo.value;
			
			document.generalForm.status.value=obj2;
			
			var flag = true;

			if(flag)
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
					if(document.generalForm.attachs.length>0)
					{
						document.generalForm.attachflag.value="true";
						var astring="";
						for(var i=0;i<document.generalForm.attachs.length;i++)
						{
							astring=astring+document.generalForm.attachs.options[i].value+",";
						}
						astring	= astring.substring(0,astring.length-1);
						document.generalForm.attachString.value=astring;
					}
					
					var z=document.generalForm.status.value
					
					if(z=="NEW")
					{
						y=confirm("Do you want to Save the Order?\n\nNOTE: Once order is saved it cannot be edited.\nFreight and prices may change while submitting the order")
						
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
					else
					{
						if(funTrim(zipShipCode)!=funTrim(hideShipCode))
						{
							calFreight('POSTALCODE');
						}
						else
						{
							if(z=="SUBMITTED")
							{
								y=confirm("<%=subEnterApproval_A%>")
							}
							else if(z=="TRANSFERED")
							{
								y=confirm("Do you want to Submit the Order?")
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
	function cartOrder()
	{
		document.generalForm.action="../Sales/ezAddSalesSh.jsp?bkpflg=<%=request.getParameter("bkpflg")%>"
		document.generalForm.submit();
	}
	function selectState()
	{
		var sel = document.generalForm.shipToCountry.value;

		var stateInputObj  = document.generalForm.shipToState;
		stateInputObj.value="";

		if(sel=="US")
		{
			document.getElementById("ListBoxDiv1").style.display="block";
			document.getElementById("stateId").style.display="None";
		}
		else
		{
			document.getElementById("stateId").style.display="block";
			document.getElementById("ListBoxDiv1").style.display="None";
		}		
	}
	function funSelState()
	{
		var sel = '<%=shipCountry%>'

		if(sel=="US")
		{
			document.getElementById("ListBoxDiv1").style.display="block";
			document.getElementById("stateId").style.display="None";
		}
		else
		{
			document.getElementById("stateId").style.display="block";
			document.getElementById("ListBoxDiv1").style.display="None";
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
	function Initialize()
	{
		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP"); 
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(! req&&typeof XMLHttpRequest != "undefined")
		{
			req = new XMLHttpRequest();
		}
	
	}
	function applyPromoCode()
	{
		var chkPromoCode = document.generalForm.promoCode.value;
		
		var y = true;
		
		if(funTrim(chkPromoCode)=="")
		{
			alert("Please enter Promotional Code");
			document.generalForm.promoCode.focus();
			y = false;
		}
		
		if(eval(y))
		{
			try
			{
				req = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch(e)
			{
				try
				{
					req = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch(oc)
				{
					req = null;
				}
			}

			if(!req&&typeof XMLHttpRequest!="undefined")
			{
				req = new XMLHttpRequest();
			}
			//alert(req)

			var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezAjaxCheckPromoCode.jsp?promoCode="+chkPromoCode;

			//alert(url)

			if(req!=null)
			{
				req.onreadystatechange = Process;
				req.open("GET", url, true);
				req.send(null);
			}
		}
	}
	function Process() 
	{
		if(req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
						
			if(req.status == 200)
			{
				var resultText	= resText.split("#");
				
				var validCode 	= resultText[0];
				var promoType 	= resultText[1];
				var manfId 	= resultText[2];
				var itemCat 	= resultText[3];
				var applyDisc 	= resultText[4];

				if(validCode.indexOf("VALIDPROMOCODE")!=-1)
				{
					//alert(validCode)
					//alert(promoType)
					//alert(manfId)
					//alert(itemCat)
					//alert(applyDisc)
					
					chkToApply(promoType,manfId,itemCat,applyDisc)

					//alert("Entered is Valid Promotional Code");
				}
				else
				{
					alert("Entered is Not Valid Promotional Code");
				}
			}
			else
			{
				if(req.status == 500)	 
				alert("Error");
			}
		}
	}
	
	function chkToApply(promoType,mfrCode,itemCat,applyDisc)
	{
		var len = document.generalForm.product.length;
		var pCode = document.generalForm.promoCode.value;;
		
		var mfrPartObj = document.generalForm.itemMfrPart;
		var mfrCodeObj = document.generalForm.itemMfrCode;
		var itemCatObj = document.generalForm.vendCatalog;
		//var hideFinalPriceObj = document.generalForm.hideFinalPrice;
		var hideFinalPriceObj = document.generalForm.itemOrgPrice;
		var finalPriceObj = document.generalForm.finalPrice;
		//var finalPriceObj = document.generalForm.itemOrgPrice;
		var itemMmFlagObj = document.generalForm.itemMmFlag;
		
		var desiredQtyObj = document.generalForm.desiredQty;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var grandTotalValObj = document.generalForm.grandTotalVal;
		var itemPromoCodeObj = document.generalForm.itemPromoCode;
		
		var apply = false;
		var fPrice = 0;
		var fPriceVal = 0;
		var gTotal = 0;
		var fTotVal = 0;
		
		var fVal = document.generalForm.freightVal.value;
		var fIns = document.generalForm.freightIns.value;
		
		if(funTrim(fVal)!='TBD' && funTrim(fIns)!='TBD')
			fTotVal = (parseFloat(fVal)+parseFloat(fIns)).toFixed(2);
		
		if(isNaN(len))
		{
			if((funTrim(eval(itemMmFlagObj).value)=='CNET') && ((mfrCode=='All' && itemCat=='All') || (mfrCode==funTrim(eval(mfrCodeObj).value) && itemCat=='All') || (mfrCode==funTrim(eval(mfrCodeObj).value) && itemCat==funTrim(eval(itemCatObj).value))))
			{
				fPrice = ((parseFloat(eval(hideFinalPriceObj).value))-((parseFloat(eval(hideFinalPriceObj).value)*parseFloat(applyDisc))/parseFloat(100))).toFixed(2);
				eval(finalPriceObj).value = fPrice;
				fPriceVal = (parseFloat(eval(desiredQtyObj).value)*parseFloat(fPrice)).toFixed(2);
				eval(finalPriceValObj).value = fPriceVal;
				eval(grandTotalValObj).value = (parseFloat(fPriceVal)+parseFloat(fTotVal)).toFixed(2);
				eval(itemPromoCodeObj).value = pCode;
				apply = true;
			}
			if(promoType=='MFRPN' && mfrCode==funTrim(eval(mfrPartObj).value))
			{
				eval(finalPriceObj).value = applyDisc;
				fPriceVal = (parseFloat(eval(desiredQtyObj).value)*parseFloat(applyDisc)).toFixed(2);
				eval(finalPriceValObj).value = fPriceVal;
				eval(grandTotalValObj).value = (parseFloat(fPriceVal)+parseFloat(fTotVal)).toFixed(2);
				eval(itemPromoCodeObj).value = pCode;
				apply = true;
			}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if((funTrim(eval("itemMmFlagObj["+i+"]").value)=='CNET') && ((mfrCode=='All' && itemCat=='All') || (mfrCode==funTrim(eval("mfrCodeObj["+i+"]").value) && itemCat=='All') || (mfrCode==funTrim(eval("mfrCodeObj["+i+"]").value) && itemCat==funTrim(eval("itemCatObj["+i+"]").value))))
				{
					fPrice = ((parseFloat(eval("hideFinalPriceObj["+i+"]").value))-((parseFloat(eval("hideFinalPriceObj["+i+"]").value)*parseFloat(applyDisc))/parseFloat(100))).toFixed(2);
					eval("finalPriceObj["+i+"]").value = fPrice;
					fPriceVal = (parseFloat(eval("desiredQtyObj["+i+"]").value)*parseFloat(fPrice)).toFixed(2);
					eval("finalPriceValObj["+i+"]").value = fPriceVal;
					eval("itemPromoCodeObj["+i+"]").value = pCode;
					apply = true;
				}
				if(promoType=='MFRPN' && mfrCode==funTrim(eval("mfrPartObj["+i+"]").value))
				{
					eval("finalPriceObj["+i+"]").value = applyDisc;
					fPriceVal = (parseFloat(eval("desiredQtyObj["+i+"]").value)*parseFloat(applyDisc)).toFixed(2);
					eval("finalPriceValObj["+i+"]").value = fPriceVal;
					eval("itemPromoCodeObj["+i+"]").value = pCode;
					apply = true;
				}
				gTotal = (parseFloat(gTotal)+parseFloat(eval("finalPriceValObj["+i+"]").value)).toFixed(2);
			}
			eval(grandTotalValObj).value = (parseFloat(gTotal)+parseFloat(fTotVal)).toFixed(2);
		}
		if(apply)
		{
			ApplySpan=document.getElementById("applySpan")
			RemoveSpan=document.getElementById("removeSpan")
			if(ApplySpan!=null)
			{
				ApplySpan.style.display="none"
				RemoveSpan.style.display="block"
			}
			document.generalForm.hidePromoCode.value=pCode;
			
			alert("Promotional code applied successfully");
		}
		else
			alert("Entered promotional code cannot be applied to these product(s)");
	}
	function removePromoCode()
	{
		var len = document.generalForm.product.length;
		
		var finalPriceObj = document.generalForm.finalPrice;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var grandTotalValObj = document.generalForm.grandTotalVal;
		
		var hideFinalPriceObj = document.generalForm.hideFinalPrice;		
		var hideFinalPriceValObj = document.generalForm.hideFinalPriceVal;
		var hideGrandTotalValObj = document.generalForm.hideGrandTotalVal;
		var itemPromoCodeObj = document.generalForm.itemPromoCode;
		
		var remove = false;
		
		var fVal = document.generalForm.freightVal.value;
		var fIns = document.generalForm.freightIns.value;
		
		var fTotVal = 0;
		
		if(funTrim(fVal)!='TBD' && funTrim(fIns)!='TBD')
			fTotVal = (parseFloat(fVal)+parseFloat(fIns)).toFixed(2);
		
		if(isNaN(len))
		{
			eval(finalPriceObj).value=eval(hideFinalPriceObj).value;
			eval(finalPriceValObj).value=eval(hideFinalPriceValObj).value;
			eval(itemPromoCodeObj).value="";
			remove = true;
		}
		else
		{
			for(i=0;i<len;i++)
			{
				eval("finalPriceObj["+i+"]").value=eval("hideFinalPriceObj["+i+"]").value;
				eval("finalPriceValObj["+i+"]").value=eval("hideFinalPriceValObj["+i+"]").value;
				eval("itemPromoCodeObj["+i+"]").value="";
				remove = true;
			}
		}
		if(remove)
		{
			eval(grandTotalValObj).value=(parseFloat(eval(hideGrandTotalValObj).value)+parseFloat(fTotVal)).toFixed(2);
		
			ApplySpan=document.getElementById("applySpan")
			RemoveSpan=document.getElementById("removeSpan")
			if(RemoveSpan!=null)
			{
				ApplySpan.style.display="block"
				RemoveSpan.style.display="none"
			}
			document.generalForm.hidePromoCode.value="";
		
			alert("Promotional code removed successfully");
		}
	}
	function calFreight(obj)
	{
		stat = obj;
		
		var servType = document.generalForm.fServType.value;
		var countryCode = document.generalForm.shipToCountry.value;
		var zipCode = document.generalForm.shipToZipcode.value;
		var weight = document.generalForm.weight.value;
		var packType = document.generalForm.packType.value;
		
		if(stat=="FTYPE")
			document.generalForm.hideShipTo.value = zipCode;
		
		var fVal = document.generalForm.freightVal.value;
		var fIns = document.generalForm.freightIns.value;

		var fTotVal = 0;
		
		if(funTrim(fVal)!='TBD' && funTrim(fIns)!='TBD')
			fTotVal = (parseFloat(fVal)+parseFloat(fIns)).toFixed(2);


		var grandTotalValObj = document.generalForm.grandTotalVal;
		eval(grandTotalValObj).value = (parseFloat(eval("grandTotalValObj").value)-parseFloat(fTotVal)).toFixed(2);
		document.generalForm.freightVal.value = "0.00";
		document.generalForm.freightIns.value = "0.00";
		
		var noFreight = document.generalForm.noFreight.value;
		
		if(funTrim(servType)!="SP")
		{
			if(funTrim(noFreight)=="TBD")
			{
				document.generalForm.freightVal.value = "TBD";
				document.generalForm.freightIns.value = "TBD";
				alert("Freight is To Be Determined for the order");
			}
			else if((funTrim(servType)!="" && funTrim(weight)!="0") || stat=="POSTALCODE")
			{
				Popup.showModal('modal')

				try
				{
					reqFM = new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e)
				{
					try
					{
						reqFM = new ActiveXObject("Microsoft.XMLHTTP");
					}
					catch(oc)
					{
						reqFM = null;
					}
				}

				if(!reqFM&&typeof XMLHttpRequest!="undefined")
				{
					reqFM = new XMLHttpRequest();
				}
				//alert(reqFM)

				var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezAjaxFreightType.jsp?servType="+servType+"&countryCode="+countryCode+"&zipCode="+zipCode+"&weight="+weight+"&packType="+packType;

				//alert(url)

				if(reqFM!=null)
				{
					reqFM.onreadystatechange = ProcessFreight;
					reqFM.open("GET", url, true);
					reqFM.send(null);
				}
				else
					Popup.hide('modal')
			}
			else if(funTrim(servType)!="" && funTrim(weight)=="0")
			{
				document.generalForm.freightVal.value = "TBD";
				document.generalForm.freightIns.value = "TBD";
				alert("Freight is To Be Determined for the order");
			}
		}
		else if(funTrim(servType)=="SP")
		{
			document.generalForm.freightVal.value = "TBD";
			document.generalForm.freightIns.value = "TBD";
			alert("Freight is To Be Determined for the order");
		}
	}
	function ProcessFreight() 
	{
		if(reqFM.readyState == 4)
		{
			var resText = reqFM.responseText;	 	        	
						
			if(reqFM.status == 200)
			{
				Popup.hide('modal')
				
				var resultText	= resText.split("#");
				
				var fType = resultText[0];
				var fPrice = resultText[1];

				if(fType.indexOf("FRIEGHT")!=-1)
				{
					calFreightIns();
					
					document.generalForm.freightVal.value = parseFloat(fPrice).toFixed(2);
					
					var fIns = document.generalForm.freightIns.value;
					var fTotVal = (parseFloat(fPrice)+parseFloat(fIns)).toFixed(2);

					var grandTotalValObj = document.generalForm.grandTotalVal;
					eval(grandTotalValObj).value = (parseFloat(fTotVal)+parseFloat(eval("grandTotalValObj").value)).toFixed(2);
				}
				else
				{
					document.generalForm.freightVal.value = "TBD";
					document.generalForm.freightIns.value = "TBD";

					if(stat=="FTYPE")
					{
						alert("Freight is To Be Determined for the order");
					}
				}
				if(stat=="POSTALCODE")
				{
					if(confirm("As the postal code is changed frieght might also change\n\nDo you want to Submit the Order?"))
					{
						document.body.style.cursor="wait";
						document.generalForm.target="_self";
						document.generalForm.action="ezAddSaveSales.jsp";
						document.generalForm.submit();
					}
					else
					{
						buttonsSpan=document.getElementById("EzButtonsSpan")
						buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
						buttonsSpanRem=document.getElementById("EzButtonsRemarksSpan")
						buttonsMsgSpanRem=document.getElementById("EzButtonsRemarksMsgSpan")
						
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
			else
			{
				Popup.hide('modal')
				if(reqFM.status == 500)
					alert("Error");
			}
		}
	}
	function calFreightIns()
	{
		var len = document.generalForm.product.length;
		
		var freightInsObj = document.generalForm.freightIns;
		var itemWeightObj = document.generalForm.itemWeight;
		var finalPriceValObj = document.generalForm.finalPriceVal;
		var frInsValObj = document.generalForm.frInsVal;
		var fIns = 0;
		var flag = false;
		
		if(isNaN(len))
		{
			if(eval(itemWeightObj).value!="0")
			{
				fIns = (parseFloat(eval("finalPriceValObj").value)*parseFloat(eval("frInsValObj").value)).toFixed(2);
				eval(freightInsObj).value = fIns;
			}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(eval("itemWeightObj["+i+"]").value!="0")
				{
					fIns = (parseFloat(fIns)+(parseFloat(eval("finalPriceValObj["+i+"]").value)));
					flag = true;
				}
			}
			
			if(eval(flag))
			{
				fIns = (parseFloat(fIns)*parseFloat(eval("frInsValObj").value)).toFixed(2);
				eval(freightInsObj).value = fIns;
			}
		}
		eval(freightInsObj).value = "0";
	}
	function showTabN(tabToShow)
	{
		obj1=document.getElementById("div1")
		obj3=document.getElementById("theads")
		obj5=document.getElementById("div5")
		obj6=document.getElementById("div6")
		obj7=document.getElementById("buttonDiv")
		obj8=document.getElementById("showTot");
		obj9=document.getElementById("InnerBox1Tab");
		if(tabToShow=="1")
		{
			obj1.style.visibility="visible";
			obj3.style.visibility="visible";
			obj5.style.visibility="visible";
			obj6.style.visibility="hidden";
			obj7.style.visibility="hidden";
			obj8.style.visibility="visible";
			obj9.style.visibility="visible";
		}
		else if(tabToShow=="2")
		{
			obj1.style.visibility="hidden";
			obj3.style.visibility="hidden";
			obj5.style.visibility="hidden";
			obj6.style.visibility="visible";
			obj7.style.visibility="visible";
			obj8.style.visibility="hidden";
			obj9.style.visibility="hidden";
		}
	}

	var MValues 	= new Array();
	var MDate 	= new Array();
	var UserRole 	= "<%=UserRole%>";
	var total 	= "<%=cartcount%>";
	
	MValues[0] 	= "desiredQty";
	MDate[0] 	= "desiredDate";
</Script>
</Head>
<body onLoad="funSelState();" scroll=auto>
<form name="generalForm" method="post" onSubmit="return false">
<input type="hidden" name="obj123">
<input type="hidden" name="chkBrowser" value="0">
<input type="hidden" name="ProductGroup" value="<%=pGroupNumber%>">
<input type="hidden" name="backFlag" value="<%=backFlag%>">
<input type="hidden" name="frameFlg" value="<%=frameFlg%>">
<input type="hidden" name="attachflag">
<input type="hidden" name="attachString">
<input type="hidden" name="hideShipTo" value="<%=shipZip%>">
<input type="hidden" name="frInsVal" value="<%=frInsVal%>">

<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:20%; text-align:center; display:none;">
	<BR><BR><BR>
	<Table align=center>
	<Tr>
		<Td class="blankcell"><font size=2><B>Freight calculation is in process. Please wait...</B></font></Td>
	</Tr>
	</Table>
</div>
<%
	String display_header = COrderFor_L+" "+agentName;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type="hidden" name="agentName" value="<%=agentName%>">

<div id="div1" align="center" style="visibility:visible;width:100%">
<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=0 >
	<Tr>
     		<th class="labelcell" align="left" width="15%" ><%=pono_L%></th>
     		<td width="15%"><input type="text" class=InputBox name="poNo" value=""></td>
        	<th class="labelcell" align="left" width="15%" colSpan=2><%=podate_L%></th>
        	<td width="25%" colSpan=2><input type="text" class=InputBox name="poDate" id="poDate" value="<%=PODate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImage("poDate")%></td>
        	<th class="labelcell" align="left" width="15%" >Required Delivery Date</th>
        	<td width="15%"><input type="text" class=InputBox name="requiredDate" id="requiredDate" value="<%=requiredDate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("requiredDate")%></td>
        	<!--<Th class="labelcell" align="left" width="10%" >Ship Type</Th>
		<Td nowrap>
		<Select name =shippingType style="width:100%; border:1px solid;" id=FullListBox>-->
			<!--<option value="">-select-</Option>-->
<%
			/*while(enumShip.hasMoreElements())
			{
				enumShipKey = (String)enumShip.nextElement();
				enumShipDesc = (String)ezShippingTypes.get(enumShipKey);
				if(shippingTypeDesc[0].equals(enumShipKey))
				{*/
%>					
					<!--<option value="<%=enumShipKey+"#"+enumShipDesc%>" selected><%=enumShipDesc%></Option>-->
<%	                        
				/*}
				else
				{*/
%>					
					<!--<option value="<%=enumShipKey+"#"+enumShipDesc%>"><%=enumShipDesc%></Option>-->
<%				
				//}
			//}
%>
			<!--<option value="SP#Special">Special</Option>
		</Select>     
		</Td>-->
	</Tr>
	<Tr>
     		<th class="labelcell"  align="left"  colspan = 4 >
     		        <%=soldto_L %> Address
			<input type="hidden" name="soldTo" value="<%=SoldTo%>">
			<input type="hidden" name="soldToName" value="<%=agentName%>">
     		</th>
     		<Th class="labelcell"  align="left" colspan = 4 cellPadding=3 cellSpacing=0 >
     		        <%=shipto_L%> Address
			<input type="hidden" name="shipTo" value="<%=ShipTo%>">
     		</Th>
	</Tr>
	<Tr>
		<Td align=right>Company:</Td>
		<td colspan=2><%=agentName%></Td>
                <Td align=right>Company*:</Td>
                <Td colspan = 2 ><input maxlength="64" class='InputBox' type="text" name="shipToName" value="<%=ShipToName%>"> </Td>
                <Td align=right>Attn.:</Td>
		<Td >
		<input type="text"  class='InputBox' name="shAttn"  maxlength="40" value=''> 
	        </Td>
	</Tr>
	<!--<Tr>
      		<Td align=right>Room/ House No:</Td>
      		<td colspan=2><%=billAddr1%></Td>
	        <Td align=right>Room/ House No*:</Td>
	        <Td  colspan=2>
	        <input type="text"  class='InputBox' name="shipToAddress1"  maxlength="10" value=''>
	        </Td>
	</Tr>
	<Tr>
      		<Td align=right>Floor:</Td>
      		<td colspan=2><%=billAddress2%></Td>
      		<Td align=right>Floor:</Td>
      		<Td  colspan=2>
      		<input type="text"  class='InputBox' name="shipToAddr2"  maxlength="10" value='<%//=shipAddress2%>'>
      		</Td>
	</Tr>
	<Tr>
      		<Td align=right>Building:</Td>
      		<td colspan=2></Td>
      		<Td align=right>Building:</Td>
      		<Td  colspan=2>
      		<input type="text"  class='InputBox' name="buildingName"  maxlength="10" value=''>
      		</Td>
	</Tr>-->
	<Tr>
      		<Td align=right>Street:</Td>
      		<td colspan=2><%=billAddr1%>
      		<input type="hidden" name="soldToAddress1" value="<%=billAddr1%>"></Td>
      		<Td align=right>Street*:</Td>
      		<Td  colspan=2>
      		<input type="text"  class='InputBox' name="streetName"  maxlength="40" value='<%=shipAddr1%>'>
      		</Td>
	        <Td align=right>Tel# 1</Td>
	        <Td >
	        <input type="text"  class='InputBox' name="telNumber"  maxlength="16" value='<%=shPhone%>'>
	        </Td>
	</Tr>
	<Tr>
      		<Td align=right>City:</Td>
      		<td colspan=2><%=billAddr2%>
      		<input type="hidden" name="soldToAddress2" value="<%=billAddr2%>"></Td>
                <Td align=right>City*:</Td>
                <Td colspan=2>
                	<input type="text"  class='InputBox' name="shipToAddress2"  maxlength="40" value='<%=shipAddr2%>'>
                </Td>
      		<Td align=right>Tel# 2</Td>
      		<Td >
      		<input type="text"  class='InputBox' name="mobileNumber"  maxlength="16" value=''>
      	        </Td>
	</Tr>
	<Tr>
      		<Td align=right>State:</Td>
      		<td colspan=2><%=billState%>
      		<input type="hidden" name="soldToState" value="<%=billState%>"></Td>
                <Td align=right>State*:</Td>
                <Td  colspan=2>
                
		<select name="shipToState" id ="ListBoxDiv1"  style="width:50%">
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
		<input type="text" id="stateId" class="inputbox" style="display:none" name="shipToState" size=25 >
                </Td>
                <Td align=right>Fax #</Td>
		<Td >
		<input type="text"  class='InputBox' name="faxNumber"  maxlength="16" value='<%=shFax%>'>
		</Td>
	</Tr>
	<Tr>
		<Td align=right>Country:</Td>
		<td colspan=2><%=billCountry%>
		<input type="hidden" name="soldToCountry" value="<%=billCountry%>"></Td>
		<Td align=right>Country:</Td>
		<Td  colspan=2>
		<select name="shipToCountry" onChange="selectState()" style="width:50%" value="<%=shipCountry%>">
<%
			Enumeration enum2S =  ezCountry.keys();
			String enum2Key=null;
			String enum2Desc=null;

			while(enum2S.hasMoreElements())
			{
				enum2Key = (String)enum2S.nextElement();
				enum2Desc = (String)ezCountry.get(enum2Key);
				if(enum2Key.equals(shipCountry))
				{
%>
					<option value="<%=enum2Key%>" selected><%=enum2Desc%></Option>
<%	                        
				}
				else
				{
%>					
					<option value="<%=enum2Key%>"><%=enum2Desc%></Option>
<%		 			
				}
			}
%>
		</select>
		</td>
                <Td align=right>Freight Type</Td>
		<Td>
		<select name="fServType" id ="ListBoxDiv1" style="width:100%" onChange="calFreight('FTYPE')">
		<option value="">--Select--</option>
		<option value="SP">Special</Option>
<%
		for(int i=0;i<stCnt;i++)
		{
			String stId = stRet.getFieldValueString(i,"EFS_STYPE_CODE");
			String desc = stRet.getFieldValueString(i,"EFS_STYPE_DESC");
%>
			<option value="<%=stId%>"><%=desc%></option>		
<%
		}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right>Postal Code:</Td>
		<td colspan=2 >
			<%=billZip%>
			<input type="hidden" name="soldToZipcode" value="<%=billZip%>">
			<input type="hidden" name="billTPZone" value="<%=billTPZone%>">
			<input type="hidden" name="billJurCode" value="<%=billJurCode%>">
		</Td>
		<Td align=right>Postal Code*:</Td>
		<Td colspan=4>
			<input type="text" class='InputBox' size = '10' name="shipToZipcode"  maxlength="10"  value='<%=shipZip%>'>
		</Td>
	</Tr>
	<Tr>
		<Th colspan=8 style="text-align:left;width:100%">Special Shipping Instructions (for Freight Type - Special Only)</Th>
	</Tr>
	<Tr>
		<Td colspan=8 width="100%">
		<textarea name="specialShIns" style="width:100%" rows="3" cols="*"></textarea>
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
</Table>
</div>

<Div id='theads'>
<Table width="95%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<Tr>
	<th width="10%" valign="top" nowrap>Product</th>
        <th width="28%" valign="top" nowrap>Description</th>
        <th width="10%" valign="top" >Manufacturer</th>
        <th width="10%" valign="top" >List Price</th>
	<!--<th width="4%"  valign="top"><%=uom_L%></th>-->
	<th width="10%" valign="top"><%=qty_L%></th>
	<th width="10%" valign="top">Discount Price [<%=Currency%>]</th>
	<Th width="10%" valign="top">Total Price [<%=Currency%>]</Th>
	<Th width="12%" valign="top"><%=delSchedue_L%></Th>
</Tr>
</Table>
</div>
<!--<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>-->
<Table width='95%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
	//log4j.log("prices_prices_prices_prices_prices_:confirm:"+itemoutTable.toEzcString(),"W");
	String[] prodUnitQty = new String[cartcount];
	Hashtable selectdMet = (Hashtable)session.getAttribute("SELECTEDMET");
	
	java.math.BigDecimal totWeight = new java.math.BigDecimal("0");
	
	String noFreight = "";
	
	log4j.log("selectdMet::::::::"+selectdMet,"W");
	//itemoutTable.toEzcString(); 
	
	if(cartcount>0)
	{
		java.util.Hashtable itemQtys = (java.util.Hashtable)session.getValue("itemQtys");
		java.util.Hashtable itemCatalogs = (java.util.Hashtable)session.getValue("itemcatalog");
		log4j.log("itemCatalogs::::::::"+itemCatalogs,"W");
                 
    		for(int i=0;i<cartcount;i++)
    		{
   			
   			if(selectdMet!=null)
   			{
      				//String metGroup=(String)selectdMet.get(itemoutTable.getFieldValueString(i,"Material"));
      				String metGroup=(String)selectdMet.get(itemoutTable.getFieldValueString(i,"MatEntrd"));
      				
      				String custMat =itemoutTable.getFieldValueString(i,"CustMat");
      				
      				if(custMat!=null && !"null".equals(custMat) && !"".equals(custMat.trim()))
      				metGroup = custMat;
      				log4j.log("metGroup::::::::"+metGroup,"W");
   				java.util.StringTokenizer   stoken=new java.util.StringTokenizer(metGroup,"¥");
   				
				try
				{
					metGroup=(String)stoken.nextElement();
   					prodUnitQty[i]=(String)stoken.nextElement();
				}
				catch(Exception e)
				{
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
			String atpEanUPC    = itemoutTable.getFieldValueString(i,"EanUPC");	
			
			String itemVenCatalog 	= "";
			String tempItemStr	= "";
			String itemBrand	= "";
			String itemListPrice	= "";
			String atpDispStr  	= "";
			String atpStatus   	= "";
			String atpQty      	= "";
			String atpLeadTime 	= "";
			String atpLinkStatus 	= "";
			
			String itemMfrPart 	= "";
			String itemMfrNr   	= "";
			String itemEanUPC  	= "";
			String itemMmFlag  	= "";
			String itemDiscCode 	= "";
			String itemMfrCode  	= "";
			String itemMfrPartNo	= "";
			String itemWeight 	= "";
			String itemOrgPrice 	= "";
			String itemCnetProd	= "";
			
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
			//out.println(custMatFlg+"***"+tempItemStr);
			while(itemSt.hasMoreTokens())
			{
				try
				{
					itemVenCatalog	 = itemSt.nextToken();
					itemBrand	 = itemSt.nextToken();
					itemListPrice    = itemSt.nextToken();
					itemMfrPart      = itemSt.nextToken();
					itemEanUPC       = itemSt.nextToken();
					itemMmFlag	 = itemSt.nextToken();
					itemDiscCode	 = itemSt.nextToken();
					itemMfrCode	 = itemSt.nextToken();
					itemMfrPartNo	 = itemSt.nextToken();
					itemWeight	 = itemSt.nextToken();
					itemOrgPrice	 = itemSt.nextToken();
					itemCnetProd	 = itemSt.nextToken();
					itemMfrNr        = itemBrand;

					//if(custMatFlg){
						//subTot = String.valueOf(Double.parseDouble( prodQty ) * Double.parseDouble( itemListPrice ));
						subTot = ((new java.math.BigDecimal(prodQty)).multiply(new java.math.BigDecimal(itemListPrice))).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						//out.println(subTot + "**" + prodQty + "**" + itemListPrice);
					//}
				}
				catch(Exception e){ }
			}

			if(itemDiscCode!=null && "N/A".equals(itemDiscCode)) itemDiscCode = "";
			if(itemMfrCode!=null && "N/A".equals(itemMfrCode)) itemMfrCode = "";
			if(itemMfrPartNo!=null && "N/A".equals(itemMfrPartNo)) itemMfrPartNo = "";
			if(itemEanUPC!=null && "N/A".equals(itemEanUPC)) itemEanUPC = "";
			if(itemWeight!=null && "N/A".equals(itemWeight)) itemWeight = "0";
			
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
        		
        		
        		try
        		{
        			a=Integer.parseInt(prodCode)+"-->"+prodDesc;
        		}
        		catch(Exception e)
        		{
        			a=prodCode +"--->"+prodDesc;
        		}
        		
        		try
        		{
        		   	tqty=tqty.substring(0,tqty.indexOf('.'));
           		}
           		catch(Exception e){}
           		
           		if("0".equals(itemWeight))
           		{
           			noFreight = "TBD";	//if weight is zero for atleast one item then freight must be TBD
           		}
           		
           		java.math.BigDecimal itemWeight_bd = null;
           		
			try
			{
				itemWeight_bd = new java.math.BigDecimal(itemWeight);
				
				itemWeight_bd = itemWeight_bd.multiply(new java.math.BigDecimal(tqty));
				totWeight = totWeight.add(itemWeight_bd);
			}
			catch(Exception e){}

			java.math.BigDecimal bUprice = new java.math.BigDecimal(pric);
			bUprice = bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
			java.math.BigDecimal bPrice = null;
			java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());
			bPrice = bQty.multiply(bUprice);
			grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
			String priceCurr = bUprice.doubleValue()+"";
			//String valueCurr = bPrice.doubleValue()+"";
			String valueCurr = bPrice.setScale(2,java.math.BigDecimal.ROUND_UP)+"";
			boolean prflg = false;
			java.math.BigDecimal bUpricetemp = null;
			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_UP).doubleValue()==0 || "0.00".equals(priceCurr.trim()) )
			{
				bUpricetemp = new java.math.BigDecimal(Double.parseDouble(subTot)/Double.parseDouble(prodQty));
				prflg = true;
				priceCurr = bUpricetemp.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";
			}
			
			String tPNo= "";
			String prodNoUD ="";
			
			if(custprodCode!=null && !"null".equals(custprodCode) && !"".equals(custprodCode.trim()))
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

		String tdColor="";
		if(i%2==0)
		{
			colTone = "class='tx1'";
			tdColor="style='background-color:#EFEFEF'";
		}	
			
			
%>
		<Tr>
			<Td width="10%" align="left" title="<%=a%>" <%=tdColor%>><%=tPNo%></Td> 
			<Td width="28%" align="left" title="<%=a%>" <%=tdColor%>>
				&nbsp;<input type="text" name="prodDesc" size="50" <%=colTone%>  readonly value="<%=prodDesc%>">
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
				<input type="hidden" name="itemMmFlag" value="<%=itemMmFlag%>">
				<input type="hidden" name="itemDiscCode" value="<%=itemDiscCode%>">
				<input type="hidden" name="itemMfrCode" value="<%=itemMfrCode%>">
				<input type="hidden" name="itemWeight" value="<%=itemWeight%>">
				<input type="hidden" name="itemTotWeight" value="<%=itemWeight_bd%>">
				<input type="hidden" name="itemPromoCode" value="">
				<input type="hidden" name="itemCnetProd" value="<%=itemCnetProd%>">

				<input type="hidden" name="vendCatalog" value="<%=itemVenCatalog%>">
<%
				if(prflg)
				{
%>
					<input type="hidden" name="desiredPrice"  value="<%=bUpricetemp.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
<%
				}
				else
				{
%>
					<input type="hidden" name="desiredPrice"  value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
<%
				}
%>
				<input type="hidden" name="itemListPrice" value="<%=itemListPrice%>">
				<input type="hidden" name="desiredQty" value="<%=prodQty%>">
				<input type="hidden" name="prodQty" value="<%=prodQty %>">
				<input type="hidden" name="commitedQty" value="<%=commitedQty%>">
				<input type="hidden" name="desiredDate" value="<%=requiredDate%>">
				<input type="hidden" name="pack" value="<%=prodUom%>">
				<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
				<input type="hidden" name="UomQty" value="<%=prodUnitQty[i]%>">
				<input type="hidden" name="plant" value="<%=plant%>">
				<input type="hidden" name="itemOrgPrice" value="<%=itemOrgPrice%>">
			</Td>
			<Td width="10%" align="center" <%=tdColor%>>&nbsp;<%=itemBrand%></Td>
			<Td width="10%" align="right" <%=tdColor%>>&nbsp;<%="$"+itemOrgPrice%></Td> 
			
			<!--<Td width="4%" align="center" <%=colTone%>>&nbsp;<%=prodUom%></Td>-->
			<Td width="10%" align="right" <%=tdColor%>><input type="hidden" name="del_sch_qty" value="<%=commitedQty%>"><%=tqty%>
				<input type="hidden"  name="focVal" >
			</Td>
			<Td width="10%" align="right" <%=tdColor%>>
<% 			
			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_UP).doubleValue()==0 || "0.00".equals(priceCurr.trim()) )
	   		{
	   			//out.println("&nbsp;"+bUpricetemp.setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
%>	   		
	   			<input type="text" name="finalPrice" <%=colTone%> size="10" readonly value="<%=bUpricetemp.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()%>" style="text-align:right">
	   			<input type="hidden" name="hideFinalPrice" value="<%=bUpricetemp.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString()%>">
<%
			}
			else
			{
				//out.println(priceCurr);
%>
				<input type="text" name="finalPrice" <%=colTone%> size="10" readonly value="<%=priceCurr%>" style="text-align:right">
				<input type="hidden" name="hideFinalPrice" value="<%=priceCurr%>">
<%
	   		}
%>			
			</Td>
			<Td width="10%" align="right" <%=tdColor%>>
<% 			
			if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
			{
				//out.println("&nbsp;");
%>
				<input type="text" name="finalPriceVal" <%=colTone%> size="10" readonly value="0" style="text-align:right">
				<input type="hidden" name="hideFinalPriceVal" value="0">
<%
			}
			else
			{
				//out.println(valueCurr);
%>
				<input type="text" name="finalPriceVal" <%=colTone%> size="10" readonly value="<%=valueCurr%>" style="text-align:right">
				<input type="hidden" name="hideFinalPriceVal" value="<%=valueCurr%>">
<%
			}
%>
			</Td>

<%
		if(!"TANN".equals(ItemCat))
		{
%>
		<Td width="12%" align="center"  id="DesiredDate[<%=i%>]" <%=tdColor%>>
			<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
				<a name="DD_<%= i %>"  id="DD_<%= i %>" href="JavaScript:void(0)" onClick='openNewWindow("ezAddDatesEntry.jsp?ind=<%= i %>&unitQty=<%=prodUQ%>","<%=i%>")'>
<%				
				if(i==0)
				{
%>
					<span id="selectG" style="display:''"><%=requiredDate%></span>
<%
				}
				else
				{
%>
					<%=requiredDate%>
<%
				}
%>
				</a>
		</td>
<%
		}
		else
		{
%>
			<Td width="12%" align="center"  id="DesiredDate[<%=i%>]" <%=tdColor%>>
			<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
			Bonus
			</td>
<%
		}
%>
		</Tr>
<%  
				colTone = "class='tx'";
		}
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
	
	String packType = "PACK";
	
	try
	{
		int pt = totWeight.compareTo(new java.math.BigDecimal("0.5"));
		
		if(pt==-1 || pt==0)
			packType = "ENV";
	}
	catch(Exception ex){}
	
	java.math.BigDecimal grandTotal_bd = new java.math.BigDecimal(grandTotal.toString());
	grandTotal_bd = grandTotal_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
%>
</Table>
<!--</Div>-->

<Div id="showTot" style="visibility:visible">
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="98%">
	<Tr>
		<Td width=64% class=blankcell>&nbsp;</Td>
		<Td width=23% class=blankcell>
		
		
		<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th width="58%" align=right>Freight</Th>
			<Td width="42%" align=right>&nbsp;<input type="text" name="freightVal" <%=colTone%> size="10" readonly value="0.00" style="text-align:right"></Td>
		</Tr>
		<Tr>
			<Th width="58%" align=right>Freight Insurance</Th>
			<Td width="42%" align=right>&nbsp;TBD<input type="hidden" name="freightIns" <%=colTone%> size="10" readonly value="0.00" style="text-align:right"></Td>
		</Tr>
		<Tr>
			<Th width="58%" align=right>Taxes</Th>
			<Td width="42%" align=right>&nbsp;<input type="text" name="taxes" <%=colTone%> size="10" readonly value="TBD" style="text-align:right">
			<input type="hidden" name="noFreight" value="<%=noFreight%>">
			</Td>
		</Tr>
		<Tr>
			<Th width="58%" align=right><%=tot_L%></Th>
			<Td width="42%" align=right>&nbsp;<input type="text" name="grandTotalVal" <%=colTone%> size="10" readonly value="<%=grandTotal_bd.toString()%>" style="text-align:right">
			<input type="hidden" name="hideGrandTotalVal" value="<%=grandTotal_bd.toString()%>">
			<input type="hidden" name="weight" value="<%=(totWeight.setScale(0,java.math.BigDecimal.ROUND_HALF_UP)).toString()%>">
			<input type="hidden" name="packType" value="<%=packType%>">
			</Td>
		</Tr>
		</Table>
		</td>
		<Td width=13% class=blankcell></td>
	</Tr>
	</Table>
</div>

<input type="hidden" name="total" value="<%=cartcount%>">

<div id="div5" align="center" style="overflow:auto;visibility:visible;position:absolute;width:100%">
<%
	if(cartcount>0)
	{
%>
	<Table align=center width=95% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th width=15%>Promotional Code</Th>
		<Td width=12%><input type="text" class="InputBox" size="20" name="promoCode" maxlength="20" value="">
		<input type="hidden" name="hidePromoCode" value="">
		</Td>
		<Td width=10%>
		<span id="applySpan">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Apply");
		buttonMethod.add("applyPromoCode()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</span>
		<span id="removeSpan" style="display:none">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Remove");
		buttonMethod.add("removePromoCode()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>		
		</span>
		</Td>
		<Td width=63% class=blankcell>&nbsp;</Td>
	</Tr>
<%
		if("CU".equals(UserRole.toUpperCase()))
		{
%>
		<Tr>
			<Th width=15%>Forward to Email<br>(sent while save only)</Th>
			<Td width=22% colSpan=2><input type="text" class="InputBox" size="40" name="saveEmail" value=""></Td>
			<Td width=63% class=blankcell>&nbsp;</Td>
		</Tr>
<%
		}
%>
	</Table>
<%
	}
%>
	<BR>
	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
	<Th align="left" width=60%>
		<Table width=100%><Tr><Th align=left>
		<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white"><B>Attach PO</B></Font></a>
		</Th><Th align=right>
		<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B></Font></a>
		</Th></Tr></Table>
	</Th>
	</Tr>
	<Tr>
	<Td align="center" width=60% class='blankcell' >
		<select name="attachs" style="width:100%" size=5 ondblclick="funOpenFile()">
		</select>
	</Td>
	</Tr>
	</Table>

<Table align=center>
<Tr>
	<Td align="center" class="blankcell"><font color="blue">Taxes extra as applicable</font></Td>
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
		
		if("CU".equals(UserRole.toUpperCase()))
		{
			if("Y".equals(isSubUser))
			{
				if("VSAVE".equals(suAuth))
				{
					buttonName.add("Save Order");
					buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");
				
				}
				if("VEDIT".equals(suAuth))
				{
					buttonName.add("Save Order");
					buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");

					buttonName.add("Submit Order");
					buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");
				}
			}
			else
			{

				buttonName.add("Save Order");
				buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"NEW\")");

				buttonName.add("Submit Order");
				buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");
			}
		}
		else
		{
			buttonName.add("Submit Order");
			buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");
		
		}

		buttonName.add("Remarks");
		buttonMethod.add("showTabN(\"2\")");
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
		
		//buttonName.add("Submit Order");
		//buttonMethod.add("formSubmit(\"ezAddSaveSales.jsp\",\"TRANSFERED\")");

		buttonName.add("Back");
		buttonMethod.add("showTabN(\"1\")");

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
</form>
<Div id="MenuSol"></Div>
</body>
</html>
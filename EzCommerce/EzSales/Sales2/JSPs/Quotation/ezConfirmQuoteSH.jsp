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
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<%@ include file="../../../Includes/JSPs/Quotation/iPaymentTerms.jsp" %>
<%@ page import="ezc.fedex.freight.params.*"%>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	Double grandTotal =new Double("0");
	String colTone = "class='tx'";
	ReturnObjFromRetrieve itemoutTable=(ReturnObjFromRetrieve)session.getValue("ITEMSOUT");
	int cartcount=itemoutTable.getRowCount();
	String from = request.getParameter("from");
	EzCurrencyFormat myFormat = new EzCurrencyFormat();

        ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos((String)session.getValue("AgentCode"));
	ReturnObjFromRetrieve  listBillTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos((String)session.getValue("AgentCode"));
	
	//out.println("listShipTos_ent:::::::::::"+listShipTos_ent.toEzcString());
	//out.println("listBillTos_ent:::::::::::"+listBillTos_ent.toEzcString());

	String Agent		= request.getParameter("agent");
	String SoldTo		= request.getParameter("soldTo");
	String ShipTo		= request.getParameter("shipTo");

	String PODate 		= FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	String requiredDate 	= FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	String OrderDate 	= request.getParameter("orderDate");
	String Currency 	= request.getParameter("currency");
	String UserRole		= (String)session.getValue("UserRole");
	UserRole.trim();
	String formatkey	= (String)session.getValue("formatKey");
	String pGroupNumber 	= request.getParameter("ProductGroup");
	
	String shippingTypeVal  = request.getParameter("shippingTypeVal");
	
	String cartItems  = request.getParameter("cartItems"); 
	
	String[] shippingTypeDesc	= new String[2];
	String shippingType 		= request.getParameter("shippingType");
		
	if("null".equals(shippingType)||shippingType==null ||"".equals(shippingType)|| shippingType=="")
	{
		shippingTypeDesc[0]="02";
		shippingTypeDesc[1]="Mail";
	}
	else
	{ 
		shippingTypeDesc	= shippingType.split("#"); 	
	}

	Enumeration enumShip =  ezShippingTypes.keys();
	String enumShipKey=null;
	String enumShipDesc=null;
	
	int rowId = -1;
	if(listShipTos_ent!=null && listShipTos_ent.getRowCount()>0)
	{
		rowId = listShipTos_ent.getRowId("EC_PARTNER_NO",ShipTo);

	}
	
	String ShipToName = listShipTos_ent.getFieldValueString(rowId,"ECA_NAME");
	
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
	
	String agentName  = listBillTos_ent.getFieldValueString(0,"ECA_NAME");
	
	String billAddr1  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_1");
	String billAddress2  	= listBillTos_ent.getFieldValueString(0,"ECA_ADDR_2");
	String billAddr2  	= listBillTos_ent.getFieldValueString(0,"ECA_CITY");
	String billState  	= listBillTos_ent.getFieldValueString(0,"ECA_STATE");
	String billCountry  	= listBillTos_ent.getFieldValueString(0,"ECA_COUNTRY");
	String billZip    	= listBillTos_ent.getFieldValueString(0,"ECA_PIN");
	
	//out.println( listBillTos_ent.toEzcString());
	String billTPZone	  = listBillTos_ent.getFieldValueString(0,"ECA_TRANSORT_ZONE");
	String billJurCode	  = listBillTos_ent.getFieldValueString(0,"ECA_JURISDICTION_CODE");

	if(billTPZone!=null)
	billTPZone = billTPZone.trim();

	if(billJurCode!=null)
	billJurCode = billJurCode.trim();

	billAddr1 	= (billAddr1==null || "null".equals(billAddr1))?"":billAddr1;
	billAddress2 	= (billAddress2==null || "null".equals(billAddress2))?"":billAddress2;//for address2
	billAddr2 	= (billAddr2==null || "null".equals(billAddr2))?"":billAddr2;//for city
	billState	= (billState==null || "null".equals(billState))?"":billState;
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
	
	/*try{
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
	String plantT ="";
	
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

		plantT              = myObj.getFieldValueString(i,"PLANT");
		status              = myObj.getFieldValueString(i,"STATUS");
		availableQty        = myObj.getFieldValueString(i,"AVAIL_QTY");
		String availDateStr = myObj.getFieldValueString(i,"ENDLEADTME");
		Date availDate      = (Date)myObj.getFieldValue(i,"ENDLEADTME");
		
		if(plantT!=null)
		plantT = plantT.trim();
		
		if(atpMat.contains(matIdTemp))
			linkStr="Y";
		else
			atpMat.addElement(matIdTemp);
		
					
		if("A".equals(status))
		{
			if("BP01".equals(plantT)) {
				if(atpMatQty.containsKey(matIdTemp)){
					cumQty =(String)atpMatQty.get(matIdTemp);

					try{
						//availableQty = (Double.parseDouble(availableQty)+Double.parseDouble(cumQty))+"";
						availableQty = (new java.math.BigDecimal(availableQty).add(new java.math.BigDecimal(cumQty))).toString();
						atpMatQty.put(matIdTemp,availableQty); 
					}catch(Exception e){  }
				}else{
					atpMatQty.put(matIdTemp,availableQty);
				}
			}
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
	}*/
	
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
<Script src="../../Library/JavaScript/popup.js"></Script>
<Script>
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
	var today ="<%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY)%>" 
	var notesCount = new Array();
	
	var retSign='N'

	function validateAddress()
	{
		/*if(document.generalForm.poNo.value=="")
		{
			alert("Please enter PO number");
			document.generalForm.poNo.focus();
			return false;
		}
		if(document.generalForm.validFrom.value=="")
		{
			alert("Please select valid from date");
			document.generalForm.validFrom.focus();
			return false;
		}
		if(document.generalForm.validTo.value=="")
		{
			alert("Please valid to date");
			document.generalForm.validTo.focus();
			return false;
		}
		if(document.generalForm.shippingType.value=="")
		{
			alert("Please select Shipping Type");
			document.generalForm.shippingType.focus();
			return false;
		}
		if(document.generalForm.paymentTerm.value=="")
		{
			alert("Please select Payment Term");
			document.generalForm.paymentTerm.focus();
			return false;
		}*/
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
		if(document.generalForm.reasons.value=="")
		{
			alert("Please enter Comments");
			document.generalForm.reasons.focus();
			return false;
		}
		return true;
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
	function formSubmit(obj,obj2)  
	{
		if(validateAddress() && chkPrice())	//&& chkDates() 
		{
			var zipShipCode = document.generalForm.shipToZipcode.value;
			var hideShipCode = document.generalForm.hideShipTo.value;
		
			document.generalForm.status.value=obj2;
	
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
				//if(funTrim(zipShipCode)!=funTrim(hideShipCode))
				{
					//calFreight('POSTALCODE');
				}
				//else
				{
					var z=document.generalForm.status.value

					if(z=="SUBMITTED")
					{
						 y=confirm("Do you want to Submit the Quotation?");
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
	function chkPrice()
	{
		var len	= document.generalForm.product.length;
		var itemListPriceObj = document.generalForm.itemListPrice;
		//var listPriceObj = document.generalForm.listPrice;
		var listPriceObj = document.generalForm.itemOrgPrice;
		
		var custVal;
		var listVal;
		
		if(!isNaN(len))
		{
			for(i=0;i<len;i++)
			{
				custVal = parseFloat(eval(itemListPriceObj[i]).value)
				listVal = parseFloat(eval(listPriceObj[i]).value)
			
				if(custVal>listVal)
				{
					alert("Entered price should not be greater than List price");
					eval(itemListPriceObj[i]).value = "";
					eval(itemListPriceObj[i]).focus();
					return false;
				}
			}
		}
		else
		{
			custVal = parseFloat(eval(itemListPriceObj).value)
			listVal = parseFloat(eval(listPriceObj).value)
		
			if(custVal>listVal)
			{
				alert("Entered price should not be greater than List price");
				eval(itemListPriceObj).value = "";
				eval(itemListPriceObj).focus();
				return false;
			}
		}
		return true;
	}
	function chkDates()
	{
		fd = document.generalForm.validFrom.value;
		td = document.generalForm.validTo.value;
		
		if(fd=="")
		{
			alert("Please Enter Valid From Date");
			return false;
		}
		if(td=="")
		{
			alert("Please Enter Valid To Date");
			return false;
		}
		
		a=fd.split("/");
		b=td.split("/");

		fd1=new Date(a[2],a[0]-1,a[1])
		td1=new Date(b[2],b[0]-1,b[1])
		
		if(fd1 > td1)
		{
			alert("Valid From date must be less than Valid To date");
			document.generalForm.validFrom.focus();
			return false;
		}
		return true;
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
	function showATPDetails(prodCode,prdDesc,vcode,matId,upc)
	{
		prodCode = prodCode.replace('#','@@@');   
		myurl ="../Sales/ezGetATPDetails.jsp?matId="+matId+"&vendCode="+vcode+"&upc="+upc+"&ProductCode="+prodCode+"&prdDesc="+prdDesc
		
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=400,width=500,status=no,toolbar=no,menubar=no,location=no")
	}
	function ezBackMain() 
	{ 
		document.body.style.cursor="wait"
		
		if("ADDDELETE"=='<%//=backFlag%>')
		{
			document.generalForm.action="ezAddSalesOrder.jsp"
			document.generalForm.submit();
		}
		else
			top.history.back()
	}
	function textCounter(field, countfield, maxlimit)
	{
		if (field.value.length > maxlimit)
		{
			alert("Comments Limit Exceeded : You can enter only "+maxlimit+" in the Comments field");
			field.value = field.value.substring(0, maxlimit);
			return false;
		}
		else
		{
			countfield.value = maxlimit - field.value.length;
		}
		return true
	}
	function verifyField(field,alertMsg)
	{
		if(isNaN(funTrim(field.value)) || funTrim(field.value)=="")
		{
			alert(alertMsg);
			field.value="";
			field.focus();
		}
		if(funTrim(document.generalForm.weight.value)!="0" && document.generalForm.fServType.value=="")
		{
			alert("Please select a Freight Type");
			document.generalForm.fServType.focus();
			return false;
		}
	}
	function mulTotValPrice(priceObj,indx)
	{
		var len	= document.generalForm.product.length;
		var netValObj = document.generalForm.NetValue;
		var reqQtyObj = document.generalForm.Reqqty;
		var listPriceObj = document.generalForm.itemListPrice;
		var totValObj = document.generalForm.TotalValue;
		var totalValue = 0;
		
		var fVal = document.generalForm.freightVal.value;
		
		if(funTrim(fVal)=='TBD') fVal = 0;

		var entPrice = priceObj.value;
		
		if(isNaN(funTrim(entPrice)) || funTrim(entPrice)=="")
		{
			entPrice = 0;
		}
		
		if(!isNaN(len))
		{
			eval(netValObj[indx]).value = (parseFloat(eval(reqQtyObj[indx]).value)*parseFloat(entPrice)).toFixed(2);

			if(isNaN(netValObj[indx].value))
				eval(netValObj[indx]).value = "";
				
			for(i=0;i<len;i++)
			{
				totalValue += (parseFloat(reqQtyObj[i].value))*(parseFloat(listPriceObj[i].value));
			}
			totValObj.value = (parseFloat(totalValue)+parseFloat(fVal)).toFixed(2);
			if(isNaN(totValObj.value)) totValObj.value = "";
		}
		else
		{
			netValObj.value = (parseFloat(reqQtyObj.value)*parseFloat(entPrice)).toFixed(2);

			if(isNaN(netValObj.value))
				netValObj.value = "";
			else
				totalValue = netValObj.value;
			
			totValObj.value = (parseFloat(totalValue)+parseFloat(fVal)).toFixed(2);
			if(isNaN(totValObj.value)) totValObj.value = "";
		}
		
		var noFreight = document.generalForm.noFreight.value;
		
		if(funTrim(noFreight)=="TBD")
		{
			document.generalForm.freightVal.value = "TBD";
			document.generalForm.freightIns.value = "TBD";
		}
		else
			calFreightIns();
		
		var fInsNew = document.generalForm.freightIns.value;
		
		if(funTrim(fInsNew)=='TBD') fInsNew = 0;

		eval(totValObj).value = (parseFloat(fInsNew)+parseFloat(eval("totValObj").value)).toFixed(2);
		if(isNaN(totValObj.value)) totValObj.value = "";
	}
	function ValidateNum(input,evt,checkType)
	{
		var keyCode = evt.which ? evt.which : evt.keyCode;
		//var lisShiftkeypressed = evt.shiftKey;
		var inputValue = input.value
		/*if(lisShiftkeypressed && parseInt(keyCode) != 9) 
		{
			return false ;
		}*/
		if(checkType == 'QUANTITY' || checkType == 'AMOUNT')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/ || keyCode==46 /*DOT*/)
			{
				    if(inputValue.indexOf(".") != -1)
				    {
				    		if(keyCode==46)
				    			return false
						var inputSub = inputValue.substring(inputValue.indexOf("."))
						var inputSubLength = inputSub.length
						if(inputSubLength <= 2)
						{
							    return true
						}
						else
						{
							    return false;
						}
				    }
				    else
						return true;
			}
		}           
		if(checkType == 'NUMERIC')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/)
			{
				    return true;
			}
		}           
		if(checkType == 'ALPHANUMERIC')
		{
			if((parseInt(keyCode)>=48 && parseInt(keyCode)<=57) || keyCode==37/*LFT ARROW*/ || keyCode==39/*RGT ARROW*/ || keyCode==8/*BCKSPC*/ || keyCode==46/*DEL*/ || keyCode==9/*TAB*/ || (parseInt(keyCode)>=65 && parseInt(keyCode)<=90) || (parseInt(keyCode)>=97 && parseInt(keyCode)<=122))
			{
				    return true;
			}
		}           
		if(checkType == 'ALPHABETS')
		{
			if(keyCode==32 /*SPACE*/ || (parseInt(keyCode)>=65 && parseInt(keyCode)<=90) || (parseInt(keyCode)>=97 && parseInt(keyCode)<=122))
			{
				    return true;
			}
		}           
		return false;
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
		
		var TotalValObj = document.generalForm.TotalValue;
		eval(TotalValObj).value = (parseFloat(eval("TotalValObj").value)-parseFloat(fTotVal)).toFixed(2);
		document.generalForm.freightVal.value = "0.00";
		document.generalForm.freightIns.value = "0.00";
		
		var noFreight = document.generalForm.noFreight.value;
		
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

					var TotalValObj = document.generalForm.TotalValue;
					eval(TotalValObj).value = (parseFloat(fTotVal)+parseFloat(eval("TotalValObj").value)).toFixed(2);
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
					if(confirm("As the postal code is changed frieght might also change\n\nDo you want to Submit the Quote?"))
					{
						document.body.style.cursor="wait";
						document.generalForm.target="_self";
						document.generalForm.action="ezAddSaveQuote.jsp";
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
		var NetValObj = document.generalForm.NetValue;
		var frInsValObj = document.generalForm.frInsVal;
		var fIns = 0;
		var flag = false;
		
		if(isNaN(len))
		{
			if(eval(itemWeightObj).value!="0")
			{
				fIns = (parseFloat(eval("NetValObj").value)*parseFloat(eval("frInsValObj").value)).toFixed(2);
				eval(freightInsObj).value = fIns;
			}
		}
		else
		{
			for(i=0;i<len;i++)
			{
				if(eval("itemWeightObj["+i+"]").value!="0")
				{
					fIns = (parseFloat(fIns)+(parseFloat(eval("NetValObj["+i+"]").value)));
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
	String display_header = "Create Quotation";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<input type="hidden" name="agentName" value="<%=agentName%>">

<div id="div1" align="center" style="visibility:visible;width:100%">
<Table width='95%' valign='top'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=0 >
     <!--<Tr>
     		<th class="labelcell" align="left" width="10%" ><%=pono_L%></th>
     		<td width="15%"><input type="text" class=InputBox name="poNo" value=""></td>
        	<th class="labelcell" align="left" width="10%" ><%=podate_L%></th>
        	<td width="15%"><input type="text" class=InputBox name="poDate" id="poDate" value="<%=PODate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImage("poDate")%></td>
        	<th class="labelcell" align="left" width="10%" >Required Delivery Date</th>
        	<td width="15%"><input type="text" class=InputBox name="requiredDate" id="requiredDate" value="<%=requiredDate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("requiredDate")%></td>
        	<Th class="labelcell" align="left" width="10%" >Ship Type</Th>
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
		<!--</Select>
		</Td>
	</Tr>
	<Tr>
        	<th class="labelcell" align="left">Valid From</th>
        	<td ><input type="text" class=InputBox name="validFrom" id="validFrom" value="" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("validFrom")%></td>
        	<th class="labelcell" align="left">Valid To</th>
        	<td ><input type="text" class=InputBox name="validTo" id="validTo" value="" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("validTo")%></td>
        	<Th class="labelcell" align="left" width="10%" colspan=2>Payment Terms</Th>
		<Td nowrap colspan=2>
		<Select name =paymentTerm style="width:100%; border:1px solid;" id=FullListBox>
			<option value="">-select-</Option>-->
<%
			/*Enumeration enumPayT = ezPaymentTerms.keys();

			String enumPayTKey = null;
			String enumPayTDesc = null;

			while(enumPayT.hasMoreElements())
			{
				enumPayTKey = (String)enumPayT.nextElement();
				enumPayTDesc = (String)ezPaymentTerms.get(enumPayTKey);*/
%>
				<!--<Option value="<%//=enumPayTKey%>"><%//=enumPayTKey%><%//=enumPayTDesc%></Option>-->
<%				
			//}
%>
		<!--</Select>
		</Td>
	</Tr>-->
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
		<input type="text"  class='InputBox' name="shipToAddr2"  maxlength="10" value='<%=shipAddress2%>'>
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
      		<td colspan=2></Td>
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
      		<td colspan=2><%=billAddr2%></Td>
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
      		<td colspan=2>
      		<%=billState%>
      		</Td>
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
		<!-- <input type="text"  class='InputBox' size='3' name="shipToState"  maxlength="3" value='<%=shipState%>'>-->
                </Td>
                <Td align=right>Fax #</Td>
		<Td >
		<input type="text"  class='InputBox' name="faxNumber"  maxlength="16" value='<%=shFax%>'>
		</Td>
	</Tr>
	<Tr>
		<Td align=right>Country:</Td>
		<td colspan=2><%=billCountry%></Td>
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
			<input type ="hidden" name="billTPZone" value="<%=billTPZone%>">
			<input type ="hidden" name="billJurCode" value="<%=billJurCode%>"> 
		</Td>
		<Td align=right>Postal Code*:</Td>
		<Td colspan=4>
			<input type="text" class='InputBox' size = '10' name="shipToZipcode"  maxlength="10"  value='<%=shipZip%>'>
		</Td>	
	</Tr>
	<input type="hidden" name="docCurrency" value="<%= Currency %>">
	<input type="hidden" name="currency" value="<%= Currency %>">
	<input type="hidden" name="disCash"  value="0">
	<input type="hidden" name="disPercentage"  value="0">
	<input type="hidden" name="agent"     value="<%=Agent%>">
	<input type="hidden" name="orderDate"  value="<%=OrderDate%>">
	<input type="hidden" name="status">
	<input type="hidden" name="shippingTypeDesc" value="<%=shippingTypeDesc%>">
	<input type="hidden" name="shippingTypeVal" value="<%=shippingTypeVal%>">
      
</Table>
</div>

<Div id='theads'>
<Table width="95%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 >
<Tr>
	<th width="10%" valign="top" nowrap>Product</th>
        <th width="22%" valign="top" nowrap>Description</th>
        <th width="10%" valign="top">Brand</th>
        <th width="10%" valign="top">List Price</th>
        <th width="10%" valign="top">Discount Price</th>
	<!--<th width="4%" valign="top"><%=uom_L%></th>-->
	<th width="7%" valign="top"><%=qty_L%></th>
	<th width="10%" valign="top"><%=price_L%> [<%=Currency%>]</th>
	<Th width="10%" valign="top">Total Price [<%=Currency%>]</Th>
	<Th width="11%" valign="top">Delivery Date</Th>
        <!--<Th width="12%" valign="top">ATP</Th>-->
</Tr>
</Table>
</div>
<!--<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:30%;left:2%'>-->
<Table width='95%' id='InnerBox1Tab'  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 >
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
			String atpEanUPC    = itemoutTable.getFieldValueString(i,"EanUPC");
			
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
			String itemMmFlag  ="";
			String itemDiscCode  ="";
			String itemMfrCode  ="";
			String itemMfrPartNo  ="";
			String itemWeight ="";
			String itemOrgPrice = "";
			
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
					itemMmFlag	 = itemSt.nextToken();
					itemDiscCode	 = itemSt.nextToken();
					itemMfrCode	 = itemSt.nextToken();
					itemMfrPartNo	 = itemSt.nextToken();
					itemWeight	 = itemSt.nextToken();
					itemOrgPrice	 = itemSt.nextToken();
					itemMfrNr        = itemBrand;

					//if(custMatFlg){
						subTot = String.valueOf(Double.parseDouble( prodQty ) * Double.parseDouble( itemListPrice ));
					//}
				}
				catch(Exception e){ }
			}
			if(itemDiscCode!=null && "N/A".equals(itemDiscCode))itemDiscCode="";
			if(itemMfrCode!=null && "N/A".equals(itemMfrCode))itemMfrCode="";
			if(itemMfrPartNo!=null && "N/A".equals(itemMfrPartNo))itemMfrPartNo="";
			if(itemEanUPC!=null && "N/A".equals(itemEanUPC))itemEanUPC="";
			if(itemWeight!=null && "N/A".equals(itemWeight))itemWeight="0";
			
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

			java.math.BigDecimal bUprice = new java.math.BigDecimal( pric );
			java.math.BigDecimal bPrice = null;
			java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());
		
			bPrice = bQty.multiply(bUprice);
			grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
			String priceCurr = bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";
			String valueCurr = myFormat.getCurrencyString(bPrice.doubleValue());
			boolean prflg = false;
			java.math.BigDecimal bUpricetemp = null;
			if(bUprice.setScale(2,java.math.BigDecimal.ROUND_UP).doubleValue()==0 || "0.00".equals(priceCurr.trim()))
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
			String tdColor = "";
			if(i%2==0)
			{
				colTone = "class='tx1'";
				tdColor="style='background-color:#EFEFEF'";
			}
%>
		<Tr>
			<Td width="10%" align="left" title="<%=a%>" <%=tdColor%>><%=tPNo%></Td> 
			<Td width="22%" align="left" title="<%=a%>" <%=tdColor%>>
				&nbsp;<input type="text" name="prodDesc" size="40" <%=colTone%> readonly value="<%=prodDesc%>">
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
				<input type="hidden" name="desiredQty" value="<%=prodQty%>">
				<input type="hidden" name="prodQty" value="<%=prodQty %>">
				<input type="hidden" name="commitedQty" value="<%=commitedQty%>">
				<input type="hidden" name="desiredDate" value="<%=requiredDate%>">
				<input type="hidden" name="pack" value="<%=prodUom%>">
				<input type="hidden" name="ItemCat" value="<%=ItemCat%>">
				<input type="hidden" name="UomQty" value="<%=prodUnitQty[i]%>">
				<input type="hidden" name="plant" value="<%=plant%>">
				<input type="hidden" name="listPrice" value="<%=itemListPrice%>">
				<input type="hidden" name="Reqqty" value="<%=tqty%>">
				<input type="hidden" name="itemOrgPrice" value="<%=itemOrgPrice%>">
			</ >
			<Td width="10%" align="center" <%=tdColor%>>&nbsp;<%=itemBrand%></Td>
			<Td width="10%" align="right" <%=tdColor%>>&nbsp;<%="$"+itemOrgPrice%></Td>
			<Td width="10%" align="right" <%=tdColor%>>&nbsp;<%="$"+itemListPrice%></Td>
			
			<!--<Td width="4%" align="center">&nbsp;<%=prodUom%></Td>-->
			<Td width="7%" align="right" <%=tdColor%>><input type="hidden" name="del_sch_qty" value="<%=commitedQty%>"><%=tqty%>
				<input type="hidden"  name="focVal" >
			</Td>
			<!--<Td width="8%" align="right">
				<input type="text" class="InputBox" size="8" name="requiredPrice" value="<%=priceCurr.trim()%>" style="text-align:right" onKeyPress="return ValidateNum(this,event,'AMOUNT')">
			</Td>-->
			<Td width="10%" align="right" <%=tdColor%>>
				<input type="text" class="InputBox" size="8" name="itemListPrice" value="<%=priceCurr.trim()%>" style="text-align:right" onBlur="verifyField(this,'Please enter valid price');mulTotValPrice(this,<%=i%>)" onKeyPress="return ValidateNum(this,event,'AMOUNT')">
			</Td>
			<Td width="10%" align="right" <%=tdColor%>>
<% 			
			if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
			{
				//out.println("&nbsp;");
%>
				<input type="text" <%=colTone%> size="8" name="NetValue" value="" style="text-align:right" readonly>
<%
			}
			else
			{
				//out.println(valueCurr);
%>
				<input type="text" <%=colTone%> size="8" name="NetValue" value="<%=valueCurr.trim()%>" style="text-align:right" readonly>
<%
			}
%>
			</Td>
<%
			if(!"TANN".equals(ItemCat))
			{
%>
				<Td width="11%" align="center"  id="DesiredDate[<%=i%>]" <%=tdColor%>>
					<input type="text" class=InputBox name="DesiredDate_<%=i%>" id="DesiredDate_<%=i%>" value="<%=requiredDate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("DesiredDate_"+i)%>
				</td>
<%
			}
			else
			{
%>
				<Td width="11%" align="center"  id="DesiredDate[<%=i%>]"  <%=tdColor%>>
					<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
					Bonus
				</td>
<%
			}
%>
			<!--<Td width="12%" align="center">-->
<%
			/*if(atpMatHt!=null)
			{

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
			{
				atpDispStr = "Special";  
			}
			else if("A".equals(atpStatus))
			{
				atpDispStr = "In stock<br>"+atpQty;        
			}
			else if("O".equals(atpStatus) && !"".equals(atpLeadTime))
			{
				atpDispStr = "Call for<br>Availability Date";                       
				//atpDispStr = "Available&nbsp;On<br>"+atpLeadTime;                       
			}
			else
			{
				atpDispStr ="Out of stock";  
			}	

			if("N".equals(atpLinkStatus))
				out.println(atpDispStr);
			else
			{
				out.println(atpDispStr);*/
%>
			<!--<a href="JavaScript:showATPDetails('<%//=atpMfrPart%>','<%//=prodDesc%>','<%//=atpMfrNr%>','<%//=atpMatId%>','<%//=atpEanUPC%>')"> ATP</a>-->
<%
			//}
%>
			<!--</Td>-->
		</Tr>
<%   		
			colTone = "class='tx'";
		}
	}
	else
	{
%>		
		<Tr>
			<Td colspan='9' align='center'>
<%			
			String msg = request.getParameter("msg");
			if(msg !=null && !"null".equals(msg) && msg.trim().length() !=0)
			 	out.println("Error:"+msg);
			else
				out.println("Prices not defined");
%>			
			</Td>
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
	<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 width="98%">
	<Tr>
		<Td width=65% class=blankcell>&nbsp;</Td>
		<Td width=23% class=blankcell>
			<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 >
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
				<Td width="42%" align=right>&nbsp;TBD
				<input type="hidden" name="noFreight" value="<%=noFreight%>">
				</Td>
			</Tr>
			<Tr>
				<Th width="58%" align=right><%=tot_L%></Th>
				<Td width="42%" align=right>&nbsp;<input type="text" <%=colTone%> size="10" name="TotalValue" value="<%=grandTotal_bd.toString()%>" style="text-align:right" readonly>
				<input type="hidden" name="weight" value="<%=(totWeight.setScale(0,java.math.BigDecimal.ROUND_HALF_UP)).toString()%>">
				<input type="hidden" name="packType" value="<%=packType%>">
				</Td>
			</Tr>
			</Table>
		</Td>
		<Td width=12% class=blankcell></Td>
	</Tr>
	</Table>
</div>

<input type="hidden" name="total" value="<%=cartcount%>">

<div id="div5" align="center" style="overflow:auto;visibility:visible;position:absolute;width:100%">

        <!--  //** comments begin **// --> 

	<Table align="center" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 >
	<Tr>
		<Th align=left ><B><Font color=white>Enter your comments here</Font></B></Th>
	</Tr>
	<Tr>	
		<Td class='blankcell' width='100%'>
			<textarea style='width:100%' rows=3 name=reasons onKeyDown="textCounter(document.generalForm.reasons,document.generalForm.remLen,2000);" onKeyUp="textCounter(document.generalForm.reasons,document.generalForm.remLen,2000);"></textarea>
			<input type=hidden name=remLen value="2000">
		</Td>
	</Tr>
	</Table>
	<!--  //** comments end **// -->

<Table align=center>
<Tr>
	<Td align="center" class="blankcell"><font color="blue">Taxes extra as applicable</font></Td>
</Tr>
<Tr>
	<Td  class="blankcell" align="center">
	<span id="EzButtonsSpan">
<%	

	if(cartcount > 0)
	{
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Submit Quotation");
		buttonMethod.add("formSubmit(\"ezAddSaveQuote.jsp\",\"SUBMITTED\")");	
		
		//buttonName.add("Remarks");
		//buttonMethod.add("showTab(\"2\")");
		
		buttonName.add("Back");
		buttonMethod.add("ezBackMain()");

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
	</Td>
</Tr>
</Table>
</div>
<input type="hidden" name="delBlock">

<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;left:2%;top:16%;height:70%;width:98%">
<Table align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=3 cellSpacing=1 width="60%">
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

<Div id="buttonDiv"  style="visibility:hidden;position:absolute;width:100%">
<Table align="center" width="70%">
<Tr>
	<Td class="blankcell" align="center"><nobr>
	<span id="EzButtonsRemarksSpan">
<%	if(cartcount > 0)
	{
	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Submit Quotation");
		buttonMethod.add("formSubmit(\"ezAddSaveQuote.jsp\",\"SUBMITTED\")");	
		
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

<input type="hidden" name="onceSubmit" value=0>
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


<%@ include file="ezCartRulesApply.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iStatesRetObj.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
<%
	String loginUserId = Session.getUserId();
	loginUserId = loginUserId.trim();
	loginUserId = loginUserId.toUpperCase();

	java.util.ArrayList uProdOrderType = new java.util.ArrayList();

	String itemSalesOrg_C = "";
	String itemDivision_C = "";
	String itemDistChnl_C = "";
	String itemOrdType_C = "";
	String itemBrand_C = "";
	String quoteSoldTo = "";

	String splitKey_S = "";
	boolean multiOrders = false;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		int cartRows = Cart.getRowCount();

		for(int h=0;h<cartRows;h++)
		{
			itemBrand_C       = Cart.getBrand(h);
			itemSalesOrg_C 	  = Cart.getSalesOrg(h);
			itemDivision_C    = Cart.getDivision(h);
			itemDistChnl_C    = Cart.getDistChnl(h);
			itemOrdType_C     = Cart.getOrdType(h);

			String itemCust_C = Cart.getMfrCode(h);

			if(!"N/A".equals(itemCust_C)) quoteSoldTo = itemCust_C;

			if(!("56".equals(itemBrand_C) || "36".equals(itemBrand_C)))
				itemBrand_C = itemDivision_C;

			splitKey_S = itemOrdType_C+"е"+itemSalesOrg_C+"е"+itemDivision_C+"е"+itemDistChnl_C+"е"+itemBrand_C;

			if(!uProdOrderType.contains(splitKey_S))
			{
				uProdOrderType.add(splitKey_S);
			}
		}
	}

	if(uProdOrderType.size()>1)
		multiOrders = true;

	String sysKey = (String)session.getValue("SalesAreaCode");

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve purOrderRetObj = null;
	focParams.setIdenKey("MISC_SELECT");

	String subQuery = "";
	if("Y".equals((String)session.getValue("REPAGENCY")))
		subQuery = "AND A.VALUE1 IN (SELECT C.VALUE1 FROM EZC_VALUE_MAPPING C WHERE C.MAP_TYPE='FDREPPURP')";

	//String query = "SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE IN ('FDPURPOSE','FDREASON')";
	String query = "SELECT A.MAP_TYPE MAP_TYPE,A.VALUE1 VALUE1,A.VALUE2 VALUE2,(SELECT VALUE2 FROM EZC_VALUE_MAPPING B WHERE MAP_TYPE='FDREASON' AND B.VALUE1=A.VALUE2) REASON_NAME FROM EZC_VALUE_MAPPING A WHERE MAP_TYPE IN ('FDPURPOSE','PURPREASON') "+subQuery+" ORDER BY VALUE1,VALUE2";

	focParams.setQuery(query);

	focParamsMisc.setLocalStore("Y");
	focParamsMisc.setObject(focParams);
	Session.prepareParams(focParamsMisc);	

	try
	{
		purOrderRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
	}
	catch(Exception e){}

	String purposeOrder = (String)session.getValue("PURP_PREP");
	if(purposeOrder==null || "null".equalsIgnoreCase(purposeOrder))
	{
		purposeOrder = request.getParameter("purposeOrder");
	}

	ReturnObjFromRetrieve approverRetObj = null;

	if(purposeOrder!=null && !"null".equalsIgnoreCase(purposeOrder) && !"".equals(purposeOrder))
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT VALUE2,EU_FIRST_NAME,EU_LAST_NAME FROM EZC_VALUE_MAPPING,EZC_USERS WHERE EU_ID=VALUE2 AND MAP_TYPE='PURPTOAPPR' AND VALUE1='"+purposeOrder+"' ORDER BY EU_FIRST_NAME";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);

		try
		{
			approverRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	String approver = (String)session.getValue("APPR_PREP");
	if(approver==null || "null".equalsIgnoreCase(approver))
	{
		approver = request.getParameter("approver");
	}

	ReturnObjFromRetrieve fdActRetObj = null;

	if(approver!=null && !"null".equalsIgnoreCase(approver) && !"".equals(approver))
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='APPRTOACCT' AND VALUE1='"+approver+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	if(fdActRetObj!=null)
	{
		String soldTo_A = "";

		for(int i=0;i<fdActRetObj.getRowCount();i++)
		{
			String tempSold_A = fdActRetObj.getFieldValueString(i,"VALUE2");
			tempSold_A = "0000000000"+tempSold_A;
			tempSold_A = tempSold_A.substring(tempSold_A.length()-10,tempSold_A.length());

			if("".equals(soldTo_A))
				soldTo_A = tempSold_A;
			else
				soldTo_A = soldTo_A+"','"+tempSold_A;
		}
		focParams.setIdenKey("MISC_SELECT");

		//query = "SELECT DISTINCT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_SYS_KEY = '"+sysKey+"' AND A.EC_PARTNER_FUNCTION IN ('AG') AND A.EC_ERP_CUST_NO IN ('"+soldTo_A+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";
		query = "SELECT DISTINCT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_PARTNER_FUNCTION IN ('AG') AND A.EC_ERP_CUST_NO IN ('"+soldTo_A+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	String reasonCode = (String)session.getValue("REASON_PREP");
	if(reasonCode==null || "null".equalsIgnoreCase(reasonCode))
	{
		reasonCode = request.getParameter("reasonCode");
	}

	String defCat1 = (String)session.getValue("DEFCAT1_PREP");
	String defCat2 = (String)session.getValue("DEFCAT2_PREP");
	String defCat3 = (String)session.getValue("DEFCAT3_PREP");

	if(defCat1==null || "null".equalsIgnoreCase(defCat1)) defCat1 = request.getParameter("defCat1");
	if(defCat2==null || "null".equalsIgnoreCase(defCat2)) defCat2 = request.getParameter("defCat2");
	if(defCat3==null || "null".equalsIgnoreCase(defCat3)) defCat3 = request.getParameter("defCat3");

	ReturnObjFromRetrieve retObjDefCat = null;
	ReturnObjFromRetrieve retObjDefCond = null;
	boolean showDefCat = false;

	if(purposeOrder!=null && !"null".equalsIgnoreCase(purposeOrder) && !"".equals(purposeOrder))
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT MAP_TYPE,VALUE1 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='DEFCOND' AND VALUE1='"+purposeOrder+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			retObjDefCond = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}

		if(retObjDefCond!=null && retObjDefCond.getRowCount()>0)
			showDefCat = true;
	}

	/*
	if(purposeOrder!=null && "Missing Parts".equals(purposeOrder))
	{
		if(reasonCode!=null && ("F07".equals(reasonCode) || "F14".equals(reasonCode))) showDefCat = true;
	}
	if(purposeOrder!=null && "Warranty Replacement".equals(purposeOrder))
	{
		if(reasonCode!=null && ("F07".equals(reasonCode) || "F13".equals(reasonCode))) showDefCat = true;
	}
	*/

	if(showDefCat)
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT MAP_TYPE,VALUE1,VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE IN ('DEFCATL1','DEFCATL2','DEFCATL3') ORDER BY MAP_TYPE,VALUE1,VALUE2";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			retObjDefCat = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	String poNumber 	= (String)session.getValue("PONUM_PREP");
	String poDate 		= (String)session.getValue("PODATE_PREP");
	String fdCode	 	= (String)session.getValue("SOLDTO_PREP");
	String shipInst 	= (String)session.getValue("SHIPINST_PREP");
	String complDlv 	= (String)session.getValue("SHIPCOMP_PREP");
	String desiredDate 	= (String)session.getValue("DESDATE_PREP");
	String selShipToCode 	= (String)session.getValue("SHIPTO_PREP");
	String explanation 	= (String)session.getValue("EXPL_PREP");

	String shipMethod	= (String)session.getValue("SHIPMETHOD_PREP");
	String carrierName 	= (String)session.getValue("CARRNAME_PREP");
	String useMyCarrier	= (String)session.getValue("CARRUSE_PREP");
	String isResidential	= (String)session.getValue("ISRESID_PREP");
	String carrierId 	= (String)session.getValue("CARRID_PREP");
	String billToName 	= (String)session.getValue("BNAME_PREP");
	String billToStreet 	= (String)session.getValue("BSTREET_PREP");
	String billToCity 	= (String)session.getValue("BCITY_PREP");
	String billToState 	= (String)session.getValue("BSTATE_PREP");
	String billToZipCode 	= (String)session.getValue("BZIPCODE_PREP");

	String fromPage		= request.getParameter("fromPage");


	if(poNumber==null || "null".equalsIgnoreCase(poNumber))
	{
		poNumber = request.getParameter("poNumber");

		if(poNumber==null || "null".equalsIgnoreCase(poNumber)) poNumber = "";
	}
	if(poDate==null || "null".equalsIgnoreCase(poDate) || "".equals(poDate))
	{
		poDate = request.getParameter("poDate");

		if(poDate==null || "null".equalsIgnoreCase(poDate) || "".equals(poDate))
			poDate = FormatDate.getStringFromDate(new Date(),"/",FormatDate.MMDDYYYY);
	}
	if(fdCode==null || "null".equalsIgnoreCase(fdCode))
	{
		fdCode = request.getParameter("selSoldTo");

		if(fdCode==null || "null".equalsIgnoreCase(fdCode)) fdCode = "";
	}
	if(explanation==null || "null".equalsIgnoreCase(explanation))
	{
		explanation = request.getParameter("explanation");

		if(explanation==null || "null".equalsIgnoreCase(explanation)) explanation = "";
	}
	ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
	//out.println("retsoldto_A::::"+retsoldto_A.toEzcString());
%>
<Script src="../../Library/Script/popup.js"></Script> 
<link rel="stylesheet" type="text/css" href="../../Library/Styles/formalize.css">
<script type="text/javascript" src="../../Library/Script/jquery.formalize.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.validate.js"></script>

<!--Stylesheets-->
<link rel="stylesheet" type="text/css" href="../../Library/Script/jquery.qtip.min-latest.css" />
<!--JavaScript - Might want to move these to the footer of the page to prevent blocking-->
<script type="text/javascript" src="../../Library/Script/jquery.qtip.min-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$('input[title]').qtip();
	});

	function selectedShipTos()
	{
		//alert()
		var selShipTo=document.generalForm.selShipToInfo.value
		//alert(selShipTo)
		shipAddr	= selShipTo.split('е')[0]
		shipStreet	= selShipTo.split('е')[1]
		shipCity	= selShipTo.split('е')[2]
		shipState	= selShipTo.split('е')[3]
		shipCountry	= selShipTo.split('е')[4]
		shipZip		= selShipTo.split('е')[5]
		shipPhNum	= selShipTo.split('е')[6]
		shipCode	= selShipTo.split('е')[7]
		accGroup	= selShipTo.split('е')[8]

		document.generalForm.shipToName.value = shipAddr
		document.generalForm.shipToStreet.value	= shipStreet
		document.generalForm.shipToCity.value = shipCity
		document.generalForm.shipToState.value = shipState	
		document.generalForm.shipToCountry.value = shipCountry
		document.generalForm.shipToZip.value = shipZip
		document.generalForm.shipToPhone.value = shipPhNum
		document.generalForm.selShipTo.value = shipCode
		document.generalForm.accGroup.value = accGroup

		if(selShipTo=='ееееееее')
		{
			document.getElementById("selShipToInfo").setCustomValidity('Please select Ship To ID');
		}
		else
		{
			document.getElementById("selShipToInfo").setCustomValidity('');
		}
	}
	function goToCart(rulesapp)
	{
		Popup.showModal('modal');

		document.generalForm.rulappl.value = rulesapp;
		document.generalForm.action="../ShoppingCart/ezViewCart.jsp";
		document.generalForm.submit();
	}
	function getPricing()
	{
		var y = validateForm();

		if(eval(y))
		{
			Popup.showModal('modal');

			var selSoldTo 	= document.generalForm.selSoldToInfo.value;

			if(selSoldTo!="")
			{
				soldAddr	= selSoldTo.split('#')[0]
				soldStreet	= selSoldTo.split('#')[1]
				soldCity	= selSoldTo.split('#')[2]
				soldState	= selSoldTo.split('#')[3]
				soldCountry	= selSoldTo.split('#')[4]
				soldZip		= selSoldTo.split('#')[5]
				soldPhNum	= selSoldTo.split('#')[6]
				soldCode	= selSoldTo.split('#')[7]

				document.generalForm.soldToName.value = soldAddr
				document.generalForm.soldToStreet.value	= soldStreet
				document.generalForm.soldToCity.value = soldCity
				document.generalForm.soldToState.value = soldState	
				document.generalForm.soldToCountry.value = soldCountry
				document.generalForm.soldToZipCode.value = soldZip
				document.generalForm.soldToPhNum.value = soldPhNum
				document.generalForm.selSoldTo.value = soldCode
			}
			else
				document.generalForm.selSoldTo.value = "0000400276";

			document.generalForm.action="../Sales/ezCreateSalesOrder.jsp";
			document.generalForm.submit();
		}
	}
	function validateForm()
	{
		var pOrd 	= document.generalForm.purposeOrder.value;
		var rCode 	= document.generalForm.reasonCode.value;
		var expl 	= document.generalForm.explanation.value;
		var poNum 	= document.generalForm.poNumber.value;
		var shName 	= document.generalForm.shipToName.value;
		var shStreet 	= document.generalForm.shipToStreet.value;
		var shCity 	= document.generalForm.shipToCity.value;
		var shState 	= document.generalForm.shipToState.value;
		var shZip 	= document.generalForm.shipToZip.value;
		var shPhone 	= document.generalForm.shipToPhone.value;
		var appr 	= document.generalForm.approver.value;
		var userId 	= document.generalForm.loginUserId.value;
		var selSoldTo 	= document.generalForm.selSoldToInfo.value;
		var sCountry	= document.generalForm.shipToCountry.value;
		if(pOrd=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Purpose of Order");
			return false;
		}
		if(rCode=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Reason Code");
			return false;
		}
		if(trim(expl)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Explanation");
			return false;
		}
		if(trim(poNum)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter PO Number");
			return false;
		}
		else
		{
			var re = new RegExp(/^[a-zA-Z0-9]*$/); /* allows alphabets and spaces */

			if(!trim(poNum).match(re))
			{
				$( "#dialog-alert" ).dialog('open').text("Special Characters and Spaces (i.e. С-С,space,С`Т, etc.) are not allowed in PO number");
				return false;
			}
		}
		if(appr==userId)
		{
			if(selSoldTo=="")
			{
				$( "#dialog-alert" ).dialog('open').text("Please select FD Expense Account");
				return false;
			}
			if(document.generalForm.defectCat.value=="Y")
			{
				if(document.generalForm.defCat1.value=="")
				{
					$( "#dialog-alert" ).dialog('open').text("Please select Defect Category 1");
					return false;
				}
				if(document.generalForm.defCat2.value=="")
				{
					$( "#dialog-alert" ).dialog('open').text("Please select Defect Category 2");
					return false;
				}
				if(document.generalForm.defCat3.value=="")
				{
					$( "#dialog-alert" ).dialog('open').text("Please select Defect Category 3");
					return false;
				}
			}
		}
		if(trim(shName)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Name");
			return false;
		}
		if(trim(shStreet)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Street");
			return false;
		}
		if(trim(shCity)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Ship to City");
			return false;
		}
		if(shState=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Ship to State");
			return false;
		}
		if(trim(shZip)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Zip");
			return false;
		}
		else if(!(trim(shZip).length==5 || trim(shZip).length==10))
		{
			$( "#dialog-alert" ).dialog('open').text("Zip code should be 5 or 10 digits");
			return false;
		}
		if(trim(shPhone)=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please enter Ship to Phone");
			return false;
		}
		if(sCountry=="")
		{
			$( "#dialog-alert" ).dialog('open').text("Please select Ship to Country");
			return false;
		}
		return true;
	}
	function openSearch()
	{
		window.open("ezSearchShipToPOP.jsp",'name','height=475,width=800,left=200,top=100,location=no,resizable=no,scrollbars=no,toolbar=no,status=yes,z-lock=yes');
	}
	/*
	function selDefCat()
	{
		var pOrd = document.generalForm.purposeOrder.value;
		var rCode = document.generalForm.reasonCode.value;
		var y = false;

		if(pOrd=='Missing Parts' && (rCode=='F07' || rCode=='F14')) y = true;
		else if(pOrd=='Warranty Replacement' && (rCode=='F07' || rCode=='F13')) y = true;

		if(eval(y))
		{
			document.getElementById("divDefCat").style.display="block";
			selDefCatLevels("","defCat1");
		}
		else
			document.getElementById("divDefCat").style.display="none";
	}
	*/
	function selShipMethod()
	{
		var flag = document.generalForm.shipMethod.value;

		if(flag=='STD'){
			document.getElementById("divBillTo").style.display="none";
			document.getElementById("divuseyourcarrier").style.display="none";
			//document.generalForm.billToState.value="";
		}
		else
		{
			document.getElementById("divuseyourcarrier").style.display="block";

			var useCarr = document.generalForm.useMyCarrier.value;

			if(useCarr=='YES')
			{
				document.getElementById("divBillTo").style.display="block";
			}
		}
		selUseMyCarrier();
	}
	function selUseMyCarrier()
	{
		var flag = document.generalForm.useMyCarrier.value;
		var flag1 = document.generalForm.shipMethod.value;

		if(flag=='NO' || flag1=='STD')
		{
			document.getElementById("divBillTo").style.display="none";
			//document.generalForm.billToState.value="";
			document.getElementById("carrierId").setCustomValidity('');
			document.getElementById("billToName").setCustomValidity('');
			document.getElementById("billToStreet").setCustomValidity('');
			document.getElementById("billToCity").setCustomValidity('');
			document.getElementById("billToState").setCustomValidity('');
			document.getElementById("billToZipCode").setCustomValidity('');
		}
		else if(flag=='YES' && flag1!='STD')
		{
			document.getElementById("divBillTo").style.display="block";
			if(document.generalForm.carrierId.value=='')
				document.getElementById("carrierId").setCustomValidity('Please enter Carrier ID');
			else
				document.getElementById("carrierId").setCustomValidity('');
			if(document.generalForm.billToName.value=='')
				document.getElementById("billToName").setCustomValidity('Please enter Bill To Name');
			else
				document.getElementById("billToName").setCustomValidity('');
			if(document.generalForm.billToStreet.value=='')
				document.getElementById("billToStreet").setCustomValidity('Please enter Bill To Street');
			else
				document.getElementById("billToStreet").setCustomValidity('');
			if(document.generalForm.billToCity.value=='')
				document.getElementById("billToCity").setCustomValidity('Please enter Bill To City');
			else
				document.getElementById("billToCity").setCustomValidity('');
			if(document.generalForm.billToState.value=='')
				document.getElementById("billToState").setCustomValidity('Please enter Bill To State');
			else
				document.getElementById("billToState").setCustomValidity('');
			if(document.generalForm.billToZipCode.value=='')
				document.getElementById("billToZipCode").setCustomValidity('Please enter Bill To Zipcode');
			else
				document.getElementById("billToZipCode").setCustomValidity('');
		}
	}
</script>
<script language="javascript" type="text/javascript">

	var xmlHttp

	function selPurOrder()
	{
		var pOrd = document.generalForm.purposeOrder.value;

		if(pOrd!="")
		{
			Popup.showModal('modal');

			if(typeof XMLHttpRequest != "undefined")
			{
				xmlHttp = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if(xmlHttp==null)
			{
				Popup.hide('modal');
				alert("Browser does not support XMLHTTP Request")
				return;
			}

			if(xmlHttp!=null)
			{
				var url = "ezGetFOCApprover.jsp?purposeOrder="+pOrd;
				xmlHttp.onreadystatechange = process;
				xmlHttp.open("GET", url, true);
				xmlHttp.send(null);
			}
			else
				Popup.hide('modal');
		}
		else
		{
			document.getElementById("approver").innerHTML="";
			document.getElementById("reasonCode").innerHTML="";
		}
	}
	function process()
	{
		if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		{
			Popup.hide('modal');

			var resText = xmlHttp.responseText;
			document.getElementById("approver").innerHTML=unescape(resText.split("ееее")[0]);
			document.getElementById("reasonCode").innerHTML=unescape(resText.split("ееее")[1]);
			selDefCat();
		}
	}

	function selApprover()
	{
		var appr = document.generalForm.approver.value;
		var userId = document.generalForm.loginUserId.value;

		if(appr!="")
		{
			Popup.showModal('modal');

			if(typeof XMLHttpRequest != "undefined")
			{
				xmlHttp = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if(xmlHttp==null)
			{
				Popup.hide('modal');
				alert("Browser does not support XMLHTTP Request")
				return;
			}

			if(xmlHttp!=null)
			{
				if(appr==userId)
				{
					document.generalForm.focApprover.value="Y";
					document.getElementById("selSoldToInfo").setCustomValidity('Please select FD Expense Account');

					if(document.generalForm.defectCat.value=="Y")
					{
						document.getElementById("defCat1").setCustomValidity('Please select Defect Category 1');
						document.getElementById("defCat2").setCustomValidity('Please select Defect Category 2');
						document.getElementById("defCat3").setCustomValidity('Please select Defect Category 3');
					}
					else
					{
						document.getElementById("defCat1").setCustomValidity('');
						document.getElementById("defCat2").setCustomValidity('');
						document.getElementById("defCat3").setCustomValidity('');
					}

					var url = "ezGetFOCAccount.jsp?approver="+appr;
					xmlHttp.onreadystatechange = process1;
					xmlHttp.open("GET", url, true);
					xmlHttp.send(null);
				}
				else
				{
					Popup.hide('modal');
					document.generalForm.focApprover.value="N";
					document.getElementById("selSoldToInfo").setCustomValidity('');
					document.getElementById("defCat1").setCustomValidity('');
					document.getElementById("defCat2").setCustomValidity('');
					document.getElementById("defCat3").setCustomValidity('');
				}
			}
			else
				Popup.hide('modal');
		}
		else
		{
			document.getElementById("selSoldToInfo").innerHTML="";
			document.getElementById("defCat1").setCustomValidity('');
			document.getElementById("defCat2").setCustomValidity('');
			document.getElementById("defCat3").setCustomValidity('');
		}
	}
	function process1()
	{
		if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		{
			Popup.hide('modal');
			document.getElementById("divFdCode").style.display="block";
			document.getElementById("selSoldToInfo").innerHTML=xmlHttp.responseText
		}
	}
	function selectSoldTo()
	{
		var selSoldTo = document.generalForm.selSoldToInfo.value;
		var appr = document.generalForm.approver.value;
		var userId = document.generalForm.loginUserId.value;

		if(selSoldTo!="")
		{
			document.getElementById("selSoldToInfo").setCustomValidity('');
		}
		else
		{
			if(appr==userId)
				document.getElementById("selSoldToInfo").setCustomValidity('Please select FD Expense Account');
			else
				document.getElementById("selSoldToInfo").setCustomValidity('');
		}
	}
	function selDefCatL1()
	{
		var defCat1 = document.generalForm.defCat1.value;

		if(defCat1!="")
		{
			document.getElementById("defCat1").setCustomValidity('');
			selDefCatLevels(defCat1,"defCat2");
		}
		else
			document.getElementById("defCat1").setCustomValidity('Please select Defect Category 1');
	}
	function selDefCatL2()
	{
		var defCat2 = document.generalForm.defCat2.value;

		if(defCat2!="")
		{
			document.getElementById("defCat2").setCustomValidity('');
			selDefCatLevels(defCat2,"defCat3");
		}
		else
			document.getElementById("defCat2").setCustomValidity('Please select Defect Category 2');
	}
	function selDefCatL3()
	{
		var defCat3 = document.generalForm.defCat3.value;

		if(defCat3!="")
			document.getElementById("defCat3").setCustomValidity('');
		else
			document.getElementById("defCat3").setCustomValidity('Please select Defect Category 3');
	}
	var defCat;
	var defFlag;
	function selDefCatLevels(val1,val2)
	{
		defCat = val1;
		defFlag = val2;

		Popup.showModal('modal');

		if(typeof XMLHttpRequest != "undefined")
		{
			xmlHttp = new XMLHttpRequest();
		}
		else if(window.ActiveXObject)
		{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlHttp==null)
		{
			Popup.hide('modal');
			alert("Browser does not support XMLHTTP Request")
			return;
		}

		if(xmlHttp!=null)
		{
			var url = "ezGetDefCategories.jsp?defCat="+defCat+"&defFlag="+defFlag;
			xmlHttp.onreadystatechange = process2;
			xmlHttp.open("GET", url, true);
			xmlHttp.send(null);
		}
		else
			Popup.hide('modal');
	}
	function process2()
	{
		if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		{
			Popup.hide('modal');

			if(defFlag=='defCat1')
			{
				document.getElementById("defCat1").innerHTML=xmlHttp.responseText
				document.getElementById("defCat2").innerHTML=""
				document.getElementById("defCat3").innerHTML=""
			}
			else if(defFlag=='defCat2')
			{
				document.getElementById("defCat2").innerHTML=xmlHttp.responseText
				document.getElementById("defCat3").innerHTML=""
			}
			else if(defFlag=='defCat3')
				document.getElementById("defCat3").innerHTML=xmlHttp.responseText
		}
	}
	function selDefCat()
	{
		var pOrd = document.generalForm.purposeOrder.value;

		if(pOrd!="")
		{
			Popup.showModal('modal');

			if(typeof XMLHttpRequest != "undefined")
			{
				xmlHttp = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if(xmlHttp==null)
			{
				Popup.hide('modal');
				alert("Browser does not support XMLHTTP Request")
				return;
			}

			if(xmlHttp!=null)
			{
				var url = "ezGetFOCDefCond.jsp?purposeOrder="+pOrd;
				xmlHttp.onreadystatechange = processDefCond;
				xmlHttp.open("GET", url, true);
				xmlHttp.send(null);
			}
			else
				Popup.hide('modal');
		}
		else
		{
			document.getElementById("divDefCat").style.display="none";
			document.generalForm.defectCat.value = "N";
		}
	}
	function processDefCond()
	{
		Popup.hide('modal');
		if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		{
			var resText = xmlHttp.responseText;
			var sDef = resText.split("е")[1];
			sDef = trim(sDef);

			if(sDef=="Y")
			{
				document.getElementById("divDefCat").style.display="block";
				document.generalForm.defectCat.value = "Y";
				selDefCatLevels("","defCat1");
			}
			else
			{
				document.getElementById("divDefCat").style.display="none";
				document.generalForm.defectCat.value = "N";
			}
		}
		else
		{
			document.getElementById("divDefCat").style.display="none";
			document.generalForm.defectCat.value = "N";
		}
	}
	function trim(str)
	{
		str = str.toString();
		var begin = 0;
		var end = str.length - 1;
		while (begin <= end && str.charCodeAt(begin) < 33) { ++begin; }
		while (end > begin && str.charCodeAt(end) < 33) { --end; }
		return str.substr(begin, end - begin + 1);
	}

$(function() {
 	$( "#dialog-alert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
});
</script>
<style type="text/css">
#input {
	box-shadow: inset 0px 0px 0px ; 
	-moz-box-shadow: inset 0px 0px 0px ; 
	-webkit-box-shadow: inset 0px 0px 0px ; 
	border: none; 
}

.highlight {
	height: 65px;
	width: 100%;
	background: #e9e9e9;
	background: -webkit-linear-gradient(#e9e9e9, #c0c0c0);
	background: -moz-linear-gradient(#e9e9e9, #c0c0c0);
	background: -ms-linear-gradient(#e9e9e9, #c0c0c0);
	background: -o-linear-gradient(#e9e9e9, #c0c0c0);
	background: linear-gradient(#e9e9e9, #c0c0c0);
}
</style>
<!--<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://jzaefferer.github.com/jquery-validation/jquery.validate.js"></script>-->
<script type="text/javascript">
/*$.validator.setDefaults({
	submitHandler: function() { getPricing(); }
});
$.validator.addMethod("valueNotEquals", function(value, element, arg){
	return arg != value;
}, "Value must not equal arg.");
$().ready(function() {
	// validate signup form on keyup and submit
	$("#generalForm").validate({
		rules: {
			purposeOrder: "required",
			reasonCode: "required",
			poNumber: "required",
			poDate: {
				required: true,
				date: true
			},
			approver: "required",
			selSoldToInfo: "required",
			selShipToInfo: { valueNotEquals: "ееееееее" },
			shipToName: "required",
			shipToState: "required",
			shipToStreet: "required",
			shipToCity: "required",
			shipToZip: "required",
			shipToPhone: "required"
		},
		messages: {
			purposeOrder: "<font color=red>Please select Purpose of Order</font>",
			reasonCode: "<font color=red>Please select SAP Reason Code</font>",
			poNumber: "<font color=red>Please enter PO Number</font>",
			poDate: "<font color=red>Please enter PO Date</font>",
			approver: "<font color=red>Please select Approver</font>",
			selSoldToInfo: "<font color=red>Please select FD A/c Code</font>",
			selShipToInfo: { valueNotEquals: "<font color=red>Please select Ship To ID</font>"},
			shipToName: "<font color=red>Please provide Name</font>",
			shipToState: "<font color=red>Please provide State</font>",
			shipToStreet: "<font color=red>Please provide Street</font>",
			shipToCity: "<font color=red>Please provide City</font>",
			shipToZip: "<font color=red>Please provide Zipcode</font>",
			shipToPhone: "<font color=red>Please provide Phone No</font>"
		}
	});
});*/
</script>
<script type="text/javascript">
function changeState()
{
	var statePR = document.getElementById('shipToState').value;
	var shipToCountry = document.getElementById('shipToCountry').value;
	if(statePR=='PR'){
		$('#shipToCountry').val('PR');
	}else
	{
		$('#shipToCountry').val('US');
	}
}
</script>

<form name="generalForm" id="generalForm" method="post" >
<input type=hidden name="rulappl">
<input type=hidden name="rulesCust">
<input type=hidden name="loginUserId" value="<%=loginUserId%>">
<input type=hidden name="focApprover" value="N">
<input type=hidden name="accGroup">
<input type=hidden name="defectCat" value="N">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div style="display:none;">
<div id="dialog-alert" title="Alert">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please fill out this field.</p>
</div>
</div>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
	<div class='highlight'>
		<table>
		<tbody>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>				
			<table>
				<tbody>
				<tr>
					<td>
						<font size='5' color='black'>&nbsp;&nbsp;CONFIRM HEADER INFO</font>
					</td>
				</tr>
				</tbody>
			</table>
			</td>
		</tr>
		</tbody>
		</table>
	</div>
	<br>
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back" class="button btn-black" onclick="javascript:goToCart('<%=rulesApply%>')"><span class="left-link">Back</span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply))
		{
%>
			<div class="col-2">
				<button type="button" title="Next" class="button btn-black" onclick="getPricing()"><span class="right-link">Next</span></button>
			</div>
<%		}
%>
	</div>
<%
	if("Y".equals(rulesApply))
	{
%>
	<div class="info-box">		
	<ul class="error-msg"><span>Some of the Items in the Cart are Exclusive to default Sold To. 
	Please Go to Cart and Remove the Items which are Exclusive and continue. (OR) Please select the previous Sold To to continue.</span></li></ul>			
	</div> 
<%
	}
%>
<br>
<div class="col2-set">
<div class="col-1">
<div class="info-box">
	<h2 class="legend" style="background-color:#EEEDE7">Purpose and Reason </h2>
	<ul class="form-list">
		<li style="padding-top: 10px"><label for="purposeOrder" class="required">Purpose of Order<em>*</em></label>
			<div class="input-box">
			<select id="purposeOrder" name="purposeOrder" title="Purpose Order" onChange="selPurOrder();" required>
			<option value="">------Select------</option>
<%
			for(int i=0;i<purOrderRetObj.getRowCount();i++)
			{
				String mapType = purOrderRetObj.getFieldValueString(i,"MAP_TYPE");
				if("FDPURPOSE".equals(mapType))
				{
					String purOrderVal = purOrderRetObj.getFieldValueString(i,"VALUE1").trim();

					String selected_A = "";

					if(purposeOrder!=null && purposeOrder.equals(purOrderVal))
						selected_A	= "selected";
%>
					<option value="<%=purOrderVal%>" <%=selected_A%>><%=purOrderVal%></option>
<%
				}
			}
%>
			</select>
			</div>
		</li>
		<li><label for="reasonCode" class="required">Reason Code<em>*</em></label>
			<div class="input-box" id="reasonCode">
			<select name="reasonCode" title="Reason Code" required>//onChange="selDefCat();" 
			<option value="">------Select------</option>
<%
			for(int i=0;i<purOrderRetObj.getRowCount();i++)
			{
				String mapType = purOrderRetObj.getFieldValueString(i,"MAP_TYPE");
				if("PURPREASON".equals(mapType))
				{
					String reasonCodeChk = purOrderRetObj.getFieldValueString(i,"VALUE1");

					if(purposeOrder!=null && purposeOrder.equals(reasonCodeChk))
					{
						String reasonCodeKey = purOrderRetObj.getFieldValueString(i,"VALUE2");
						String reasonDescVal = purOrderRetObj.getFieldValueString(i,"REASON_NAME");

						String selected_A = "";

						if(reasonCode!=null && reasonCode.equals(reasonCodeKey))
							selected_A = "selected";
%>
						<option value="<%=reasonCodeKey%>" <%=selected_A%>><%=reasonCodeKey%> - <%=reasonDescVal%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
		</li>
		<li>
			<label for="explanation" class="required">Explanation</label>
			<div class="input-box">
			<div>
				<textarea name="explanation" cols="80" rows="3"><%=explanation%></textarea>
			</div>
			</div>
		</li>
	</ul>
<%
	String visHidDC = "none";

	if(showDefCat) visHidDC = "block";
%>
	<div id="divDefCat" style="display:<%=visHidDC%>">
	<h2 class="legend" style="background-color:#EEEDE7">Defect Categories</h2>
	<ul class="form-list">
		<li style="padding-top: 10px">
			<label for="defCat1" class="required">Category Level 1</label>
			<div class="input-box">
			<div>
			<select id="defCat1" name="defCat1" title="Category Level 1" onChange="selDefCatL1()">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					if("DEFCATL1".equals(mapType))
					{
						String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat1!=null && defCat1.equals(value1))
							selected_A	= "selected";
%>
						<option value="<%=value1%>" <%=selected_A%>><%=value1%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
		<li>
			<label for="defCat2" class="required">Category Level 2</label>
			<div class="input-box">
			<div>
			<select id="defCat2" name="defCat2" title="Category Level 2" onChange="selDefCatL2()">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");

					if("DEFCATL2".equals(mapType) && defCat1.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat2!=null && defCat2.equals(value2))
							selected_A	= "selected";
%>
						<option value="<%=value2%>" <%=selected_A%>><%=value2%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
		<li>
			<label for="defCat3" class="required">Category Level 3</label>
			<div class="input-box">
			<div>
			<select id="defCat3" name="defCat3" title="Category Level 3" onChange="selDefCatL3()">
			<option value="">------Select------</option>
<%
			if(retObjDefCat!=null)
			{
				for(int i=0;i<retObjDefCat.getRowCount();i++)
				{
					String mapType = retObjDefCat.getFieldValueString(i,"MAP_TYPE");
					String value1 = retObjDefCat.getFieldValueString(i,"VALUE1");
					if("DEFCATL3".equals(mapType) && defCat2.equals(value1))
					{
						String value2 = retObjDefCat.getFieldValueString(i,"VALUE2");

						String selected_A = "";

						if(defCat3!=null && defCat3.equals(value2))
							selected_A	= "selected";
%>
						<option value="<%=value2%>" <%=selected_A%>><%=value2%></option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
	</ul>
	</div>

	<h2 class="legend" style="background-color:#EEEDE7">PO and Approval Info</h2>
	<p style="padding-top: 10px;padding-bottom: 10px;">Enter your PO Information here. It is critical for searching Orders quickly</p>
	<ul class="form-list">
		<li><label for="ponumber" class="required">PO Number<em>*</em></label>
			<div class="input-box">
				<input style="text-transform: uppercase" type="text" id="poNumber" name="poNumber" maxlength="20" style="width:100%" value="<%=poNumber%>" required title="Special Characters and Spaces (i.e. С-С,space,С`Т, etc.) are not allowed">
			</div>
		</li>
		<li><label for="podate" class="required">PO Date<em>*</em></label>
			<div class="input-box">
				<input type="text" id="poDate" name="poDate" size="12" value="<%=poDate%>" readonly required><%=getDateImage("poDate")%>
			</div>
		</li>
<%
		//ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
		//if(userAuth_R.containsKey("FOC_APPR"))
		//{
%>
		<li>
			<label for="approver" class="required">Approver </label>
			<div class="input-box" id="approver" >
			<select name="approver" title="Approver" onChange="selApprover()" >
			<option value="">------Select------</option>
<%
			if(approverRetObj!=null)
			{
				for(int i=0;i<approverRetObj.getRowCount();i++)
				{
					String apprVal = approverRetObj.getFieldValueString(i,"VALUE2");
					String apprFName = approverRetObj.getFieldValueString(i,"EU_FIRST_NAME");
					String apprLName = approverRetObj.getFieldValueString(i,"EU_LAST_NAME");
					apprVal = apprVal.trim();
					apprVal = apprVal.toUpperCase();

					String selected_A = "";

					if(approver!=null && approver.equals(apprVal))
						selected_A	= "selected";
%>
					<option value="<%=apprVal%>" <%=selected_A%>><%=apprFName%> <%=apprLName%> (<%=apprVal%>)</option>
<%
				}
			}
%>
			</select>
			</div>
		</li>
<%
		//}
		//else
		//{
%>
			<!--<input type="hidden" id="approver" name="approver">-->
<%
		//}
%>
	</ul>
<%
	String selSoldName 	= "";
	String selSoldAddr1	= "";
	String selSoldCity 	= "";
	String selSoldState 	= "";
	String selSoldCountry 	= "";
	String selSoldZipCode	= "";
	String selSoldPhNum 	= "";
	String selSoldEmail 	= "";

	String visHid = "none";

	if(approver!=null && !"null".equalsIgnoreCase(approver) && !"".equals(approver)) visHid = "block";
%>
	<div id="divFdCode" style="display:<%=visHid%>">
	<h2 class="legend" style="background-color:#EEEDE7">FD Expense A/C (for Approver Use only)</h2>
	<ul class="form-list">
		<li style="padding-top: 10px">
			<label for="fdCode" class="required">FD Exp. Int A/c code</label>
			<div class="input-box">
			<div>
			<select id="selSoldToInfo" name="selSoldToInfo" onChange="selectSoldTo()">
			<option value="">------Select------</option>
<%
			if(fdActRetObj!=null)
			{
				java.util.ArrayList fdAct_AL = new java.util.ArrayList();

				for(int i=0;i<fdActRetObj.getRowCount();i++)
				{
					String blockCode_A 	= fdActRetObj.getFieldValueString(i,"ECA_EXT1");
					if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

					if(!"BL".equalsIgnoreCase(blockCode_A))
					{

					String soldToCode_A 	= fdActRetObj.getFieldValueString(i,"EC_ERP_CUST_NO");
					String soldToName_A 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");

					if(fdAct_AL.contains(soldToCode_A))
						continue;

					fdAct_AL.add(soldToCode_A);

					String selected_A = "";

					if(fdCode!=null && fdCode.equals(soldToCode_A))
						selected_A	= "selected";

					selSoldName 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");
					selSoldAddr1	= fdActRetObj.getFieldValueString(i,"ECA_ADDR_1");
					selSoldCity 	= fdActRetObj.getFieldValueString(i,"ECA_CITY");
					selSoldState 	= fdActRetObj.getFieldValueString(i,"ECA_DISTRICT");
					selSoldCountry 	= fdActRetObj.getFieldValueString(i,"ECA_COUNTRY");
					selSoldZipCode	= fdActRetObj.getFieldValueString(i,"ECA_POSTAL_CODE");
					selSoldPhNum 	= fdActRetObj.getFieldValueString(i,"ECA_PHONE");
					selSoldEmail 	= fdActRetObj.getFieldValueString(i,"ECA_EMAIL");

					selSoldAddr1 	= (selSoldAddr1==null || "null".equals(selSoldAddr1)|| "".equals(selSoldAddr1))?"":selSoldAddr1;
					selSoldCity 	= (selSoldCity==null || "null".equals(selSoldCity)|| "".equals(selSoldCity))?"":selSoldCity;// for city
					selSoldState 	= (selSoldState==null || "null".equals(selSoldState) || "".equals(selSoldState))?"":selSoldState;
					selSoldCountry 	= (selSoldCountry==null || "null".equals(selSoldCountry)|| "".equals(selSoldCountry))?"":selSoldCountry.trim();
					selSoldZipCode 	= (selSoldZipCode==null || "null".equals(selSoldZipCode)|| "".equals(selSoldZipCode))?"":selSoldZipCode;
					selSoldPhNum 	= (selSoldPhNum==null || "null".equals(selSoldPhNum)|| "".equals(selSoldPhNum))?"":selSoldPhNum;
					selSoldEmail 	= (selSoldEmail==null || "null".equals(selSoldEmail)|| "".equals(selSoldEmail))?"":selSoldEmail;

					String soldParams = selSoldName+"#"+selSoldAddr1+"#"+selSoldCity+"#"+selSoldState+"#"+selSoldCountry+"#"+selSoldZipCode+"#"+selSoldPhNum+"#"+soldToCode_A;
%>
					<option value="<%=soldParams%>" <%=selected_A%>><%=soldToCode_A%>(<%=soldToName_A%>)</option>
<%
					}
				}
			}
%>
			</select>
			</div>
			</div>
		</li>
	</ul>
	</div>
<input type="hidden" name="selSoldTo" value="0000400276">
<input type="hidden" name="soldToName" >
<input type="hidden" name="soldToStreet" >
<input type="hidden" name="soldToCity" >
<input type="hidden" name="soldToState" >
<input type="hidden" name="soldToCountry" >
<input type="hidden" name="soldToZipCode" >
<input type="hidden" name="soldToPhNum" >
<input type="hidden" name="soldToEmail" >
</div> <!-- info-box -->
</div> <!-- col1 -->
<div class="col-2">
<div class="info-box">
<%
	String dlvCheck = "";
	String disabled = "";

	if(multiOrders)
		disabled = "disabled=disabled";
	else
	{
		if(complDlv!=null && ("on".equalsIgnoreCase(complDlv) || "Y".equals(complDlv)))
			dlvCheck = "checked=checked";
		else if(request.getParameter("shipComplete")!=null && !"null".equalsIgnoreCase(request.getParameter("shipComplete")))
			dlvCheck = "checked=checked";
	}

	if(desiredDate==null || "null".equalsIgnoreCase(desiredDate))
	{
		desiredDate = request.getParameter("desiredDate");

		if(desiredDate==null || "null".equalsIgnoreCase(desiredDate)) desiredDate = "";
	}
	if(shipInst==null || "null".equalsIgnoreCase(shipInst))
	{
		shipInst = request.getParameter("shipInst");

		if(shipInst==null || "null".equalsIgnoreCase(shipInst)) shipInst = "";
	}
	if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim()))
	{
		shipMethod = request.getParameter("shipMethod");

		if(shipMethod==null || "null".equalsIgnoreCase(shipMethod) || "".equals(shipMethod.trim())) shipMethod = "STD";
	}
	if(carrierName==null || "null".equalsIgnoreCase(carrierName)) carrierName = "";
	if(useMyCarrier==null || "null".equalsIgnoreCase(useMyCarrier))
	{
		useMyCarrier = request.getParameter("useMyCarrier");

		if(useMyCarrier==null || "null".equalsIgnoreCase(useMyCarrier)) useMyCarrier = "";
	}
	if(carrierId==null || "null".equalsIgnoreCase(carrierId))
	{
		carrierId = request.getParameter("carrierId");

		if(carrierId==null || "null".equalsIgnoreCase(carrierId)) carrierId = "";
	}
	if(billToName==null || "null".equalsIgnoreCase(billToName))
	{
		billToName = request.getParameter("billToName");

		if(billToName==null || "null".equalsIgnoreCase(billToName)) billToName = "";
	}
	if(billToStreet==null || "null".equalsIgnoreCase(billToStreet))
	{
		billToStreet = request.getParameter("billToStreet");

		if(billToStreet==null || "null".equalsIgnoreCase(billToStreet)) billToStreet = "";
	}
	if(billToCity==null || "null".equalsIgnoreCase(billToCity))
	{
		billToCity = request.getParameter("billToCity");

		if(billToCity==null || "null".equalsIgnoreCase(billToCity)) billToCity = "";
	}
	if(billToState==null || "null".equalsIgnoreCase(billToState))
	{
		billToState = request.getParameter("billToState");

		if(billToState==null || "null".equalsIgnoreCase(billToState)) billToState = "";
	}
	if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode))
	{
		billToZipCode = request.getParameter("billToZipCode");

		if(billToZipCode==null || "null".equalsIgnoreCase(billToZipCode)) billToZipCode = "";
	}
%>
<h2 class="legend" style="background-color:#EEEDE7">Shipping Info </h2>
<p style="padding-top: 10px;padding-bottom: 10px;">Shipping Method will be defaulted.</p>
	<ul class="form-list">
	<li>
		<label for="delivery" >Deliver Together<br>(Restrictions Apply<em>*</em>)</label>
		<div class="input-box">
			<input class="input-checkbox" type="checkbox" id="shipComplete" name="shipComplete" <%=dlvCheck%> <%=disabled%>></input>
		</div>
	</li>
	<li>
		<label for="desiredDate" >Expected Delivery Date</label>
		<div class="input-box">
			<input type="text" id="desiredDate" name="desiredDate" size="12" value="<%=desiredDate%>" readonly><%=getDateImageFromTomorrow("desiredDate")%>
		</div>
	</li>
	<!--<li>
		<label for="shipMethod" class="required">Shipping Method<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="shipMethod" name="shipMethod" title="shipping-method" onChange="selShipMethod()">-->
<%
		Map sortedMap = new TreeMap(shipMethodHM);

		Set shipCol = sortedMap.entrySet();
		Iterator shipColIte = shipCol.iterator();

                while(shipColIte.hasNext())
                {
			Map.Entry shipColData = (Map.Entry)shipColIte.next();

			String shipMethodCode = (String)shipColData.getKey();
			String shipMethodDesc = (String)shipColData.getValue();

			String selected_A = "";

			if(shipMethod.equals(shipMethodCode))
				selected_A = "selected";
%>
			<!--<option value="<%//=shipMethodCode%>" <%//=selected_A%>><%//=shipMethodDesc%></option>-->
<%
		}
%>
		<!--</select>
		</div>
		</div>
	</li>-->
<%
	String selected_N = "selected";
	String selected_Y = "";
	String visHid2 = "none";
	String visHid1 = "none";

	if(!"STD".equals(shipMethod))
	{
		visHid1 = "block";

		if("YES".equals(useMyCarrier))
		{
			visHid2 = "block";
			selected_N = "";
			selected_Y = "selected";
		}
	}
%>
	<div id="divuseyourcarrier" style="display:<%=visHid1%>">
	<ul class="form-list">
	<li>
		<label for="useMyCarrier" class="required">Use My Carrier's<br>Billing Account<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="useMyCarrier" name="useMyCarrier" title="use-carrier" onchange="selUseMyCarrier();" STYLE="width: 60px">
			<option value="NO" <%=selected_N%>>No</option>
			<option value="YES" id="selectedYes" <%=selected_Y%>>Yes</option>
		</select>
		</div>
		</div>
	</li>
	</ul>
	</div>

	<div id="divBillTo" style="display:<%=visHid2%>">
	<ul class="form-list">
	<!--<li>
		<label for="carrierName" >Carrier Name</label>
		<div class="input-box">
			<input type="text" id="carrierName" name="carrierName" style="width:100%" value="<%//=carrierName%>">
		</div>
	</li>-->
	<li>
		<label for="carrierId" class="required">Carrier A/c ID<em>*</em></label>
		<div class="input-box">
			<input type="text" id="carrierId" name="carrierId" style="width:100%" value="<%=carrierId%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToName" class="required">Bill To Name<em>*</em></label>
		<div class="input-box">
			<input type="text" id="billToName" name="billToName" style="width:100%" value="<%=billToName%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToStreet" class="required">Street 1<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToStreet" name="billToStreet" style="width:100%" value="<%=billToStreet%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToCity" class="required">City<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToCity" name="billToCity" style="width:100%" value="<%=billToCity%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	<li>
		<label for="billToState" class="required">State<em>*</em> </label>
		<div class="input-box">
		<div>
		<select id="billToState" name="billToState" title="Bill To State" onchange="selUseMyCarrier();">
<%
	if(stateRetRes!=null)
	{
		for(int i=0;i<stateRetRes.getRowCount();i++)
		{
			String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
			String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

			String selected_A = "selected";

			if(billToState.equals(shipToStateCode))
			{
%>
				<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateName%></option>
<%
			}
			else
			{
%>
				<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
<%
			}
		}
	}
%>
		</select>
		</div>
		</div>
	</li>
	<li>
		<label for="billToZipCode" class="required">ZipCode<em>*</em> </label>
		<div class="input-box">
			<input type="text" id="billToZipCode" name="billToZipCode" style="width:100%" value="<%=billToZipCode%>" onblur="selUseMyCarrier();">
		</div>
	</li>
	</ul>
	</div>
	<li>
		<label for="shippingText" class="required">Shipping Text</label>
		<div class="input-box">
		<div>
			<textarea name="shipInst" cols="80" rows="3"><%=shipInst%></textarea>
		</div>
		</div>
	</li>
<%
	String listSoldTo = "";

	for(int i=0;i<retsoldto_A.getRowCount();i++)
	{
		if("".equals(listSoldTo))
			listSoldTo = retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
		else
			listSoldTo = listSoldTo+"','"+retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
	}

	/*ReturnObjFromRetrieve listShipTos_ent = null;

	if(!"".equals(listSoldTo))
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_SYS_KEY = '"+sysKey+"' AND A.EC_PARTNER_FUNCTION IN ('WE') AND A.EC_ERP_CUST_NO IN ('"+listSoldTo+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			listShipTos_ent = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}*/

	//if(selShipToCode==null || "null".equalsIgnoreCase(selShipToCode) || "".equals(selShipToCode.trim()) || "ееееееее".equals(selShipToCode))
		//selShipToCode = (String)session.getValue("ShipCode");

	String shipToName = "";
	String shipAddr1 = "";
	String shipAddr2 = "";
	String shipState = "";
	String shipCountry = "";
	String shipZip = "";
	String shipPhNum = "";
	String selShipParams = "ееееееее";
%>
	<!--<h2 class="legend">Ship To Address </h2><a href="javascript:void(0)">Search</a>-->
	<ul class="form-list">
	<li>
		<!--<label for="shiptoname" class="required">Ship To ID<em>*</em></label>
		<div class="input-box" style="width:290px !important;">
		<div>
		<select name="selShipToInfo" id="selShipToInfo" onChange="selectedShipTos()">
			<option value="ееееееее">------Select------</option>
			<option value="0999999999">0999999999 (ONE-TIME SHIP TO-PUT PHONE# IN SHIP)</option>-->
<%
		/*int listShipCnt = listShipTos_ent.getRowCount();
		Vector shipDelete = new Vector();
		for(int l=0;l<listShipCnt;l++)
		{
			String blockCode_A 	= listShipTos_ent.getFieldValueString(l,"ECA_EXT1");
			if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

			if(!"BL".equalsIgnoreCase(blockCode_A))
			{
		
			String shipToCode = listShipTos_ent.getFieldValueString(l,"EC_PARTNER_NO");

			if(shipDelete.contains(shipToCode))
				continue;
			else
				shipDelete.add(shipToCode);

			shipToName 	= listShipTos_ent.getFieldValueString(l,"ECA_NAME");
			shipAddr1  	= listShipTos_ent.getFieldValueString(l,"ECA_ADDR_1"); //Street
			shipAddr2  	= listShipTos_ent.getFieldValueString(l,"ECA_CITY");
			shipState  	= listShipTos_ent.getFieldValueString(l,"ECA_STATE");
			shipCountry  	= listShipTos_ent.getFieldValueString(l,"ECA_COUNTRY");
			shipZip    	= listShipTos_ent.getFieldValueString(l,"ECA_PIN");
			shipPhNum    	= listShipTos_ent.getFieldValueString(l,"ECA_PHONE");

			shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
			shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
			shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
			shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
			shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
			shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;

			//String tempShip = shipToCode.substring(shipToCode.length()-4,shipToCode.length());
			String tempShip = listShipTos_ent.getFieldValueString(l,"ECA_ACCOUNT_GROUP");

			String shipParams = shipToName+"е"+shipAddr1+"е"+shipAddr2+"е"+shipState+"е"+shipCountry+"е"+shipZip+"е"+shipPhNum+"е"+shipToCode+"е"+tempShip;

			if("CPDA".equalsIgnoreCase(tempShip)) shipToName = "Drop Ship";

			String selected_A = "";

			//if((listShipCnt==1) || ((listShipCnt==2) && !"CPDA".equalsIgnoreCase(tempShip)))
			if("0999999999".equals(shipToCode))
			{
				selected_A = "selected";
				//selShipParams = shipParams;
			}

			if(selShipToCode!=null && selShipToCode.equals(shipToCode))
			{
				selected_A = "selected";
				selShipParams = shipParams;
			}*/
%>
			<!--<option value="<%//=shipParams%>" <%//=selected_A%>><%//=shipToCode%>(<%//=shipToName%>)</option>-->
<%
			//}
		//}

	String defShipToName 	= (String)session.getValue("SHIPNA_PREP");
	String defShipAddr1 	= (String)session.getValue("SHIPSR_PREP");
	String defShipAddr2 	= (String)session.getValue("SHIPCT_PREP");
	String defShipState 	= (String)session.getValue("SHIPST_PREP");
	String defShipCountry 	= (String)session.getValue("SHIPCN_PREP");
	String defShipZip 	= (String)session.getValue("SHIPZC_PREP");
	String defShipPhNum 	= (String)session.getValue("SHIPPH_PREP");
	String defShipToCode 	= (String)session.getValue("SHIPTO_PREP");

	if(defShipToName==null || "null".equalsIgnoreCase(defShipToName))
	{
		defShipToName = request.getParameter("shipToName");
		if(defShipToName==null || "null".equalsIgnoreCase(defShipToName)) defShipToName = "";
	}
	if(defShipAddr1==null || "null".equalsIgnoreCase(defShipAddr1))
	{
		defShipAddr1 = request.getParameter("shipToStreet");
		if(defShipAddr1==null || "null".equalsIgnoreCase(defShipAddr1)) defShipAddr1 = "";
	}
	if(defShipAddr2==null || "null".equalsIgnoreCase(defShipAddr2))
	{
		defShipAddr2 = request.getParameter("shipToCity");
		if(defShipAddr2==null || "null".equalsIgnoreCase(defShipAddr2)) defShipAddr2 = "";
	}
	if(defShipState==null || "null".equalsIgnoreCase(defShipState))
	{
		defShipState = request.getParameter("shipToState");
		if(defShipState==null || "null".equalsIgnoreCase(defShipState)) defShipState = "";
	}
	if(defShipCountry==null || "null".equalsIgnoreCase(defShipCountry))
	{
		defShipCountry = request.getParameter("shipToCountry");
		if(defShipCountry==null || "null".equalsIgnoreCase(defShipCountry)) defShipCountry = "";
	}
	if(defShipZip==null || "null".equalsIgnoreCase(defShipZip))
	{
		defShipZip = request.getParameter("shipToZip");
		if(defShipZip==null || "null".equalsIgnoreCase(defShipZip)) defShipZip = "";
	}
	if(defShipPhNum==null || "null".equalsIgnoreCase(defShipPhNum))
	{
		defShipPhNum = request.getParameter("shipToPhone");
		if(defShipPhNum==null || "null".equalsIgnoreCase(defShipPhNum)) defShipPhNum = "";
	}
	if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode))
	{
		defShipToCode = request.getParameter("selShipTo");
		if(defShipToCode==null || "null".equalsIgnoreCase(defShipToCode)) defShipToCode = "";
	}

	try
	{
		if("".equals(defShipToName))
		{
			defShipToName = selShipParams.split("е")[0];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipAddr1))
		{
			defShipAddr1 = selShipParams.split("е")[1];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipAddr2))
		{
			defShipAddr2 = selShipParams.split("е")[2];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipState))
		{
			defShipState = selShipParams.split("е")[3];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipCountry))
		{
			defShipCountry = selShipParams.split("е")[4];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipZip))
		{
			defShipZip = selShipParams.split("е")[5];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipPhNum))
		{
			defShipPhNum = selShipParams.split("е")[6];
		}
	}
	catch(Exception e){}
	try
	{
		if("".equals(defShipToCode))
		{
			defShipToCode = "0999999999";//selShipParams.split("е")[7];
		}
	}
	catch(Exception e){}
%>
		<!--</select>
		</div>
		</div>-->
		<input type="hidden" name="selShipTo" value="<%=defShipToCode%>">
		<!--<input type="hidden" name="shipToCountry" value="<%//=defShipCountry%>">-->
	</li>
	<li>
		<label for="shipToName" class="required">Ship To Name<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToName" name="shipToName" style="width:100%" maxlength="100" value="<%=defShipToName%>" required>
		</div>
		<a href="javascript:openSearch()"><img height="20px" width="20px" src="../../Images/search2.png"></a>
	</li>
	<li>
		<label for="shipToStreet" class="required">Street 1<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToStreet" name="shipToStreet" style="width:100%" maxlength="100" value="<%=defShipAddr1%>" required>
		</div>
	</li>
	<li>
		<label for="city-state-zip" class="required">City<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToCity" name="shipToCity" style="width:100%" maxlength="40" value="<%=defShipAddr2%>" required>
		</div>
	</li>
	<li>
		<label for="city-state-zip" class="required">State<em>*</em></label>
		<div class="input-box">
			<select name="shipToState" id="shipToState" required  onchange="changeState()">
			<option value="">------Select------</option>
<%
			if(stateRetRes!=null)
			{
				for(int i=0;i<stateRetRes.getRowCount();i++)
				{
					String shipToStateCode 	= stateRetRes.getFieldValueString(i,"STATECODE");
					String shipToStateName 	= stateRetRes.getFieldValueString(i,"STATENAME");

					String selected_A = "selected";

					if(defShipState.equals(shipToStateCode))
					{
%> 
						<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateName%></option>
<%
					}
					else
					{
%>
						<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
<%
					}
				}
			}
%>
			</select>
			<!--<input type="text" id="shipToState" name="shipToState" value="<%=defShipState%>">-->
		</div>
	</li>
	<li>
		<label for="Country" class="required">Country<em>*</em></label>
		<div class="input-box">
			<select name="shipToCountry" id="shipToCountry" required>
			<option value="">------Select------</option>
			<option value="US">US</option>
			<option value="PR">PR</option>
			</select>
		</div>
	</li>	
	<li>
		<label for="city-state-zip" class="required">Zip<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToZip" name="shipToZip" style="width:100%" maxlength="20" value="<%=defShipZip%>" required>
		</div>
	</li>
	<li>
		<label for="shipToPhone" class="required">Phone<em>*</em></label>
		<div class="input-box">
			<input type="text" id="shipToPhone" name="shipToPhone" style="width:100%" maxlength="16" value="<%=defShipPhNum%>" required>
		</div>
	</li>
	</ul>
</div> <!-- info-box -->
</div> <!-- col2 -->
</div> <!-- col2-set -->
<script>
	//selectedShipTos()
</script>
	<div class="col2-set">
		<div class="col-1">
			<button type="button" title="Back" class="button btn-black" onclick="javascript:goToCart('<%=rulesApply%>')"><span class="left-link">Back</span></button>
		</div>
		
<%
		if(!"Y".equals(rulesApply))
		{
%>
			<div class="col-2">
				<button type="button" title="Next" class="button btn-black" onclick="getPricing()"><span class="right-link">Next</span></button>
			</div>
<%		}
%>
	</div>

	
</div>
<!-- <div>-->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
</form>

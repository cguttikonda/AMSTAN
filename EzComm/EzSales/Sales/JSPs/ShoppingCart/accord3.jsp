<%@ page import="ezc.ezcommon.*" %>
<%@ page import="ezc.ezparam.*,ezc.sales.client.*" %>
<%@ page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Manager" class="ezc.sales.local.client.EzSalesManager" scope="page"></jsp:useBean>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="ezGetProductInfo.jsp"%>
<%@ include file="ezReturnJobQuotePrice.jsp"%>
<head>
	<Script>
	function uploadAgain()
	{								      
		document.myForm.action="accord.jsp#vertservices"; 
		document.myForm.target="_self";
		document.myForm.submit();       
	}
	function clsifr()
	{
		parent.jQuery.fancybox.close();  
		
		document.myForm.action="ezViewCart.jsp";
		document.myForm.target="_parent";
		document.myForm.submit(); 
	}	
	function downloadErr()
	{								      
		document.myForm.action="ezDownLoadERR.jsp"; 
		document.myForm.target="_self";
		document.myForm.submit();       
	}
	</Script>
	
	<link rel="stylesheet" href="../../Library/Styles/accord.css" />
	<style>
		button, button.button, p.back-link, .buttons-set .back-link, .pager ol li, .back-to-top .to-top, a.button, button.restock-addtocart { border: none; border-radius: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; height: 30px; color: #fff  background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
		background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
		button:hover, button.button:hover, button:active, button.button:active, button.button.button:active, p.back-link:hover, .buttons-set .back-link:hover, p.back-link:active, .buttons-set .back-link:active, .pager ol li:hover, .pager ol li:active, .back-to-top:hover .to-top, .back-to-top:active .to-top, a.button:hover, a.button:active { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; border: none !important; box-shadow: 0 0 0 #000; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; }
	</style>
	
</head>

<Body> 
<form name=myForm ENCTYPE="multipart/form-data" method=post>
<div class="accordion vertical">
<section id="vertabout">
	<h2><a href="#vertabout">1: Download Template</a></h2>
	<a href="#vertservices" onClick="funDownload()">
	<button type="button" class="button" value='Review'><span><font color=white>Download Template</font> </span></button></a>
</section>
<section id="vertservices">
	<h2><a href="accord.jsp#vertservices">2: Choose File to Upload</a></h2>
	<p>Please choose a file  <BR>
	<input name="path" class=inputbox type="file" style="width:100%"></p>
	<br><br>
	<a href="" onClick="funUpload()"> 
	<button type="button" class="button"  value='Review'><span><font color=white>Review</font> </span></button></a>
</section>
<section id="vertblog">
	<h2><a href="#vertblog">3: Review Info and Save to Cart</a></h2>
	<h2>Please Choose a File and Review</a></h2>
</section>
<section id="vertportfolio">
	<h2><a href="#vertportfolio">4: Close Upload Wizard</a></h2>
<%
	String retMessage =""; 
	int strTempLen = 0;
	int errCnt = 0;
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = null;
	ezc.ezparam.ReturnObjFromRetrieve myRetERR = null;

	try
	{
		String strTemp[] = request.getParameterValues("chk1");

		myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","QTY","MYPO","MYSKU","QUOTENO","QUOTELINE","ACTUALCODE","VALIDPROD"});
		myRetERR  = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE_ERR","QTY_ERR","MYPO_ERR","MYSKU_ERR","QUOTE_NO","QUOTE_LINE","REASON"});
		String prdStr = "";
		strTempLen = strTemp.length;
		errCnt = strTemp.length;

		for(int i=0;i<strTemp.length;i++)
		{
			ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"¥");
			java.util.Vector Tokens = EzToken.getTokens();

			try
			{
				myRetTemp.setFieldValue("MATCODE",(String)Tokens.elementAt(0));
				myRetTemp.setFieldValue("ACTUALCODE",(String)Tokens.elementAt(0));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MATCODE","");
				myRetTemp.setFieldValue("ACTUALCODE","");
			}
			try
			{
				myRetTemp.setFieldValue("QTY",(String)Tokens.elementAt(1));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("QTY","");
			}
			try
			{
				myRetTemp.setFieldValue("MYPO",(String)Tokens.elementAt(2));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MYPO","");
			}
			try
			{
				myRetTemp.setFieldValue("MYSKU",(String)Tokens.elementAt(3));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MYSKU","");
			}
			try
			{
				myRetTemp.setFieldValue("QUOTENO",(String)Tokens.elementAt(4));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("QUOTENO","");
			}
			try
			{
				myRetTemp.setFieldValue("QUOTELINE",(String)Tokens.elementAt(5));
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("QUOTELINE","");
			}
			myRetTemp.setFieldValue("VALIDPROD","Y");
			myRetTemp.addRow();
		}
	}
	catch(Exception e){}

	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	EzShoppingCart Cart = null;
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);

	try
	{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}
	catch(Exception err){}

	int cartRows = 0;
	String catType_C = "";
	boolean DXVProd = false;
	boolean nonDXVProd = false;
	boolean rpDXVProd = false;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();
		catType_C = Cart.getType(0);

		for(int c=0;c<Cart.getRowCount();c++)
		{
			String prodDiv = (String)Cart.getCat2(c);

			if("D1".equals(prodDiv) || "D2".equals(prodDiv) || "D3".equals(prodDiv) || "D4".equals(prodDiv) || "D5".equals(prodDiv))
			{
				DXVProd = true;
			}
			else if("D9".equals(prodDiv))
			{
				rpDXVProd = true;
			}
			else
			{
				nonDXVProd = true;
			}
		}
		if(DXVProd || nonDXVProd) rpDXVProd = false;
	}

	if(catType_C==null || "null".equalsIgnoreCase(catType_C) || "".equals(catType_C)) catType_C = "PT";

	String defProgType = (String)session.getValue("DEFPROG");//request.getParameter("dispVipProd");

	if("PT".equals(catType_C) || "QT".equals(catType_C))
	{
		if(defProgType!=null && "NONE".equals(defProgType)) catType_C = "PT";
		else if(defProgType!=null && "DISP".equals(defProgType)) catType_C = "DISP";
		else if(defProgType!=null && "VIP".equals(defProgType)) catType_C = "VIP";
		else if(defProgType!=null && "FOC".equals(defProgType)) catType_C = "FOC";
	}

	String enteredCode = "";

   	for(int u=0;u<myRetTemp.getRowCount();u++)
	{
		String matCodeUP    = myRetTemp.getFieldValueString(u,"MATCODE");

		if("".equals(enteredCode))
			enteredCode = matCodeUP;
		else
			enteredCode = enteredCode+"','"+matCodeUP;
	}

	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY","PROD_DIV"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);

	ReturnObjFromRetrieve commGrpRetObj = null;
	ReturnObjFromRetrieve prodStatObj = null;

	Hashtable custAttrsHT = (Hashtable)session.getValue("CUSTATTRS");
	String soldToCode = (String)session.getValue("AgentCode");
	String shipToCode = (String)session.getValue("ShipCode");
	java.util.ArrayList commGrpAL = new java.util.ArrayList();
	String catalogCode = (String)session.getValue("CatalogCode");
	String notAdded = "Y";

	if(enteredCode!=null && !"null".equals(enteredCode) && !"".equals(enteredCode))
	{
		EzcParams prodParamsMisc= new EzcParams(false);
		EziMiscParams prodParams = new EziMiscParams();

		String appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZR','ZM','ZL','ZD','ZP')";	//'ZE',

		if(!"CU".equals((String)session.getValue("UserRole")))
			appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZD','ZP')";

		String query1="SELECT ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_STATUS,EZP_UPC_CODE,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_CURR_PRICE,EZP_ATTR1,EZP_SALES_ORG,EZP_PROD_ATTRS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DIVISION') DIVISION FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+enteredCode+"') AND EPD_LANG_CODE='EN'"+appendQry;

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery(query1);
		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			prodStatObj = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
			//out.println(prodStatObj.toEzcString());
		}
		catch(Exception e){}

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery("SELECT * from EZC_VALUE_MAPPING where MAP_TYPE='COMMGRPALLOWED'");

		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			commGrpRetObj = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}

		String commGrpCodeMap="";

		if(commGrpRetObj!=null && commGrpRetObj.getRowCount()>0)
		{
			for(int i=0;i<commGrpRetObj.getRowCount();i++)
			{
				commGrpCodeMap = commGrpRetObj.getFieldValueString(i,"VALUE1");
				commGrpAL.add(commGrpCodeMap);
			}
		}
	}

	if(myRetTemp!=null && myRetTemp.getRowCount()>0)
	{
		for(int u=0;u<myRetTemp.getRowCount();u++)
		{
			String prodCode	    = myRetTemp.getFieldValueString(u,"MATCODE");
			String quantityC    = myRetTemp.getFieldValueString(u,"QTY");
			String prodSkuC	    = myRetTemp.getFieldValueString(u,"MYSKU");
			String poLineC	    = myRetTemp.getFieldValueString(u,"MYPO");
			String quoteNoC	    = myRetTemp.getFieldValueString(u,"QUOTENO");
			String quoteLNo	    = myRetTemp.getFieldValueString(u,"QUOTELINE");

			if(quantityC==null || "null".equalsIgnoreCase(quantityC) || "".equals(quantityC)) quantityC = "1";
			if(prodSkuC==null || "null".equalsIgnoreCase(prodSkuC) || "".equals(prodSkuC)) prodSkuC = "N/A";
			if(poLineC==null || "null".equalsIgnoreCase(poLineC) || "".equals(poLineC)) poLineC = "N/A";
			if(quoteNoC==null || "null".equalsIgnoreCase(quoteNoC) || "".equals(quoteNoC)) quoteNoC = "N/A";
			if(quoteLNo==null || "null".equalsIgnoreCase(quoteLNo) || "".equals(quoteLNo)) quoteLNo = "N/A";

			String prodDesc  = "";
			String listPrice = "";
			String eanUpc 	 = "";
			String prodCat   = "";
			String prdType	 = "";
			String status	 = "";
			String commGrp	 = "";
			String prdSysKey = "";
			String prdAttrs  = "";
			String prodDiv	 = "";
			String actualCodeForQT = prodCode;
			boolean validProd = false;
			notAdded = "Y";

			if(prodStatObj.find("EZP_PRODUCT_CODE",prodCode))
			{
				validProd = true;
				int row = prodStatObj.getRowId("EZP_PRODUCT_CODE",prodCode);

				prodDesc  = prodStatObj.getFieldValueString(row,"PROD_DESC");
				listPrice = prodStatObj.getFieldValueString(row,"EZP_CURR_PRICE");
				eanUpc 	  = prodStatObj.getFieldValueString(row,"EZP_UPC_CODE");
				prodCat   = prodStatObj.getFieldValueString(row,"ECP_CATEGORY_CODE");
				prdType	  = prodStatObj.getFieldValueString(row,"EZP_TYPE");
				status	  = prodStatObj.getFieldValueString(row,"EZP_STATUS");
				commGrp	  = prodStatObj.getFieldValueString(row,"EZP_ATTR1");
				prdSysKey = prodStatObj.getFieldValueString(row,"EZP_SALES_ORG");
				prdAttrs  = prodStatObj.getFieldValueString(row,"EZP_PROD_ATTRS");
				prodDiv	  = prodStatObj.getFieldValueString(row,"DIVISION");
			}
			else
			{
				prodCode = prodCode.trim(); 
				String prodCode_A = prodCode;

				prodCode = prodCode.replaceAll("\\,","");
				prodCode = prodCode.replaceAll("\\.","");
				prodCode = prodCode.replaceAll("\\-","");
				prodCode = prodCode.replaceAll("\\/","");

				EzcParams prodParamsMisc= new EzcParams(false);
				EziMiscParams prodParams = new EziMiscParams();

				String appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZR','ZM','ZL','ZD','ZP')";	//'ZE',

				if(!"CU".equals((String)session.getValue("UserRole")))
					appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZD','ZP')";

				String query1="SELECT ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_STATUS,EZP_UPC_CODE,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_CURR_PRICE,EZP_ATTR1,EZP_SALES_ORG,EZP_PROD_ATTRS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DIVISION') DIVISION FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_WEB_SKU LIKE '"+prodCode+"' "+appendQry+" AND EPD_LANG_CODE='EN'";
				prodParams.setQuery(query1);
				prodParams.setIdenKey("MISC_SELECT");
				
				prodParamsMisc.setLocalStore("Y");
				prodParamsMisc.setObject(prodParams);
				Session.prepareParams(prodParamsMisc);	

				prodCode = prodCode_A;

				try
				{
					ReturnObjFromRetrieve prodStatObj1 = (ReturnObjFromRetrieve)ezMiscManager1.ezSelect(prodParamsMisc);
					if(prodStatObj1!=null && prodStatObj1.getRowCount()>1)
					{
						boolean prdDelete = false;
						String prdCode_Chk = "";
						String prdCode_Chk1 = "";
						for(int i=0;i<prodStatObj1.getRowCount();i++)
						{
							if(i==0)
								prdCode_Chk = prodStatObj1.getFieldValueString(i,"EZP_PRODUCT_CODE");
							else
								prdCode_Chk1 = prodStatObj1.getFieldValueString(i,"EZP_PRODUCT_CODE");

							if(!"".equals(prdCode_Chk) && !"".equals(prdCode_Chk1) && !prdCode_Chk.equals(prdCode_Chk1))
								prdDelete = true;
						}
						if(prdDelete)
						{
							for(int i=(prodStatObj1.getRowCount()-1);i>=0;i--)
							{
								prodStatObj1.deleteRow(i);
							}
						}
					}
					if(prodStatObj1!=null && prodStatObj1.getRowCount()>0)
					{
						validProd = true;
						actualCodeForQT = prodStatObj1.getFieldValueString(0,"EZP_PRODUCT_CODE");
						myRetTemp.setFieldValueAt("ACTUALCODE",actualCodeForQT,u);

						prodDesc  = prodStatObj1.getFieldValueString(0,"PROD_DESC");
						listPrice = prodStatObj1.getFieldValueString(0,"EZP_CURR_PRICE");
						eanUpc 	  = prodStatObj1.getFieldValueString(0,"EZP_UPC_CODE");
						prodCat   = prodStatObj1.getFieldValueString(0,"ECP_CATEGORY_CODE");
						prdType	  = prodStatObj1.getFieldValueString(0,"EZP_TYPE");
						status	  = prodStatObj1.getFieldValueString(0,"EZP_STATUS");
						commGrp	  = prodStatObj1.getFieldValueString(0,"EZP_ATTR1");
						prdSysKey = prodStatObj1.getFieldValueString(0,"EZP_SALES_ORG");
						prdAttrs  = prodStatObj1.getFieldValueString(0,"EZP_PROD_ATTRS");
						prodDiv	  = prodStatObj1.getFieldValueString(0,"DIVISION");
					}
					else
					{
						myRetTemp.setFieldValueAt("VALIDPROD","X",u);
						notAdded = "IP";
						validProd = false;
					}
				}
				catch(Exception e){}
			}

			boolean dxvChk = false;

			if("D1".equals(prodDiv) || "D2".equals(prodDiv) || "D3".equals(prodDiv) || "D4".equals(prodDiv) || "D5".equals(prodDiv))
			{
				if(DXVProd)
				{
					dxvChk = true;
				}
				else if(rpDXVProd)
				{
					dxvChk = true;
					DXVProd = true;
					rpDXVProd = false;
				}
				else if(nonDXVProd)
				{
					dxvChk = false;
				}
			}
			else if("D9".equals(prodDiv))
			{
				dxvChk = true;
			}
			else
			{
				if(nonDXVProd)
				{
					dxvChk = true;
				}
				else if(rpDXVProd)
				{
					dxvChk = true;
					nonDXVProd = true;
					rpDXVProd = false;
				}
				else if(DXVProd)
				{
					dxvChk = false;
				}
			}

			if(!DXVProd && !nonDXVProd && !rpDXVProd)
			{
				if("D1".equals(prodDiv) || "D2".equals(prodDiv) || "D3".equals(prodDiv) || "D4".equals(prodDiv) || "D5".equals(prodDiv))
				{
					DXVProd = true;
				}
				else if("D9".equals(prodDiv))
				{
					rpDXVProd = true;
				}
				else
				{
					nonDXVProd = true;
				}

				dxvChk = true;
			}

			if(dxvChk)
			{
				if(validProd)
				{
					String custAttr  = "";
					String prodAllow = "X";
					boolean prdAllowed = false;

					if("CU".equals((String)session.getValue("UserRole")) && "ZE".equals(status))
						prdAllowed = checkExclusive(Session,soldToCode,shipToCode,actualCodeForQT);		// Customer Exclusive table check
					else
						prdAllowed = true;

					if(prdAllowed)
					{
						if("CU".equals((String)session.getValue("UserRole")))
						{
							try
							{
								custAttr = (String)custAttrsHT.get(prdSysKey);
								prdAllowed = checkAttributes(prdAttrs,custAttr);
							}
							catch(Exception e){}
						}

						if(prdAllowed)
						{
							prodAllow = "Y";

							if(commGrp==null || "null".equals(commGrp)) commGrp = "";

							if(!"CU".equals((String)session.getValue("UserRole")) && ("ZR".equals(status) || "ZE".equals(status)))
							{
								commGrp = "";
							}

							if(commGrpAL.contains(commGrp) || "".equals(commGrp))
							{
								String jobItemPrice = "";
								String quoteOpenQty = "";
								boolean retJob = true;

								if(!"N/A".equals(quoteNoC))
								{
									quoteNoC = "0000000000"+quoteNoC;
									quoteNoC = quoteNoC.substring(quoteNoC.length()-10,quoteNoC.length());
									quoteNoC = quoteNoC.trim();
								}
								if(!"N/A".equals(quoteLNo))
								{
									quoteLNo = "000000"+quoteLNo;
									quoteLNo = quoteLNo.substring(quoteLNo.length()-6,quoteLNo.length());
									quoteLNo = quoteLNo.trim();

									String quoteCust=(String)session.getValue("AgentCode");

									try
									{
										String jobItemPriceQty = getJobQuotePrice(Session,quoteNoC,quoteLNo,actualCodeForQT,quantityC,quoteCust);
										jobItemPrice = jobItemPriceQty.split("¥")[0];
										quoteOpenQty = jobItemPriceQty.split("¥")[1];
									}
									catch(Exception e){}

									if("JR".equals(jobItemPrice) || "NL".equals(jobItemPrice) || "NM".equals(jobItemPrice) || "NQ".equals(jobItemPrice) || "EQ".equals(jobItemPrice) || "CQ".equals(jobItemPrice))
									{	
										retJob 	 = false;
										notAdded = jobItemPrice;
									}
								}
								if(retJob)
								{
									if("KI".equals(prdType))
									{
										listPrice = checkKitCompPrice(Session,actualCodeForQT,listPrice);
									}
									if(!"JR".equals(jobItemPrice) && !"NL".equals(jobItemPrice) && !"NM".equals(jobItemPrice) && !"NQ".equals(jobItemPrice) && !"EQ".equals(jobItemPrice) && !"CQ".equals(jobItemPrice) && !"".equals(jobItemPrice))
									{
										listPrice = jobItemPrice;
									}

									myRetTemp.setFieldValueAt("VALIDPROD",prodAllow,u);

									productsRetObj.setFieldValue("PROD_CODE",actualCodeForQT);
									productsRetObj.setFieldValue("PROD_DESC",prodDesc);
									productsRetObj.setFieldValue("LIST_PRICE",listPrice);
									productsRetObj.setFieldValue("UPC_CODE",eanUpc);
									productsRetObj.setFieldValue("CATEGORY_CODE",prodCat);
									productsRetObj.setFieldValue("PROG_TYPE",catType_C);
									productsRetObj.setFieldValue("TYPE",prdType);
									productsRetObj.setFieldValue("STATUS",status);
									productsRetObj.setFieldValue("QUANTITY",quantityC);
									productsRetObj.setFieldValue("CUST_QUOTE","N/A");
									productsRetObj.setFieldValue("PROD_SKU",prodSkuC);
									productsRetObj.setFieldValue("PROD_LINE",poLineC);
									productsRetObj.setFieldValue("QUOTE_NUM",quoteNoC);
									productsRetObj.setFieldValue("QUOTE_LINE",quoteLNo);
									productsRetObj.setFieldValue("COMM_GRP",commGrp);
									productsRetObj.setFieldValue("SALES_ORG",prdSysKey);
									productsRetObj.setFieldValue("PROD_ATTRS",prdAttrs);
									productsRetObj.setFieldValue("CUST_ATTRS",custAttr);
									productsRetObj.setFieldValue("PROD_ALLOW",prodAllow);
									productsRetObj.setFieldValue("OPEN_QTY",quoteOpenQty);
									productsRetObj.setFieldValue("PROD_DIV",prodDiv);
									productsRetObj.addRow();
								}
							}
							else
							{
								notAdded = "RE";
							}
						}
						else
						{
							notAdded = "PA";
						}
					}
					else
					{
						notAdded = "RE";
					}
				}
			}
			else
			{
				notAdded = "DX";
			}
			if(!"Y".equals(notAdded))
			{
				--strTempLen;
				myRetERR.setFieldValue("MATCODE_ERR",prodCode);
				myRetERR.setFieldValue("QTY_ERR",quantityC);
				myRetERR.setFieldValue("MYPO_ERR",poLineC);
				myRetERR.setFieldValue("MYSKU_ERR",prodSkuC);
				myRetERR.setFieldValue("QUOTE_NO",quoteNoC);
				myRetERR.setFieldValue("QUOTE_LINE",quoteLNo);

				if("RE".equals(notAdded))
					myRetERR.setFieldValue("REASON","Impermissible - contact customer care for ordering");
				else if("NL".equals(notAdded) || "NM".equals(notAdded) || "NQ".equals(notAdded) || "EQ".equals(notAdded))
					myRetERR.setFieldValue("REASON","Invalid Job Quote");
				else if("CQ".equals(notAdded))
					myRetERR.setFieldValue("REASON","Invalid Job Quote: Quantity depleted");
				else if("JR".equals(notAdded))
					myRetERR.setFieldValue("REASON","Rejected on Job Quote");
				else if("PA".equals(notAdded))
					myRetERR.setFieldValue("REASON","Item is not included in your portfolio - Please contact ASB for further details");
				else if("DX".equals(notAdded))
					myRetERR.setFieldValue("REASON","DXV products cannot be mixed with other Brands");
				else
					myRetERR.setFieldValue("REASON","Invalid Item");

				myRetERR.addRow();
			}
		}

		if(cartRows==0)
		{
			DXVProd = false;
			nonDXVProd = false;
			rpDXVProd = false;

			for(int u=0;u<productsRetObj.getRowCount();u++)
			{
				String prodDiv_C = productsRetObj.getFieldValueString(u,"PROD_DIV");

				if("D1".equals(prodDiv_C) || "D2".equals(prodDiv_C) || "D3".equals(prodDiv_C) || "D4".equals(prodDiv_C) || "D5".equals(prodDiv_C))
				{
					DXVProd = true;
				}
				else if("D9".equals(prodDiv_C))
				{
					rpDXVProd = true;
				}
				else
				{
					nonDXVProd = true;
				}
			}

			if(DXVProd && nonDXVProd)
			{
				strTempLen = errCnt;

				for(int i=productsRetObj.getRowCount()-1;i>=0;i--)
				{
					productsRetObj.deleteRow(i);
				}
				for(int i=myRetERR.getRowCount()-1;i>=0;i--)
				{
					myRetERR.deleteRow(i);
				}
				for(int u=0;u<myRetTemp.getRowCount();u++)
				{
					String prodCode	    = myRetTemp.getFieldValueString(u,"MATCODE");
					String quantityC    = myRetTemp.getFieldValueString(u,"QTY");
					String poLineC	    = myRetTemp.getFieldValueString(u,"MYPO");
					String prodSkuC	    = myRetTemp.getFieldValueString(u,"MYSKU");
					String quoteNoC	    = myRetTemp.getFieldValueString(u,"QUOTENO");
					String quoteLNo	    = myRetTemp.getFieldValueString(u,"QUOTELINE");

					--strTempLen;
					myRetERR.setFieldValue("MATCODE_ERR",prodCode);
					myRetERR.setFieldValue("QTY_ERR",quantityC);
					myRetERR.setFieldValue("MYPO_ERR",poLineC);
					myRetERR.setFieldValue("MYSKU_ERR",prodSkuC);
					myRetERR.setFieldValue("QUOTE_NO",quoteNoC);
					myRetERR.setFieldValue("QUOTE_LINE",quoteLNo);
					myRetERR.setFieldValue("REASON","DXV products cannot be mixed with other Brands");
					myRetERR.addRow();
				}
			}
		}

		String fileName = "accord3.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
		//out.println(notAdded);
	}

	if(myRetERR!=null && myRetERR.getRowCount()>0)
	{
		session.putValue("myRetERRSes",myRetERR);
		errCnt= errCnt-strTempLen;
%>
		<img src="../../Library/images/icon-success-message.png"/>&nbsp;<font color=green size=4> <%=strTempLen%></font>&nbsp;<font size=4> Items Successfully Added to Cart.</font>
		<br><br>
		<img src="../../Library/images/icon-error-message.png"/>&nbsp;<a href="JavaScript:downloadErr()"><font color=red size=4>Click Here</font></a><font size=4> to check the items (<%=errCnt%>) which are not saved to Cart.</font>
		<!--<h3>Rest of the Items Successfully Added to Cart.</h3> -->
<%
	}
	else
	{
%>
		<img src="../../Library/images/icon-success-message.png"/>&nbsp;<font size=4>Items Successfully Added to Cart.</font>
<%
	}
%>
<br><br><br>
<div>			
	<button type="button" class="button"  onClick="uploadAgain()" value='Upload Again'><span><font color=white>Upload More</font> </span></button></a>
	&nbsp
	<button type="button" style="margin-left:10px;" class="button" onClick="clsifr()" value='Close'><span><font color=white>Back to Cart</font> </span></button></a>
</div>
</section>
</div>
</Form>
</Body>
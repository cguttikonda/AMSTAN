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
<%

	String retMessage =""; 
	int strTempLen = 0;
	int errCnt = 0;
	String errConcant = "";
	ezc.ezparam.ReturnObjFromRetrieve myRetTemp = null;
	ezc.ezparam.ReturnObjFromRetrieve myRetERR = null;
	
	
	String selectedPrdsSplit = request.getParameter("splitMat");    

	ezc.ezcommon.EzLog4j.log("CheckBox1Value::::"+selectedPrdsSplit,"D");

	int prdsLen =0;
	String selectedPrdsSplitArr[] = null;
	if(selectedPrdsSplit!=null)
	{
		selectedPrdsSplitArr = selectedPrdsSplit.split("§");
		prdsLen = selectedPrdsSplitArr.length;
	}

	String enteredCode = "";	

	try
	{
		

		myRetTemp = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE","QTY","MYPO","MYSKU","QUOTENO","QUOTELINE","ACTUALCODE","VALIDPROD"});
		myRetERR  = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATCODE_ERR","QTY_ERR","MYPO_ERR","MYSKU_ERR","QUOTE_NO","QUOTE_LINE","REASON"});
		String prdStr = "";
		strTempLen = prdsLen;
		errCnt = prdsLen;

		for(int i=0;i<prdsLen;i++)
		{
			String prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];
			String quantity  =  selectedPrdsSplitArr[i].split("¥")[1];
			String mySKU  	 =  selectedPrdsSplitArr[i].split("¥")[2];
			String myPO  	 =  selectedPrdsSplitArr[i].split("¥")[3];
			String quoteNo	 =  selectedPrdsSplitArr[i].split("¥")[4];
			String lineNo 	 =  selectedPrdsSplitArr[i].split("¥")[5];
			
			if("".equals(enteredCode))
				enteredCode = prodCode;
			else
				enteredCode = enteredCode+"','"+prodCode;
	

			try
			{
				myRetTemp.setFieldValue("MATCODE",prodCode);
				myRetTemp.setFieldValue("ACTUALCODE",prodCode);
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MATCODE","");
				myRetTemp.setFieldValue("ACTUALCODE","");
			}
			try
			{
				myRetTemp.setFieldValue("QTY",quantity);
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("QTY","");
			}
			try
			{
				myRetTemp.setFieldValue("MYPO",myPO);
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MYPO","");
			}
			try
			{
				myRetTemp.setFieldValue("MYSKU",mySKU);
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("MYSKU","");
			}
			try
			{
				myRetTemp.setFieldValue("QUOTENO",quoteNo);
			}
			catch(Exception e)
			{
				myRetTemp.setFieldValue("QUOTENO","");
			}
			try
			{
				myRetTemp.setFieldValue("QUOTELINE",lineNo);
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
			if(!"Y".equals(notAdded) && !"N/A".equals(prodCode))
			{
				
				myRetERR.setFieldValue("MATCODE_ERR",prodCode);
				myRetERR.setFieldValue("QTY_ERR",quantityC);
				myRetERR.setFieldValue("MYPO_ERR",poLineC);
				myRetERR.setFieldValue("MYSKU_ERR",prodSkuC);
				myRetERR.setFieldValue("QUOTE_NO",quoteNoC);
				myRetERR.setFieldValue("QUOTE_LINE",quoteLNo);

				if("RE".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Impermissible - contact customer care for ordering");
					errConcant = errConcant+"¥"+"Impermissible - contact customer care for ordering";
				}
				else if("NL".equals(notAdded) || "NM".equals(notAdded) || "NQ".equals(notAdded) || "EQ".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Invalid Job Quote");
					errConcant = errConcant+"¥"+"Invalid Job Quote";
				}
				else if("CQ".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Invalid Job Quote: Quantity depleted");
					errConcant = errConcant+"¥"+"Invalid Job Quote: Quantity depleted";
				}
				else if("JR".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Rejected on Job Quote");
					errConcant = errConcant+"¥"+"Rejected on Job Quote";
				}
				else if("PA".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Item is not included in your portfolio - Please contact ASB for further details");
					errConcant = errConcant+"¥"+"Item is not included in your portfolio - Please contact ASB for further details";
				}
				else if("DX".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","DXV products cannot be mixed with other Brands");
					errConcant = errConcant+"¥"+"DXV products cannot be mixed with other Brands";
				}
				else
				{
					myRetERR.setFieldValue("REASON","Invalid Item");
					errConcant = errConcant+"¥"+"Invalid Item";
				}

				myRetERR.addRow();
			}
			else if(!"N/A".equals(prodCode))
			{
				
				errConcant = errConcant+"¥"+"Added to Cart";
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

		String fileName = "ezAddCartSpread.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
		
	}

	

	out.println(errConcant);

%>
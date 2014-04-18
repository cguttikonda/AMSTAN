<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="ezGetProductInfo.jsp"%>
<%
	String poDate 		= request.getParameter("poDate");
	String soldTo_S		= request.getParameter("soldTo_S");
	String complDlv_C 	= request.getParameter("complDlv_C");
	String carrierName 	= request.getParameter("carrierName");
	String reqDate 		= request.getParameter("reqDate");
	String carrierId 	= request.getParameter("carrierId");
	String billToName 	= request.getParameter("billToName");
	String billToStreet 	= request.getParameter("billToStreet");
	String billToCity 	= request.getParameter("billToCity");
	String billToState 	= request.getParameter("billToState");
	String billToZipCode 	= request.getParameter("billToZipCode");
	String shipTo_S 	= request.getParameter("shipTo_S");
	String negotiateType  	= request.getParameter("negotiateType");
	String webOrdNo  	= request.getParameter("webOrdNo");

	session.putValue("PODATE_PREP",poDate);
	session.putValue("SOLDTO_PREP",soldTo_S);
	//session.putValue("COMMENTS_PREP",comments);
	session.putValue("SHIPCOMP_PREP",complDlv_C);
	session.putValue("SHIPMETHOD_PREP",carrierName);
	session.putValue("DESDATE_PREP",reqDate);
	session.putValue("CARRNAME_PREP",carrierName);
	session.putValue("CARRID_PREP",carrierId);
	session.putValue("BNAME_PREP",billToName);
	session.putValue("BSTREET_PREP",billToStreet);
	session.putValue("BCITY_PREP",billToCity);
	session.putValue("BSTATE_PREP",billToState);
	session.putValue("BZIPCODE_PREP",billToZipCode);
	session.putValue("SHIPTO_PREP",shipTo_S);	

	/****Removed from session as the same is build in iPointsAlerts.jsp****/
	session.removeValue("Faucets(incl. Flush Valves)-Non Luxury");
	session.removeValue("Faucets(incl. Flush Valves)-Luxury");
	session.removeValue("Chinaware");
	session.removeValue("Americast & Acrylics (Excludes Acrylux)");
	session.removeValue("Acrylux");
	session.removeValue("Enamel Steel");
	session.removeValue("Marble");
	session.removeValue("Shower Doors-Standard");
	session.removeValue("Shower Doors-Custom");
	session.removeValue("Walk In Baths");
	session.removeValue("Repair Parts");
	session.removeValue("JADO");
	session.removeValue("FIAT");
	/****Removed from session as the same is build in iPointsAlerts.jsp****/

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
	boolean DXVProd = false;
	boolean nonDXVProd = false;
	boolean rpDXVProd = false;

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();

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
	}

	String poItems[] = request.getParameterValues("itemLineNo");

	int poItemsLen = 0;

	if(poItems!=null)
		poItemsLen = poItems.length;

	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);
	ReturnObjFromRetrieve prodStatObj = null;
	ReturnObjFromRetrieve myRetERR = new ReturnObjFromRetrieve(new String[]{"MATCODE_ERR","QTY_ERR","MYPO_ERR","MYSKU_ERR","QUOTE_NO","QUOTE_LINE","REASON"});

	Hashtable custAttrsHT = (Hashtable)session.getValue("CUSTATTRS");
	String notAdded = "Y";
	String prodCodeStr = "";

	if(poItemsLen > 0)
	{
		for(int i=0;i<poItemsLen;i++)
		{
			String poItemStr = poItems[i];
			String prodCode  = request.getParameter("tPNo"+poItemStr);

			if("".equals(prodCodeStr))
				prodCodeStr = prodCode;
			else
				prodCodeStr = prodCodeStr+"','"+prodCode;
		}

		if(!"".equals(prodCodeStr))
		{
			EzcParams prodParamsMisc= new EzcParams(false);
			EziMiscParams prodParams = new EziMiscParams();

			String query1="SELECT EZP_PRODUCT_CODE,EZP_STATUS,EZP_ATTR1,EZP_CURR_PRICE,EZP_SALES_ORG,EZP_PROD_ATTRS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DIVISION') DIVISION FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+prodCodeStr+"')";

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
		}

		for(int i=0;i<poItemsLen;i++)
		{
			String poItemStr = poItems[i];
			String prodCode  = request.getParameter("tPNo"+poItemStr);

			if("PTSCH".equals(prodCode) || "PTSAM".equals(prodCode) || "PIECES".equals(prodCode))
				continue;

			String prodDesc  = request.getParameter("prdDesc"+poItemStr);
			//String listPrice = request.getParameter("listPrice"+poItemStr);
			String eanUpc 	 = ((request.getParameter("eanUpc"+poItemStr)==null)||(("").equals(request.getParameter("eanUpc"+poItemStr))) || ("null".equals(request.getParameter("eanUpc"+poItemStr))))?"N/A":request.getParameter("eanUpc"+poItemStr);
			String quantityC = request.getParameter("quantity"+poItemStr);

			int row = prodStatObj.getRowId("EZP_PRODUCT_CODE",prodCode);

			String listPrice  = prodStatObj.getFieldValueString(row,"EZP_CURR_PRICE");
			String status	  = prodStatObj.getFieldValueString(row,"EZP_STATUS");
			String commGrp	  = prodStatObj.getFieldValueString(row,"EZP_ATTR1");
			String prdSysKey  = prodStatObj.getFieldValueString(row,"EZP_SALES_ORG");
			String prdAttrs   = prodStatObj.getFieldValueString(row,"EZP_PROD_ATTRS");
			String prodDiv    = prodStatObj.getFieldValueString(row,"DIVISION");

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
				if(commGrp==null || "null".equals(commGrp)) commGrp="";

				if("FI".equals(commGrp) || "ST".equals(commGrp) || "QS".equals(commGrp) || "".equals(commGrp))
				{
					String custAttr  = "";
					String prodAllow = "X";
					boolean prdAllowed = true;

					if("CU".equals((String)session.getValue("UserRole")))
					{
						try
						{
							custAttr  = (String)custAttrsHT.get(prdSysKey);
							prdAllowed = checkAttributes(prdAttrs,custAttr);
						}
						catch(Exception e){}
					}

					if(prdAllowed)
					{
						prodAllow = "Y";

						productsRetObj.setFieldValue("PROD_CODE",prodCode);
						productsRetObj.setFieldValue("PROD_DESC",prodDesc);
						productsRetObj.setFieldValue("LIST_PRICE",listPrice);
						productsRetObj.setFieldValue("UPC_CODE",eanUpc);
						productsRetObj.setFieldValue("CATEGORY_CODE","N/A");
						productsRetObj.setFieldValue("PROG_TYPE","PT");
						productsRetObj.setFieldValue("TYPE","N/A");
						productsRetObj.setFieldValue("STATUS",status);
						productsRetObj.setFieldValue("QUANTITY",quantityC);
						productsRetObj.setFieldValue("CUST_QUOTE","N/A");
						productsRetObj.setFieldValue("PROD_SKU","N/A");
						productsRetObj.setFieldValue("PROD_LINE","N/A");
						productsRetObj.setFieldValue("QUOTE_NUM","N/A");
						productsRetObj.setFieldValue("QUOTE_LINE","N/A");
						productsRetObj.setFieldValue("COMM_GRP",commGrp);
						productsRetObj.setFieldValue("SALES_ORG",prdSysKey);
						productsRetObj.setFieldValue("PROD_ATTRS",prdAttrs);
						productsRetObj.setFieldValue("CUST_ATTRS",custAttr);
						productsRetObj.setFieldValue("PROD_ALLOW",prodAllow);
						productsRetObj.setFieldValue("OPEN_QTY",quantityC);
						productsRetObj.addRow();
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
			else
			{
				notAdded = "DX";
			}
			if(!"Y".equals(notAdded))
			{
				myRetERR.setFieldValue("MATCODE_ERR",prodCode);
				myRetERR.setFieldValue("QTY_ERR",quantityC);
				myRetERR.setFieldValue("MYPO_ERR","N/A");
				myRetERR.setFieldValue("MYSKU_ERR","N/A");
				myRetERR.setFieldValue("QUOTE_NO","N/A");
				myRetERR.setFieldValue("QUOTE_LINE","N/A");

				if("RE".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Impermissible - contact customer care for ordering");
				}
				else if("PA".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","Item is not included in your portfolio - Please contact AS for further details");
				}
				else if("DX".equals(notAdded))
				{
					myRetERR.setFieldValue("REASON","DXV products cannot be mixed with other Brands");
				}

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
				for(int i=productsRetObj.getRowCount()-1;i>=0;i--)
				{
					productsRetObj.deleteRow(i);
				}
				for(int i=myRetERR.getRowCount()-1;i>=0;i--)
				{
					myRetERR.deleteRow(i);
				}
				for(int i=0;i<poItemsLen;i++)
				{
					String poItemStr  = poItems[i];
					String prodCode   = request.getParameter("tPNo"+poItemStr);
					String quantityC  = request.getParameter("quantity"+poItemStr);

					myRetERR.setFieldValue("MATCODE_ERR",prodCode);
					myRetERR.setFieldValue("QTY_ERR",quantityC);
					myRetERR.setFieldValue("MYPO_ERR","N/A");
					myRetERR.setFieldValue("MYSKU_ERR","N/A");
					myRetERR.setFieldValue("QUOTE_NO","N/A");
					myRetERR.setFieldValue("QUOTE_LINE","N/A");
					myRetERR.setFieldValue("REASON","DXV products cannot be mixed with other Brands");
					myRetERR.addRow();
				}
			}
		}
	}

	String fileName = "ezAddCartSaveOrder.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
	String prdError = "";
	if(myRetERR!=null && myRetERR.getRowCount()>0)
	{
		session.putValue("myRetERRSes",myRetERR);
		prdError = "ERROR";
	}

	response.sendRedirect("ezViewCart.jsp?enteredCode="+prodCodeStr+"&notAdded="+notAdded+"&fromPage=S&webOrdNo="+webOrdNo+"&prdError="+prdError);
%>
<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="ezGetProductInfo.jsp"%>
<%
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

	String poItems[] = request.getParameterValues("poItems");

	int poItemsLen = 0;

	if(poItems!=null)
		poItemsLen = poItems.length;

	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY","PROD_DIV"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);
	ReturnObjFromRetrieve prodStatObj = null;
	ReturnObjFromRetrieve myRetERR = new ReturnObjFromRetrieve(new String[]{"MATCODE_ERR","QTY_ERR","MYPO_ERR","MYSKU_ERR","QUOTE_NO","QUOTE_LINE","REASON"});

	Hashtable custAttrsHT = (Hashtable)session.getValue("CUSTATTRS");
	String notAdded = "Y";

	if(poItemsLen > 0)
	{
		String prodCodeStr = "";

		for(int i=0;i<poItemsLen;i++)
		{
			String poItemStr = poItems[i];
			String prodCode  =  request.getParameter("prodCode"+poItemStr);

			if("PTSCH".equals(prodCode) || "PTSAM".equals(prodCode) || "PIECES".equals(prodCode))
				continue;

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
			String poItemStr  = poItems[i];
			String prodCode   = request.getParameter("prodCode"+poItemStr);

			if("PTSCH".equals(prodCode) || "PTSAM".equals(prodCode) || "PIECES".equals(prodCode))
				continue;

			String prodDesc   = request.getParameter("prodDesc"+poItemStr);
			String eanUpc 	  = request.getParameter("eanUpc"+poItemStr);
			String quantityC  = request.getParameter("quantity"+poItemStr);

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
						productsRetObj.setFieldValue("PROG_TYPE",catType_C);
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
						productsRetObj.setFieldValue("PROD_DIV",prodDiv);
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
					String prodCode   = request.getParameter("prodCode"+poItemStr);
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

	String fileName = "ezAddCartRepeatOrder.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
	//out.println(notAdded);

	String prdError = "";
	if(myRetERR!=null && myRetERR.getRowCount()>0)
	{
		session.putValue("myRetERRSes",myRetERR);
		prdError = "ERROR";
	}

	response.sendRedirect("ezViewCart.jsp?prdError="+prdError);
%>
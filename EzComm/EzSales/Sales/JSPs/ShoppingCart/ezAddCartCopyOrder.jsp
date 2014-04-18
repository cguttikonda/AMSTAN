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
		if(DXVProd || nonDXVProd) rpDXVProd = false;
	}

	String selectedPrdsSplit = request.getParameter("CheckBox1");    
	String custQuote = request.getParameter("custQuote");

	ezc.ezcommon.EzLog4j.log("CheckBox1Value::::"+selectedPrdsSplit,"D");

	int prdsLen =0;
	String selectedPrdsSplitArr[] = null;
	if(selectedPrdsSplit!=null)
	{
		selectedPrdsSplitArr = selectedPrdsSplit.split("§");
		prdsLen = selectedPrdsSplitArr.length;
	}

	String enteredCode = "";

	for(int i=0;i<prdsLen;i++)
	{
		String prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];

		if("".equals(enteredCode))
			enteredCode = prodCode;
		else
			enteredCode = enteredCode+"','"+prodCode;
	}

	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);

	ReturnObjFromRetrieve prodStatObj = null;

	if(enteredCode!=null && !"null".equals(enteredCode) && !"".equals(enteredCode))
	{
		EzcParams prodParamsMisc= new EzcParams(false);
		EziMiscParams prodParams = new EziMiscParams();

		String query1="SELECT EZP_PRODUCT_CODE,EZP_TYPE,EZP_STATUS,EZP_ATTR1,EZP_SALES_ORG,EZP_PROD_ATTRS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DIVISION') DIVISION FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+enteredCode+"')";

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

	Hashtable custAttrsHT = (Hashtable)session.getValue("CUSTATTRS");
	boolean prdAllowed = true;
	String notAdded="NA";

	for(int i=0;i<prdsLen;i++)
	{
		String prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];

		if("PTSCH".equals(prodCode) || "PTSAM".equals(prodCode) || "PIECES".equals(prodCode))
			continue;

		String prodDesc  = selectedPrdsSplitArr[i].split("¥")[1];
		String listPrice = selectedPrdsSplitArr[i].split("¥")[2];
		String eanUpc 	 = selectedPrdsSplitArr[i].split("¥")[3];
		String quantity  = selectedPrdsSplitArr[i].split("¥")[4];
		String quoteNo	 = selectedPrdsSplitArr[i].split("¥")[5];
		String lineNo 	 = selectedPrdsSplitArr[i].split("¥")[6];

		if(prodDesc!=null || !"null".equals(prodDesc) || !"".equals(prodDesc))
			prodDesc = prodDesc.replaceAll("££","&");

		int row = prodStatObj.getRowId("EZP_PRODUCT_CODE",prodCode);

		String prdType		= prodStatObj.getFieldValueString(row,"EZP_TYPE");
		String status		= prodStatObj.getFieldValueString(row,"EZP_STATUS");
		String commGrp		= prodStatObj.getFieldValueString(row,"EZP_ATTR1");
		String prdSysKey	= prodStatObj.getFieldValueString(row,"EZP_SALES_ORG");
		String prdAttrs		= prodStatObj.getFieldValueString(row,"EZP_PROD_ATTRS");
		String custAttr 	= "";

		String prodAllow = "X";
		prdAllowed = true;

		if("CU".equals((String)session.getValue("UserRole")))
		{
			try
			{
				custAttr = (String)custAttrsHT.get(prdSysKey);
				prdAllowed = checkAttributes(prdAttrs,custAttr);
			}
			catch(Exception e){}
		}

		boolean dxvChk = false;
		String prodDiv   = prodStatObj.getFieldValueString(i,"DIVISION");

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
			if(prdAllowed)
			{
				prodAllow = "Y";

				productsRetObj.setFieldValue("PROD_CODE",prodCode);
				productsRetObj.setFieldValue("PROD_DESC",prodDesc);
				productsRetObj.setFieldValue("LIST_PRICE",listPrice);
				productsRetObj.setFieldValue("UPC_CODE",eanUpc);
				productsRetObj.setFieldValue("CATEGORY_CODE","N/A");
				productsRetObj.setFieldValue("PROG_TYPE","QT");
				productsRetObj.setFieldValue("TYPE",prdType);
				productsRetObj.setFieldValue("STATUS",status);
				productsRetObj.setFieldValue("QUANTITY",quantity);
				productsRetObj.setFieldValue("CUST_QUOTE",custQuote);
				productsRetObj.setFieldValue("PROD_SKU","N/A");
				productsRetObj.setFieldValue("PROD_LINE","N/A");
				productsRetObj.setFieldValue("QUOTE_NUM",quoteNo);
				productsRetObj.setFieldValue("QUOTE_LINE",lineNo);
				productsRetObj.setFieldValue("COMM_GRP",commGrp);
				productsRetObj.setFieldValue("SALES_ORG",prdSysKey);
				productsRetObj.setFieldValue("PROD_ATTRS",prdAttrs);
				productsRetObj.setFieldValue("CUST_ATTRS",custAttr);
				productsRetObj.setFieldValue("PROD_ALLOW",prodAllow);
				productsRetObj.setFieldValue("OPEN_QTY",quantity);
				productsRetObj.addRow();
			}
			else
			{
				notAdded = "PA";
			}
		}
		else
		{
			notAdded = "DX";
		}
	}

	String fileName = "ezAddCartCopyOrder.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
	out.println(notAdded);

	//response.sendRedirect("ezViewCart.jsp");
%>
<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
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

	String notAdded="NA";

	String quantityC = request.getParameter("atpqty");
	String commGrp	 = request.getParameter("atpcgr");
	String catType_C = request.getParameter("catType");
	String prodDiv   = request.getParameter("atpdiv");

	if(catType_C==null || "null".equals(catType_C) || "".equals(catType_C)) catType_C = "PT";
	if(commGrp==null || "null".equals(commGrp) || "".equals(commGrp)) commGrp = "N/A";

	String defProgType = (String)session.getValue("DEFPROG");

	if("PT".equals(catType_C))
	{
		if(defProgType!=null && "DISP".equals(defProgType)) catType_C = "DISP";
		else if(defProgType!=null && "VIP".equals(defProgType)) catType_C = "VIP";
		else if(defProgType!=null && "FOC".equals(defProgType)) catType_C = "FOC";
	}

	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);

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
		if("FI".equals(commGrp) || "ST".equals(commGrp) || "QS".equals(commGrp) || "N/A".equals(commGrp))
		{
			String prodCode  = request.getParameter("atpfor");
			String prodDesc  = request.getParameter("atpdesc");
			String listPrice = request.getParameter("atpprice");
			String eanUpc 	 = request.getParameter("atpupc");

			productsRetObj.setFieldValue("PROD_CODE",prodCode);
			productsRetObj.setFieldValue("PROD_DESC",prodDesc);
			productsRetObj.setFieldValue("LIST_PRICE",listPrice);
			productsRetObj.setFieldValue("UPC_CODE",eanUpc);
			productsRetObj.setFieldValue("CATEGORY_CODE","N/A");
			productsRetObj.setFieldValue("PROG_TYPE",catType_C);
			productsRetObj.setFieldValue("TYPE","N/A");
			productsRetObj.setFieldValue("STATUS","N/A");
			productsRetObj.setFieldValue("QUANTITY",quantityC);
			productsRetObj.setFieldValue("CUST_QUOTE","N/A");
			productsRetObj.setFieldValue("PROD_SKU","N/A");
			productsRetObj.setFieldValue("PROD_LINE","N/A");
			productsRetObj.setFieldValue("QUOTE_NUM","N/A");
			productsRetObj.setFieldValue("QUOTE_LINE","N/A");
			productsRetObj.setFieldValue("COMM_GRP",commGrp);
			productsRetObj.setFieldValue("SALES_ORG","N/A");
			productsRetObj.setFieldValue("PROD_ATTRS","N/A");
			productsRetObj.setFieldValue("CUST_ATTRS","N/A");
			productsRetObj.setFieldValue("PROD_ALLOW","N/A");
			productsRetObj.setFieldValue("OPEN_QTY",quantityC);
			productsRetObj.addRow();
		}
		else
			notAdded="RE";
	}
	else
		notAdded="DX";

	String fileName = "ezAddCartItems.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
	out.println(notAdded);

	//response.sendRedirect("ezViewCart.jsp?categoryID="+categoryID+"&enteredCode="+prodCode);
%>
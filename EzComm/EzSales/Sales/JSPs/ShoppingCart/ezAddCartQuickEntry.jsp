<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager1" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="ezGetProductInfo.jsp"%>
<%@ include file="ezReturnJobQuotePrice.jsp"%>
<%
	String notAdded = "NA";

	String categoryID  = request.getParameter("categoryID");
	String enteredCode = request.getParameter("atpfor");
	String quantity_A  =  request.getParameter("atpqty");
	String prodSku_A = request.getParameter("prodSku");
	String poLine	 = request.getParameter("poLine");
	String quoteNo_A = request.getParameter("quoteNo");
	String quoteLine = request.getParameter("quoteLine");	
	String jobItemPrice = "";
	String quoteOpenQty = "";
	boolean toBeAdded = true;

	if(prodSku_A==null || "null".equalsIgnoreCase(prodSku_A) || "".equals(prodSku_A)) prodSku_A = "N/A";
	if(poLine==null || "null".equalsIgnoreCase(poLine) || "".equals(poLine)) poLine = "N/A";
	if(quoteNo_A==null || "null".equalsIgnoreCase(quoteNo_A) || "".equals(quoteNo_A)) quoteNo_A = "N/A";
	if(quoteLine==null || "null".equalsIgnoreCase(quoteLine) || "".equals(quoteLine)) quoteLine = "N/A";
%>
<%@ include file="ezCartConditions.jsp"%>
<%
	String[] prdColumns = new String[]{"PROD_CODE","PROD_DESC","LIST_PRICE","UPC_CODE","CATEGORY_CODE","PROG_TYPE","TYPE","STATUS","QUANTITY","CUST_QUOTE","PROD_SKU","PROD_LINE","QUOTE_NUM","QUOTE_LINE","COMM_GRP","SALES_ORG","PROD_ATTRS","CUST_ATTRS","PROD_ALLOW","OPEN_QTY"};
	ReturnObjFromRetrieve productsRetObj = new ReturnObjFromRetrieve(prdColumns);

	ReturnObjFromRetrieve prodStatObj = null;

	java.util.ArrayList commGrpAL = new java.util.ArrayList();

	String catalogCode = (String)session.getValue("CatalogCode");
	String userRole = (String)session.getValue("UserRole");

	try
	{
		prodStatObj = getProductStatus(Session,catalogCode,userRole,enteredCode);
	}
	catch(Exception e){}

	if(prodStatObj!=null && prodStatObj.getRowCount()>0)
	{
		Hashtable custAttrsHT = (Hashtable)session.getValue("CUSTATTRS");
		String soldToCode = (String)session.getValue("AgentCode");
		String shipToCode = (String)session.getValue("ShipCode");

		for(int i=0;i<prodStatObj.getRowCount();i++)
		{
			boolean prdAllowed = false;

			String status	 = prodStatObj.getFieldValueString(i,"EZP_STATUS");

			if("CU".equals(userRole) && "ZE".equals(status))
				prdAllowed = checkExclusive(Session,soldToCode,shipToCode,enteredCode);		// Customer Exclusive table check
			else
				prdAllowed = true;

			if(prdAllowed)
			{
				String prodCode  = prodStatObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
				String prodDesc  = prodStatObj.getFieldValueString(i,"PROD_DESC");
				String listPrice = prodStatObj.getFieldValueString(i,"EZP_CURR_PRICE");
				String eanUpc 	 = prodStatObj.getFieldValueString(i,"EZP_UPC_CODE");
				String prodCat   = prodStatObj.getFieldValueString(i,"ECP_CATEGORY_CODE");
				String quantityC = quantity_A;
				String quoteNoC	 = quoteNo_A;
				String quoteLNo	 = quoteLine;
				String prodSkuC	 = prodSku_A;
				String poLineC	 = poLine;
				String prdType	 = prodStatObj.getFieldValueString(i,"EZP_TYPE");
				String commGrp	 = prodStatObj.getFieldValueString(i,"EZP_ATTR1");
				String prdSysKey = prodStatObj.getFieldValueString(i,"EZP_SALES_ORG");
				String prdAttrs  = prodStatObj.getFieldValueString(i,"EZP_PROD_ATTRS");
				String custAttr  = "";
				String prodAllow = "X";
				String prodDiv   = prodStatObj.getFieldValueString(i,"DIVISION");

				prdAllowed = checkDXVProd(prodDiv,DXVProd,rpDXVProd,nonDXVProd);	// DXV Product Check

				if(prdAllowed)
				{
					if("CU".equals(userRole))
					{
						//prdAllowed = false;
						try
						{
							custAttr  = (String)custAttrsHT.get(prdSysKey);
							prdAllowed = checkAttributes(prdAttrs,custAttr);	// Product/Customer Attributes Check
						}
						catch(Exception e){}
					}

					if(prdAllowed)
					{
						prdAllowed = false;
						prodAllow = "Y";

						if(quantityC==null || "null".equalsIgnoreCase(quantityC) || "".equals(quantityC)) quantityC = "1";
						if(quoteOpenQty==null || "null".equalsIgnoreCase(quoteOpenQty) || "".equals(quoteOpenQty)) quoteOpenQty = quantityC;
						if(categoryID==null || "null".equalsIgnoreCase(categoryID) || "".equals(categoryID)) categoryID = prodCat;
						if(commGrp==null || "null".equals(commGrp)) commGrp = "";

						if(!"CU".equals(userRole) && ("ZR".equals(status) || "ZE".equals(status)))
						{
							commGrp = "";
						}

						if(!"N/A".equals(quoteNo_A))
						{
							quoteNo_A = "0000000000"+quoteNo_A;
							quoteNo_A = quoteNo_A.substring(quoteNo_A.length()-10,quoteNo_A.length());
							quoteNo_A = quoteNo_A.trim();
						}
						if(!"N/A".equals(quoteLine))
						{
							quoteLine = "000000"+quoteLine;
							quoteLine = quoteLine.substring(quoteLine.length()-6,quoteLine.length());
							quoteLine = quoteLine.trim();

							try
							{
								String jobItemPriceQty = getJobQuotePrice(Session,quoteNo_A,quoteLine,enteredCode,quantity_A,soldToCode);
								jobItemPrice = jobItemPriceQty.split("¥")[0];
								quoteOpenQty = jobItemPriceQty.split("¥")[1];
							}
							catch(Exception e){}

							if("JR".equals(jobItemPrice) || "NL".equals(jobItemPrice) || "NM".equals(jobItemPrice) || "NQ".equals(jobItemPrice) || "EQ".equals(jobItemPrice) || "CQ".equals(jobItemPrice))
							{
								toBeAdded 	= false;
								notAdded 	= jobItemPrice;
							}
						}

						if(toBeAdded)
						{
							try
							{
								commGrpAL = getCommGrp(Session);
								prdAllowed = checkCommGroup(quoteNoC,commGrpAL,commGrp);

								if("N/A".equals(quoteNoC) && !(commGrpAL.contains(commGrp) || "".equals(commGrp)))
								{
									notAdded = "RE";
								}
							}
							catch(Exception e){}
						}

						if(prdAllowed)
						{
							prodAllow = "X";

							if("KI".equals(prdType))
							{
								listPrice = checkKitCompPrice(Session,prodCode,listPrice);
							}
							if(!"JR".equals(jobItemPrice) && !"NL".equals(jobItemPrice) && !"NM".equals(jobItemPrice) && !"NQ".equals(jobItemPrice) && !"EQ".equals(jobItemPrice) && !"CQ".equals(jobItemPrice) && !"".equals(jobItemPrice))
							{
								listPrice = jobItemPrice;
							}

							String defProgType = (String)session.getValue("DEFPROG");//request.getParameter("dispVipProd");

							if("PT".equals(catType_C) || "QT".equals(catType_C))
							{
								if(defProgType!=null && "NONE".equals(defProgType)) catType_C = "PT";
								else if(defProgType!=null && "DISP".equals(defProgType)) catType_C = "DISP";
								else if(defProgType!=null && "VIP".equals(defProgType)) catType_C = "VIP";
								else if(defProgType!=null && "FOC".equals(defProgType)) catType_C = "FOC";
							}

							productsRetObj.setFieldValue("PROD_CODE",prodCode);
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
							productsRetObj.setFieldValue("QUOTE_NUM",quoteNo_A);
							productsRetObj.setFieldValue("QUOTE_LINE",quoteLine);
							productsRetObj.setFieldValue("COMM_GRP",commGrp);
							productsRetObj.setFieldValue("SALES_ORG",prdSysKey);
							productsRetObj.setFieldValue("PROD_ATTRS",prdAttrs);
							productsRetObj.setFieldValue("CUST_ATTRS",custAttr);
							productsRetObj.setFieldValue("PROD_ALLOW",prodAllow);
							productsRetObj.setFieldValue("OPEN_QTY",quoteOpenQty);
							productsRetObj.addRow();
						}
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
		}
	}

	String fileName = "ezAddCartQuickEntry.jsp";
%>
<%@ include file="ezAddCart.jsp"%>
<%
	out.println(notAdded);

	//response.sendRedirect("ezViewCart.jsp?categoryID="+categoryID+"&enteredCode="+enteredCode+"&notAdded="+notAdded);
%>

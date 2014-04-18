<%
	if(productsRetObj!=null && productsRetObj.getRowCount()>0)
	{
		int prdCnt = productsRetObj.getRowCount();

		String[] matIds   	= new String[prdCnt];
		String[] products 	= new String[prdCnt];
		String[] reqQtys  	= new String[prdCnt];
		String[] reqDates 	= new String[prdCnt];
		String[] catalogs 	= new String[prdCnt];

		String[] uom	 	= new String[prdCnt];
		String[] unitPrice 	= new String[prdCnt];
		String[] matDesc 	= new String[prdCnt];

		String[] mmFlag 	= new String[prdCnt];
		String[] currency 	= new String[prdCnt];
		String[] varPriceFlag 	= new String[prdCnt];
		String[] brand 		= new String[prdCnt];
		String[] upcNo 		= new String[prdCnt];
		String[] discPer_A	= new String[prdCnt];
		String[] discCode_A	= new String[prdCnt];
		String[] orgPrice_A	= new String[prdCnt];
		String[] mfrCode_A	= new String[prdCnt];
		String[] mfrPartNo_A	= new String[prdCnt];
		String[] weight_A	= new String[prdCnt];

		String[] cat1		= new String[prdCnt];
		String[] cat2		= new String[prdCnt];
		String[] cat3		= new String[prdCnt];
		String[] custSku	= new String[prdCnt];
		String[] poLine_A	= new String[prdCnt];
		String[] reftype	= new String[prdCnt];
		String[] division	= new String[prdCnt];
		String[] distChnl	= new String[prdCnt];
		String[] salesOrg	= new String[prdCnt];
		String[] ordType	= new String[prdCnt];
		String[] volume_A	= new String[prdCnt];
		String[] points_A	= new String[prdCnt];
		String[] plant_A	= new String[prdCnt];
		String[] kitComp_A	= new String[prdCnt];
		String[] ext1		= new String[prdCnt];
		String[] ext2		= new String[prdCnt];
		String[] ext3		= new String[prdCnt];

		for(int i=0;i<prdCnt;i++)
		{
			String lineItem	 = "";

			if(cartRows>0)
			{
				lineItem = (String)session.getValue("LINEITEM");

				if(lineItem==null || "null".equalsIgnoreCase(lineItem) || "".equals(lineItem))
					lineItem = ((cartRows+1)*10)+"";
			}
			else
			{
				lineItem = ((cartRows+1)*10)+"";
				cartRows++;
			}

			String lineItemSes = (Integer.parseInt(lineItem)+10)+"";
			session.putValue("LINEITEM",lineItemSes);

			String prodCode  = productsRetObj.getFieldValueString(i,"PROD_CODE");
			String prodDesc  = productsRetObj.getFieldValueString(i,"PROD_DESC");
			String listPrice = productsRetObj.getFieldValueString(i,"LIST_PRICE");
			String eanUpc    = productsRetObj.getFieldValueString(i,"UPC_CODE");
			String prodCat   = productsRetObj.getFieldValueString(i,"CATEGORY_CODE");
			String poPrgType = productsRetObj.getFieldValueString(i,"PROG_TYPE");
			String quantity  = productsRetObj.getFieldValueString(i,"QUANTITY");
			String quoteNo	 = productsRetObj.getFieldValueString(i,"QUOTE_NUM");
			String lineNo 	 = productsRetObj.getFieldValueString(i,"QUOTE_LINE");
			String cust_Qt 	 = productsRetObj.getFieldValueString(i,"CUST_QUOTE");
			String prodSku 	 = productsRetObj.getFieldValueString(i,"PROD_SKU");
			String prodLine	 = productsRetObj.getFieldValueString(i,"PROD_LINE");
			String prodAttrs = productsRetObj.getFieldValueString(i,"PROD_ATTRS");
			String qOpenQty  = productsRetObj.getFieldValueString(i,"OPEN_QTY");

			try
			{
				quantity = quantity.trim();
				quantity = (new java.math.BigDecimal(quantity)).toString();
			}
			catch(Exception e)
			{
				quantity = (new java.math.BigDecimal("1")).toString();
			}
%>
<%@include file="../../../Includes/JSPs/Misc/iPointsAlerts.jsp"%>
<%
			matIds[i] 	= prodCode;
			products[i]     = lineItem;
			reqQtys[i]  	= quantity;
			reqDates[i] 	= "1.11.1000";
			catalogs[i]	= groupID;	//from iPointsAlerts

			uom[i] 		= "EA";
			unitPrice[i] 	= listPrice;
			matDesc[i] 	= prodDesc;

			mmFlag[i]	= "CNET";
			currency[i] 	= imgLinkCart;	//from iPointsAlerts
			varPriceFlag[i]	= progTypeCart;	//from iPointsAlerts
			brand[i]	= "N/A";
			upcNo[i]	= eanUpc;
			discPer_A[i]	= brandCart;	//from iPointsAlerts
			discCode_A[i]	= prodStatus;	//from iPointsAlerts
			orgPrice_A[i]	= quantity;     //"N/A";
			mfrCode_A[i]	= cust_Qt;	//"N/A";
			mfrPartNo_A[i]	= quoteNo;	//"N/A";
			weight_A[i]	= lineNo;	//"N/A";

			cat1[i]		= poPrgType;	//"N/A";
			//cat2[i]		= "N/A";
			cat3[i]		= "N/A";
			kitComp_A[i]	= compItems_A;	//from iPointsAlerts (num of kit components)
			custSku[i]	= prodSku;	//"N/A";
			poLine_A[i]	= prodLine;	//"N/A";
			reftype[i]	= poPrgType;
			volume_A[i]	= volume;	//from iPointsAlerts
			points_A[i]	= points;	//from iPointsAlerts
			ext1[i]		= classType;	//from iPointsAlerts (this is for classification, LUX for luxury, COM for commercial)
			ext2[i]		= qOpenQty;	// Job Quantity change
			ext3[i]		= prodAttrs;	// Product Attributes

			String div_C	= (String)session.getValue("division");
			String dChnl_C  = (String)session.getValue("dc");
			String sOrg_C	= (String)session.getValue("salesOrg");
			String oType_C	= "OR";

			try
			{
				String filePath = request.getRealPath(fileName);

				String returnValue = getProductInfo(Session,prodCode,sOrg_C,div_C,dChnl_C,oType_C,fileName,filePath);
				//out.println("returnValue::"+returnValue);

				salesOrg[i] = returnValue.split("¥")[0];
				division[i] = returnValue.split("¥")[1];
				distChnl[i] = returnValue.split("¥")[2];
				ordType[i]  = returnValue.split("¥")[3];
				brand[i]    = returnValue.split("¥")[4];	// setting plant
				cat2[i]     = returnValue.split("¥")[5];	// setting material division
				plant_A[i]  = returnValue.split("¥")[6];	// getting material plant not sure of above plant at [4]
			}
			catch(Exception e){}

			if("DISP".equals(reftype[i]))
			{
				if("ZIDS".equals(ordType[i])) 
					ordType[i] = "ZIDP";
				else
					ordType[i] = "ZDPO";
			}
			else if("VIP".equals(reftype[i]))
			{
				ordType[i] = "ZDPO";
			}
			else if("QS".equals(reftype[i]))	//used for quick ship items
				ordType[i] = "Z1";
			else if("FOC".equals(reftype[i]))
			{
				distChnl[i] = "70";

				if("24".equals(plant_A[i]) || "956".equals(plant_A[i]) || "167".equals(plant_A[i]))//(ordType[i]).startsWith("ZIS"))
					ordType[i] = "ZIDF";
				else
					ordType[i] = "FD";
			}

			if("20".equals(distChnl[i]))
			{
				if("ZDPO".equals(ordType[i]))
					ordType[i] = "Z28";
			}
			/*else if("90".equals(distChnl[i]))
			{
				ordType[i] = "Z1";
			}*/
		}

		reqparams.setMatId(matIds);
		reqparams.setProducts(products);
		reqparams.setReqQty(reqQtys);
		reqparams.setReqDate(reqDates);
		reqparams.setVendorCatalogs(catalogs); 

		reqparams.setUom(uom);
		reqparams.setUnitPrice(unitPrice);
		reqparams.setProdDesc(matDesc);

		reqparams.setDiscPer(discPer_A);
		reqparams.setDiscCode(discCode_A);
		reqparams.setOrgPrice(orgPrice_A);
		reqparams.setMfrCode(mfrCode_A);
		reqparams.setMfrPartNo(mfrPartNo_A);
		reqparams.setMmFlag(mmFlag);
		reqparams.setCurrency(currency);
		reqparams.setVarPriceFlag(varPriceFlag);
		reqparams.setBrand(brand);
		reqparams.setUpcNo(upcNo);
		reqparams.setWeight(weight_A);

		reqparams.setCat1(cat1);
		reqparams.setCat2(cat2);
		reqparams.setCat3(cat3);
		reqparams.setCustSku(custSku);
		reqparams.setPoLine(poLine_A);
		reqparams.setType(reftype);
		reqparams.setDivision(division);
		reqparams.setDistChnl(distChnl);
		reqparams.setSalesOrg(salesOrg);
		reqparams.setOrdType(ordType);
		reqparams.setVolume(volume_A);
		reqparams.setPoints(points_A);
		reqparams.setKitComp(kitComp_A);
		reqparams.setExt1(ext1);
		reqparams.setExt2(ext2);
		reqparams.setExt3(ext3);

		subparams.setType("AMSTAN");
		subparams.setLanguage("EN");
		subparams.setEziReqParams(reqparams);
		params.setObject(subparams);
		Session.prepareParams(params);

		try
		{
			SCManager.saveCart(params);
			SCManager.updateCart(params);
			SCManager.saveCartToPersistentStorage(params);
			notAdded="";
		}
		catch(Exception e){}
	}
%>
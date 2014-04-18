<%!
	private String getProductInfo(ezc.session.EzSession Session,String prodCode,String sOrg,String div,String dChnl,String oType,String fileName,String filePath)
	{
		String returnValue = "";
		
		ezc.ezcommon.EzLog4j.log("getProdinfo start:::"+(new Date()),"F");

		ezc.ezcommon.EzLog4j.log("sOrgsOrg::"+sOrg,"I");
		ezc.ezcommon.EzLog4j.log("divdiv::"+div,"I");
		ezc.ezcommon.EzLog4j.log("dChnldChnl::"+dChnl,"I");
		ezc.ezcommon.EzLog4j.log("oTypeoType::"+oType,"I");

		String salesOrg = sOrg;
		String division = div;
		String distChnl = dChnl;
		String ordType  = oType;
		String div_56   = "N/A";
		String division_M = "";
		String matPlant = "";

		try
		{
			ezc.ezparam.EzcParams prodParamsMisc= new ezc.ezparam.EzcParams(false);
			ezc.ezmisc.params.EziMiscParams prodParams = new ezc.ezmisc.params.EziMiscParams();
			ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

			ezc.ezparam.ReturnObjFromRetrieve prodAttrRetObj = null;
			ezc.ezparam.ReturnObjFromRetrieve prodOverRideObj = null;

			if(prodCode!=null && !"null".equals(prodCode) && !"".equals(prodCode))
			{
				String query1 = "";
				prodParams.setIdenKey("MISC_SELECT");

				query1="SELECT EPA_PRODUCT_CODE,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE IN ('"+prodCode+"') AND EPA_ATTR_CODE IN ('DIVISION','DIST_CHANNEL','SALES_ORG','ITEM_CAT_GROUP','DEF_DEL_PLANT','MATERIAL_GROUP5','SAP_COMM_GROUP','MATERIAL_GROUP1')";

				prodParams.setQuery(query1);

				prodParamsMisc.setLocalStore("Y");
				prodParamsMisc.setObject(prodParams);
				Session.prepareParams(prodParamsMisc);	

				try
				{
					prodAttrRetObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
					//out.println(prodAttrRetObj.toEzcString());
				}
				catch(Exception e)
				{
					//out.println("Exception in Getting Data"+e);
				}

				String queryOr = "";
				prodParams.setIdenKey("MISC_SELECT");

				queryOr="SELECT EAO_OVERRIDE_TYPE,EAO_VALUE FROM EZC_AMS_SPLIT_OVERRIDES WHERE EAO_VALUE_BASIS='"+prodCode+"' AND EAO_BASED_ON='1_MATERIAL'";

				prodParams.setQuery(queryOr);

				prodParamsMisc.setLocalStore("Y");
				prodParamsMisc.setObject(prodParams);
				Session.prepareParams(prodParamsMisc);	

				try
				{
					prodOverRideObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
					//out.println(prodOverRideObj.toEzcString());
				}
				catch(Exception e)
				{
					//out.println("Exception in Getting Data"+e);
				}
			}

			int prodAttrCnt = 0;

			if(prodAttrRetObj!=null)
			{
				String itemCatGrp = "";
				String matGrp5 = "";
				String defPlant = "";
				String divConf = "";
				String matDiv = "";
				String sapCommGrp = "";

				try
				{
					ezc.ezcommon.EzLog4j.log("fileName::"+fileName,"I");
					filePath = filePath.substring(0,filePath.indexOf(fileName));
					ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");
					filePath +="ezSplitCond.properties";
					ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");

					Properties prop=new Properties();
					prop.load(new java.io.FileInputStream(filePath));

					itemCatGrp 	= prop.getProperty("ITEMCATGROUP");
					matGrp5		= prop.getProperty("MATERIALGROUP5");
					defPlant	= prop.getProperty("DEFPLANT");
					divConf		= prop.getProperty("DIVISION");
					//matDiv	= prop.getProperty("MATDIV");
					sapCommGrp	= prop.getProperty("SAPCOMMGRP");

					/*ezc.ezcommon.EzLog4j.log("itemCatGrp::"+itemCatGrp,"I");
					ezc.ezcommon.EzLog4j.log("matGrp5::"+matGrp5,"I");
					ezc.ezcommon.EzLog4j.log("defPlant::"+defPlant,"I");
					ezc.ezcommon.EzLog4j.log("divConf::"+divConf,"I");
					ezc.ezcommon.EzLog4j.log("matDiv::"+matDiv,"I");
					ezc.ezcommon.EzLog4j.log("sapCommGrp::"+sapCommGrp,"I");*/
				}
				catch(Exception e){}

				prodAttrCnt = prodAttrRetObj.getRowCount();

				String salesOrg_M = "";
				String salesOrg_AO = "";
				String itemGrp_M = "";
				String matGrp5_M = "";
				String defDelPlant_M = "";
				String sapCommGrp_M = "";
				String ordType_M = "";
				String matGrp1_M = "";

				for(int i=0;i<prodAttrCnt;i++)
				{
					String attrCode = (prodAttrRetObj.getFieldValueString(i,"EPA_ATTR_CODE")).trim();
					String attrVal = prodAttrRetObj.getFieldValueString(i,"EPA_ATTR_VALUE");

					if("SALES_ORG".equals(attrCode))
						salesOrg_M = attrVal;
					if("DIVISION".equals(attrCode))
						division_M = attrVal;
					//if("DIST_CHANNEL".equals(attrCode))
						//distChnl = attrVal;

					if("ITEM_CAT_GROUP".equals(attrCode) && !"".equals(attrVal))
						itemGrp_M = attrVal;
					if("MATERIAL_GROUP5".equals(attrCode) && !"".equals(attrVal))
						matGrp5_M = attrVal;
					if("DEF_DEL_PLANT".equals(attrCode) && !"".equals(attrVal))
						defDelPlant_M = attrVal;
					if("SAP_COMM_GROUP".equals(attrCode) && !"".equals(attrVal))
						sapCommGrp_M = attrVal;
					if("MATERIAL_GROUP1".equals(attrCode) && !"".equals(attrVal))
						matGrp1_M = attrVal;
				}

				if(prodOverRideObj!=null)
				{
					for(int j=0;j<prodOverRideObj.getRowCount();j++)
					{
						String overRideCode = (prodOverRideObj.getFieldValueString(j,"EAO_OVERRIDE_TYPE")).trim();
						String overRideVal = prodOverRideObj.getFieldValueString(j,"EAO_VALUE");

						if("DIVISION".equals(overRideCode))
							division_M = overRideVal;
						if("DIST_CHANNEL".equals(overRideCode))
							distChnl = overRideVal;
						if("SALES_ORG".equals(overRideCode))
							salesOrg_AO = overRideVal;
						if("ORDER_TYPE".equals(overRideCode))
							ordType_M = overRideVal;
					}
				}

				/*if(oType.equals(ordType) && !"".equals(division_M))
				{
					ordType = applySplitRules(matDiv,division_M,ordType);

					ezc.ezcommon.EzLog4j.log("MAT_DIV::"+ordType,"I");
				}*/

				if(!"".equals(itemGrp_M))
				{
					ordType = applySplitRules(itemCatGrp,itemGrp_M,ordType);

					ezc.ezcommon.EzLog4j.log("ITEM_CAT_GROUP::"+ordType,"I");
					//if("BANS".equals(attrVal)) ordType = "ZDSH";
				}
				if(oType.equals(ordType) && !"".equals(matGrp5_M))
				{
					ordType = applySplitRules(matGrp5,matGrp5_M,ordType);

					ezc.ezcommon.EzLog4j.log("MATERIAL_GROUP5::"+ordType,"I");
					//if("VDS".equals(attrVal) || "CAN".equals(attrVal)) ordType = "ZIDS";
				}
				if(oType.equals(ordType) && !"".equals(defDelPlant_M))
				{
					ordType = applySplitRules(defPlant,defDelPlant_M,ordType);

					ezc.ezcommon.EzLog4j.log("DEF_DEL_PLANT::"+ordType,"I");
					//if("24".equals(attrVal) || "956".equals(attrVal)) ordType = "ZIDS";
					//if("15".equals(attrVal)) ordType = "Z1";
				}
				if(oType.equals(ordType) && !"".equals(sapCommGrp_M))
				{
					ordType = applySplitRules(sapCommGrp,sapCommGrp_M,ordType);

					ezc.ezcommon.EzLog4j.log("SAP_COMM_GROUP::"+ordType,"I");
					//if("24".equals(attrVal) || "956".equals(attrVal)) ordType = "ZIDS";
					//if("15".equals(attrVal)) ordType = "Z1";
				}
				if(oType.equals(ordType) && !"".equals(ordType_M))
				{
					ordType = ordType_M;

					ezc.ezcommon.EzLog4j.log("ORDER_TYPE::"+ordType,"I");
					//if("24".equals(attrVal) || "956".equals(attrVal)) ordType = "ZIDS";
					//if("15".equals(attrVal)) ordType = "Z1";
				}

				if(!"".equals(division_M))
					salesOrg = applySplitRules(divConf,division_M,"1001");

				if("56".equals(division_M) || "36".equals(division_M) || "5L".equals(division_M) || ("55".equals(division_M) && "ALX".equals(matGrp1_M))) div_56 = division_M;

				//if("35".equals(division_M)) salesOrg = "1004";
				//else if("32".equals(division_M) || "36".equals(division_M)) salesOrg = "1002";
				//else salesOrg = "1001";

				if("".equals(division_M)) division_M = "N/A";

				matPlant = defDelPlant_M;

				if(matPlant==null || "null".equalsIgnoreCase(matPlant) || "".equals(matPlant)) matPlant = "N/A";

				if(!"".equals(salesOrg_AO))
					salesOrg = salesOrg_AO;

				ezc.ezcommon.EzLog4j.log("salesOrg::"+salesOrg,"I");

				ezc.ezparam.ReturnObjFromRetrieve divRetObj = null;

				if(salesOrg!=null && !"null".equals(salesOrg) && !"".equals(salesOrg))
				{
					String query2 = "";
					prodParams.setIdenKey("MISC_SELECT");

					query2="SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY IN (SELECT ECAD_SYS_KEY FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_KEY='SALESORG' AND ECAD_VALUE='"+salesOrg+"') AND ECAD_KEY='DIVISION'";

					prodParams.setQuery(query2);

					prodParamsMisc.setLocalStore("Y");
					prodParamsMisc.setObject(prodParams);
					Session.prepareParams(prodParamsMisc);

					try
					{
						divRetObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
						//out.println(divRetObj.toEzcString());
					}
					catch(Exception e)
					{
						//out.println("Exception in Getting Data"+e);
					}
				}

				if(divRetObj!=null)
					division = divRetObj.getFieldValueString(0,"ECAD_VALUE");

				if("N/A".equals(div_56)) div_56 = division;
			}
		}
		catch(Exception ex){}

		returnValue = salesOrg+"¥"+division+"¥"+distChnl+"¥"+ordType+"¥"+div_56+"¥"+division_M+"¥"+matPlant;

		return returnValue;
	}
	private String applySplitRules(String condType,String attrVal,String retType)
	{
		String returnType = retType;

		try
		{
			ezc.ezcommon.EzLog4j.log("condType::in applySplitRules::"+condType,"I");

			java.util.StringTokenizer condChk = null;

			if(condType!=null && (condType.indexOf("§"))!=-1)
			{
				java.util.StringTokenizer condConf = new java.util.StringTokenizer(condType,"§");

				if(condConf!=null)
				{
					while(condConf.hasMoreElements())
					{
						String condConfStr = (String)condConf.nextElement();

						condChk = new java.util.StringTokenizer(condConfStr,"¥");

						while(condChk.hasMoreElements())
						{
							String condVal1 = (String)condChk.nextElement();
							String condVal2 = (String)condChk.nextElement();

							if(attrVal.equals(condVal1))
								returnType = condVal2;
						}
					}
				}
			}
			else
			{
				condChk = new java.util.StringTokenizer(condType,"¥");

				while(condChk.hasMoreElements())
				{
					String condVal1 = (String)condChk.nextElement();
					String condVal2 = (String)condChk.nextElement();

					if(attrVal.equals(condVal1))
						returnType = condVal2;
				}
			}
		}
		catch(Exception e){}

		ezc.ezcommon.EzLog4j.log("returnType::in applySplitRules::"+returnType,"I");
		ezc.ezcommon.EzLog4j.log("getProdinfo end:::"+(new Date()),"F");

		return returnType;
	}
	private String checkKitCompPrice(ezc.session.EzSession Session,String prodCode,String listPrice)
	{
		String returnValue = listPrice;

		try
		{
			ezc.ezparam.EzcParams prodParamsMisc= new ezc.ezparam.EzcParams(false);
			ezc.ezmisc.params.EziMiscParams prodParams = new ezc.ezmisc.params.EziMiscParams();
			ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

			ezc.ezparam.ReturnObjFromRetrieve prodKitRetObj = null;

			if(prodCode!=null && !"null".equals(prodCode) && !"".equals(prodCode))
			{
				String query1 = "";
				prodParams.setIdenKey("MISC_SELECT");

				query1="SELECT EZP_PRODUCT_CODE,EZP_CURR_PRICE,EZP_STATUS FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN (SELECT EPR_PRODUCT_CODE2 FROM EZC_PRODUCT_RELATIONS WHERE EPR_PRODUCT_CODE1='"+prodCode+"' AND EPR_RELATION_TYPE='SBOM')";

				prodParams.setQuery(query1);

				prodParamsMisc.setLocalStore("Y");
				prodParamsMisc.setObject(prodParams);
				Session.prepareParams(prodParamsMisc);	

				prodKitRetObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
			}
			if(prodKitRetObj!=null && prodKitRetObj.getRowCount()>0)
			{
				for(int i=0;i<prodKitRetObj.getRowCount();i++)
				{
					String kitListPrice = prodKitRetObj.getFieldValueString(i,"EZP_CURR_PRICE");

					java.math.BigDecimal bKitPrice = new java.math.BigDecimal(kitListPrice);
					bKitPrice = bKitPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);

					if("0.00".equals(bKitPrice.toString()))
					{
						returnValue = bKitPrice.toString();
						break;
					}
				}
			}
		}
		catch(Exception e){}

		return returnValue;
	}
	public boolean checkAttributes(String prdAttrs,String custAttr)
	{
		boolean prdAllowed = true;
		int i1 = custAttr.indexOf("X");
		char c1;
		while (i1 >= 0)
		{
			c1 = prdAttrs.charAt(i1);

			prdAllowed = true;
			if('X'==c1)
			{
				prdAllowed = false;
				break;
			}
			i1 = custAttr.indexOf("X",i1+1);
		}
		return prdAllowed;
	}
	public boolean checkDXVProd(String prodDiv,boolean DXVProd,boolean rpDXVProd,boolean nonDXVProd)
	{
		boolean prdAllowed = false;

		if("D1".equals(prodDiv) || "D2".equals(prodDiv) || "D3".equals(prodDiv) || "D4".equals(prodDiv) || "D5".equals(prodDiv))
		{
			if(DXVProd)
			{
				prdAllowed = true;
			}
			else if(rpDXVProd)
			{
				prdAllowed = true;
				DXVProd = true;
				rpDXVProd = false;
			}
			else if(nonDXVProd)
			{
				prdAllowed = false;
			}
		}
		else if("D9".equals(prodDiv))
		{
			prdAllowed = true;
		}
		else
		{
			if(nonDXVProd)
			{
				prdAllowed = true;
			}
			else if(rpDXVProd)
			{
				prdAllowed = true;
				nonDXVProd = true;
				rpDXVProd = false;
			}
			else if(DXVProd)
			{
				prdAllowed = false;
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

			prdAllowed = true;
		}

		return prdAllowed;
	}
	public boolean checkCommGroup(String quoteNoC,java.util.ArrayList commGrpAL,String commChk)
	{
		boolean prdAllowed = false;

		if("N/A".equals(quoteNoC))
		{
			if(commGrpAL.contains(commChk) || "".equals(commChk))
			{
				prdAllowed = true;
			}
		}
		else
		{
			prdAllowed = true;
		}

		return prdAllowed;
	}
	public boolean checkExclusive(ezc.session.EzSession Session,String soldToCode,String shipToCode,String enteredCode)
	{
		boolean prdAllowed = false;
		ezc.ezparam.ReturnObjFromRetrieve prodStatObj = null;

		ezc.ezparam.EzcParams prodParamsMisc = new ezc.ezparam.EzcParams(false);
		ezc.ezmisc.params.EziMiscParams prodParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

		String query1="SELECT * FROM EZC_CUSTOMER_EXCLUSIVE WHERE ECE_SOLD_TO='"+soldToCode+"' AND ECE_PRODUCT_CODE='"+enteredCode+"'";

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery(query1);
		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			prodStatObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);

			if(prodStatObj!=null && prodStatObj.getRowCount()>0)
			{
				for(int i=0;i<prodStatObj.getRowCount();i++)
				{
					String shipToCode_E = prodStatObj.getFieldValueString(i,"ECE_SHIP_TO");
					String notAllowed_E = prodStatObj.getFieldValueString(i,"ECE_NOT_ALLOWED");

					if(notAllowed_E!=null && !"X".equals(notAllowed_E))
					{
						if(shipToCode_E!=null && !"null".equalsIgnoreCase(shipToCode_E) && !"".equals(shipToCode_E))
						{
							if(shipToCode.equals(shipToCode_E))
								prdAllowed = true;
						}
						else
							prdAllowed = true;
					}
				}
			}
		}
		catch(Exception e){}

		return prdAllowed;
	}
	public ezc.ezparam.ReturnObjFromRetrieve getProductStatus(ezc.session.EzSession Session,String catalogCode,String userRole,String enteredCode)
	{
		ezc.ezparam.ReturnObjFromRetrieve prodStatObj = null;

		ezc.ezparam.EzcParams prodParamsMisc = new ezc.ezparam.EzcParams(false);
		ezc.ezmisc.params.EziMiscParams prodParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

		String appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZR','ZM','ZL','ZD','ZP')";	//'ZE',

		if(!"CU".equals(userRole))
			appendQry = " AND EZP_STATUS NOT IN ('Z2','Z3','01','11','ZD','ZP')";

		String query1="SELECT TOP 1 ECP_CATEGORY_CODE,EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC,EZP_TYPE,EZP_STATUS,EZP_UPC_CODE,EZP_WEIGHT,EZP_WEIGHT_UOM,EZP_CURR_PRICE,EZP_ATTR1,EZP_SALES_ORG,EZP_PROD_ATTRS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DIVISION') DIVISION FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORIES,EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_CATEGORY_CODE = EC_CODE AND ECC_CATEGORY_ID = EC_PARENT AND ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+enteredCode+"') AND EPD_LANG_CODE='EN'"+appendQry;

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery(query1);
		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			prodStatObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}

		return prodStatObj;
	}
	public java.util.ArrayList getCommGrp(ezc.session.EzSession Session)
	{
		java.util.ArrayList commGrpAL = new java.util.ArrayList();

		ezc.ezparam.ReturnObjFromRetrieve commGrpRetObj = null;

		ezc.ezparam.EzcParams prodParamsMisc = new ezc.ezparam.EzcParams(false);
		ezc.ezmisc.params.EziMiscParams prodParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

		prodParams.setIdenKey("MISC_SELECT");
		prodParams.setQuery("SELECT * from EZC_VALUE_MAPPING where MAP_TYPE='COMMGRPALLOWED'");
		prodParamsMisc.setLocalStore("Y");
		prodParamsMisc.setObject(prodParams);
		Session.prepareParams(prodParamsMisc);	

		try
		{
			commGrpRetObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(prodParamsMisc);
		}
		catch(Exception e){}

		if(commGrpRetObj!=null && commGrpRetObj.getRowCount()>0)
		{
			for(int i=0;i<commGrpRetObj.getRowCount();i++)
			{
				String commGrpCodeMap = commGrpRetObj.getFieldValueString(i,"VALUE1");
				commGrpAL.add(commGrpCodeMap);
			}
		}

		return commGrpAL;
	}
%>
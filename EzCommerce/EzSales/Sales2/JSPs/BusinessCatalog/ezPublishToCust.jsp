<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%> 
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%

	String[] products= (String[])session.getAttribute("productspc");
	String[] venCatalogs= (String[])session.getAttribute("prodCatalogspc");
	String[] matIds= (String[])session.getAttribute("matidspc");
	String[] types= (String[])session.getAttribute("typespc");
	
	String type=request.getParameter("type");
	String noDataStatement =""; 
	
	String soldTo1=request.getParameter("soldTo1");
	String favGroupDesc=request.getParameter("FavGroupDesc");
	String favWebDesc=request.getParameter("FavWebDesc");
	
	
	String soldTo=request.getParameter("soldTo");
	String catalog=request.getParameter("catalog");
	if(catalog!=null)catalog=catalog.trim();
	if(favGroupDesc!=null)favGroupDesc=favGroupDesc.trim();
	
	String sysKey = (String)session.getValue("SalesAreaCode");
	
	String userId = "";
	
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setSyskeys(sysKey);
	if("CCP".equals(type))
		adminUtilsParams.setPartnerValueBy(soldTo1);
	else if("ACP".equals(type))
		adminUtilsParams.setPartnerValueBy(soldTo);
	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(adminUtilsParams);
	Session.prepareParams(mainParams);

	ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	if(partnersRet!=null && partnersRet.getRowCount()>0)
	{
		userId = partnersRet.getFieldValueString(0,"EU_ID");
		if(userId!=null)userId=userId.trim();
		
		ezc.ezparam.EzcUserParams uparams = null;
		EzcUserNKParams ezcUserNKParams = null;

		if(partnersRet!=null && partnersRet.getRowCount()>0)
		{
			MAINLOOP:
			for(int l=0;l<partnersRet.getRowCount();l++)
			{
				uparams= new ezc.ezparam.EzcUserParams();
				ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key("0");
				uparams.createContainer();
				uparams.setUserId(partnersRet.getFieldValueString(l,"EU_ID"));
				uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);
				ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));

				for(int i=0;i<retobj.getRowCount();i++)
				{
					if("ISSUBUSER".equals(retobj.getFieldValueString(i,"EUD_KEY")) && !"Y".equals(retobj.getFieldValueString(i,"EUD_VALUE").trim()))
					{
						userId = partnersRet.getFieldValueString(l,"EU_ID");
						break MAINLOOP;
					}
				}
			}
		}	
		
		
		
		
		
	}
	if(!"".equals(userId))
	{
		if("CCP".equals(type))
		{
			EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
			EziPersonalizationParams iparams = new EziPersonalizationParams();
			iparams.setLanguage("EN");
			iparams.setUserId(userId);
			iparams.setProductFavGroupDesc(favGroupDesc);
			iparams.setProductFavGroupWebDesc(favWebDesc);
			ezpparams.setObject(iparams);
			Session.prepareParams(ezpparams);
			EzcPersonalizationManager.addUserProdFavDesc(ezpparams);
			
			String groupNumber = "";
			String groupDesc = "";
			String webDesc = "";
			String finalGroupNumber="";
			EzcPersonalizationParams ezget = new EzcPersonalizationParams();
			EziPersonalizationParams izget = new EziPersonalizationParams();
			izget.setLanguage("EN");
			izget.setUserId(userId);
			ezget.setObject(izget);
			Session.prepareParams(ezget);
			ReturnObjFromRetrieve retFAV = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
			int retprodfavCount=retFAV.getRowCount();
			for ( int i = 0 ; i < retprodfavCount ; i++ )
			{
				groupNumber     = retFAV.getFieldValueString(i,"EPG_NO");
				groupDesc       = retFAV.getFieldValueString(i,"EPGD_DESC");
				webDesc         = retFAV.getFieldValueString(i,"EPGD_WEB_DESC");
				if( webDesc.equals(favWebDesc) || favWebDesc.equals(webDesc) )
				{
					finalGroupNumber = groupNumber;	
				}

			}
			
			for( int k = 0; k < products.length; k++)
			{
			       if("CNET".equals(types[k]))
					venCatalogs[k] = "10@@@10@@@CNET@@@"+venCatalogs[k];
			       else
					venCatalogs[k] = venCatalogs[k]+"@@@"+matIds[k]+"@@@VC@@@##";
			}
			
			
			ezget = new EzcPersonalizationParams();
			izget = new EziPersonalizationParams();
			izget.setLanguage("EN");
			izget.setUserId(userId);
			izget.setObject(products);
			izget.setVendorCatalogs(venCatalogs);
			izget.setProductFavGroup(finalGroupNumber);
			ezget.setObject(izget);
			Session.prepareParams(ezget);
			EzcPersonalizationManager.addUserProdFavMat(ezget);
			
			

		}
		else if("ACP".equals(type))
		{
			
			String tempProducts[] = new String[products.length];
			String tempVendCatalogs[] = new String[products.length];
			String tempMatIds[] = new String[products.length];
			String tempTypes[] = new String[products.length];
			String tempItemCat[] = new String[products.length];

			EzCatalogParams ezread = new EzCatalogParams();
			ezread.setLanguage("EN");
			ezread.setUserId(userId);
			ezread.setProductGroup(catalog);
			Session.prepareParams(ezread);

			ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
			ReturnObjFromRetrieve cnetRet = (ReturnObjFromRetrieve)ret.getObject("CNETRET");

			int tempProdIndex=0;
			for ( int j = 0; j < products.length; j++)
			{
				String retProd = products[j];

				if("CNET".equals(types[j]))
				{
					String iCat = venCatalogs[j];
					boolean pres = false;
					for ( int k = 0; k < cnetRet.getRowCount(); k++)
					{
						if(retProd.equals(cnetRet.getFieldValueString(k,"EPF_MAT_NO")) && iCat.equals(cnetRet.getFieldValueString(k,"EPF_ITEMCAT")))
						{
							pres = true;
							break;
						}
					}


					if(!pres)
					{
						tempProducts[tempProdIndex] = products[j];
						tempVendCatalogs[tempProdIndex] = "10";
						tempMatIds[tempProdIndex] = "10";
						tempItemCat[tempProdIndex] = venCatalogs[j];
						tempTypes[tempProdIndex++] = "CNET";

					}

				}
				else
				{
					if ( ret != null && !ret.find("EMM_ID",new java.math.BigDecimal(retProd)))
					{
						tempProducts[tempProdIndex] = products[j];
						tempVendCatalogs[tempProdIndex] = venCatalogs[j];
						tempMatIds[tempProdIndex] = matIds[j];
						tempItemCat[tempProdIndex] = "##";
						tempTypes[tempProdIndex++] = "VC";
					}
				}
			}
			String newProducts[]     = new String[tempProdIndex];
			String newVendCatalogs[] = new String[tempProdIndex];
			for( int k = 0; k < tempProdIndex; k++)
			{
				if ( tempProducts[k] != null )
				{
				       newProducts[k]     = tempProducts[k];
				       newVendCatalogs[k] = tempVendCatalogs[k]+"@@@"+tempMatIds[k]+"@@@"+tempTypes[k]+"@@@"+tempItemCat[k];


				}
			}
			
			EzcPersonalizationParams ezget = new EzcPersonalizationParams();
			EziPersonalizationParams izget = new EziPersonalizationParams();
			izget.setLanguage("EN");
			izget.setUserId(userId);
			izget.setObject(newProducts);
			izget.setVendorCatalogs(newVendCatalogs);
			izget.setProductFavGroup(catalog);
			ezget.setObject(izget);
			Session.prepareParams(ezget);
			EzcPersonalizationManager.addUserProdFavMat(ezget);

		}
		noDataStatement = "Published successfully";
	}
	else
	{
		noDataStatement = "Problem occured while publishing";
	}


%>
<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
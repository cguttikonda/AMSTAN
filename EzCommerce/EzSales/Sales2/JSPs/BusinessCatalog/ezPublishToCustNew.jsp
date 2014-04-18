<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UAdminManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<%


	String [] products = null;
	String [] venCatalogs = null;
	String [] itemCats = null;
	String [] matIds = null;
	String [] types = null;
	
	String selCustomer = request.getParameter("selCustomer");
	String strTcount =  request.getParameter("TotalCount");
	String noDataStatement = "";

	if ( strTcount != null )
	{
		int totCount = (new Integer(strTcount)).intValue();

		if ( totCount > 0 )
		{
			products = new String[totCount];
			venCatalogs =new String[totCount];
			matIds =new String[totCount];
			types =new String[totCount];
			itemCats =new String[totCount];

			for ( int i = 0 ; i < totCount; i++ )
			{
				products[i] = request.getParameter("CNETPrd_"+i);
				venCatalogs[i] = request.getParameter("VendCatalog_"+i);
				itemCats[i] = request.getParameter("VendCatalog_"+i);
				venCatalogs[i] = "10@@@10@@@CNET@@@"+venCatalogs[i];
				matIds[i] = request.getParameter("matId_"+i);
				types[i] = request.getParameter("mmFlag_"+i);


			}
		}
	}


	String sysKey = (String)session.getValue("SalesAreaCode");
	
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setSyskeys(sysKey);
	adminUtilsParams.setPartnerValueBy(selCustomer);

	EzcParams mainParams = new EzcParams(false);
	mainParams.setObject(adminUtilsParams);
	Session.prepareParams(mainParams);

	ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	
	if(partnersRet!=null && partnersRet.getRowCount()>0)
	{
		String userId = "";
		for(int l=0;l<partnersRet.getRowCount();l++)
		{
			String tmpSendToUser = partnersRet.getFieldValueString(l,"EU_ID");

			if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) 
			{
				tmpSendToUser = tmpSendToUser.trim();

				ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key("0");
				uparams.createContainer();
				uparams.setUserId(tmpSendToUser);
				uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);
				ReturnObjFromRetrieve retObjSubUser = (ReturnObjFromRetrieve)(UAdminManager.getAddUserDefaults(uparams));

				String isSubUser = null;
				String userStatus = null;

				if(retObjSubUser!=null && retObjSubUser.getRowCount()>0)
				{
					for(int i=0;i<retObjSubUser.getRowCount();i++)
					{
						if("ISSUBUSER".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							isSubUser=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
					}
					if(!"Y".equals(isSubUser))
					{
						userId = tmpSendToUser;
						break;
					}
				}
			}
		}
		ReturnObjFromRetrieve retprodfav = null;

		EzcPersonalizationParams ezget = new EzcPersonalizationParams();
		EziPersonalizationParams izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		izget.setUserId(userId);
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		int retprodfavCount=retprodfav.getRowCount();
		if(retprodfavCount>0)
		{
			String favGroup = retprodfav.getFieldValueString(0,"EPG_NO");
			String favDesc  = retprodfav.getFieldValueString(0,"EPGD_DESC");
			String favWebDesc = retprodfav.getFieldValueString(0,"EPGD_WEB_DESC");
			
			EzCatalogParams ezread = new EzCatalogParams();
			ezread.setLanguage("EN");
			ezread.setUserId(userId);
			ezread.setProductGroup(favGroup);
			Session.prepareParams(ezread);

			ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
			ReturnObjFromRetrieve cnetRet = (ReturnObjFromRetrieve)ret.getObject("CNETRET");
			
			int tempProdIndex=0;
			String tempProducts[] = new String[products.length];
			String tempItemCat[] = new String[products.length];
			
			for ( int j = 0; j < products.length; j++)
			{
				String retProd = products[j];

				String iCat = itemCats[j];
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
					tempItemCat[tempProdIndex++] = itemCats[j];

				}
			}
			String newProducts[]     = new String[tempProdIndex];
			String newVendCatalogs[] = new String[tempProdIndex];
			for( int k = 0; k < tempProdIndex; k++)
			{
				if ( tempProducts[k] != null )
				{
				       newProducts[k]     = tempProducts[k];
				       newVendCatalogs[k] = "10@@@10@@@CNET@@@"+tempItemCat[k];
				}
			}
			
			if(tempProdIndex>0)
			{
				ezget = new EzcPersonalizationParams();
				izget = new EziPersonalizationParams();
				izget.setLanguage("EN");
				izget.setUserId(userId);
				izget.setObject(newProducts);
				izget.setVendorCatalogs(newVendCatalogs);
				izget.setProductFavGroup(favGroup);
				ezget.setObject(izget);
				Session.prepareParams(ezget);
				EzcPersonalizationManager.addUserProdFavMat(ezget);
			}
		}
		else
		{
		
		
			EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
			EziPersonalizationParams iparams = new EziPersonalizationParams();
			iparams.setLanguage("EN");
			iparams.setUserId(userId);
			iparams.setProductFavGroupDesc("MYFAVOURITES");
			iparams.setProductFavGroupWebDesc("My Favourites");
			ezpparams.setObject(iparams);
			Session.prepareParams(ezpparams);
			EzcPersonalizationManager.addUserProdFavDesc(ezpparams);
			
			String groupNumber = "";
			ezget = new EzcPersonalizationParams();
			izget = new EziPersonalizationParams();
			izget.setLanguage("EN");
			izget.setUserId(userId);
			ezget.setObject(izget);
			Session.prepareParams(ezget);
			ReturnObjFromRetrieve retFAV = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
			groupNumber     = retFAV.getFieldValueString(0,"EPG_NO");
		
			ezget = new EzcPersonalizationParams();
			izget = new EziPersonalizationParams();
			izget.setLanguage("EN");
			izget.setUserId(userId);
			izget.setObject(products);
			izget.setVendorCatalogs(venCatalogs);
			izget.setProductFavGroup(groupNumber);
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
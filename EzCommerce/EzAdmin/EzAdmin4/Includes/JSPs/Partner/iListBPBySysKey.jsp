<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<jsp:useBean id="BPManager1" class="ezc.client.CEzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />



<%
	String websys="";
	String websyskey=request.getParameter("WebSysKey");
	
	///out.println("websyskey"+websyskey);
	
	if("All".equals(websyskey))
			websys=websyskey;
	
	ReturnObjFromRetrieve ret1 = null;
	if((websyskey!=null) && !("All".equals(websyskey))&& !"sel".equals(websyskey))
	{


			EzcBussPartnerParams bparams = new EzcBussPartnerParams();
			EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
			bnkparams.setSys_key("'"+websyskey+"'");
			bnkparams.setLanguage("EN");
			bparams.setObject(bnkparams);
			Session.prepareParams(bparams);
			// Get Business Partners
			
			//ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey");
			ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
			//ezc.ezcommon.EzLog4j.log("getBussPartnersBySysKeygetBussPartnersBySysKey");
	}
	else if("V".equals(areaFlag) && "All".equals(websyskey) )
	{
			if(websyskey!=null)
			{
				if(!"sel".equals(websyskey))
				{
					websyskey="";
					/*
					for(int i=0;i<ret.getRowCount();i++)
					{
						if(i==ret.getRowCount()-1)
						{
							websyskey=websyskey+"'"+ret.getFieldValueString(i,SYSTEM_KEY)+"'";
						}
						else
						{
							websyskey=websyskey+"'"+ret.getFieldValueString(i,SYSTEM_KEY)+"',";
						}
					}
					
					EzcBussPartnerParams bparams = new EzcBussPartnerParams();
					EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
					bnkparams.setSys_key(websyskey);
					bnkparams.setLanguage("EN");
					bparams.setObject(bnkparams);
					Session.prepareParams(bparams);
					*/
					EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
					adminUtilsParams.setActionStr("PARTNER");
					EzcParams mainParams = new EzcParams(false);
					mainParams.setObject(adminUtilsParams);
					Session.prepareParams(mainParams);
					
					// Get Business Partners
					ezc.ezcommon.EzLog4j.log("DE1:Before Get BizPartners"+websyskey,"I");
					ret1 = (ReturnObjFromRetrieve)AdminUtilsManager.getPartnersByPartnerValueAndArea(mainParams);
					///ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
					//ezc.ezcommon.EzLog4j.log("DE2:End Get BizPartners"+ret1.toEzcString(),"I");
				}
			}
	}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	String initAlpha = "";
	int deleteCount = 0;
	if(websyskey!=null && !"null".equals(websyskey))
	{
		
		deleteCount = ret1.getRowCount();
		for(int i=0;i<deleteCount;i++)
		{
			alphaName = ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
		if(alphaTree.size()>0)
		initAlpha = (String)alphaTree.first()+"*";
	}	
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";
%>

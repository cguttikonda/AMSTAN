<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ page import="ezc.ezparam.*" %>

<jsp:useBean id="BPManager1" class="ezc.client.CEzBussPartnerManager" scope="session">
</jsp:useBean>



<%
	String websys="";
	String websyskey=request.getParameter("WebSysKey");
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
			ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
	}
	else
	{
			if(websyskey!=null)
			{
				if(!"sel".equals(websyskey))
				{
					websyskey="";
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
					// Get Business Partners
					ret1 =(ReturnObjFromRetrieve) BPManager1.getBussPartnersBySysKey(bparams);
				}
			}
	}


%>

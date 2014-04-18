<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>
<%
	EZC_MATERIAL_DESC in = new EZC_MATERIAL_DESC();
	EzCatalogParams catalogParams=null;
	Object ret =null;

	String lang =  request.getParameter("Language");
	String prodgroup =  request.getParameter("ProdGroup");
	String syskey =  request.getParameter("SysKey");

	String[] pCheckBox = request.getParameterValues("CheckBox");
	System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< "+pCheckBox);
	String[] pWebDesc = request.getParameterValues("WebDesc"); 
	/*String[] pSpec1 = request.getParameterValues("Spec1"); 
	String[] pSpec2 = request.getParameterValues("Spec2"); 
	String[] pSpec3 = request.getParameterValues("Spec3"); 
	String[] pSpec4 = request.getParameterValues("Spec4"); 
	*/
	if(pCheckBox!=null)
	{
		for ( int i = 0 ; i < pCheckBox.length; i++ ) 
		{
			in.setEMD_WEB_DESC(pWebDesc[i]);
			/*in.setEMD_SPECS1(pSpec1[i]);
			in.setEMD_SPECS2(pSpec2[i]);
			in.setEMD_SPECS3(pSpec3[i]);
			in.setEMD_EXTERNAL_URL(" ");
			in.setEMD_SPECS4(pSpec4[i]);*/
			in.setEMM_NO(pCheckBox[i]);
			in.setEMD_LANG("EN");
			catalogParams = new EzCatalogParams();
			Session.prepareParams(catalogParams);
			catalogParams.setObject(in);
			catalogParams.setSysKey(syskey);
			catalogParams.setLanguage("EN");
			catalogParams.setProductGroup(prodgroup);
			ret = catalogObj.updateMaterialDesc(catalogParams);
		}
	}
	response.sendRedirect("../Catalog/ezChangeProdDesc.jsp?saved=Y&ProductGroup=" + prodgroup + "&SystemKey=" + syskey + "&Language=EN");
%>
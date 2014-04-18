<%@ page import = "ezc.ezcommon.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>

<%


String lang =  request.getParameter("Language");
String syskey =  request.getParameter("SystemKey");
String[] pCheckBox = request.getParameterValues("CheckBox");
String[] pWebDesc = request.getParameterValues("WebDesc");

StringTokenizer st=null;
EZC_PRODUCT_GROUP_DESC prodGrpDesc=null;
EzCatalogParams catalogParams=null;
ReturnObjFromRetrieve retcat=null;

for ( int i = 0 ; i <pCheckBox.length; i++ )
{
	st=new StringTokenizer(pCheckBox[i],"#");
	String chk= (String)st.nextToken();
	int index=Integer.parseInt((String)st.nextToken());
	prodGrpDesc = new EZC_PRODUCT_GROUP_DESC();
	prodGrpDesc.setEPG_NO(chk);
	prodGrpDesc.setEPGD_WEB_DESC(pWebDesc[index]);
	prodGrpDesc.setEPGD_LANG("EN"); //this needs to be a system parameter..

	catalogParams = new EzCatalogParams();
	catalogParams.setSysKey(syskey);
	catalogParams.setObject(prodGrpDesc);
	Session.prepareParams(catalogParams);
	retcat = (ReturnObjFromRetrieve)catalogObj.updateProdGroupWebDesc(catalogParams);
	retcat.check();
	//check if the updat is successful of not..check for "S"

}// End For

//Redirect to Change Group Description Page
response.sendRedirect("../Catalog/ezChangeGroupDesc.jsp?saved=Y&Language=" + lang + "&SystemKey=" + syskey);
%>
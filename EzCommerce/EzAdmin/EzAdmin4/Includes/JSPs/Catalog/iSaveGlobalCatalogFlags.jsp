<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<%
String GlobalCheck = null; 
String pGlobalCheck = null; 
String ImageCheck = null; 
String pImageCheck = null; 
String GroupNum = null; 
String pGroupNum = null; 

String pFinalGlobal = null; 
String pFinalImage = null; 

String strTcount =  request.getParameter("TotalCount");
String sysnum =  request.getParameter("SystemKey");
//String sysnum =  request.getParameter("SysNum");

if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

for ( int i = 0 ; i < totCount; i++ ) {
	GlobalCheck = "ChkShow_"+i;
	ImageCheck = "ChkImage_"+i;
	GroupNum = "GroupNum_"+i;

	pGlobalCheck = request.getParameter(GlobalCheck);
	pImageCheck = request.getParameter(ImageCheck);
	pGroupNum = request.getParameter(GroupNum);

	// Check For Selection
	if ( pGlobalCheck != null ){
		pFinalGlobal = "Y";
	} else {
		pFinalGlobal = "N";
	}

	// Check For Selection
	if ( pImageCheck != null ){
		pFinalImage = "Y";
	} else {
		pFinalImage = "N";
	}

	Object[] UpdateData = new Object[4];
	UpdateData[0] = pGroupNum;
	UpdateData[1] = new Integer(sysnum);
	UpdateData[2] = pFinalGlobal;
	UpdateData[3] = pFinalImage;
	AdminObject.UpdateProductGroupSelected(servlet, UpdateData);

}// End For
}// End if

response.sendRedirect("../Catalog/ezGlobalCatalogFlags.jsp");
%>
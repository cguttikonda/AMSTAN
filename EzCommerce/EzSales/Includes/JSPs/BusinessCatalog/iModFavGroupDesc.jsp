<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
String checkbox = null; 
String FavGroup = null; 
String GroupDesc = null; 
String WebDesc = null; 

String pCheckBox = null; 
String pFavGroup = null; 
String pGroupDesc = null; 
String pWebDesc = null; 

String strTcount =  request.getParameter("TotalCount");
if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  

for ( int i = 0 ; i < totCount; i++ ) {
	checkbox = "CheckBox_"+i;
	FavGroup = "FavGroup_"+i;
	GroupDesc = "GroupDesc_"+i;
	WebDesc  = "WebDesc_"+i;	

	pCheckBox = request.getParameter(checkbox);

	// Check For Selection
	if ( pCheckBox != null ){
		// Get the Fav Group Number and the Web Description
		pFavGroup = request.getParameter(FavGroup);
		pGroupDesc = request.getParameter(GroupDesc); 
		pWebDesc = request.getParameter(WebDesc); 

		//Update Favourite Group Description Call
            //Commented by Venkat on 1/29/2001
		//SBObject.updateProductFavGroupDesc(servlet, pFavGroup, pGroupDesc, pWebDesc);

            //Added by Venkat on 1/29/2001
                EzcPersonalizationParams ezcupd = new EzcPersonalizationParams();
                EziPersonalizationParams izcupd = new EziPersonalizationParams();
                izcupd.setLanguage("EN");
                izcupd.setProductFavGroup(pFavGroup);
                izcupd.setProductFavGroupDesc(pGroupDesc);
                izcupd.setProductFavGroupWebDesc(pWebDesc);
                ezcupd.setObject(izcupd);
                Session.prepareParams(ezcupd);
                EzcPersonalizationManager.updateProductFavGroupDesc(ezcupd);
            //Code changes end here
	}//End if
}// End For
}// End if strTcount
%>

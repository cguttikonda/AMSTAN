<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
String checkbox = null; 
String FavGroup = null; 

String pCheckBox = null; 
String pFavGroup = null; 

String strTcount =  request.getParameter("TotalCount");

EzCatalogParams ezcatparams = new EzCatalogParams();
ezc.ezparam.EzWebCatalogSearchParams ezwebparams = new ezc.ezparam.EzWebCatalogSearchParams();


if ( strTcount != null )
{
    int totCount = (new Integer(strTcount)).intValue();  

    for ( int i = 0 ; i < totCount; i++ ) 
    {
	checkbox = "CheckBox_"+i;
	FavGroup = "FavGroup_"+i;

	pCheckBox = request.getParameter(checkbox);
        ezc.ezutil.EzSystem.out.println("pCheckBox:"+pCheckBox);

	// Check For Selection
	if ( pCheckBox != null )
      {
	      // Get the Fav Group Number and the Web Description
	      pFavGroup = request.getParameter(FavGroup);
	     //ezc.ezutil.EzSystem.out.println("****Group" + pFavGroup );

                // Commented by Venkat on 1/29/2001
		// SBObject.removeFromProdFav(servlet, pFavGroup);

            //Venkat Added the following code on 1/29/2001
              EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
              EziPersonalizationParams iparams = new EziPersonalizationParams();
              iparams.setLanguage("EN");
              iparams.setProductGroup(pFavGroup);
              ezcparams.setObject(iparams);
              Session.prepareParams(ezcparams);
              EzcPersonalizationManager.removeFromProdFav(ezcparams);
              
	     /*
	     ezwebparams.setCatalogCode(pFavGroup);
	      ezwebparams.setCatalogType("DP");
	      ezcatparams.setObject(ezwebparams);
	      Session.prepareParams(ezcatparams);
	      EzWebCatalogManager.maintainCatalogView(ezcatparams);
	     */
    	 	
            //Code changes end here
	  }
      }// End For
}// End if strTcount
%>


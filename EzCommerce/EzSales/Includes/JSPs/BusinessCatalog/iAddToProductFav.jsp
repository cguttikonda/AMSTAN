<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
// actual parameters
String pCheckBox = null; 
String pProductNumber = null; 

// for looping
String checkbox = null; 
String product = null; 
String [] products = null;

String strTcount =  request.getParameter("TotalCount");
String prodfavgroup =  request.getParameter("FavGroups");
//out.println("prodfavgroup"+prodfavgroup);
if ( strTcount != null ){
int totCount = (new Integer(strTcount)).intValue();  
int selCount =  0;

// This is to find the number of selected rows
for ( int i = 0 ; i < totCount; i++ ) {
	checkbox = "CheckBox_"+i;	
	pCheckBox = request.getParameter(checkbox);
	if ( pCheckBox != null ){
		selCount = selCount + 1;
	}
}

if ( selCount > 0 ) {

	// Loop thru the last selection
	products = new String[selCount];
	selCount = 0;
	for ( int i = 0 ; i < totCount; i++ ) {
		checkbox = "CheckBox_"+i;
		product = "Product_"+i;

		pCheckBox = request.getParameter(checkbox);
		if ( pCheckBox != null ){
			pProductNumber = request.getParameter(product);
			products[selCount] = new String(pProductNumber);
			selCount++;
		}
	}// End For

//Commented by Venkat on 1/29/2001
//	SBObject.addUserProdFavMat(servlet, products, prodfavgroup);

//Venkat added following code on 4/17/2001 - to avoid products that are already added to groups
        EzCatalogParams ezread = new EzCatalogParams();
        ezread.setLanguage("EN");
        ezread.setProductGroup(prodfavgroup);
        Session.prepareParams(ezread);
        ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
        int prodLen = products.length;
        String tempProducts[] = new String[selCount];
        int tempProdIndex=0;

	for ( int j = 0; j < prodLen; j++)
	{
		String retProd = products[j];
		if ( ret != null && !ret.find("EPF_MAT_NO",retProd))
		{
			int foundRow = ret.getRowId("EPF_MAT_NO",retProd);
			tempProducts[tempProdIndex++] = products[j];
		}
	}

         String newProducts[] = new String[tempProdIndex];
         for( int k = 0; k < tempProdIndex; k++)
         {
            if ( tempProducts[k] != null )
            {
               newProducts[k] = tempProducts[k];
            }
         }
//Code changes end here


//Venkat Added the following code on 1/29/2001
    EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
    EziPersonalizationParams iparams = new EziPersonalizationParams();
    iparams.setLanguage("EN");
    //iparams.setObject(products); //Commented to remove the products already added
    iparams.setObject(newProducts);
    iparams.setProductFavGroup(prodfavgroup);
    ezcparams.setObject(iparams);
    Session.prepareParams(ezcparams);
    EzcPersonalizationManager.addUserProdFavMat(ezcparams);
//Code changes end here

	pProductNumber = null;
}// if ( selCount > 0 ) 
} // If strTcount != null 
%>

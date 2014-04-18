<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
	String pCheckBox 	= null; 
	String pProductNumber 	= null; 
	String type		= null;
	String vendCat		= null;
	String [] products 	= null;

	String strTcount 	= request.getParameter("TotalCount");
	String prodfavgroup 	= request.getParameter("FavGroup");
	String GroupDesc	= request.getParameter("GroupDesc");

	if ( strTcount != null ){
		int totCount = (new Integer(strTcount)).intValue();  
		int selCount =  0;

		// This is to find the number of selected rows
		for ( int i = 0 ; i < totCount; i++ ) {
			pCheckBox = request.getParameter("CheckBox_"+i);
			if ( pCheckBox != null ){
				selCount = selCount + 1;
			}
		}
		if ( selCount > 0 ) {
			products = new String[selCount];

			// Update the Shopping cart with selected rows values

			int j=0;
			for ( int i = 0 ; i < totCount; i++ ) {
				pCheckBox = request.getParameter("CheckBox_"+i);
				if ( pCheckBox != null ) {
					pProductNumber = request.getParameter("Product_"+i);
					type           = request.getParameter("Type_"+i);
					vendCat	       = request.getParameter("VendCatalog_"+i);
					if("CNET".equals(type))
						products[j] = pProductNumber+"' AND EPF_ITEMCAT='"+vendCat+"' AND EPF_TYPE='CNET";
					else
						products[j] = pProductNumber;
					j++;
				}
			}
			
			EzcPersonalizationParams ezc = new EzcPersonalizationParams();
			EziPersonalizationParams izc = new EziPersonalizationParams();
		        izc.setLanguage("EN");
		        izc.setProductGroup(prodfavgroup);
		        izc.setObject(products);
		        ezc.setObject(izc);
		        Session.prepareParams(ezc);
			EzcPersonalizationManager.removeFromProdFavMat(ezc);
			
		}
	}
 %>

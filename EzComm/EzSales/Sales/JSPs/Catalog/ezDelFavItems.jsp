<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%> 
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String [] products 	= null;

	String prodfavgroup 	= (String)session.getValue("USR_FAV_GRP");
	String GroupDesc	= (String)session.getValue("USR_FAV_DESC");
	String chkVal		= request.getParameter("favDtl");
	String catalogStr       = prodfavgroup+"@@"+GroupDesc+"@@P";

	//out.println("chkVal::::::::::::::"+chkVal);
        java.util.StringTokenizer prdDat = new java.util.StringTokenizer(chkVal,"~~");
        products 	= new String[prdDat.countTokens()];
        int cnt = 0;
	while(prdDat.hasMoreTokens())
	{
		String token1 = (String)prdDat.nextToken();
		String token2 = (String)prdDat.nextToken();
		String token3 = (String)prdDat.nextToken();
		
		products[cnt] = token1+"' AND EPF_ITEMCAT='"+token2+"' AND EPF_TYPE='CNET";
		cnt++;
	}

	EzcPersonalizationParams ezc = new EzcPersonalizationParams();
	EziPersonalizationParams izc = new EziPersonalizationParams();
	izc.setLanguage("EN");
	izc.setProductGroup(prodfavgroup);
	izc.setObject(products);
	ezc.setObject(izc);
	Session.prepareParams(ezc);
	EzcPersonalizationManager.removeFromProdFavMat(ezc);
	out.println("EzcPersonalizationManager::::::"+products);
	response.sendRedirect("../Catalog/ezGetFavProdMain.jsp");
%>


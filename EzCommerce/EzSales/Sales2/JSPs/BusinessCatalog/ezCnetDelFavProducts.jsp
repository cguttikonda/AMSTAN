<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
	String [] products 	= null;

	String prodfavgroup 	= request.getParameter("favGroup");
	String GroupDesc	= request.getParameter("favGrpDesc");
	String chkVal		= request.getParameter("chkVal");
	String catalogStr       = prodfavgroup+"@@"+GroupDesc+"@@P";


        java.util.StringTokenizer prdDat = new java.util.StringTokenizer(chkVal,"$$");
        products 	= new String[prdDat.countTokens()];
        int cnt = 0;
	while(prdDat.hasMoreTokens())
	{
		String prdStr = prdDat.nextToken()+"";
		java.util.StringTokenizer prdDet = new java.util.StringTokenizer(prdStr,"~~");
		products[cnt] =prdDet.nextToken()+"' AND EPF_ITEMCAT='"+prdDet.nextToken()+"' AND EPF_TYPE='CNET";
		//out.print(products[cnt]);
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

	String noDataStatement = "Product(s) deleted successfully";	
%>
<%@ include file="../Misc/ezDisplayNoData.jsp"%> 

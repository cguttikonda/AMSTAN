<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%
	boolean ADDFLAG				= true;			
	String UserRole 			= (String)session.getValue("UserRole");
// Key Variables
	ReturnObjFromRetrieve ret 		= null;
	ReturnObjFromRetrieve retprodfav 	= null;

	String CatalogDescription		= request.getParameter("CatalogDescription");
	String groupDesc			= request.getParameter("GroupDesc");
	String pGroupNumber 			= request.getParameter("ProductGroup");
	String chkString			= request.getParameter("chkString");
	if(CatalogDescription ==null || CatalogDescription=="")	CatalogDescription="My Catalog";
	String [] checkedProducts 		= null;
	int chklength				= 0;
	
	if (!(chkString == null || chkString =="" || "null".equals(chkString)))
	{
		StringTokenizer st=new StringTokenizer(chkString,",");
		checkedProducts = new String[st.countTokens()];
		for(int cal=0;st.hasMoreTokens();cal++)
		{
			checkedProducts[cal]=(String)st.nextElement();
		}
	}
	if(checkedProducts!= null) chklength=checkedProducts.length;
	
	
	// Received Group number as Parameter
	
	
   	EzCatalogParams ezcfparams = new EzCatalogParams();
   	ezcfparams.setLanguage("EN");
   	ezcfparams.setProductGroup(pGroupNumber);
   	Session.prepareParams(ezcfparams);

	ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezcfparams);
	int retCount=ret.getRowCount();
	if ((ret!=null)&&(retCount> 0))
	{
		
		String sortField[]={MATD_WEB_DESC};
		ret.sort(sortField,true);
	}
	//Code change ends here

/*	
   EzCatalogParams ezcfvparams = new EzCatalogParams();
   ezcfvparams.setLanguage("EN");
   Session.prepareParams(ezcfvparams);
   retprodfav = (ReturnObjFromRetrieve) EzCatalogManager.getProdFavDesc(ezcfvparams);
   int retprodfavCount =retprodfav.getRowCount();
*/


%>


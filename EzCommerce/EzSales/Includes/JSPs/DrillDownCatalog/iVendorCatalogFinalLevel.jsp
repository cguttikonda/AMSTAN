<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>

<%

	System.out.println("chkStringchkStringchkStringchkStringchkString");
        ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
        
	boolean ADDFLAG				= true;			
	boolean ADDPRDFLAG			= false;	
	String UserRole 			= (String)session.getValue("UserRole");
	String skey				= (String) session.getValue("SalesAreaCode");
	
// Key Variables
	ReturnObjFromRetrieve ret 		= null;
	ReturnObjFromRetrieve retprodfav 	= null;

	String CatalogDescription		= request.getParameter("CatalogDescription");
	String groupDesc			= request.getParameter("GroupDesc");
	String pGroupNumber 			= request.getParameter("ProductGroup");
	String chkString			= request.getParameter("chkString");
	String catalogNo                        = "";
	String catalogDesc                      = "";
	String catalogType                      = "";
	
	int retCount =0;
	
	// Added By Balu
	
	String idStr			= request.getParameter("id");
	String alertStr			= request.getParameter("alertStr");
	String addProduct		= request.getParameter("addProduct");
	
	String FavGroup			= request.getParameter("FavGroup");
	String GroupDesc		= request.getParameter("GroupDesc");
	
		
	if("Y".equals(addProduct))
	         ADDPRDFLAG =true;
	
	
	
	
	java.util.StringTokenizer idSt	= null;
	int countToken=0;
	
	if(idStr!=null)
	{
		idSt	= new java.util.StringTokenizer(idStr,"$$");
		countToken=idSt.countTokens();
		while(idSt.hasMoreTokens())
		{
			catalogNo	 = idSt.nextToken();
			if(countToken>1)
			{
			   catalogDesc	 = idSt.nextToken();	
			   catalogType   = idSt.nextToken();
			}
		}
	}
	
	// Ends Here
	
	System.out.println(chkString+"-->"+pGroupNumber+"-->"+groupDesc+"-->"+CatalogDescription);
	
	
	
	if(CatalogDescription ==null || CatalogDescription=="")	CatalogDescription=catalogDesc;
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
		
	// Received Catalog number as Parameter
	
	String prdNo = request.getParameter("ProdDesc1");
	
	if(prdNo==null || "null".equals(prdNo)){
		prdNo="";
	}
	else
	{ 
	    prdNo=prdNo.replace('*','%');
	}
	if(countToken>1)
	{
	
		EzCatalogParams catalogParams = new EzCatalogParams();
		EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
		if(!"".equals(prdNo)){
		searchParams.setSearchType("CP");
		}else{
			searchParams.setSearchType("C");
		}
		searchParams.setCatalogType(catalogType);
		searchParams.setCatalogCode(catalogNo);
		searchParams.setProductCode(prdNo);
		catalogParams.setSysKey(skey);
		catalogParams.setLanguage("EN");
		catalogParams.setObject(searchParams);

		Session.prepareParams(catalogParams);


		ret =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
	}
	
	
	if(ret!=null) 
		retCount=ret.getRowCount();
	
	if ((ret!=null)&&(retCount> 0))
	{
		for(int i = 0;i < retCount;i++)
		{
			String tempDesc = ret.getFieldValueString(i,"EMD_DESC");
			tempDesc = tempDesc.trim();
			ret.setFieldValueAt("EMD_DESC",tempDesc,i);
		}
		String sortField[]={"EMD_DESC"};
		ret.sort(sortField,true);
	}
	

/************For Images**************/
	
	//String imagePath	= "";
	//ResourceBundle site	= null;
	String[] fileList 	= null;    
	try
	{
		site	    = ResourceBundle.getBundle("Site");
		imagePath   = "D:\\usr\\sap\\JEZ\\JC00\\j2ee\\cluster\\server0\\apps\\sap.com\\EzPharma\\servlet_jsp\\EZP\\root\\EzCommerce\\EzSales\\Sales2\\Images\\IMAGEUPLOAD\\";//site.getString("IMAGEPATH");
		java.io.File f = new java.io.File(imagePath+"\\"); 
		fileList = f.list();
	}
	catch(Exception e)
	{ 
	    System.out.println("Got Exception while getting Upload imagePath Dir "+e);	
	}
	
		
	Hashtable files = new Hashtable();
	if(fileList!=null)
	{
		for(int l=0;l<fileList.length;l++)
		{
			if(fileList[l]!=null)
			{
				
				//fileList[l] = fileList[l].substring(0,fileList[l].lastIndexOf('.'));
				files.put((fileList[l].substring(0,fileList[l].lastIndexOf('.'))).toUpperCase(),fileList[l]);			
			}
		}
	}	

%>


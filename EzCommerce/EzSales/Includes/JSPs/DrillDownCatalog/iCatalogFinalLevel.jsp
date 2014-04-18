<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%

	System.out.println("chkStringchkStringchkStringchkStringchkString");

	boolean ADDFLAG				= true;			
	String UserRole 			= (String)session.getValue("UserRole");
// Key Variables
	ReturnObjFromRetrieve ret 		= null;
	ReturnObjFromRetrieve retprodfav 	= null;

	String CatalogDescription		= request.getParameter("CatalogDescription");
	String groupDesc			= request.getParameter("GroupDesc");
	String pGroupNumber 			= request.getParameter("ProductGroup");
	String chkString			= request.getParameter("chkString");
	
	
	// Added By Balu
	
	String idStr			= request.getParameter("id");
	String alertStr			= request.getParameter("alertStr");
	
	java.util.StringTokenizer idSt	= null;
	
	if(idStr!=null)
	{
		idSt	= new java.util.StringTokenizer(idStr,"$$");
		while(idSt.hasMoreTokens())
		{
			chkString		= idSt.nextToken();
			pGroupNumber		= idSt.nextToken();
			groupDesc		= idSt.nextToken();
			CatalogDescription	= idSt.nextToken();
		}
	}
	
	// Ends Here
	
	System.out.println(chkString+"-->"+pGroupNumber+"-->"+groupDesc+"-->"+CatalogDescription);
	
	
	
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
		for(int i = 0;i < retCount;i++)
		{
			String tempDesc = ret.getFieldValueString(i,"EMD_WEB_DESC");
			tempDesc = tempDesc.trim();
			ret.setFieldValueAt("EMD_WEB_DESC",tempDesc,i);
		}
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


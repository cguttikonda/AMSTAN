<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" buffer="512kb" autoFlush="true" %>



<%
	
	
	ezc.ezbasicutil.EzExcelDriver driver = new ezc.ezbasicutil.EzExcelDriver();
	
	java.util.StringTokenizer catalogSt = null;
		
	String catalogStr    = request.getParameter("catalogStr");
	String catalogNumber = "";
	String catalogType   = "";
	String catalogDesc   = "";   
	
	ezc.ezdisplay.ResultSetData rsData=null;
	
	
	
	String syskey        = (String)session.getValue("SalesAreaCode");   
	    
	int countToken=0;
	String noDataStatement ="No Data to Download";  
	
	
	if(catalogStr!=null) 
	{
		catalogSt	= new java.util.StringTokenizer(catalogStr,"$$");

		countToken=catalogSt.countTokens();

		while(catalogSt.hasMoreTokens())
		{
			catalogNumber	 = catalogSt.nextToken();
			if(countToken>1)
			{
			   catalogDesc	 = catalogSt.nextToken();	
			   catalogType   = catalogSt.nextToken();
			}
		}
	}
	
	

	
	
	ReturnObjFromRetrieve retObj[] = null;
	ReturnObjFromRetrieve retObjData = null;
	int rowCount = 0;
	
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();


	searchParams.setSearchType("C");
	searchParams.setCatalogType(catalogType);
	searchParams.setCatalogCode(catalogNumber); 
	
	catalogParams.setSysKey(syskey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(searchParams);
	Session.prepareParams(catalogParams);
	
        
	retObjData =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
	int sIndx = 0;
	if(retObjData!=null && retObjData.getRowCount()>0){
		rowCount = retObjData.getRowCount();
		sIndx    = rowCount % 60000;
		
		
		if(sIndx == 0){
			sIndx = rowCount/60000;
		}else{
			sIndx = (rowCount/60000)+1;
		}
		
		
		
	
	        
	       
	        retObj = new ReturnObjFromRetrieve[sIndx];
	        for(int i=0;i<sIndx;i++){
	        	retObj[i] =new ReturnObjFromRetrieve(new String[]{"Product Code","Product Desc","Manufacturer","List Price","UOM","EAN/UPC"});
	        }
		java.util.ArrayList rCol[] = new java.util.ArrayList[sIndx];
		java.util.ArrayList rHeader[] = new java.util.ArrayList[sIndx];
		
		java.util.ArrayList rColName = new java.util.ArrayList();
		java.util.ArrayList rHeaderName = new java.util.ArrayList();

		rColName.add("Product Code");
		rColName.add("Product Desc");
		rColName.add("Manufacturer");
		rColName.add("List Price");
		rColName.add("UOM");
		rColName.add("EAN/UPC"); 
		rHeaderName.add("Vendor Price File");
		
		out.println("======rowCount>"+rowCount);
		out.println("sIndx======>"+sIndx);
		
		int tempIndex = 0;
		for(int i=0;i<rowCount;i++){
		    tempIndex = (i/60000);    
		    
		    
		    retObj[tempIndex].setFieldValue("Product Code",retObjData.getFieldValue(i,"EMM_NO"));
		    retObj[tempIndex].setFieldValue("Product Desc",retObjData.getFieldValue(i,"EMD_DESC"));
		    retObj[tempIndex].setFieldValue("Manufacturer",retObjData.getFieldValue(i,"EMM_MANUFACTURER"));
		    retObj[tempIndex].setFieldValue("List Price",retObjData.getFieldValue(i,"EMM_UNIT_PRICE"));
		    retObj[tempIndex].setFieldValue("UOM",retObjData.getFieldValue(i,"EMM_UNIT_OF_MEASURE"));
		    retObj[tempIndex].setFieldValue("EAN/UPC",retObjData.getFieldValue(i,"EMM_EAN_UPC_NO"));
		    retObj[tempIndex].addRow();
		    
		
		}
		
		for(int i=0;i<sIndx;i++){
		
		
			rCol[i] = rColName;
			rHeader[i] = rHeaderName;
		}
		
		
		driver.ezCreateExcel(response,"Product.xls",retObj,rCol,rHeader,false);
		
	}else{
		 
%>
		 <html>
		 <head>
		 <%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
		 </head>
		 <body>
		 <form>
			<br><br><br><br>
			<table  align=center border=0>
			<tr>
				<td class=displayalert align ="center" colspan ="4">Please explore catalogs to Download.</td>
			</tr>
			</table >
			<br><br>
		 </form>
		  <Script>
		    alert('No data to download');
		  </Script>
		 </body>
		 </html>

<%
	
	}
			
	
	
	
	
%>

 
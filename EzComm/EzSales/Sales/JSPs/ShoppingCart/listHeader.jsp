<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
 	String strMat = (String)request.getParameter("q");
 	String catalogCode = (String)session.getValue("CatalogCode");

 	strMat = strMat.trim(); 
 	strMat = strMat.replaceAll("\\,","");
 	strMat = strMat.replaceAll("\\.","");
 	strMat = strMat.replaceAll("\\-","");
 	strMat = strMat.replaceAll("\\/","");

 	EzcParams matSearchParamsMisc = new EzcParams(false);
	EziMiscParams matSearchParams = new EziMiscParams();
	ReturnObjFromRetrieve matSearchRetObj = null;

	matSearchParams.setIdenKey("MISC_SELECT");

	String query="SELECT TOP 10 EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORIES,EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_CATEGORY_CODE = EC_CODE AND ECC_CATEGORY_ID = EC_PARENT AND ECC_CATALOG_ID IN ('"+catalogCode+"') AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND (EZP_WEB_SKU LIKE '"+strMat+"%' OR EPD_PRODUCT_DESC LIKE '"+strMat+"%') GROUP BY EZP_PRODUCT_CODE,EPD_PRODUCT_DESC ORDER BY EZP_PRODUCT_CODE";

	matSearchParams.setQuery(query);

	matSearchParamsMisc.setLocalStore("Y");
	matSearchParamsMisc.setObject(matSearchParams);
	Session.prepareParams(matSearchParamsMisc);

	try{
		matSearchRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(matSearchParamsMisc);
	}
	catch(Exception e){
		e.printStackTrace();
	}

	if(matSearchRetObj!=null)
	{
		if(matSearchRetObj.getRowCount()>0)
		{
			String exclMat  =   (String)session.getValue("EXCLMAT");

			for(int i=0;i<matSearchRetObj.getRowCount();i++)
			{
				/*String exclusive = matSearchRetObj.getFieldValueString(i,"EXCLUSIVE");
				String strCommGroupEx  =   (String)session.getValue("CommGroup");

				if(exclMat!=null && "N".equals(exclMat))
				{
					if(exclusive!=null && !"null".equals(exclusive) && !"".equals(exclusive) && !"QS".equals(exclusive) && !"CS".equals(exclusive))
					{
						if(!exclusive.equals(strCommGroupEx))
							continue;
					}
				}*/

				String prodCode = matSearchRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
				String prodDesc = nullCheck(matSearchRetObj.getFieldValueString(i,"PROD_DESC"));	
				String prodStat = "";//matSearchRetObj.getFieldValueString(i,"STATUS");
				String commGrp  = (String)session.getValue("CommGroup");


				if("Z4".equals(prodStat))
					prodStat=", Discontinued";
				else if("ZF".equals(prodStat))
					prodStat=", To Be Discontinued";
				else
					prodStat="";


				//out.print("<li class="+liClass+">"+prodCode+" -- "+prodDesc+"</li>");

				//if(i%2==0) out.println("<li  onMouseOver = \"fillM('"+prodCode+"')\"  onclick = \"fill('"+prodCode+"')\"   >"+prodCode+ " --- "+prodDesc+" "+prodStat+"</li>");
				//else       out.println("<li  onMouseOver = \"fillM('"+prodCode+"')\"  onclick = \"fill('"+prodCode+"')\"   >"+prodCode+ " --- "+prodDesc+" "+prodStat+"</li>");
				
				out.println(prodCode+", "+prodDesc+""+prodStat+"\n");
				 //out.println(prodCode+"\n");
			}
		}
		else
		{
			out.println("Entered item is not found, invalid or impermissible");
		}
	}
%>
<%!
 	public String nullCheck(String str)
 	{
 		String ret = str;
 
 		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
 			ret = "N/A";
 		return ret;
 	}
 	public String eliminateDecimals(String myStr)
 	{
 		String remainder = "";
 		if(myStr.indexOf(".")!=-1)
 		{
 			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
 			myStr = myStr.substring(0,myStr.indexOf("."));
 		}
 		return myStr;
 	}
%>
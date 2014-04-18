<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%//@ include file="../../../Includes/JSPs/ShoppingCart/iCheckCartItems.jsp"%>
<%
	String str=request.getParameter("queryString");
	String str1=request.getParameter("queryString1");
	//ezc.ezcommon.EzLog4j.log("queryString1::::::::::"+str1,"D");

	response.setHeader("Content-Type", "text/html");
	
	response.setContentType("text/html");

	try
	{
		//ezc.ezcommon.EzLog4j.log("catType_C::::::::::"+catType_C,"D");
		//ezc.ezcommon.EzLog4j.log("mat search::::::::::"+str,"D");
		if(str!=null)
		{
			EzcParams matSearchParamsMisc = new EzcParams(false);
			EziMiscParams matSearchParams = new EziMiscParams();
			ReturnObjFromRetrieve matSearchRetObj = null;

			matSearchParams.setIdenKey("MISC_SELECT");
			
			//ezc.ezcommon.EzLog4j.log("before::::::::::query","D");
			//String query="SELECT TOP 10 EZP_PRODUCT_CODE FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE LIKE '"+str+"%' ORDER BY EZP_PRODUCT_CODE";
			String query="";

			/*if("Q".equals(catType_C))
			{
				query="SELECT TOP 10 EZP_PRODUCT_CODE,EPD_PRODUCT_DESC  PROD_DESC,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DCH_STATUS') STATUS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='SAP_COMM_GROUP') EXCLUSIVE FROM EZC_CLASSIFICATION_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DCH_STATUS' AND EPA_ATTR_VALUE NOT IN ('Z3','Z2','11') AND ECP_CLASSIFICATION_CODE IN (SELECT EPCL_CODE FROM EZC_PRODUCT_CLASSIFICATION WHERE EPCL_TYPE='Q') AND (EZP_PRODUCT_CODE LIKE '"+str+"%' OR EPD_PRODUCT_DESC LIKE '"+str+"%') GROUP BY EZP_PRODUCT_CODE,EPD_PRODUCT_DESC ORDER BY EPD_PRODUCT_DESC";
			}
			else if("C".equals(catType_C))
			{
				query="SELECT TOP 10 EZP_PRODUCT_CODE,EPD_PRODUCT_DESC  PROD_DESC,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DCH_STATUS') STATUS,(SELECT EPA_ATTR_VALUE FROM EZC_PRODUCT_ATTRIBUTES WHERE EPA_PRODUCT_CODE=EZP_PRODUCT_CODE AND EPA_ATTR_CODE='SAP_COMM_GROUP') EXCLUSIVE FROM EZC_CLASSIFICATION_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPA_ATTR_CODE='DCH_STATUS' AND EPA_ATTR_VALUE NOT IN ('Z3','Z2','11') AND ECP_CLASSIFICATION_CODE IN (SELECT EPCL_CODE FROM EZC_PRODUCT_CLASSIFICATION WHERE EPCL_TYPE='C') AND (EZP_PRODUCT_CODE LIKE '"+str+"%' OR EPD_PRODUCT_DESC LIKE '"+str+"%') GROUP BY EZP_PRODUCT_CODE,EPD_PRODUCT_DESC ORDER BY EPD_PRODUCT_DESC";
			}
			else
			{*/
				query="SELECT TOP 10 EZP_PRODUCT_CODE,EPD_PRODUCT_DESC  PROD_DESC,EZP_STATUS STATUS,EZP_ATTR1 EXCLUSIVE FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_STATUS NOT IN ('Z3','Z2','11','ZM','ZP') AND EZP_PRODUCT_CODE NOT IN (select EPA_PRODUCT_CODE from EZC_PRODUCT_ATTRIBUTES where EPA_ATTR_CODE = 'SAP_COMM_GROUP' and EPA_ATTR_VALUE = 'CS') and (EZP_PRODUCT_CODE LIKE '"+str+"%' OR EPD_PRODUCT_DESC LIKE '"+str+"%') GROUP BY EZP_PRODUCT_CODE,EPD_PRODUCT_DESC,EZP_STATUS,EZP_ATTR1 ORDER BY EPD_PRODUCT_DESC";
			//}

			matSearchParams.setQuery(query);
			//ezc.ezcommon.EzLog4j.log("after query"+query,"D");

			matSearchParamsMisc.setLocalStore("Y");
			matSearchParamsMisc.setObject(matSearchParams);
			Session.prepareParams(matSearchParamsMisc);	

			matSearchRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(matSearchParamsMisc);

			if(matSearchRetObj!=null)
			{
				if(matSearchRetObj.getRowCount()>0)
				{
					out.print("<ul>");
					for(int i=0;i<matSearchRetObj.getRowCount();i++)
					{
						String exclusive = matSearchRetObj.getFieldValueString(i,"EXCLUSIVE");
						String strCommGroupEx  =   (String)session.getValue("CommGroup");
						
						if(exclusive!=null && !"null".equals(exclusive) && !"".equals(exclusive) && !"QS".equals(exclusive) && !"CS".equals(exclusive))
						{
							if(!exclusive.equals(strCommGroupEx))
								continue;						
						}
														
						String prodCode = matSearchRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
						String prodDesc = nullCheck(matSearchRetObj.getFieldValueString(i,"PROD_DESC"));	
						String prodStat = matSearchRetObj.getFieldValueString(i,"STATUS");
						String commGrp  = (String)session.getValue("CommGroup");
						
							
						if("Z4".equals(prodStat))
							prodStat=" --- Discontinued";
						else if("ZF".equals(prodStat))
							prodStat=" --- To Be Discontinued";
						else
							prodStat="";
							
					
						//out.print("<li class="+liClass+">"+prodCode+" -- "+prodDesc+"</li>");
						
						if(i%2==0) out.println("<li style='background-color:#D3D3D3' onclick = \"fill('"+prodCode+"')\">"+prodCode+ " --- "+prodDesc+" "+prodStat+"</li>");
						else       out.println("<li style='background-color:#F5F5F5' onclick = \"fill('"+prodCode+"')\">"+prodCode+ " --- "+prodDesc+" "+prodStat+"</li>");
					}
					out.print("</ul>");
				}
				else
				{
					out.println("Entered item is not found, invalid or impermissible");
				}
			}
		}
	}
	catch(Exception e){
	
	//ezc.ezcommon.EzLog4j.log("in exception mat search::::::::::"+e,"D");
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
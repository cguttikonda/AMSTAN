<html>
<head>
    <title></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $ ('ul.image-list li:even').addClass('even');
            $ ('ul.image-list li:odd').addClass('odd');
        });
    </script>
    <style>
        .even{
                background: gray;
        }
        .odd{
                background: gray;
        }
    </style>
</head>
</html>
    
    <%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String strH=request.getParameter("queryStringH");

	response.setHeader("Content-Type", "text/html");
	
	 response.setContentType("text/html");

	try
	{
	
		ezc.ezcommon.EzLog4j.log("mat search::::::::::"+strH,"D");
		if(strH!=null)
		{
			EzcParams matSearchParamsMisc = new EzcParams(false);
			EziMiscParams matSearchParams = new EziMiscParams();
			ReturnObjFromRetrieve matSearchRetObj = null;

			matSearchParams.setIdenKey("MISC_SELECT");
			
			String query="SELECT TOP 10 EZP_PRODUCT_CODE,EPD_PRODUCT_DESC PROD_DESC FROM EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS,EZC_PRODUCT_DESCRIPTIONS WHERE ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EPD_PRODUCT_CODE = EZP_PRODUCT_CODE AND (EZP_PRODUCT_CODE LIKE '"+strH+"%' OR EPD_PRODUCT_DESC LIKE '"+strH+"%') GROUP BY EZP_PRODUCT_CODE,EPD_PRODUCT_DESC ORDER BY EPD_PRODUCT_DESC";
			matSearchParams.setQuery(query);

			matSearchParamsMisc.setLocalStore("Y");
			matSearchParamsMisc.setObject(matSearchParams);
			Session.prepareParams(matSearchParamsMisc);	

			matSearchRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(matSearchParamsMisc);

			if(matSearchRetObj!=null)
			{
				if(matSearchRetObj.getRowCount()>0)
				{
					
					out.print("<ul class=image-list>");
					for(int i=0;i<matSearchRetObj.getRowCount();i++)
					{
						String prodCode = matSearchRetObj.getFieldValueString(i,"EZP_PRODUCT_CODE");
						String prodDesc = nullCheck(matSearchRetObj.getFieldValueString(i,"PROD_DESC"));						

						//out.print("<li class="+liClass+">"+prodCode+" -- "+prodDesc+"</li>");
					
						if(i%2==0)  out.println("<li style='background-color:#D3D3D3' onclick = \"fillH('"+prodCode+"')\">"+prodCode+ " --- "+prodDesc+"</li>");
						else	    out.println("<li style='background-color:#F5F5F5' onclick = \"fillH('"+prodCode+"')\">"+prodCode+ " --- "+prodDesc+"</li>");
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
	
	ezc.ezcommon.EzLog4j.log("in exception mat search::::::::::"+e,"D");
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
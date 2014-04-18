<%@ include file="../../Lib/SalesDocManager.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezdrlsales.params.EzSalesDocMailStructure" />
<%@ page import="ezc.ezparam.*" %>
<%
    

    	ReturnObjFromRetrieve ListObj=null;
    	EzcParams param=new EzcParams(false);
          
	
	for(int i=0;i<productCodes.length;i++)
	{
		inparams.setPcode(productCodes[i]);
		inparams.setPlant(plantCodes[i]);
        	param.setObject(inparams);
    
    		Session.prepareParams(param);
    		ListObj=(ReturnObjFromRetrieve)SalesDocManager.deleteSalesDocMails(param);
	}

	//response.sendRedirect("../../../Admin1/JSPs/SalesDocMails/ezListPlantPlannerMails.jsp");	

%>
   <jsp:forward page="../../../Admin1/JSPs/SalesDocMails/ezGotoList.jsp" />

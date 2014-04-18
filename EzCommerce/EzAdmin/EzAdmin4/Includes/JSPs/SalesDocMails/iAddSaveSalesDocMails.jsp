<%@ include file="../../Lib/SalesDocManager.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezdrlsales.params.EzSalesDocMailStructure"/>
<%@ page import="ezc.ezparam.*" %>
<%
       try
       {
	   	ReturnObjFromRetrieve RetObj=null;
	    	EzcParams param=new EzcParams(false);
	        inparams.setPcode(pcode);
    		inparams.setTo(to);
	        inparams.setCc(cc);
        	inparams.setEdd(edd);
	        inparams.setPlant(plant);
	        param.setObject(inparams);
	    	Session.prepareParams(param);
        	RetObj=(ReturnObjFromRetrieve)SalesDocManager.addSalesDocMails(param);


       	 	ezc.sales.EzSalesOrderMails soMails= new ezc.sales.EzSalesOrderMails(Session);
		soMails.reload();

        	if(from.equals("PP"))
			response.sendRedirect("ezListPlantPlannerMails.jsp");

        	if(from.equals("centralplanner") || from.equals("mktservices"))
			response.sendRedirect("ezUpdateSalesDocMails.jsp?cenplan="+from);
	}
	catch(Exception e)
	{
		System.out.println("the exception is :"+e.getMessage());
	}
%>

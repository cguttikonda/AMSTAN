<%@ include file="../../Lib/SalesDocManager.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezdrlsales.params.EzSalesDocMailStructure" />
<%@ page import="ezc.ezparam.*" %>
<%
   	ReturnObjFromRetrieve RetObj=null;
    	EzcParams param=new EzcParams(false);
        inparams.setPcode(pcode);
    	inparams.setTo(to);
        inparams.setCc(cc);
        inparams.setEdd(edd);
        inparams.setPlant(plant);
        param.setObject(inparams);
    	Session.prepareParams(param);
        RetObj=(ReturnObjFromRetrieve)SalesDocManager.updateSalesDocMails(param);

	ezc.sales.EzSalesOrderMails soMails= new ezc.sales.EzSalesOrderMails(Session);
	soMails.reload();
%>



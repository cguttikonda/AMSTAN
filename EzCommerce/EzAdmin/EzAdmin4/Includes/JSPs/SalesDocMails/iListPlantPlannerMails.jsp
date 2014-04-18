<%@ include file="../../Lib/SalesDocManager.jsp" %>
<%@ page import="ezc.ezparam.*" %>
<%
    	ReturnObjFromRetrieve ListObj=null;
    	String temp="";
       	try
	{
		ezc.ezdrlsales.params.EziSalesDocMailParams inparams=new ezc.ezdrlsales.params.EziSalesDocMailParams();
    		EzcParams param=new EzcParams(false);
		//inparams.setOrderBy("C");
	        param.setObject(inparams);
    		Session.prepareParams(param);    		
    		ListObj=(ReturnObjFromRetrieve)SalesDocManager.listAllSalesDocMails(param);
		temp="false";
	}
	catch(Exception e)
	{
	    	temp="true";
	}
	
%>

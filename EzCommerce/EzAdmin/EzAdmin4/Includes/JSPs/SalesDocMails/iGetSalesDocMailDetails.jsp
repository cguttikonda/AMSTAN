<%@ include file="../../Lib/SalesDocManager.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezdrlsales.params.EziSalesDocMailParams" />
<%@ page import="ezc.ezparam.*" %>
<%

   	ReturnObjFromRetrieve DetObj=null;
    	EzcParams param=new EzcParams(false);
        String cenplan=request.getParameter("cenplan");
        if(cenplan==null)
        {
		cenplan="noexist";
        }
        if(cenplan.equals("centralplanner"))
        {
             	inparams.setPcode(cenplan);
        }
        else if(cenplan.equals("mktservices"))
        {
	     	inparams.setPcode(cenplan);
        }
        else if(cenplan.equals("noexist"))
        {
        	String pCode = request.getParameter("chk1");
        	java.util.StringTokenizer myStk = new java.util.StringTokenizer(pCode,"¥");
		inparams.setPcode((String)myStk.nextToken());
		inparams.setPlant((String)myStk.nextToken());
	}
        param.setObject(inparams);
       	Session.prepareParams(param);
    	DetObj=(ReturnObjFromRetrieve)SalesDocManager.getSalesDocMailDetails(param); 
%>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>

<%

String	pCheckBox[] = request.getParameterValues("pointsvals");

if(pCheckBox!=null && !"null".equals(pCheckBox) && !"".equals(pCheckBox))
{
	for(int i=0;i<pCheckBox.length;i++)
	{
	
		StringTokenizer  st=new StringTokenizer(pCheckBox[i],"§");
		String ptsTyp="",divVal="",ph1Val="",cgrVal="",mg1Val="",mg5Val="";
		
		if(st.hasMoreTokens())
		{
		ptsTyp=(String)st.nextToken();
		divVal=(String)st.nextToken();
		ph1Val=(String)st.nextToken();
		cgrVal=(String)st.nextToken();
		mg1Val=(String)st.nextToken();
		mg5Val=(String)st.nextToken();
		}
		
		if("-".equals(divVal)) divVal="";
		if("-".equals(ph1Val)) ph1Val="";
		if("-".equals(cgrVal)) cgrVal="";
		if("-".equals(mg1Val)) mg1Val="";
		if("-".equals(mg5Val)) mg5Val="";
		
		
		
		if(ptsTyp!=null && !"null".equals(ptsTyp) && !"".equals(ptsTyp))
		{					
			EzcParams mainParams_CVM = new EzcParams(false);
			EziMiscParams miscParams_CVM = new EziMiscParams();
			miscParams_CVM.setIdenKey("MISC_UPDATE");
			miscParams_CVM.setQuery("UPDATE EZC_POINTS_MAPPING SET DIV_VAL='"+divVal+"',PH1_VAL='"+ph1Val+"',CGR_VAL='"+cgrVal+"',MG1_VAL='"+mg1Val+"',MG5_VAL='"+mg5Val+"' WHERE POINTS_TYPE='"+ptsTyp+"'"); 
			mainParams_CVM.setLocalStore("Y");
			mainParams_CVM.setObject(miscParams_CVM);
			Session.prepareParams(mainParams_CVM);	
			try{	ezMiscManager.ezUpdate(mainParams_CVM);
			}
			catch(Exception e){out.println("Exception in Getting Data"+e);}		
		}				
	}
}
response.sendRedirect("ezPointsMapping.jsp?saved=Y");
%>
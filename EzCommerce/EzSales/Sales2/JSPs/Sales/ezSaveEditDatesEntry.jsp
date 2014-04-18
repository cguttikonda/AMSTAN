
<%@  page import ="ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%
	
	String itemNo= request.getParameter("itemNo");
	
	String ind=request.getParameter("ind");

        String status = request.getParameter("status");
        
        
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");

	try{
		
		if(ret!=null)
		{
			for(int i=ret.getRowCount()-1;i>=0;i--)
			{
				if(ret.getFieldValueString(i,"EZDS_ITM_NUMBER").equals(itemNo))
				{	
					ret.deleteRow(i);
				}
			}
		}
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	int count = 1;
	double totReqQty =0;
	String reqQty[] = request.getParameterValues("Qty");
	String dat[]= new String[reqQty.length];
	//String reqDate[] = request.getParameterValues("dat");
	for(int i=0;i<10;i++)
	{
			dat[i] ="";
		if( (reqQty[i] != null) && (reqQty[i].trim().length() !=0) && (!"null".equals(reqQty[i]) && (!"0".equals(reqQty[i]))) )
		{
			
			String reqDate = request.getParameter("dat"+i);
			dat[i] =reqDate;
			ret.setFieldValue("EZDS_STATUS",status);
			ret.setFieldValue("EZDS_ITM_NUMBER",itemNo);
			ret.setFieldValue("EZDS_SCHED_LINE",String.valueOf(count));
			ret.setFieldValue("EZDS_REQ_DATE",reqDate);
			ret.setFieldValue("EZDS_CON_DATE","");
			ret.setFieldValue("EZDS_DATE_TYPE","  ");
			ret.setFieldValue("EZDS_REQ_TIME"," ");
			ret.setFieldValue("EZDS_REQ_QTY",reqQty[i]);
			ret.setFieldValue("EZDS_CON_QTY","0");
			ret.setFieldValue("EZDS_REQ_DLV_BL"," ");
			ret.setFieldValue("EZDS_SCHED_TYPE"," ");
			ret.setFieldValue("EZDS_TP_DATE"," ");
			ret.setFieldValue("EZDS_MS_DATE"," ");
			ret.setFieldValue("EZDS_LOAD_DATE"," ");
			ret.setFieldValue("EZDS_GI_DATE"," ");
			ret.setFieldValue("EZDS_TP_TIME"," ");
			ret.setFieldValue("EZDS_MS_TIME"," ");
			ret.setFieldValue("EZDS_LOAD_TIME","");
			ret.setFieldValue("EZDS_GI_TIME","");
			ret.setFieldValue("EZDS_REFOBJTYPE","");
			ret.setFieldValue("EZDS_EXT1",reqQty[i]);
			ret.setFieldValue("EZDS_EXT2",reqDate);
			totReqQty =totReqQty + Double.parseDouble( reqQty[i]);
			ret.addRow();
			count++;
		}

	}
	session.putValue("EzDeliveryLines",ret);

%>	
<html>
<head>
<Title>Save Delivery Schedules Info -- Powered  by EzCommerce Inc</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
	ede =eval('opener.document.getElementById("editDateEntry_<%=ind%>")')
	edd =eval('opener.document.getElementById("editDateDisplay_<%=ind%>")')
	var temp="";
	var cc=0;
	
	<%
	for(int i=0;i<10;i++)
	{
%>
		temp="<%=dat[i]%>"
		
		if(temp != "")
			cc++;
<%
	}
%>	
	
	var retVal="";
	if(cc > 1)
		retVal="multiple"
	else
		retVal="<%=dat[0]%>"
		
	if(edd != null)
	{
		edd.innerHTML=retVal
	}
	if(ede != null)
	{	
		ede.innerHTML=retVal
		
	}
	
	x=eval("opener.document.generalForm.desiredQty").length
	
if(x>1)
{
	eval("opener.document.generalForm.desiredQty[<%=Integer.parseInt(ind)%>]").value="<%=totReqQty%>"
	eval("opener.document.generalForm.desiredDate[<%=Integer.parseInt(ind)%>]").value="<%=dat[0]%>"
}else{
	eval("opener.document.generalForm.desiredQty").value="<%=totReqQty%>"
	eval("opener.document.generalForm.desiredDate").value="<%=dat[0]%>"

}	
	this.close();
	
</script>
</head>
<body>
<Div id="MenuSol"></Div>
</body>
</html>



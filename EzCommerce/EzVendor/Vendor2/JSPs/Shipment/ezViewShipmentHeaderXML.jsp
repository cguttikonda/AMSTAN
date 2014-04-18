<%@ page import = "ezc.ezshipment.client.*" %>
<%@page import = "ezc.ezcommon.*" %>
<%@page import = "ezc.ezshipment.params.*,ezc.ezvendorapp.params.*" %>
jsp:useBean id="shipManager" class="ezc.ezshipment.client.EzShipmentManager" />
<%
	String sysKey = request.getParameter("sysKey");
	String ponum = request.getParameter("ponum");
	String soldTo = request.getParameter("soldTo");
	String userType = request.getParameter("userType");
	String invNum="";
	
	int count = 0;
	
	EziShipmentInfoParams inParams1 =new EziShipmentInfoParams();
	inParams1.setSelection("H");
	inParams1.setPurchaseOrderNumber(ponum);
	inParams1.setSysKey(sysKey);
	inParams1.setSoldTo(soldTo);		//////+"' AND EZSH_STATUS='N"
	if ("3".equals(userType))
		inParams1.setStatus("N");
	else if ("2".equals(userType))
		inParams1.setStatus("Y");
	EzcParams ezcparams = new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(inParams1);	
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);
	if ((ret!=null)&&(ret.getRowCount()>0))
	{
		finalret = (ReturnObjFromRetrieve)ret.getFieldValue("HEADER");
		if(finalret != null)
			count = finalret.getRowCount();
		out.println("<?xml version=\"1.0\"?>");		
		out.println("<rows>");
		if(count > 0)
		{
			for(int i=0;i< count;i++)
			{
				Date dcdate	= (Date)finalret.getFieldValue(i,"DC_DATE");
				Date shipdate	= (Date)finalret.getFieldValue(i,"SHIPMENT_DATE");
				ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();			
			
				if (finalret.getFieldValue(i,"INV_NUM")!=null && !finalret.getFieldValueString(i,"INV_NUM").equals(""))
					invNum = finalret.getFieldValueString(i,"INV_NUM");
				else	
					invNum = "&nbsp;";			
				out.println("<row id='"+ i +"'><cell></cell><cell>"+finalret.getFieldValueString(i,"DC_NR")+"</cell><cell>"+invNum+"</cell><cell>"+fd.getStringFromDate(shipdate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"</cell><cell><![CDATA[<nobr>"+"<a href=\"JavaScript:funDetails("+i+",'"+finalret.getFieldValueString(i,"STATUS")+"') style=\"cursor:hand\">Details</a></nobr>]]></cell></row>");
			}	
		}
		else
		{
			out.println("<row id='"+count1+"'></row>");
		}
		out.println("</rows>");
	}	
%>
<Div id="MenuSol"></Div>
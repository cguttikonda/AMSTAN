<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iListRejectedMaterials.jsp" %>
<%!
	public String getNumberFormat(String dblValue,int maxDecimal)
	{
		String retValue = "";
		try
		{
			java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
			numberFormat.setMaximumFractionDigits(0);
			numberFormat.setMinimumFractionDigits(maxDecimal);
			if(dblValue != null && !"null".equals(dblValue) && !"".equals(dblValue.trim()))
				retValue = numberFormat.format(Double.valueOf(dblValue))+"";
			else	
				retValue = "0";
		}
		catch(Exception ex)
		{
			retValue = dblValue;
		}
		return retValue;
	}
%>	
<%
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");
	
	if(Count > 0)
	{
		for(int i=0;i<Count;i++)
		{
			String matno		= matlist.getFieldValueString(i,"MATNR");
			String desc		= matlist.getFieldValueString(i,"MAKTX");
			String grno		= matlist.getFieldValueString(i,"LFBNR");
			String qty		= getNumberFormat(matlist.getFieldValueString(i,"MENGE"),0);
			String localvalue	= matlist.getFieldValueString(i,"DMBTR");
			String ponum		= matlist.getFieldValueString(i,"EBELN");
			String remarkstr	= (String)remarks.get(ponum);
			String remarkView	= "";
			if(grno == null || "null".equals(grno))
				grno = "";
			if(remarkstr == null || "null".equals(remarkstr))
				remarkstr = "";
			else
				remarkView = "View";
			
			String outputString = "<row id='"+desc+"#"+ponum+"#"+i+"'><cell></cell><cell>"+matno+"</cell><cell>"+desc+"</cell><cell>"+grno+"</cell><cell>"+qty+"</cell><cell>"+localvalue+"</cell><cell>"+ponum+"</cell>";
			if(remarkstr != null && !"null".equals(remarkstr) && !"".equals(remarkstr))
				outputString += "<cell><![CDATA[<nobr><a href=\"JavaScript:openWindow('"+remarkstr+"')\" onMouseover=\"window.status='Click To View Remaks '; return true\" onMouseout=\"window.status=' '; return true\">View</a></nobr>]]></cell>";
			else
				outputString += "<cell></cell>";
			outputString += "</row>";
			out.println(outputString);
		}	
	}
	else
	{
		out.println("<row id='"+Count+"'></row>");
	}
	out.println("</rows>");
%>
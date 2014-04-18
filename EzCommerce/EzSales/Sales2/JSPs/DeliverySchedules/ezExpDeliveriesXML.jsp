<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iDeliverySchedules.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddDelSchedule_Lables.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%!
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
	public static String replaceChar(String s,char c)
	{
		StringBuffer r = new StringBuffer(s.length());
		r.setLength(s.length());
		int current = 0;
		for(int i=0;i<s.length();i++)
		{
			char cur=s.charAt(i);
			if(cur==c)
			{
				r.setLength(s.length()+4);
				//r.setCharAt(current++,cur);  
				r.setCharAt(current++,'a');
				r.setCharAt(current++,'m');
				r.setCharAt(current++,'p');
				r.setCharAt(current++,';');
			}
			else
			{
				r.setCharAt(current++,cur);
			}
		}
		return r.toString();
	}

%>

<%
//out.println("<?xml version=\"1.0\"?>");		
//out.println("<rows>");

int count =delivShedules.getRowCount();
if( count >0)
{


	Vector types = new Vector();
	types.addElement("date");
	types.addElement("date");
	EzGlobal.setColTypes(types);

	Vector names = new Vector();
	names.addElement("ReqDate");
	names.addElement("GiDate");
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(delivShedules);
	

	String item="0",matStr="",matCode="",materialDesc="",reqDate= "",giDate = "",custMat="";
	java.util.StringTokenizer st = null;
	for(int j=0;j<delivShedules.getRowCount();j++)
	{
	
		matStr	= (String)matdesc.get(delivShedules.getFieldValueString(j,"ItmNumber")); 
		
		if(matStr!=null)
		{
			st	= new java.util.StringTokenizer(matStr,"###");
			if(st!=null){
				matCode		= st.nextToken();
				custMat         = st.nextToken();
				materialDesc	= st.nextToken();
				materialDesc	= replaceChar(materialDesc,'&');

			}
		}
		
		String confirmQty = delivShedules.getFieldValueString(j,"ConfirQty");
		if(("0.000").equals(confirmQty))
		{
			confirmQty = "";
			giDate     = "";
		}
		else{
			confirmQty  = eliminateDecimals(confirmQty)+"";
			giDate      = ret.getFieldValueString(j,"GiDate");
		}
		
		
		String reqQty = delivShedules.getFieldValueString(j,"ReqQty");
		if(("0.000").equals(reqQty))
		{
			reqQty  = "";
			reqDate = "";
			
		}else{
			reqQty  = eliminateDecimals(reqQty)+"";
			reqDate = ret.getFieldValueString(j,"ReqDate"); 
		}
		
		
		//out.println("<row id='"+matCode+"'><cell>"+matCode+"</cell><cell>"+custMat+"</cell><cell>"+materialDesc+"</cell><cell>"+delivShedules.getFieldValueString(j,"BaseUom")+"</cell><cell>"+reqQty+"&amp;</cell><cell>"+reqDate+"</cell><cell>"+confirmQty+"&amp;</cell><cell>"+giDate+"</cell></row>");		
		out.println("<row id='"+matCode+"'><cell>"+matCode+"</cell><cell>"+custMat+"</cell><cell>"+materialDesc+"</cell><cell>"+reqQty+"&amp;</cell><cell>"+reqDate+"</cell><cell>"+confirmQty+"&amp;</cell><cell>"+giDate+"</cell></row>");		
		
	}	
		
}
else
{

}
out.println("</rows>");
%>
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezutil.*" %> 

<%!
public String dateConvertion(String reqDate, String dateFormat)
{	 
	int mm=0;
	int dd=0;
	int yy=0;
	if(reqDate!=null ||!"null".equals(reqDate)||!"".equals(reqDate))
	{
		if("1".equals(dateFormat))
		{
	        	yy=Integer.parseInt(reqDate.substring(0,4));
	        	mm=Integer.parseInt(reqDate.substring(5,7));
			dd=Integer.parseInt(reqDate.substring(8,10));		
		}
		else if("2".equals(dateFormat))
		{
	        	yy=Integer.parseInt(reqDate.substring(0,4));
	        	dd=Integer.parseInt(reqDate.substring(5,7));	
	        	mm=Integer.parseInt(reqDate.substring(8,10));
			
		}
		else if("3".equals(dateFormat))
		{
			mm=Integer.parseInt(reqDate.substring(0,2));
	        	dd=Integer.parseInt(reqDate.substring(3,5));	
	        	yy=Integer.parseInt(reqDate.substring(6,10));
	        	
		
		}
		else if("4".equals(dateFormat))
		{
			dd=Integer.parseInt(reqDate.substring(0,2));	
			mm=Integer.parseInt(reqDate.substring(3,5));
	        	yy=Integer.parseInt(reqDate.substring(6,10));		
		}
		else if("5".equals(dateFormat))
		{
			yy=Integer.parseInt(reqDate.substring(0,2));	
			mm=Integer.parseInt(reqDate.substring(3,5));		
			dd=Integer.parseInt(reqDate.substring(6,8));	
		}
		else if("6".equals(dateFormat))
		{
			yy=Integer.parseInt(reqDate.substring(0,2));	
			dd=Integer.parseInt(reqDate.substring(3,5));		
			mm=Integer.parseInt(reqDate.substring(6,8));		
			
		}
		else if("7".equals(dateFormat))
		{
			mm=Integer.parseInt(reqDate.substring(0,2));	
			dd=Integer.parseInt(reqDate.substring(3,5));		
			yy=Integer.parseInt(reqDate.substring(6,8));	
		}
		else if("8".equals(dateFormat))
		{
			dd=Integer.parseInt(reqDate.substring(0,2));		
			mm=Integer.parseInt(reqDate.substring(3,5));	
			yy=Integer.parseInt(reqDate.substring(6,8));			
		}
		
		GregorianCalendar DocDate=new GregorianCalendar(yy,mm-1,dd);
		String finalString =FormatDate.getStringFromDate(DocDate.getTime(),".",FormatDate.DDMMYYYY);
	
		return finalString;
	}
	else
	{
		return "";
	}
	
	
}

%>

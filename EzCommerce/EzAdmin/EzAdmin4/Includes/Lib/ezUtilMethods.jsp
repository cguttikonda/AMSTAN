<%--
      Copyright Notice =====================================*
    * This file contains proprietary information of EzCommerce Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 2003 ===================================*
    * Author :V.Krishna Prasad =============================*
--%>
<%@page import="java.util.*"%>
<%!
public String ezCheckForNull(String str)
{
	if((str==null)||("null".equals(str)))
		str = "";
	return str;
}
public String ezCheckForNull(String str,String defStr)
{
	if((str==null) || ("null".equals(str)) || ((str.trim()).length() == 0))
		str = defStr;
	return str.trim();
}
public String[] ezCheckForNull(String[] strArr)
{
	if(strArr!=null)
	{
		int strArrLength = strArr.length;
		String str="";
		for(int sta =0 ;sta <strArrLength;sta++)
		{
			str = strArr[sta];
			if((str ==null)||("null".equals(str)))
				strArr[sta] = "";
		}
	}
	return 	strArr;
}
public String[] ezCheckForNull(String[] strArr,String defStr)
{
	if(strArr!=null)
	{
		int strArrLength = strArr.length;
		String str="";
		for(int sta =0 ;sta <strArrLength;sta++)
		{
			str = strArr[sta];
			if((str ==null)||("null".equals(str))||("".equals(str)))
				strArr[sta] = defStr;
		}
	}
	return 	strArr;
}

	public String weekToDate(String selweek)
	{
		String firstDate="";
		String secondDate="";
		String strDate="";
		String strMonth="";
		int weekNo=Integer.parseInt(selweek);
		Calendar dateObject = Calendar.getInstance();
		dateObject.set(Calendar.WEEK_OF_YEAR,weekNo);

		int weekNo1 = dateObject.get(Calendar.WEEK_OF_YEAR);
		dateObject.set(Calendar.DAY_OF_WEEK,2);
		strDate =(dateObject.get(Calendar.DATE)> 10)?""+dateObject.get(Calendar.DATE):"0"+dateObject.get(Calendar.DATE);
		strMonth =((dateObject.get(Calendar.MONTH)+1) > 10)?""+(dateObject.get(Calendar.MONTH)+1):"0"+(dateObject.get(Calendar.MONTH)+1);
		firstDate=strDate+"."+strMonth+"."+dateObject.get(Calendar.YEAR);
		dateObject.set(Calendar.WEEK_OF_YEAR,weekNo+1);
		weekNo1 = dateObject.get(Calendar.WEEK_OF_YEAR);
		dateObject.set(Calendar.DAY_OF_WEEK,1);
		strDate =(dateObject.get(Calendar.DATE)> 10)?""+dateObject.get(Calendar.DATE):"0"+dateObject.get(Calendar.DATE);
		strMonth =((dateObject.get(Calendar.MONTH)+1) > 10)?""+(dateObject.get(Calendar.MONTH)+1):"0"+(dateObject.get(Calendar.MONTH)+1);
		secondDate=strDate+"."+strMonth+"."+dateObject.get(Calendar.YEAR);
		return(firstDate+" To "+secondDate);
	}

/*
	public String weeksOfMonth(String selweek,int month)
	{
		String firstDate="";
		String secondDate="";
		String strDate="";
                String strMonth="";
		int weekNo=Integer.parseInt(selweek);
		Calendar dateObject = Calendar.getInstance();
		dateObject.set(Calendar.MONTH,month);
		dateObject.set(Calendar.WEEK_OF_MONTH,weekNo);
		strDate =(dateObject.get(Calendar.DATE)> 10)?""+dateObject.get(Calendar.DATE):"0"+dateObject.get(Calendar.DATE);
                strMonth =((dateObject.get(Calendar.MONTH)+1) > 10)?""+(dateObject.get(Calendar.MONTH)+1):"0"+(dateObject.get(Calendar.MONTH)+1);
		firstDate=strMonth+"."+strDate+"."+dateObject.get(Calendar.YEAR);
		strDate =(dateObject.get(Calendar.DATE)> 10)?""+dateObject.get(Calendar.DATE):"0"+dateObject.get(Calendar.DATE);
                strMonth =((dateObject.get(Calendar.MONTH)+1) > 10)?""+(dateObject.get(Calendar.MONTH)+1):"0"+(dateObject.get(Calendar.MONTH)+1);
                secondDate=strMonth+"."+strDate+"."+dateObject.get(Calendar.YEAR);
	        return(firstDate+" To "+secondDate);
	}
*/

	public int noOfWeekInMonth(String month)
	{
		int monthNo=Integer.parseInt(month);
		Calendar dateObject = Calendar.getInstance();
		dateObject.set(Calendar.MONTH,monthNo);
		return (dateObject.getActualMaximum(Calendar.WEEK_OF_MONTH));

	}

	public String firstAndLastWeeksOfMonth(String month)
	{
		int monthNo=Integer.parseInt(month);
		Calendar dateObject = Calendar.getInstance();
		dateObject.set(Calendar.MONTH,monthNo);
		dateObject.set(Calendar.DATE,1);
		int first=dateObject.get(Calendar.WEEK_OF_YEAR);
		dateObject.set(Calendar.DATE,dateObject.getActualMaximum(Calendar.DAY_OF_MONTH));
		int second=dateObject.get(Calendar.WEEK_OF_YEAR);
		return (first+","+second+","+dateObject.get(Calendar.MONTH));

	}


	public String datesOfMonth(String month)
	{
		String lastDate="";
		String firstDate="";
		String secondDate="";
		String strDate="";
                String strMonth="";

		int monthNo=Integer.parseInt(month);
		Calendar dateObject = Calendar.getInstance();
		dateObject.set(Calendar.MONTH,monthNo);
		lastDate=""+dateObject.getActualMaximum(Calendar.DAY_OF_MONTH);
		strDate ="01";
                strMonth =((dateObject.get(Calendar.MONTH)+1) > 10)?""+(dateObject.get(Calendar.MONTH)+1):"0"+(dateObject.get(Calendar.MONTH)+1);
		firstDate=strMonth+"."+strDate+"."+dateObject.get(Calendar.YEAR);
		secondDate=strMonth+"."+lastDate+"."+dateObject.get(Calendar.YEAR);
	        return(firstDate+" To "+secondDate);
	}

	public String getTitleString(String title,String buttonPath)
	{
		String tempTitle = "";
		tempTitle += "<Table align='center' border='0' cellpadding='0' class='displayheaderback' cellspacing='0' width='100%'>";
		tempTitle += "\n\t<Tr>";
		//tempTitle += "\n\t\t<Td height='35' class='displayheaderback' width='35%'><a style='text-decoration:none'  class=subclass href='../Misc/ezSalesHome.jsp' target='_top'><img src='../../Images/Buttons/"+buttonPath+"/home_button.gif' height='17'  title='Home' border=0  > </a>&nbsp; <a style='text-decoration:none'  class=subclass href='../Misc/ezLogout.jsp' target='_top'><img src='../../Images/Buttons/"+buttonPath+"/logout_butt.gif' height='17'   title='Logout'   border='0'></a></Td>";
		tempTitle += "\n\t\t<Td height='35' align='center' class='displayheader'  width='65%'>"+title+"</Td>";
		tempTitle += "\n\t</Tr>";
		tempTitle += "\n</Table>";
		return tempTitle;
	}

%>

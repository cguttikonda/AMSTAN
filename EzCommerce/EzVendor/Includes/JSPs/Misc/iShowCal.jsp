<%@page import="java.util.*"%>
<%
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH);
	int cDate = cdObj.get(Calendar.DATE);
%>



<script>
<%

String dateFormat=(String)session.getValue("DATEFORMAT");
String seperator=(String)session.getValue("DATESEPERATOR");

if(dateFormat.equals("1"))
{
   dateFormat = "yyyy"+seperator+"MM"+seperator+"dd";	
}
else if(dateFormat.equals("2"))
{
   dateFormat = "yyyy"+seperator+"dd"+seperator+"MM";
}
else if(dateFormat.equals("3"))
{
   dateFormat = "MM"+seperator+"dd"+seperator+"yyyy";
}
else if(dateFormat.equals("4"))
{
   dateFormat = "dd"+seperator+"MM"+seperator+"yyyy";
}
else if(dateFormat.equals("5"))
{
   dateFormat = "yy"+seperator+"MM"+seperator+"dd";
}
else if(dateFormat.equals("6"))
{
   dateFormat = "yy"+seperator+"dd"+seperator+"MM";
}
else if(dateFormat.equals("7"))
{
   dateFormat = "MM"+seperator+"dd"+seperator+"yy";
}
else if(dateFormat.equals("8"))
{
   dateFormat = "dd"+seperator+"MM"+seperator+"yyyy";
}
dateFormat =( (dateFormat == null)||(dateFormat.trim().length()==0)||("null".equals(dateFormat) )  )?"dd.MM.yyyy":dateFormat;
String formatKey =dateFormat.substring(2,3);
if((formatKey.toUpperCase()).equals("Y".toUpperCase()))
{
	formatKey =dateFormat.substring(4,5);
}

StringTokenizer st=new StringTokenizer(dateFormat,formatKey);
String dt[]=new String[3];
%>
var DateFarmat="<%=formatKey%>";
var dFormat=new Array();
<%
for(int cal=0;st.hasMoreTokens();cal++)
{
	dt[cal]=(String)st.nextElement();
	if((dt[cal].toUpperCase()).equals("YYYY"))
		dt[cal]="YY";
%>
	dFormat[<%=cal%>]="<%=dt[cal].toUpperCase()%>";
<%
}
%>
</script>

<%
		String thName=(String) session.getValue("userStyle");



if(("BLUE").equals(thName)){
%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeBlue.css">
<%}else{
	if(("BROWN").equals(thName)){
%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeBrown.css">
	<%}else{
		if(("DARKBLUE").equals(thName)){
	%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeDarkBlue.css">
		<%}else{
			if(("GREEN").equals(thName)){
		%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeGreen.css">
			<%}else{
				if(("MAROON").equals(thName)){
			%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemePink.css">
				<%}else{
					if(("YELLOW").equals(thName)){
			%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeYellow.css">
					<%}else{

				%>
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeGreen.css">
					<%}
				}

			}
		}
	}
}
%>




<script src="../../Library/JavaScript/ezCalender.js"></script>

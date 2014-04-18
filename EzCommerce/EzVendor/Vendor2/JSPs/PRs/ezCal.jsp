<%@page import="java.util.*"%>
<%
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear  = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH);
	int cDate  = cdObj.get(Calendar.DATE);
%>



<script>
<%

String dateFormat = "MM.dd.yyyy";
String formatKey  = ".";


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
<link rel="stylesheet" href="../../Library/Styles/ezCalenderThemeBlue.css">
<script src="../../Library/JavaScript/ezCal.js"></script>
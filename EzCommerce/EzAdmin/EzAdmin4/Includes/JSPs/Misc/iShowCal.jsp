<%@ page import = "java.util.*" %>
<%
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH);
	int cDate = cdObj.get(Calendar.DATE);
	String thName=null;
	if(ButtonDir!=null)
		thName =ButtonDir.substring(ButtonDir.indexOf('/')+1,ButtonDir.length());

	//this is for tool tip of calendar image
	String calToolTip = "Click here to Select Date";
if(thName==null){%>
	<link rel="stylesheet" href="../../Library/Styles/ezCalenderLavender.css">
<%}else{%>
	<link rel="stylesheet" href="../../Library/Styles/ezCalender<%=thName%>.css">
<%}%>
<%--
	<script>
	aDay = new Array()
	aDay[0] = 'Sunday';
	aDay[1] = 'Monday';
	aDay[2] = 'Tuesday';
	aDay[3] = 'Wednesday';
	aDay[4] = 'Thursday';
	aDay[5] = 'Friday';
	aDay[6] = 'Saturday';

	aDayShort = new Array()
	aDayShort[0] = 'Sun';
	aDayShort[1] = 'Mon';
	aDayShort[2] = 'Tue';
	aDayShort[3] = 'Wed';
	aDayShort[4] = 'Thu';
	aDayShort[5] = 'Fri';
	aDayShort[6] = 'Sat';

	var todaytxt = "Today";
	var clear = "Clear";

	Months = new Array()
	Months[1]='January';
	Months[2]='February';
	Months[3]='March';
	Months[4]='April';
	Months[5]='May';
	Months[6]='June';
	Months[7]='July';
	Months[8]='August';
	Months[9]='September';
	Months[10]='October';
	Months[11]='November';
	Months[12]='December';

<%
ezc.ezbasicutil.EzGlobal globel=new ezc.ezbasicutil.EzGlobal();
String dateFormat=globel.getDateFormat();
dateFormat =( (dateFormat == null)||(dateFormat.trim().length()==0)||("null".equals(dateFormat) )  )?"dd.MM.yyyy":dateFormat;
String formatKey =dateFormat.substring(2,3);

if((formatKey.toUpperCase()).equals("Y".toUpperCase()))
{
	formatKey =dateFormat.substring(4,5);
}


String dateFormat="MM/dd/YYYY";
String formatKey = "/";


StringTokenizer stdateF=new StringTokenizer(dateFormat,formatKey);
String dt[]=new String[3];
%>

var DateFarmat="<%=formatKey%>";
var dFormat=new Array();

<%
for(int cal=0;stdateF.hasMoreTokens();cal++)
{
	dt[cal]=(String)stdateF.nextElement();
	if((dt[cal].toUpperCase()).equals("YYYY"))
		dt[cal]="YY";
%>
	dFormat[<%=cal%>]="<%=dt[cal].toUpperCase()%>";
<%
}
%>
</script>
--%>
<script src="../../Library/JavaScript/ezCalender.js"></script>

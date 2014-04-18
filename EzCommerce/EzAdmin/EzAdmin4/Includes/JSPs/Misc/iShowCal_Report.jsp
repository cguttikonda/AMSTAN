<%
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH);
	int cDate = cdObj.get(Calendar.DATE);
	String thName=null;
	if(ButtonDir!=null)
		thName =ButtonDir.substring(ButtonDir.indexOf('/')+1,ButtonDir.length());
	
	//this is for tool tip of calendar image
	String calToolTip = getLabel("TT_CAL");
if(thName==null){%>
	<link rel="stylesheet" href="../../Library/Styles/ezCalenderGreen.css">
<%}else{%>
	<link rel="stylesheet" href="../../Library/Styles/ezCalender<%=thName%>.css">
<%}%>

	<script>
	aDay = new Array()
	aDay[0] = '<%=getLabel("CAL_SUN")%>';
	aDay[1] = '<%=getLabel("CAL_MON")%>';
	aDay[2] = '<%=getLabel("CAL_TUE")%>';
	aDay[3] = '<%=getLabel("CAL_WED")%>';
	aDay[4] = '<%=getLabel("CAL_THU")%>';
	aDay[5] = '<%=getLabel("CAL_FRI")%>';
	aDay[6] = '<%=getLabel("CAL_SAT")%>';

	aDayShort = new Array()
	aDayShort[0] = '<%=getLabel("CAL_SUN1")%>';
	aDayShort[1] = '<%=getLabel("CAL_MON1")%>';
	aDayShort[2] = '<%=getLabel("CAL_TUE1")%>';
	aDayShort[3] = '<%=getLabel("CAL_WED1")%>';
	aDayShort[4] = '<%=getLabel("CAL_THU1")%>';
	aDayShort[5] = '<%=getLabel("CAL_FRI1")%>';
	aDayShort[6] = '<%=getLabel("CAL_SAT1")%>';

	var todaytxt = "<%=getLabel("CAL_TODAY")%>";
	var clear = "<%=getLabel("CLR")%>";

	Months = new Array()
	Months[1]='<%=getLabel("JANU")%>';
	Months[2]='<%=getLabel("FEBR")%>';
	Months[3]='<%=getLabel("MARC")%>';
	Months[4]='<%=getLabel("APRI")%>';
	Months[5]='<%=getLabel("MAY")%>';
	Months[6]='<%=getLabel("JUNE")%>';
	Months[7]='<%=getLabel("JULY")%>';
	Months[8]='<%=getLabel("AUGU")%>';
	Months[9]='<%=getLabel("SEPT")%>';
	Months[10]='<%=getLabel("OCTO")%>';
	Months[11]='<%=getLabel("NOVE")%>';
	Months[12]='<%=getLabel("DECE")%>';

<%
ezc.ezbasicutil.EzGlobal globel=new ezc.ezbasicutil.EzGlobal();
String dateFormat=globel.getDateFormat();
dateFormat =( (dateFormat == null)||(dateFormat.trim().length()==0)||("null".equals(dateFormat) )  )?"yyyymmdd":dateFormat;
//if (dateFormat.length()>10)
//	dateFormat="DD.MM.YYYY";
String formatKey ="";//dateFormat.substring(2,3);
/*if((formatKey.toUpperCase()).equals("Y".toUpperCase()))
{
	formatKey =dateFormat.substring(4,5);
}*/

//StringTokenizer stdateF=new StringTokenizer(dateFormat,formatKey);
String dt[]=new String[3];
%>
var DateFarmat="<%=formatKey%>";
var dFormat=new Array();
<%
/*for(int cal=0;stdateF.hasMoreTokens();cal++)
{
	dt[cal]=(String)stdateF.nextElement();
	if((dt[cal].toUpperCase()).equals("YYYY"))
		dt[cal]="YY";*/
%>
	/*dFormat[<%//=cal%>]="<%//=dt[cal].toUpperCase()%>";*/
	dFormat[0]="YY";
	dFormat[1]="MM";
	dFormat[2]="DD";
<%
//}
%>
</script>
<script src="../../Library/JavaScript/ezCalender.js"></script>

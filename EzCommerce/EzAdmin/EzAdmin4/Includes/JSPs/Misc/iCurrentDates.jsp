<%@ page import = "java.util.*" %>
<%
	java.util.Calendar cdObj = java.util.Calendar.getInstance();
	int cYear = cdObj.get(Calendar.YEAR);
	int cMonth = cdObj.get(Calendar.MONTH)+1;
	int cDate = cdObj.get(Calendar.DATE);
	//out.println(cDate);
	//out.println(cMonth);
	//out.println(cYear);
%>	
	<script>
	var Table_BgColor = '<%=session.getValue("Table_BgColor")%>';
	var Td_TodayOverColor = '<%=session.getValue("Td_TodayOverColor")%>';
	var Txt_TodayOverColor = '<%=session.getValue("Txt_TodayOutColor")%>';
	var Txt_TodayOutColor = '<%=session.getValue("Txt_TodayOutColor")%>';
	var Td_TodayCellOverColor = '<%=session.getValue("Td_TodayCellOverColor")%>';
	</script>

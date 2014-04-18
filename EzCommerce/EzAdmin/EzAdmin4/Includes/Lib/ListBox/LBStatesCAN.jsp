<%
	String[] stateListCAN = {"Alberta",
		"British Columbia",
		"Manitoba",
		"New Brunswick",
		"Newfoundland",
		"Northwest Territories",
		"Nova Scotia",
		"Ontario",
		"Prince Edward Island",
		"Quebec",
		"Saskatchewan",
		"Yukon"};

%>

<SELECT NAME="State">
<%

for (int i=0;i<stateListCAN.length;i++){
	stsel="";
	if (state.equals(stateListCAN[i])) stsel=" selected";
	%>
	<OPTION VALUE="<%=stateListCAN[i]%>" <%=stsel%>><%=stateListCAN[i]%>
	<%
}
%>
</SELECT>
<input type="hidden" name="maxZip" value="5">
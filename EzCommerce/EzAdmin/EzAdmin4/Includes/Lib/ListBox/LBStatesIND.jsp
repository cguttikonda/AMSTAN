<%
String[] stateListIND = {"Andaman and Nicobar Islands ",
"Andhra Pradesh",
"Arunachal Pradesh",
"Assam",
"Bihar",
"Chandigarh",
"Chattisgarh",
"Dadra and Nagar Haveli",
"Daman and Diu",
"Delhi",
"Goa",
"Gujarat",
"Haryana",
"Himachal Pradesh",
"Jammu and Kashmir",
"Jharkhand",
"Karnataka",
"Kerala",
"Lakshadweep",
"Madhya Pradesh",
"Maharashtra",
"Manipur",
"Meghalaya",
"Mizoram",
"Nagaland",
"Orissa",
"Pondicherry", 
"Punjab",
"Rajasthan",
"Sikkim",
"Tamilnadu",
"Tripura",
"Uttar Pradesh Uttaranchal",
"West Bengal"};
%>
<SELECT NAME="State">
<%
for (int i=0;i<stateListIND.length;i++){
	stsel="";
	if (state.equals(stateListIND[i])) stsel=" selected";
	%>
	<OPTION VALUE="<%=stateListIND[i]%>" <%=stsel%>><%=stateListIND[i]%>
	<%
}
%>
</SELECT>
<input type="hidden" name="maxZip" value="6">
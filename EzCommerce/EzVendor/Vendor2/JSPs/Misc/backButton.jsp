<Div id="BackButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
	<Center>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Back");
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

		out.println(getButtonStr(buttonName,buttonMethod));	
	%>
</Center>
</Div>
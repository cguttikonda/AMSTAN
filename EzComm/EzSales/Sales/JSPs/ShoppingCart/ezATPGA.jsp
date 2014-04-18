<%
	String usrTyp	 = "";
	String userFN	 = (String)session.getValue("FIRSTNAME");
	String userLN	 = (String)session.getValue("LASTNAME");

	if("2".equals((String)session.getValue("UserType")))
		usrTyp = "ASB";
	else
	{
		if("Y".equals((String)session.getValue("REPAGENCY")))
		{
			usrTyp = "REP";
		}
		else
		{
			usrTyp = "CU";
		}
	}

	String gaSku	 = atpResultRet.getFieldValueString(a,"MATERIAL");
	String gaCust	 = atpSHP+" / "+atpSTP+" - "+stAtpStr;
	String gaQty	 = atpResultRet.getFieldValueString(a,"AVAILQTY");
	String gaStatus	 = "";
	String gaUser	 = userFN+" "+userLN+" / "+usrTyp;
%>

<script type="text/javascript">
	var _gaq = _gaq || [];
	//_gaq.push(['_setAccount', 'UA-35953021-1']);
	//_gaq.push(['_setDomainName', 'myasb2b.com']);
	_gaq.push(['_setAccount', 'UA-49631001-1']);
	_gaq.push(['_setDomainName', 'americanstandard.com']);
	_gaq.push(["_set", "title", "ATP"]);

	_gaq.push(["_setCustomVar", 1, "SKU", "TEST", 1]);
	_gaq.push(["_setCustomVar", 2, "Ship", "TEST", 1]);
	_gaq.push(["_setCustomVar", 3, "Qty", "TEST", 1]);
	_gaq.push(["_setCustomVar", 4, "Stat", "TEST", 1]);
	_gaq.push(["_setCustomVar", 5, "User", "TEST", 1]);

	//_gaq.push(["_setCustomVar", 1, "SKU", <%=gaSku%>, 1]);
	//_gaq.push(["_setCustomVar", 2, "Ship/Sold - State", <%=gaCust%>, 1]);
	//_gaq.push(["_setCustomVar", 3, "Quantity", <%=gaQty%>, 1]);
	//_gaq.push(["_setCustomVar", 4, "Availability Status", <%=gaStatus%>, 1]);
	//_gaq.push(["_setCustomVar", 5, "User Type", <%=gaUser%>, 1]);

	_gaq.push(['_trackPageview']);

	(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
</script>
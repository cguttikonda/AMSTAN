<head>
<script type="text/javascript" src="jquery-1.4.2.js"></script>
<script type="text/javascript">
function lookup(inputString) {
if(inputString.length == 0) {
$('#suggestions').hide();
} else {
$.post("../Misc/ezMatSearch.jsp", {queryString: ""+inputString+""}, function(data){
if(data.length >0) {
$('#suggestions').show();
$('#autoSuggestionsList').html(data);
}
});
}
}
function fill(thisValue) {
$('#inputString').val(thisValue);
setTimeout("$('#suggestions').hide();", 200);
}

</script>

<style type="text/css">

.suggestionsBox {
position: relative;
left: 260px;
margin: 0px 0px 0px 0px;
width: 200px;
background-color: #7845DD;
-moz-border-radius: 7px;
-webkit-border-radius: 7px;
border: 2px solid #000;
color: #fff;
}
.suggestionList {
margin: 0px;
padding: 0px;
}
.suggestionList li {


margin: 0px 0px 3px 0px;
padding: 3px;
cursor: pointer;
}
.suggestionList li:hover {
background-color: #DD45CD;
}
</style>
</head>
<body>
<form id="search_mini_form" action="../Catalog/ezProductDetails.jsp" method="get">

<div class="form-search">
 	<h5 class="block-title" align="left">Default Sold To : <%=soldToNameHead%></h5>
	<h5 class="block-title" align="left">Default Ship To : <%=shipToNameHead%></h5>
	
        <input type="text" size="30" value="" id="inputString" onkeyup="lookup(this.value);" onblur="fill();" />
		
		<div class="suggestionsBox" id="suggestions" style="display: none;">
		<div class="suggestionList" id="autoSuggestionsList">
		</div>
		</div>
    </div>
</form>

</div>
</header>
</div>
</div>

jdbc
=====
<%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%
String str=request.getParameter("queryString");
try {

String connectionURL = "jdbc:mysql://192.168.10.13:3306/ankdb";
Connection con;
Class.forName("com.mysql.jdbc.Driver");
// Get a Connection to the database
con = DriverManager.getConnection(connectionURL, "root", "root"); 
//Add the data into the database
String sql = "SELECT state FROM states WHERE state LIKE '"+str+"%' LIMIT 10";
Statement stm = con.createStatement();
stm.executeQuery(sql);
ResultSet rs= stm.getResultSet();
while (rs.next ()){
out.println("<li onclick='fill("+rs.getString("state")+");'>"+rs.getString("state")+"</li>");
}}catch(Exception e){
out.println("Exception is ;"+e);
}
%>



jsp
====

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jQuery Auto Complete</title>
<script type="text/javascript" src="jquery-1.4.2.js"></script>
<script type="text/javascript">
function lookup(inputString) {
if(inputString.length == 0) {
$('#suggestions').hide();
} else {
$.post("states.jsp", {queryString: ""+inputString+""}, function(data){
if(data.length >0) {
$('#suggestions').show();
$('#autoSuggestionsList').html(data);
}
});
}
}
function fill(thisValue) {
$('#inputString').val(thisValue);
setTimeout("$('#suggestions').hide();", 200);
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}
.suggestionsBox {
position: relative;
left: 260px;
margin: 0px 0px 0px 0px;
width: 200px;
background-color: #7845DD;
-moz-border-radius: 7px;
-webkit-border-radius: 7px;
border: 2px solid #000;
color: #fff;
}
.suggestionList {
margin: 0px;
padding: 0px;
}
.suggestionList li {


margin: 0px 0px 3px 0px;
padding: 3px;
cursor: pointer;
}
.suggestionList li:hover {
background-color: #DD45CD;
}
</style>
</head>
<body>
<div>
<form>
<div> <h3><font color="red">Indian States</states></font></h3> <br /> Enter India State Name to see autocomplete
<input type="text" size="30" value="" id="inputString" onkeyup="lookup(this.value);" onblur="fill();" />
</div>
<div class="suggestionsBox" id="suggestions" style="display: none;">
<div class="suggestionList" id="autoSuggestionsList">
</div>
</div>
</form>
</div>
</body>
</html>
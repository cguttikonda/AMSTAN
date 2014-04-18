<%
String listPrice 	= request.getParameter("listPrice");
String stdMulti 	= request.getParameter("stdMulti");
String res = (String)Integer.parseInt(listPrice) * Integer.parseInt(listPrice);

response.getWriter().println(res);

%>
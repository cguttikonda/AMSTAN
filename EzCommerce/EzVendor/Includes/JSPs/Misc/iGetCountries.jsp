<%@ page import="java.util.*" %>
<%

ResourceBundle rb=null;
Vector keys=new Vector();
Vector values=new Vector();

rb= ResourceBundle.getBundle("COUNTRIES");

Enumeration en=rb.getKeys();


while(en.hasMoreElements())
{
	String tempkey=em.nextelement();
	keys.addElement(tempkey);
	values.addElement(en.getString(tempkey));
}

%>
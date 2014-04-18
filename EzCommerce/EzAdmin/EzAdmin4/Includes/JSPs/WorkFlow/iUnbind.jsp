<%@ page import = "javax.naming.*" %>
<%@ page import = "java.util.*" %>

<%

try
{
	ResourceBundle rb = ResourceBundle.getBundle("EJBServers");
	Hashtable env = new Hashtable();
	env.put(Context.INITIAL_CONTEXT_FACTORY,rb.getString("Factory"));
	env.put(Context.PROVIDER_URL,rb.getString("URL"));
	if(!rb.getString("User").trim().equals(""))
	{
		env.put(Context.SECURITY_PRINCIPAL,rb.getString("User"));
		env.put(Context.SECURITY_CREDENTIALS,rb.getString("Password"));
	}

	InitialContext ctx = new InitialContext(env);

	ezc.ezparam.EzcParams unbParams=new ezc.ezparam.EzcParams(false);
	Session.prepareParams(unbParams);
	javax.ejb.Handle myHandle=(javax.ejb.Handle)unbParams.getEjbHandle();
	ezc.ezcsm.EzUser myUser= (ezc.ezcsm.EzUser)myHandle.getEJBObject();
	String conGroup=myUser.getConnGroup();

	try
	{
		ctx.unbind("EZCWFORGANOGRAMS"+conGroup);
	} catch(Exception e1)
	{

	}
	try
	{
		ctx.unbind("EZCWFSTEPS"+conGroup);
	} catch(Exception e2)
	{
		
	}
}
catch(Exception e)
{
	System.out.println(e);
}

%>
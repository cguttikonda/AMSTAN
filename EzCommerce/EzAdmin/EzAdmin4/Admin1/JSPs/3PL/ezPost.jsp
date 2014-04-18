<%@ page import="javax.jms.*,javax.naming.*,ezc.ezsynch.*" %>


<%
	try
	{

		String CTX_FACT = "org.jnp.interfaces.NamingContextFactory";
		String PROV_URL = "jnp://192.168.1.3:1099";
		String TCF_NAME = "RMIConnectionFactory";
		String TOPIC_NAME = "topic/downloadTopic";

		java.util.Properties prop = new java.util.Properties();
		prop.put(Context.INITIAL_CONTEXT_FACTORY,CTX_FACT);
		prop.put(Context.PROVIDER_URL,PROV_URL);
		prop.put(Context.SECURITY_PRINCIPAL,"guest");
		Context ctx = new InitialContext(prop);
		TopicConnectionFactory tcf = (TopicConnectionFactory)ctx.lookup(TCF_NAME);

		TopicConnection tConn = tcf.createTopicConnection();

		TopicSession tSession = tConn.createTopicSession(false,javax.jms.Session.AUTO_ACKNOWLEDGE);
		Topic topic = (Topic)ctx.lookup(TOPIC_NAME);

		TopicPublisher tPublisher = tSession.createPublisher(topic);


		ReturnObjFromRetrieve synchRet = new ReturnObjFromRetrieve(new String[]{"ADD_CUST","ADD_ADDR","ADD_SFA","UPDATE_ADDR","UPDATE_SFA"});

		EzcSynchBlockParams sybp=new EzcSynchBlockParams();
		sybp.setMessageId(String.valueOf(System.currentTimeMillis()));
		sybp.setMessageStatus("B");
		sybp.setMessageType("CUSTSYNCH-ADD");
		
		synchRet.setFieldValue("ADD_CUST",custTable);
		synchRet.setFieldValue("ADD_ADDR",addrTable);
		synchRet.setFieldValue("ADD_SFA",sfaTable);
		synchRet.setFieldValue("UPDATE_ADDR",addrTableUpdate);
		synchRet.setFieldValue("UPDATE_SFA",sfaTableUpdate);
		synchRet.addRow();
		
		sybp.setContainer(synchRet);

		javax.jms.ObjectMessage msg = tSession.createObjectMessage();
		msg.setObject(sybp);

		tPublisher.publish(msg);

		tSession.close();
		tConn.close();
		out.println("Published successfully");
	}
	catch(Exception e)
	{
		out.println("Exception-======");
		out.println(e);
	}


%>

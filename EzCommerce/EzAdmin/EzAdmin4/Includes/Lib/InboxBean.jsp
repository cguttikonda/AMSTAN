<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.forums.params.*" %>
<%@ page import="ezc.messaging.params.*" %>
<%@ page import="ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session" />
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session" />
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session" />


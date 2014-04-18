<%
	String flag=request.getParameter("flag");
	out.println("flag::::::::"+flag);

	try
	{
		ResourceBundle rb=ResourceBundle.getBundle("Site");
		String path=rb.getString("INBOXPATH");
		File dirFile=new File(path+session.getId());
		java.io.File[] files=dirFile.listFiles();


		String[] toBeDelFiles=request.getParameterValues("toBeDelFiles");
		String[] attachedList=request.getParameterValues("allAttachedList");

		java.util.Vector attVect=new java.util.Vector();
		java.util.Vector delVect=new java.util.Vector();
		for(int i=0;i<attachedList.length;i++)
			attVect.add(attachedList[i]);

		for(int i=0;i<toBeDelFiles.length;i++)
		{
			attVect.remove(toBeDelFiles[i]);
			delVect.add(toBeDelFiles[i]);
		}

		for(int i=0;i<files.length;i++)
		{
			if(delVect.contains(files[i].getName()))
				files[i].delete();
		}

		String attachedFiles="";

		if(attVect.size() > 0)
			attachedFiles = (String)attVect.elementAt(0);
		for(int i=1;i<attVect.size();i++)
		{
			attachedFiles = attachedFiles+"$$"+(String)attVect.elementAt(i);
		}
		if(!"".equals(attachedFiles))
			session.putValue("ATTACHEDFILES",attachedFiles);
		else
			session.removeValue("ATTACHEDFILES");

		if(flag!=null && !"null".equals(flag) && !"N".equals(flag))
			response.sendRedirect("ezAttachFile.jsp?attacheddFiles="+attachedFiles);
		else
			response.sendRedirect("ezAttachFile.jsp");
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
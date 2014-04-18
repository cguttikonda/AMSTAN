<%@ page import="java.io.UnsupportedEncodingException"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%!
	public String convertedToHex(byte[] data) 
	{
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < data.length; i++) 
		{
			int halfOfByte = (data[i] >>> 4) & 0x0F;
			int twoHalfBytes = 0;

			do
			{
				if ((0 <= halfOfByte) && (halfOfByte <= 9))
				{
					buf.append( (char) ('0' + halfOfByte) );
				}
				else
				{
					buf.append( (char) ('a' + (halfOfByte - 10)) );
				}

				halfOfByte = data[i] & 0x0F;
			}
			while(twoHalfBytes++ < 1);
		}
		return buf.toString();
	}

	public String MD5(String text)
	{
		byte[] md5 = new byte[64];

		try
		{
			MessageDigest md;
			md = MessageDigest.getInstance("MD5");
			md.update(text.getBytes("iso-8859-1"), 0, text.length());
			md5 = md.digest();
		}
		catch(Exception e){}

		return convertedToHex(md5);
	}
%>
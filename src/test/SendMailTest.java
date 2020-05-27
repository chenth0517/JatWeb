package test;

import static org.junit.Assert.*;

import org.junit.Test;

import java.security.GeneralSecurityException;
import java.security.Security;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.sun.mail.util.MailSSLSocketFactory;

public class SendMailTest {

	@Test
	public void test() {
		{
	        try {
	        	Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
	            final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
	            // Get a Properties object
	            Properties props = System.getProperties();
	            MailSSLSocketFactory sf = new MailSSLSocketFactory();  
	            sf.setTrustAllHosts(true);  
	            // or  
	            // sf.setTrustedHosts(new String[] { "my-server" });  
	            props.put("mail.smtp.ssl.enable", "true");  
	            // also use following for additional safety  
	            //props.put("mail.smtp.ssl.checkserveridentity", "true");  
	            props.put("mail.smtp.ssl.socketFactory", sf);  
	            props.setProperty("mail.smtp.host", "smtp.126.com");
	            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
	            props.setProperty("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.transport.protocol", "smtp");   
	            props.setProperty("mail.smtp.port", "465");
	            props.setProperty("mail.smtp.socketFactory.port", "465");
	            props.put("mail.smtp.auth", "true");
	            final String username = "fm0517@126.com";
	            final String password = "CTh860517wy";
	            Session session = Session.getDefaultInstance(props,
	                    new Authenticator() {
	                        protected PasswordAuthentication getPasswordAuthentication() {
	                            return new PasswordAuthentication(username, password);
	                        }
	                    });
	            Message msg = new MimeMessage(session);
	            msg.setFrom(new InternetAddress(username));
	            msg.setRecipients(Message.RecipientType.TO,
	                    InternetAddress.parse("chenth0517@126.com", false));
	            msg.setSubject("Hello");
	            msg.setText("How are you");
	            msg.setSentDate(new Date());
	            Transport.send(msg);
	            System.out.println("Message sent.");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

}

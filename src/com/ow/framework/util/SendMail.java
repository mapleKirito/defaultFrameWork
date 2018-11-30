package com.ow.framework.util;

import java.security.Security;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;

public class SendMail {
	public Logger log = Logger.getLogger(SendMail.class);
	/**
	 * 发送邮件
	 * 
	 * @param to 目标邮箱
	 * @param subject 主题
	 * @param body 内容
	 */
	public void send(String to, String subject, String body){
		try {
			// 支持SSL方式登录SMTP
			Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
			final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

			String smtp = Constant.sendMailSmtp;
			String user = Constant.sendMailAccount;
			String pwd = Constant.sendMailPwd;
			String from = Constant.mailAuthor;
			String sendMailSender = Constant.sendMailSender;
			sendMailSender=MimeUtility.encodeText(sendMailSender,"UTF-8","b");
			from = "\"" + sendMailSender + "\" <" + from + ">";
			Properties props = new Properties();
			Session sendMailSession;
			Transport transport;
			props.put("mail.smtp.host", smtp);
			props.put("mail.smtp.auth", "true");

			// 如果系统配置为SSL方式链接SMTP服务器
			if ("1".equals(Constant.sendMail_ssl_flag)) {
				props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
				props.setProperty("mail.smtp.socketFactory.fallback", "false");
				props.setProperty("mail.smtp.port", Constant.sendMailSmtpPort);
				props.setProperty("mail.smtp.socketFactory.port", Constant.sendMailSmtpPort);
				props.setProperty("mail.smtp.quitwait", "false");
			}

			SmtpAuthenticator sa = new SmtpAuthenticator(user, pwd);
			sendMailSession = Session.getInstance(props, sa);

			Message newMessage = new MimeMessage(sendMailSession);
			newMessage.setFrom(new InternetAddress(from));
			newMessage.setReplyTo(new InternetAddress[] { new InternetAddress(
					Constant.sendMailReplyMail) });
			newMessage.setRecipient(Message.RecipientType.TO,
					new InternetAddress(to));
			
			newMessage.setSubject(MimeUtility.encodeText(subject,"UTF-8","b"));
			newMessage.setSentDate(new Date());
			newMessage.setContent(body, "text/html;charset=UTF-8");

			transport = sendMailSession.getTransport("smtp");
			transport.send(newMessage);
			String separator = " & ";
			log.info("收件人:"+to+separator+"主题:"+subject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
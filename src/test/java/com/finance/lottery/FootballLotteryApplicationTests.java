package com.finance.lottery;

import com.finance.lottery.util.HttpUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.test.context.junit4.SpringRunner;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = FootballLotteryApplication.class)
public class FootballLotteryApplicationTests {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String username;

    @Test
    public void testSendHtmlMessage() throws MessagingException, UnsupportedEncodingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        mimeMessage.setFrom(username);
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress("xuzhiqing2014@outlook.com"));
        mimeMessage.setSubject("邮件测试");
        Multipart multipart = new MimeMultipart();
        BodyPart bodyPart = new MimeBodyPart();
        StringBuffer url = new StringBuffer();
        url.append("http://locahost:8080");
        url.append("noa");
        url.append("/reportFindPassword/updatePassword.action?");
        url.append("employeeCode=123456");
        url.append("&employeeName=" + URLEncoder.encode("发送邮件测试", "UTF-8"));
        url.append("&pemployeeCode=123456");
        url.append("&pemployeeName=" + URLEncoder.encode("哈哈", "UTF-8"));
        url.append("&email=*******@***.com");
        url.append("&dateTime=20160418162538");
        StringBuffer content = new StringBuffer();
        content.append("<div><div style='margin-left:4%;'>");
        content.append("<p style='color:red;'>");
        content.append("啊啊啊(123456)您好：</p>");
        content.append("<p style='text-indent: 2em;'>您正在使用密码找回功能，请点击下面的链接完成密码找回。</p>");
        content.append("<p style='text-indent: 2em;display: block;word-break: break-all;'>");
        content.append("链接地址：<a style='text-decoration: none;' href='" + url.toString() + "'>" + url.toString() + "</a></p>");
        content.append("</div>");
        content.append("<ul style='color: rgb(169, 169, 189);font-size: 18px;'>");
        content.append("<li>为了保障您帐号的安全，该链接有效期为12小时。</li>");
        content.append("<li>该链接只能使用一次，请周知。</li>");
        content.append("<li>如果该链接无法点击，请直接复制以上网址到浏览器地址栏中访问。</li>");
        content.append("<li>请您妥善保管，此邮件无需回复。</li>");
        content.append("</ul>");
        content.append("</div>");
        bodyPart.setContent(content.toString(), "text/html; charset=utf-8");
        multipart.addBodyPart(bodyPart);
        mimeMessage.setContent(multipart);
        mailSender.send(mimeMessage);
    }

    //    @Test
    public void testSendSimpleMessage() {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(username);
        message.setTo("xuzhiqing2014@outlook.com");
        message.setSubject("邮件测试");
        message.setText("<a href=\"www.baidu.com\">重置密码</a>");
        mailSender.send(message);
    }

    @Test
    public void contextLoads() {
    }

    @Test
    public void httpPost(){
        String url = "localhost:5555/user/login";
        Map<String,String> paramsMap = new HashMap<>();
        paramsMap.put("username","xuzhiqing");
        paramsMap.put("password","xuzhiqing1");
        String responseText = HttpUtil.post(url,paramsMap);
        System.out.println(responseText);
    }

}

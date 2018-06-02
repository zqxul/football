package com.finance.lottery.service;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.mapper.UserMapper;
import com.finance.lottery.result.ResponseEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/24 17:42
 * @Description:
 */
@Service
public class UserService {

    @Value("${user.resetpass.email.htmlTemplate}")
    private String emailHtmlTemplate;

    @Value("${user.resetpass.email.subject}")
    private String emailSubject;

    @Value("${server.ip}")
    private String ip;

    @Value("${server.port}")
    private String port;

    @Value("${football.redis.resetpass.prefix}")
    private String resetpass_prefix;

    @Value("${football.redis.resetpass.timeout.hour}")
    private long resetpass_timeout;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate<Object, Object> redisTemplate;

    @Value("${spring.mail.username}")
    private String username;

    @Autowired
    private UserMapper userMapper;

    public boolean userExist(String username) {
        User user = userMapper.selectByUsername(username);
        if (user != null) {
            return true;
        }
        return false;
    }

    public User getUser(User user) {
        return userMapper.selectOne(user);
    }

    public User loginUser(String username, String password) {
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        User user = new User(username, password);
        return userMapper.selectOne(user);
    }

    public int getUserCont() {
        return userMapper.selectCount();
    }

    public boolean registerUser(User user) {
        return userMapper.insert(user) > 0;
    }

    public boolean resetPassword(String token, String password) {
        User u = JSONObject.parseObject(stringRedisTemplate.opsForValue().get(resetpass_prefix + token), User.class);
        User user = new User();
        user.setId(u.getId());
        user.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        int rows = userMapper.updateSelective(user);
        if (rows < 1) {
            return false;
        }
        stringRedisTemplate.delete(resetpass_prefix + token);
        return true;
    }

    public boolean sendEmail(User user) throws MessagingException {
        String token = UUID.randomUUID().toString();
        StringBuilder url = new StringBuilder("http://");
        url.append(ip + ":" + port);
        url.append("/user/reset/check/token");
        url.append("?token=" + token);
        String emailContent = String.format(emailHtmlTemplate, user.getUsername(), url.toString());
        sendHtmlEmail(emailContent, user.getEmail());
        stringRedisTemplate.opsForValue().set(resetpass_prefix + token, JSON.toJSONString(user), resetpass_timeout, TimeUnit.HOURS);
        return true;
    }

    public void sendSimpleEmail(String text, String sendTo) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(username);
        message.setTo(sendTo);
        message.setSubject(emailSubject);
        message.setText("<a href=\"www.baidu.com\">重置密码</a>");
        mailSender.send(message);
    }

    public void sendHtmlEmail(String html, String sendTo) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        mimeMessage.setFrom(username);
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(sendTo));
        mimeMessage.setSubject(emailSubject);
        Multipart multipart = new MimeMultipart();
        BodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(html, "text/html; charset=utf-8");
        multipart.addBodyPart(bodyPart);
        mimeMessage.setContent(multipart);
        mailSender.send(mimeMessage);
    }
}

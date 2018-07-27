package com.finance.lottery.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.finance.lottery.entity.Recharge;
import com.finance.lottery.entity.Withdraw;
import com.finance.lottery.entity.user.Account;
import com.finance.lottery.entity.user.User;
import com.finance.lottery.entity.user.UserAccount;
import com.finance.lottery.mapper.AccountMapper;
import com.finance.lottery.mapper.RechargeMapper;
import com.finance.lottery.mapper.UserMapper;
import com.finance.lottery.mapper.WithdrawMapper;
import com.finance.lottery.util.WebUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @Author: xuzhiqing
 * @Date: 2018/5/24 17:42
 * @Description: 用户Service
 */
@Service
public class UserService {

    @Value("${football.redis.user.resetpass.email.htmlTemplate}")
    private String emailHtmlTemplate;

    @Value("${football.redis.user.resetpass.email.subject}")
    private String emailSubject;

    @Value("${server.ip}")
    private String ip;

    @Value("${server.port}")
    private String port;

    @Value("${football.redis.user.resetpass.prefix}")
    private String resetpass_prefix;

    @Value("${football.redis.user.resetpass.timeout.hour}")
    private long resetpass_timeout;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Value("${spring.mail.username}")
    private String username;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AccountService accountService;

    @Autowired
    private UserAccountService userAccountService;

    @Autowired
    private RechargeMapper rechargeMapper;

    @Autowired
    private WithdrawMapper withdrawMapper;

    /**
     * MethodName: userExist
     * Description: 判断用户是否存在
     *
     * @param username 用户名
     * @Return boolean
     */
    public boolean userExist(String username) {
        User user = userMapper.selectByUsername(username);
        if (user != null) {
            return true;
        }
        return false;
    }

    /**
     * MethodName: getUser
     * Description: 查询用户信息
     *
     * @param user 用户
     * @Return com.finance.lottery.entity.user.User
     */
    public User getUser(User user) {
        return userMapper.selectOne(user);
    }

    /**
     * MethodName: loginUser
     * Description: 登录用户
     *
     * @param username 用户名
     * @param password 密码
     * @Return com.finance.lottery.entity.user.User
     */
    public User loginUser(String username, String password) {
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        User user = new User(username, password);
        return userMapper.selectOne(user);
    }

    /**
     * MethodName: getUserCount
     * Description: 查询用户数量
     *
     * @Return int
     */
    public int getUserCount() {
        return userMapper.selectCount();
    }

    /**
     * MethodName: registerUser
     * Description: 注册用户(事务操作：1、生成用户, 2、生成账户, 3、关联用户和账户)
     *
     * @param user 用户
     * @Return boolean
     */
    @Transactional
    public boolean registerUser(User user) {
        int result = userMapper.insert(user);
        if (result > 0) {
            Account account = accountService.createAccount();
            if (account != null) {
                UserAccount userAccount = userAccountService.bindUserAccount(user.getId(), account.getId());
                if (userAccount != null) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * MethodName: resetPassword
     * Description: 重置密码
     *
     * @param token
     * @param password
     * @Return boolean
     */
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

    /**
     * MethodName: sendEmail
     * Description: 给用户发送邮件
     *
     * @param user 用户
     * @Return boolean
     */
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

    /**
     * MethodName: sendSimpleEmail
     * Description: 发送普通邮件
     *
     * @param text   邮件内容
     * @param sendTo 收件人
     * @Return void
     */
    public void sendSimpleEmail(String text, String sendTo) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(username);
        message.setTo(sendTo);
        message.setSubject(emailSubject);
        message.setText("<a href=\"www.baidu.com\">重置密码</a>");
        mailSender.send(message);
    }

    /**
     * MethodName: sendHtmlEmail
     * Description: 发送网页邮件
     *
     * @param html   网页内容
     * @param sendTo 收件人
     * @Return void
     */
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

    /**
     * MethodName: recharge
     * Description: 账户充值
     *
     * @param userId         用户ID
     * @param rechargeAmount 充值数量
     * @Return boolean
     */
    public boolean recharge(Integer userId, Integer rechargeAmount) {
        User user = userMapper.selectByPrimaryKey(userId);
        if (user != null) {
            Recharge recharge = Recharge.builder().userId(userId).amount(rechargeAmount).createBy(user.getUsername()).createTime(Calendar.getInstance().getTime()).status(0).isActive(1).build();
            int result = rechargeMapper.insert(recharge);
            if (result > 0) {
                return true;
            }
        }
        return false;
    }

    /**
     * MethodName: withdraw
     * Description: 账户提现
     *
     * @param userId         用户ID
     * @param withdrawAmount 提现数量
     * @Return boolean
     */
    public boolean withdraw(Integer userId, Integer withdrawAmount) {
        User user = userMapper.selectByPrimaryKey(userId);
        if (user != null) {
            Withdraw withdraw = Withdraw.builder().userId(userId).amount(withdrawAmount).createBy(user.getUsername()).createTime(Calendar.getInstance().getTime()).status(0).isActive(1).build();
            int result = withdrawMapper.insert(withdraw);
            if (result > 0) {
                return true;
            }
        }
        return false;
    }

    /**
     * MethodName: getUser
     * Description: 从请求中获取用户
     *
     * @param request 请求对象
     * @Return com.finance.lottery.entity.user.User
     */
    public User getUser(HttpServletRequest request) {
        String token = WebUtil.getCookieValue(request, "token");
        if (StringUtils.isNotBlank(token)) {
            Object obj = redisTemplate.opsForValue().get(token);
            if (obj != null) {
                return (User) obj;
            }
        }
        return null;
    }

    /**
     * MethodName: fullInfo
     * Description: 完善用户信息
     *
     * @param user 用户
     * @Return boolean
     */
    public boolean fillInfo(User user) {
        return userMapper.update(user) > 0;
    }

}

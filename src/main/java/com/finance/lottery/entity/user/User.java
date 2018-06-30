package com.finance.lottery.entity.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/24 19:01
 * @Description:
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User{
    private Integer id;
    private String username;
    private String password;
    private Integer role;
    private Integer level;
    private String mobile;
    private String email;
    private String realName;
    private Date createTime;

    public User(Integer userId,String email){
        this.id = userId;
        this.email = email;
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }
}

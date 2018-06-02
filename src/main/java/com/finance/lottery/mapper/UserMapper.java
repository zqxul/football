package com.finance.lottery.mapper;

import com.finance.lottery.entity.user.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @Auther: xuzhiqing
 * @Date: 2018/5/25 22:14
 * @Description:
 */
@Mapper
public interface UserMapper {

    public User selectByUsername(String username);

    public int insert(User User);

    public int update(User User);

    public int updateSelective(User user);

    public User selectByPrimaryKey(Integer id);

    public List<User> select(User user);

    public int selectCount();

    public User selectOne(User user);

    public List<User> getUserList();

}

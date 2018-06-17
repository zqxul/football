package com.finance.lottery.mapper;

import java.util.List;

/**
 * @Author: xuzhiqing
 * @Description:
 * @Date: 2018/6/5 16:44
 */
public interface BaseMapper<T> {

    int insert(T t);

    int update(T t);

    int updateSelective(T t);

    List<T> select(T t);

    List<T> selectAll();

    T selectOne(T t);

    T selectByPrimaryKey(Long id);

    T selectByPrimaryKey(Integer id);

    int selectCount();

    int delete(List<Integer> id);

}

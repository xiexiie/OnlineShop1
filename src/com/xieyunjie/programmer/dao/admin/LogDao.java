package com.xieyunjie.programmer.dao.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xieyunjie.programmer.entity.admin.Log;

/**
 * 系统日志类Dao
 * @author 17877
 *
 */
@Repository
public interface LogDao {

	public int add(Log log);
	public List<Log> findList(Map<String,Object> queryMap);
	public int getTotal(Map<String,Object> queryMap);
	public int delete(String ids);
}

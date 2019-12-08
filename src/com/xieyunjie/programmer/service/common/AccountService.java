package com.xieyunjie.programmer.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.xieyunjie.programmer.entity.common.Account;

/**
 * 客户接口
 * @author 17877
 *
 */
@Service
public interface AccountService {
	
	/**
	 * 添加客户
	 * @param account
	 * @return
	 */
	public int add(Account account);
	
	/**
	 * 编辑客户
	 * @param account
	 * @return
	 */
	public int edit(Account account);
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 多条件搜索词查询客户
	 * @param queMap
	 * @return
	 */
	public List<Account> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询客户
	 * @param id
	 * @return
	 */
	public Account findById(Long id);
	
	/**
	 * 根据用户名查找客户
	 * @param name
	 * @return
	 */
	public Account findByName(String name);
}

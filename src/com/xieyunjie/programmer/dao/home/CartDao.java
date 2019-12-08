package com.xieyunjie.programmer.dao.home;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xieyunjie.programmer.entity.home.Cart;

/**
 * 购物车dao层
 * @author Administrator
 *
 */
@Repository
public interface CartDao {
	/**
	 * 添加购物车
	 * @param cart
	 * @return
	 */
	public int add(Cart cart);
	
	/**
	 * 编辑购物车
	 * @param cart
	 * @return
	 */
	public int edit(Cart cart);
	
	/**
	 * 删除购物车
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 根据用户id删除
	 * @param userId
	 * @return
	 */
	public int deleteByUid(Long userId);
	
	/**
	 * 多条件搜索词查询购物车
	 * @param queMap
	 * @return
	 */
	public List<Cart> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询购物车
	 * @param id
	 * @return
	 */
	public Cart findById(Long id);
	
	
	/**
	 * 根据ids查询购物车
	 * @param id
	 * @return
	 */
	public Cart findByIds(Map<String, Long> queryMap);
}

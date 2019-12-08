package com.xieyunjie.programmer.dao.home;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xieyunjie.programmer.entity.home.Favorite;

/**
 * 收藏dao层
 * @author Administrator
 *
 */
@Repository
public interface FavoriteDao {
	/**
	 * 添加收藏
	 * @param favorite
	 * @return
	 */
	public int add(Favorite favorite);
	
	
	/**
	 * 删除收藏
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 多条件搜索词查询收藏
	 * @param queMap
	 * @return
	 */
	public List<Favorite> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询收藏
	 * @param id
	 * @return
	 */
	public Favorite findById(Long id);
	
	/**
	 * 根据ids查询收藏
	 * @param id
	 * @return
	 */
	public Favorite findByIds(Map<String, Long> queryMap);
}

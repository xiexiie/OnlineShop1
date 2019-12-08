package com.xieyunjie.programmer.dao.common;
/**
 * 商品dao层信息
 * @author 17877
 *
 */

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xieyunjie.programmer.entity.common.Product;

@Repository
public interface ProductDao {
	/**
	 * 添加商品
	 * @param productCategory
	 * @return
	 */
	public int add(Product product);
	
	/**
	 * 编辑商品
	 * @param productCategory
	 * @return
	 */
	public int edit(Product product);
	
	/**
	 * 删除商品
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 多条件搜索词查询商品
	 * @param queMap
	 * @return
	 */
	public List<Product> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Product findById(Long id);
	
	/**
	 * 更新统计信息
	 * @param product
	 * @return
	 */
	public int updateNum(Product product);
}

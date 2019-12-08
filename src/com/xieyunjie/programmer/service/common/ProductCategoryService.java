package com.xieyunjie.programmer.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.xieyunjie.programmer.entity.common.ProductCategory;

/**
 * 商品分类接口
 * @author 17877
 *
 */
@Service
public interface ProductCategoryService {
	/**
	 * 添加商品分类
	 * @param productCategory
	 * @return
	 */
	public int add(ProductCategory productCategory);
	
	/**
	 * 编辑商品分类
	 * @param productCategory
	 * @return
	 */
	public int edit(ProductCategory productCategory);
	
	/**
	 * 删除商品分类
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 多条件搜索词查询商品分类
	 * @param queMap
	 * @return
	 */
	public List<ProductCategory> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询商品分类
	 * @param id
	 * @return
	 */
	public ProductCategory findById(Long id);
}

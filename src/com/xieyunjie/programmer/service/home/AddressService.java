package com.xieyunjie.programmer.service.home;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.xieyunjie.programmer.entity.home.Address;

/**
 * 收货地址接口
 * @author Administrator
 *
 */
@Service
public interface AddressService {
	
	/**
	 * 添加收货地址
	 * @param address
	 * @return
	 */
	public int add(Address address);
	
	/**
	 * 编辑收货地址
	 * @param address
	 * @return
	 */
	public int edit(Address address);
	
	/**
	 * 删除收货地址
	 * @param id
	 * @return
	 */
	public int delete(Long id);
	
	/**
	 * 多条件搜索词查询收货地址
	 * @param queMap
	 * @return
	 */
	public List<Address> findList(Map<String, Object> queryMap);
	
	/**
	 * 获取符合条件的总记录数
	 * @param queryMap
	 * @return
	 */
	public Integer getTotal(Map<String, Object> queryMap);
	
	/**
	 * 根据id查询收货地址
	 * @param id
	 * @return
	 */
	public Address findById(Long id);
	
}

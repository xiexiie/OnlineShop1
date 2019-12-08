package com.xieyunjie.programmer.service.common.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xieyunjie.programmer.dao.common.OrderDao;
import com.xieyunjie.programmer.entity.common.Order;
import com.xieyunjie.programmer.entity.common.OrderItem;
import com.xieyunjie.programmer.service.common.OrderService;
/**
 * 订单接口实现类
 * @author 17877
 *
 */
@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Override
	public int add(Order order) {
		// TODO Auto-generated method stub
		if(orderDao.add(order) <= 0)return 0;
		for(OrderItem orderItem:order.getOrderItems()){
			orderItem.setOrderId(order.getId());
			orderDao.addItem(orderItem);
		}
		return 1;
	}

	@Override
	public int edit(Order order) {
		// TODO Auto-generated method stub
		return orderDao.edit(order);
	}

	@Override
	public int delete(Long id) {
		// TODO Auto-generated method stub
		return orderDao.delete(id);
	}

	@Override
	public List<Order> findList(Map<String, Object> queMap) {
		// TODO Auto-generated method stub
		return orderDao.findList(queMap);
	}

	@Override
	public Integer getTotal(Map<String, Object> queryMap) {
		// TODO Auto-generated method stub
		return orderDao.getTotal(queryMap);
	}

	@Override
	public Order findById(Long id) {
		// TODO Auto-generated method stub
		return orderDao.findById(id);
	}

	@Override
	public List<OrderItem> findOrderItemList(Long orderId) {
		// TODO Auto-generated method stub
		return orderDao.findOrderItemList(orderId);
	}

	@Override
	public List<Map<String,String>> getStats(Map<String, Object> queryMap) {
		// TODO Auto-generated method stub
		return orderDao.getStats(queryMap);
	}

}

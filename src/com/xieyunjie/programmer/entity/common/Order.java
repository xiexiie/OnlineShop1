package com.xieyunjie.programmer.entity.common;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

/**
 * 订单实体
 * @author Administrator
 *
 */
@Component
public class Order {
	
	public static int ORDER_STATUS_WAITING = 0;//待发货
	
	public static int ORDER_STATUS_SENT = 1;//已发货
	
	public static int ORDER_STATUS_FINISH = 2;//已完成
	
	
	private Long id;//订单分类id
	
	private String sn;//订单编号
	
	private Long userId;//所属用户id
	
	private String address;//收货地址
	
	private Double money;//订单总价
	
	private int productNum;//订单商品数
	
	private int status;//订单状态
	
	private String remark;//订单备注
	
	private Date createTime;//添加时间
	
	private List<OrderItem> orderItems = new ArrayList<OrderItem>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public List<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	
	
	
	
}

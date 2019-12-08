package com.xieyunjie.programmer.entity.common;

import java.util.Date;

import org.springframework.stereotype.Component;

/**
 * 评论实体
 * @author Administrator
 *
 */
@Component
public class Comment {
	
	private Long id;//评论id
	
	private Long productId;//所属商品id
	
	private Product product;
	
	private Long userId;//所属用户id
	
	private Account account;
	
	private int type;//评价类型,0:差评，1：好评，2：中评
	
	private String content;//评论内容
	
	private Date createTime;//评论时间

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
	

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	
	
	
	
}

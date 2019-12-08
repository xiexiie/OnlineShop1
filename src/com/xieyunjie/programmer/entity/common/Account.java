package com.xieyunjie.programmer.entity.common;

import java.util.Date;

import org.springframework.stereotype.Component;

/**
 * 客户实体
 * @author Administrator
 *
 */
@Component
public class Account {
	
	private Long id;//客户id
	
	private String name;//客户名称
	
	private String password;//密码
	
	private String email;//邮箱
	
	private String trueName ;//真实姓名
	
	private int sex;//性别：0：未知，1：男，2：女
	
	private int status;//状态：0：表示冻结、1：表示可用
	
	private Date createTime;//注册时间

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTrueName() {
		return trueName;
	}

	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	
	
	
	
}

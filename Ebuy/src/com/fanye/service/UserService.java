package com.fanye.service;

import java.util.List;

import com.fanye.entity.PageBean;
import com.fanye.entity.User;

public interface UserService {

	public void saveUser(User user);
	
	public boolean existUserWithUserName(String userName);
	
	public User login(User user);
	
	public List<User> findUserList(User s_user,PageBean pageBean);
	
	public Long getUserCount(User s_user);
	
	public void delete(User user);
	
	public User getUserById(int id);
}

package com.fanye.service;

import java.util.List;

import com.fanye.entity.Notice;
import com.fanye.entity.PageBean;

public interface NoticeService {

	public List<Notice> findNoticeList(Notice s_notice,PageBean pageBean);
	
	public Notice getNoticeById(int noticeId);
	
	public Long getNoticeCount(Notice s_notice);
	
	public void saveNotice(Notice notice);
	
	public void delete(Notice notice);
}

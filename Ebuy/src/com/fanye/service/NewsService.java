package com.fanye.service;

import java.util.List;

import com.fanye.entity.News;
import com.fanye.entity.Notice;
import com.fanye.entity.PageBean;

public interface NewsService {

	public List<News> findNewsList(News s_news,PageBean pageBean);
	
	public News getNewsById(int newsId);
	
	public Long getNewsCount(News s_news);
	
	public void saveNews(News news);
	
	public void delete(News news);
}

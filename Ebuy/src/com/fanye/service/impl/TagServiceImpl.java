package com.fanye.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fanye.dao.BaseDAO;
import com.fanye.entity.PageBean;
import com.fanye.entity.Tag;
import com.fanye.service.TagService;
import com.fanye.util.StringUtil;

@Service("tagService")
public class TagServiceImpl implements TagService{

	@Resource
	private BaseDAO<Tag> baseDAO;
	
	@Override
	public List<Tag> findTagList(Tag s_tag,PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Tag");
		if(s_tag!=null){
			if(StringUtil.isNotEmpty(s_tag.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_tag.getName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"),param);
		}else{
			return baseDAO.find(hql.toString());
		}
	}

	@Override
	public Long getTagCount(Tag s_tag) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Tag");
		if(s_tag!=null){
			if(StringUtil.isNotEmpty(s_tag.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_tag.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"),param);
	}

	@Override
	public void saveTag(Tag tag) {
		baseDAO.merge(tag);
	}

	@Override
	public void delete(Tag tag) {
		baseDAO.delete(tag);
	}

	@Override
	public Tag getTagById(int tagId) {
		return baseDAO.get(Tag.class, tagId);
	}

}

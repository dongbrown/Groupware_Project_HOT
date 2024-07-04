package com.project.hot.community.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.community.model.dao.CommunityDao;
import com.project.hot.community.model.dto.Community;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

	private final CommunityDao dao;
    private final SqlSession session;

	@Override
	public List<Community> getCommunities() {
        return dao.getCommunities(session);
    }

	@Override
	public int createCommunity(Community community) {
        return dao.createCommunity(session, community);
    }

}

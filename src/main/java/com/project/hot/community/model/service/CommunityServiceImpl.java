package com.project.hot.community.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.community.model.dao.CommunityDao;
import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

	private final CommunityDao dao;
    private final SqlSession session;

    @Override
    public List<Community> getCommunities(int employeeNo) {

        return dao.getCommunities(session, employeeNo);
    }


	@Override
	public int insertCommunity(Community community, CommunityUser communityUser) {
		return dao.insertCommunity(session, community, communityUser);
	}

	@Override
	public int toggleBookmark(int communityNo, int employeeNo) {
		return dao.toggleBookmark(session, communityNo, employeeNo);
	}

}

package com.project.hot.community.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    //수정해야됨
    @Transactional
	@Override
	public void insertCommunity(Community community, CommunityUser communityUser) {
		dao.insertCommunity(session, community);
    	dao.insertCommunityUser(session, communityUser);
	}

	@Override
	public int toggleBookmark(int communityNo, int employeeNo) {
		return dao.toggleBookmark(session, communityNo, employeeNo);
	}


	@Override
	public Community getCommunityByNo(int communityNo) {
		return dao.getCommunityByNo(session, communityNo);
	}

}

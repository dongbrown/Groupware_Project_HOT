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

    @Transactional
    @Override
    public void insertCommunity(Community community, CommunityUser communityUser) {
        // Community 삽입
        dao.insertCommunity(session, community);

        // 생성된 communityNo를 CommunityUser에 설정
        communityUser.setCommunityNo(community.getCommunityNo());

        // CommunityUser 삽입
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
package com.project.hot.community.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.hot.community.model.dao.CommunityDao;
import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.employee.model.dto.Employee;

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

	@Override
	public int inviteParticipants(int communityNo, List<Map<String, Object>> participants) {
		return dao.inviteParticipants(session, participants, communityNo);
	}

	@Override
	public List<Community> getCommunityList() {
		return dao.getCommunityList(session);
	}

	@Override
	public List<Employee> getNonParticipants(int communityNo) {
		return dao.getNonParticipants(session, communityNo);
	}

    @Transactional
    @Override
    public boolean joinCommunity(CommunityUser communityUser) {
        try {
            int result = dao.joinCommunity(session, communityUser);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void deleteCommunityUser(int communityNo, int employeeNo) {
        try {

            int result = dao.deleteCommunityUser(session, communityNo, employeeNo);
            if (result == 0) {
                throw new Exception("삭제된 레코드가 없습니다.");
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }

    @Override
    public List<Community> getCommunitiesWithEmployeePhotos(int employeeNo) {
        return dao.getCommunitiesWithEmployeePhotos(session, employeeNo);
    }

}
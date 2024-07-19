package com.project.hot.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.employee.model.dto.Employee;

@Repository
public class CommunityDaoImpl implements CommunityDao {
    @Override
    public List<Community> getCommunities(SqlSession session, int employeeNo) {
        return session.selectList("community.getCommunities", employeeNo);
    }

    @Override
    public void insertCommunity(SqlSession session, Community community) {
        session.insert("community.insertCommunity", community);
    }

    @Override
    public void insertCommunityUser(SqlSession session, CommunityUser communityUser) {
        session.insert("community.insertCommunityUser", communityUser);
    }

    @Override
    public int toggleBookmark(SqlSession session, int communityNo, int employeeNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("communityNo", communityNo);
        paramMap.put("employeeNo", employeeNo);
        return session.update("community.toggleBookmark", paramMap);
    }

    @Override
    public Community getCommunityByNo(SqlSession session, int communityNo) {
        return session.selectOne("community.getCommunityByNo", communityNo);
    }

    @Override
    public int inviteParticipants(SqlSession session, List<Map<String, Object>> participants, int communityNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("list", participants);
        paramMap.put("communityNo", communityNo);
        return session.insert("community.inviteParticipants", paramMap);
    }

    @Override
    public List<Community> getCommunityList(SqlSession session) {
        return session.selectList("community.getCommunityList");
    }

    @Override
    public List<Employee> getNonParticipants(SqlSession session, int communityNo) {
        return session.selectList("community.getNonParticipants", communityNo);
    }

	@Override
	public int joinCommunity(SqlSession session, CommunityUser communityUser) {
		return session.insert("community.joinCommunity", communityUser);
	}

	@Override
	public int deleteCommunityUser(SqlSession session, int communityNo, int employeeNo) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("communityNo", communityNo);
	    params.put("employeeNo", employeeNo);
	    return session.delete("community.deleteCommunityUser", params);
	}

	 public List<Community> getCommunitiesWithEmployeePhotos(SqlSession session, int employeeNo) {
	        return session.selectList("community.getCommunitiesWithEmployeePhotos", employeeNo);
	 }

}
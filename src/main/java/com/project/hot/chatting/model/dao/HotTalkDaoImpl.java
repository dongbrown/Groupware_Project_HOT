package com.project.hot.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
@Repository
public class HotTalkDaoImpl implements HotTalkDao {

	@Override
	public List<ResponseEmployeeDTO> getHotTalkMemberList(SqlSession session) {
		return session.selectList("hottalk.getHotTalkMemberList");
	}

	@Override
	public List<ResponseHotTalkListDTO> getPrivateHotTalkList(SqlSession session, int employeeNo) {
		return session.selectList("hottalk.getPrivateHotTalkList", employeeNo);

	}

	@Override
	public List<ResponseHotTalkListDTO> getGroupHotTalkList(SqlSession session, int employeeNo) {
		return session.selectList("hottalk.getGroupHotTalkList", employeeNo);
	}

	@Override
	public List<ResponseHotTalkContentDTO> getHotTalkContents(SqlSession session, int openEmployeeNo,
			int openHotTalkNo) {
		Map<String, Integer> param = new HashMap<>();
		param.put("openEmployeeNo", openEmployeeNo);
		param.put("openHotTalkNo", openHotTalkNo);
		return session.selectList("hottalk.getHotTalkContents", param);
	}

}

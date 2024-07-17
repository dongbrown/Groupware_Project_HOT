package com.project.hot.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.dto.ResponseLoginEmployeeDTO;

public interface HotTalkDao {
	List<ResponseLoginEmployeeDTO> getHotTalkMemberList(SqlSession session, int empNo);
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(SqlSession session, int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(SqlSession session, int employeeNo);
	List<ResponseHotTalkContentDTO> getHotTalkContents(SqlSession session, int openEmployeeNo, int openHotTalkNo);
	int updateHotTalkStatus(SqlSession session, int employeeNo, String status);
	int updateHotTalkStatusMessage(SqlSession session, int employeeNo, String statusMsg);
	int insertMessageSender(SqlSession session, CommonMessageDTO msg);
	int insertMessageReceiver(SqlSession session, CommonMessageDTO msg);
	int insertHotTalkAtt(SqlSession session, HotTalkAtt hotTalkAtt);
}

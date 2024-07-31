package com.project.hot.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.dto.HotTalkContent;
import com.project.hot.chatting.model.dto.HotTalkMember;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.dto.ResponseLoginEmployeeDTO;

public interface HotTalkDao {
	List<ResponseLoginEmployeeDTO> getHotTalkMemberList(SqlSession session, int empNo);
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(SqlSession session, int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(SqlSession session, int employeeNo);
	List<ResponseHotTalkContentDTO> getHotTalkContents(SqlSession session, int openEmployeeNo, int openHotTalkNo);
	int updateHotTalkStatus(SqlSession session, int employeeNo, String status);
	int insertHotTalkStatus(SqlSession session, int employeeNo, String status);
	int updateHotTalkStatusMessage(SqlSession session, int employeeNo, String statusMsg);
	int insertHotTalkStatusMessage(SqlSession session, int employeeNo, String statusMsg);
	int insertMessageSender(SqlSession session, CommonMessageDTO msg);
	int insertMessageReceiver(SqlSession session, CommonMessageDTO msg);
	int insertHotTalkAtt(SqlSession session, HotTalkAtt hotTalkAtt);
	int getHotTalkNo(SqlSession session, Map<String, Integer> param);
	HotTalkMember selectMember(SqlSession session, int employeeNo);
	int insertNewChatRoom(SqlSession session, CommonMessageDTO msg);
	int insertNewChatRoomMember(SqlSession session, CommonMessageDTO msg);
	int insertNewChatRoomContents(SqlSession session, CommonMessageDTO msg);
	int insertNewChatRoomReceiver(SqlSession session, CommonMessageDTO msg);
	int getGroupTalkNo(SqlSession session, CommonMessageDTO msg);
	int updateIsReadByNo(SqlSession session, Map<String, Integer> param);
	List<Integer> getReceivers(SqlSession session, int hotTalkNo);

	// SSE
	List<HotTalkContent> selectMyMessage(SqlSession session, int employeeNo);
}

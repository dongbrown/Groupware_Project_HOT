package com.project.hot.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.dto.HotTalkMember;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.dto.ResponseLoginEmployeeDTO;

public interface HotTalkService {
	List<ResponseLoginEmployeeDTO> getHotTalkMemberList(int empNo);
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(int employeeNo);
	List<ResponseHotTalkContentDTO> getHotTalkContents(int openEmployeeNo, int openHotTalkNo);
	int updateHotTalkStatus(int employeeNo, String status);
	int updateHotTalkStatusMessage(int employeeNo, String statusMsg);
	int insertHotTalkMessage(CommonMessageDTO msg);
	int insertHotTalkAtt(HotTalkAtt hotTalkAtt);
	int getHotTalkNo(Map<String, Integer> param);
	HotTalkMember selectMember(int employeeNo);
	int insertNewChatRoom(CommonMessageDTO msg);
}

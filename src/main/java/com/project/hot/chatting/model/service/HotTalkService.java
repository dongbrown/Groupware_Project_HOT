package com.project.hot.chatting.model.service;

import java.util.List;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;

public interface HotTalkService {
	List<ResponseEmployeeDTO> getHotTalkMemberList(int empNo);
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(int employeeNo);
	List<ResponseHotTalkContentDTO> getHotTalkContents(int openEmployeeNo, int openHotTalkNo);
	int updateHotTalkStatus(int employeeNo, String status);
	int updateHotTalkStatusMessage(int employeeNo, String statusMsg);
}

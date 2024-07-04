package com.project.hot.chatting.model.service;

import java.util.List;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;

public interface HotTalkService {
	List<ResponseEmployeeDTO> getHotTalkMemberList();
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(int employeeNo);
}

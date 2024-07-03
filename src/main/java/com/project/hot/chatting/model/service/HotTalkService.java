package com.project.hot.chatting.model.service;

import java.util.List;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;

public interface HotTalkService {
	List<ResponseEmployeeDTO> getHotTalkMemberList();
}

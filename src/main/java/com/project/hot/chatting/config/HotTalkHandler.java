package com.project.hot.chatting.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.dto.HotTalkMember;
import com.project.hot.chatting.model.dto.HotTalkStatus;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.dto.ResponseLoginEmployeeDTO;
import com.project.hot.chatting.model.service.HotTalkService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@RequiredArgsConstructor
public class HotTalkHandler extends TextWebSocketHandler {
	@Autowired
	private ObjectMapper mapper;

	private final HotTalkService service;

	Map<Integer, WebSocketSession> employees = new HashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	}

	private void enterEmployees(WebSocketSession session, CommonMessageDTO msg) {
		employees.put(msg.getSender(), session);
		List<ResponseLoginEmployeeDTO> list = service.getHotTalkMemberList(msg.getSender());
		list.forEach(l->l.setType("사원"));
		session.getAttributes().remove("grouprooms");
		session.getAttributes().remove("privaterooms");
		responseListDTO(list, session);
	}

	private void privateHotTalkList(WebSocketSession session, CommonMessageDTO msg) {
		List<ResponseHotTalkListDTO> list = service.getPrivateHotTalkList(msg.getSender());
		List<Integer> rooms = new ArrayList<>();
		list.forEach(l->{
			l.setType("갠톡");
			rooms.add(l.getHotTalkNo());
		});
		session.getAttributes().put("privaterooms", rooms);
		session.getAttributes().remove("grouprooms");
		responseListDTO(list, session);
	}

	private void groupHotTalkList(WebSocketSession session, CommonMessageDTO msg) {
		List<ResponseHotTalkListDTO> list = service.getGroupHotTalkList(msg.getSender());
		List<Integer> rooms = new ArrayList<>();
		list.forEach(l->{
			l.setType("단톡");
			rooms.add(l.getHotTalkNo());
		});
		session.getAttributes().put("grouprooms", rooms);
		session.getAttributes().remove("privaterooms");
		responseListDTO(list, session);
	}
	private void getHotTalkContents(WebSocketSession session, CommonMessageDTO msg) {
		List<ResponseHotTalkContentDTO> contents = service.getHotTalkContents(msg.getSender(), msg.getHotTalkNo());
//		if(contents.get(0).getHotTalkIsGroup().equals("N")) {
//			System.out.println("갠톡");
//		} else if(contents.get(0).getHotTalkIsGroup().equals("Y")) {
//			System.out.println("단톡");
//		} else {
//			System.out.println("ㅋㅋ");
//		}
		contents.forEach(c->{
			c.setType("open");
		});
		responseListDTO(contents, session);
	}
	private void updateHotTalkStatus(HotTalkStatus status) {
		int result;
		if(status.getHotTalkStatus() != null) {
			result = service.updateHotTalkStatus(status.getEmployeeNo(), status.getHotTalkStatus());
		} else if(status.getHotTalkStatusMessage() != null){
			result = service.updateHotTalkStatusMessage(status.getEmployeeNo(), status.getHotTalkStatusMessage());
		} else {
			result = 0;
		}
	}

	private void sendMessage(WebSocketSession session, CommonMessageDTO msg) {
	    // System.out.println(msg.getHotTalkNo() + " " + msg.getMsg() + " " + msg.getSender() + " " + msg.getReceiver() + " " + msg.getEventTime());
		if(!(msg.getReceiver().equals("") || msg.getType().equals("file"))) msg.setReceiverNo(Integer.parseInt(msg.getReceiver()));
		System.out.println(msg);
		int result = service.insertHotTalkMessage(msg);

	    for (Map.Entry<Integer, WebSocketSession> entry : employees.entrySet()) {
	        WebSocketSession cEmp = entry.getValue();
	        List<Integer> privateRooms = (List<Integer>)(cEmp.getAttributes().get("privaterooms"));
	        List<Integer> groupRooms = (List<Integer>)(cEmp.getAttributes().get("grouprooms"));
	        try {
	        	if(!msg.getType().equals("file")) msg.setType(result > 0 ? "msgSuccess" : "msgFail");

	            String message = mapper.writeValueAsString(msg);
	            if (privateRooms != null && privateRooms.contains(msg.getHotTalkNo())) {
	                cEmp.sendMessage(new TextMessage(message));
	            } else if (groupRooms != null && groupRooms.contains(msg.getHotTalkNo())) {
	            	cEmp.sendMessage(new TextMessage(message));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}
	public int checkChattingHistory(int sender, int receiver) {
		int result = 0;
		Map<String, Integer> param = new HashMap<>();
		param.put("clickedNo", receiver);
		param.put("loginEmployeeNo", sender);
		result = service.getHotTalkNo(param);
		return result;
	}
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		CommonMessageDTO msg = mapper.readValue(message.getPayload(), CommonMessageDTO.class);
		switch(msg.getType()){
			case "enter" : enterEmployees(session, msg); break;
			case "privateHotTalk" : privateHotTalkList(session, msg); break;
			case "groupHotTalk" : groupHotTalkList(session, msg); break;
			// const msg = new CommonMessage("open", sender, "", hotTalkNo, "").convert();로 전달 → 채팅방 내역 조회
			case "open" : getHotTalkContents(session, msg); break;
			case "change" : HotTalkStatus status = mapper.readValue(message.getPayload(), HotTalkStatus.class);
							updateHotTalkStatus(status);
							break;
			case "msg" : sendMessage(session, msg); break;
			case "file" : HotTalkAtt upFile = mapper.readValue(message.getPayload(), HotTalkAtt.class);
							System.out.println(upFile);
						  CommonMessageDTO fileMsg = CommonMessageDTO.builder().type("file")
								  											   .hotTalkNo(upFile.getHotTalkNo())
								  											   .msg(upFile.getHotTalkOriginalFilename())
								  											   .sender(upFile.getHotTalkAttSender())
								  											   .receiver(upFile.getHotTalkRenamedFilename())
								  											   .build();
						  sendMessage(session, fileMsg);
						  break;
			case "check" : if(!(msg.getReceiver()==null||msg.getReceiver().isEmpty())) {
						   		int receiverNo = Integer.parseInt(msg.getReceiver());
						   		msg.setReceiverNo(receiverNo);
						   }
						   int hotTalkNo = checkChattingHistory(msg.getSender(), msg.getReceiverNo());
						   responseMsg(msg, hotTalkNo, session);
						   // 채팅방 더블클릭한 사람, 더블클릭 당한사람 사번 전달해서 실행한 결과(HOT_TALK_NO) 전달
						   break;
			case "createChat" : createPrivateChatRoom(session, msg);
		}
	}

	public void createPrivateChatRoom(WebSocketSession session, CommonMessageDTO msg) {
		List<String> receivers = Arrays.asList(msg.getReceiver().split(","));
		List<Integer> receiversNo = new ArrayList<>();
		receivers.forEach(e->{
			int receiverNo = Integer.parseInt(e);
			receiversNo.add(receiverNo);
		});
		msg.setReceivers(receiversNo);
		int hotTalkNo = service.insertNewChatRoom(msg);
		CommonMessageDTO result = CommonMessageDTO.builder().type("new")
															.hotTalkNo(hotTalkNo)
															.sender(msg.getSender())
															.receivers(msg.getReceivers())
															.build();
		try {
			String resultMsg = mapper.writeValueAsString(result);
			for(Map.Entry<Integer, WebSocketSession> employee:employees.entrySet()) {
		        int empNo = employee.getKey();
				if(receiversNo.contains(empNo)) {
					WebSocketSession emp = employees.get(empNo);
					System.out.println(resultMsg);
					emp.sendMessage(new TextMessage(resultMsg));
				} else {
					WebSocketSession sender = employees.get(msg.getSender());
					sender.sendMessage(new TextMessage(resultMsg));
				}
	        }
		} catch(Exception e) {
        	log.debug("createPrivateChatRoom() 메소드 실행 에러");
        }
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		int employeeNo = 0;
		for(Map.Entry<Integer, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			if(session.equals(emp)) {
				employeeNo = employee.getKey();
				break;
			}
		}
		employees.remove(employeeNo);
	}

	private void responseListDTO(List list, WebSocketSession session) {
		for(Map.Entry<Integer, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			if(emp.equals(session)) {
				try {
					String message = mapper.writeValueAsString(list);
					emp.sendMessage(new TextMessage(message));
				}catch(Exception e){
					log.debug("responseListDTO() 실패");
				}
			}
		}
	}
	// 사원 더블클릭 시 개인 카톡 중 대화 이력이 있는 방이 있으면 해당 방 정보를 가져오고 아닐 경우 nohistory response
	private void responseMsg(CommonMessageDTO msg, int result, WebSocketSession session) {
		for(Map.Entry<Integer, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			try {
				if(session.equals(emp) && result>0) {
					msg.setHotTalkNo(result);
					getHotTalkContents(session, msg);
				} else if(session.equals(emp)) {
					HotTalkMember target = service.selectMember(msg.getReceiverNo());
					CommonMessageDTO noHistory = new CommonMessageDTO();
					noHistory.setType("nohistory");
					noHistory.setMsg(mapper.writeValueAsString(target));
					String nohistory = mapper.writeValueAsString(noHistory);
					emp.sendMessage(new TextMessage(nohistory));
				}
			}catch(Exception e){
				log.debug("responseMsg() 실패");
			}
		}
	}


}

package com.tastehill.myweb.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tastehill.myweb.comments.CommentsVO;

@Controller
public class ChatController {

	@Autowired
	ChatService svc;
	
    @RequestMapping("/chat/{seqChattingRoom}")
    public String chatRoom( Model model, @PathVariable("seqChattingRoom") int seqChattingRoom) {
    	
	    List<ChatVO> clist = svc.svcSelectChattingList(seqChattingRoom);
	    

	    System.out.println(clist.toString());
    	model.addAttribute("CLIST", clist);

    	model.addAttribute("content", "jsp/chat/chatting.jsp");
    	return "jsp/chat/chatting";
    }
    
    @RequestMapping("/newchat/{seqMember}")
    public String newChatRoom( Model model, @PathVariable("seqMember") int seqMember, HttpSession session) {
    	
    	int sessionSeq = (int)session.getAttribute("SESS_MEMBER_ID");
    	
	    ChattingRoomVO crvo = svc.svcSelectChattingRoom(seqMember, sessionSeq);

	    if(crvo != null) {
	    	
	    } else {
	    	ChattingRoomVO rvo = new ChattingRoomVO(0, sessionSeq, seqMember, null, null, null, null, null, null);
	    	svc.svcInsertChattingRoom(rvo);
	    	crvo = svc.svcSelectChattingRoom(seqMember, sessionSeq);
	    	
	    }
    	return "redirect: /chat/" + crvo.getSeqChattingRoom();
    }
    
    @RequestMapping("/chatroomlist/{seqMember}")
    public String chatRoomList(Model model, HttpSession session, @PathVariable("seqMember") int seqMember) {
    	List<ChattingRoomVO> roomlist = svc.svcSelectChattingRoomList(seqMember);
    	for(ChattingRoomVO rvo : roomlist) {
    		if((int)session.getAttribute("SESS_MEMBER_ID") == rvo.getSenderVO().getSeqMember()) {
    			rvo.setNickname(rvo.getReceiverVO().getNickname());
    			rvo.setProfile(rvo.getReceiverVO().getProfile());
    		} else {
    			rvo.setNickname(rvo.getSenderVO().getNickname());
    			rvo.setProfile(rvo.getSenderVO().getProfile());
    		}
    	}
    	model.addAttribute("RLIST", roomlist);
    	model.addAttribute("content", "jsp/chat/chatting_room.jsp");
    	return "index";
    }
    
    @RequestMapping(value = "/sendchatting", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> sendChatting(@RequestBody ChatVO cvo,
			HttpSession session) {
			// 세션에서 현재 로그인한 사용자 정보 가져오기
			int seqMember = (int) session.getAttribute("SESS_MEMBER_ID");
			int seqChattingRoom = cvo.getSeqChattingRoom();
			System.out.println(cvo.toString());

			if (seqMember == cvo.getSeqMember()) {
				svc.svcInsertChatting(cvo);
			    svc.updateLastChatting(seqChattingRoom, cvo.getContents());
			} else {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		    List<ChatVO> clist = svc.svcSelectChattingList(seqChattingRoom);
		    
			Map<String, Object> response = new HashMap<>();
		    
		    response.put("CLIST", clist);
		    
		    return new ResponseEntity<>(response, HttpStatus.OK);
	}
}
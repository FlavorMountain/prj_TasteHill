package com.tastehill.myweb.fork;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.tastehill.myweb.route.RouteService;

@Controller
public class ForkController {
	
	@Autowired
	ForkService svc;

	@Autowired
	RouteService rsvc;
	
	@GetMapping("/forkroute")
    public ResponseEntity<Map<String, Object>> likeRoute(@RequestParam("seqRoute") int seqRoute, HttpSession session) {
		Map<String, Object> response = new HashMap<>();		
		if(session.getAttribute("SESS_MEMBER_ID") != null) {
			int seqMember = (int)session.getAttribute("SESS_MEMBER_ID");
			
			if(svc.selectFork(seqMember, seqRoute) != null) {
				svc.deleteFork(seqMember, seqRoute);
				response.put("fork", false);
				rsvc.svcDecreaseFork(seqRoute);
			} else {
				svc.insertFork(seqMember, seqRoute);
				response.put("fork", true);
				rsvc.svcIncreaseFork(seqRoute);
				
			}
			
			response.put("message", true);
			
		}
		else {
		    response.put("message", false);
		}
	    return new ResponseEntity<>(response, HttpStatus.OK);
    }
	
	
}
//
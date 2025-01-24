package com.tastehill.myweb.comments;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommentsController {
	
	@RequestMapping(value = "/comments", method = RequestMethod.GET)
	public String Get() {
		return "test";
	}
}
//
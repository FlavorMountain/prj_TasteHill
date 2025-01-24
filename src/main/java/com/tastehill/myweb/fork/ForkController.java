package com.tastehill.myweb.fork;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ForkController {
	
	@RequestMapping(value = "/fork", method = RequestMethod.GET)
	public String Get() {
		return "test";
	}
}
//
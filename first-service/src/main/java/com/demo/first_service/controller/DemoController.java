package com.demo.first_service.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.service.annotation.GetExchange;

@RestController
@RequestMapping("/api")
public class DemoController {

    @GetMapping("/test")
    public String demo(){
        return "First Service";
    }
}

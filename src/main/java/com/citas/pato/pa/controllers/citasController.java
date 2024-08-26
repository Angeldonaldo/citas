package com.citas.pato.pa.controllers;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/citas")
public class citasController {

    @GetMapping("/show/{day}")
    public String muestraCitasByDay(@PathVariable("day") String day) {
        return day;
    }
    

}

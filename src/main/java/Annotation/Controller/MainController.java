package Annotation.Controller;

import Annotation.Dto.DiaryDto;
import Annotation.Entity.DiaryEntity;
import Annotation.Service.DiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    DiaryService diaryService;
    @GetMapping("/Home")
    public String MainHome() {
        return "mainpage";
    }

    @GetMapping("/diary/{Monn}")
    public String diary(@RequestParam("Moon") int moon , DiaryEntity diaryEntity, Model model) {
        List<DiaryEntity> diaryDtos = new ArrayList<DiaryEntity>();
        diaryDtos = diaryService.LoadPage(diaryEntity);


        return "diary";
    }

    @PostMapping("/diary")
    @ResponseBody // json 값 diary이 반환
    public List<DiaryEntity> Update(DiaryDto diaryDto) {
        List<DiaryEntity> diaryList = new ArrayList<DiaryEntity>();
        diaryService.diarySave(diaryDto);

        diaryList = diaryService.diaryPlus(diaryDto);
        return diaryList;
    }
}

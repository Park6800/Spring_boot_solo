package Annotation.Controller;

import Annotation.Dto.AccountDto;
import Annotation.Dto.DiaryDto;
import Annotation.Entity.AccountEntity;
import Annotation.Entity.DiaryEntity;
import Annotation.Service.DiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {

    @Autowired
    DiaryService diaryService;
    @GetMapping("/Home")
    public String MainHome() {
        return "mainpage";
    }

    @GetMapping("/diary")
    public String diary(@RequestParam("Month") int month , DiaryEntity diaryEntity, Model model) {
        List<DiaryEntity> diaryEntities = new ArrayList<DiaryEntity>();
        diaryEntities = diaryService.LoadPage(diaryEntity);
        // 기존에 작성 되있던 다이어리 리스트
        // 월 별 작성 다이어리 리스트로 가져옴
        model.addAttribute("Diary_List", diaryEntities);

        model.addAttribute("Month" , month);
        return "diary";
    }

    // ajax 다이어리 작성
    @PostMapping("/diary")
    @ResponseBody // json 값 diary이 반환
    public List<DiaryEntity> Update(DiaryDto diaryDto) {
        List<DiaryEntity> diaryList = new ArrayList<DiaryEntity>();

        if (diaryDto.getContent() != "" && diaryDto.getTitle() != "") {
            diaryService.diarySave(diaryDto);
        }

        diaryList = diaryService.diaryPlus(diaryDto);
        return diaryList;
    }

    @GetMapping("/diary/detail/{title}")
    public String detail(@PathVariable("title") String title , Model model) {
        List<DiaryEntity> detailDiaryDtos = diaryService.selecct_diary(title);
        model.addAttribute("Detail" , detailDiaryDtos);
        return "detail_diary";
    }

    @PostMapping("/diary/detail")
    public String FixDiary(DiaryDto diaryDto) {
        int Month = diaryDto.getMonth();
        diaryService.Fixdiary(diaryDto);
        // 기존 ' 월 ' 다이어리로 리다이렉트
        return "redirect:/diary?Month=" + Month;
    }

    @PostMapping("/Account_book")
    @ResponseBody // json 값 diary이 반환
    public Map<String, Object> AccountMoney(AccountDto accountDto) {
        List<AccountEntity> accountlist = new ArrayList<AccountEntity>();
        if(accountDto.getMoney() != 0 || accountDto.getWhere_use()!="") {
            diaryService.AccountSave(accountDto);
        }
        accountlist = diaryService.findMoney(accountDto);
        String MostUsed = diaryService.findmostUsed(accountDto);

        Map<String, Integer> MoneyMap = new HashMap<>();
        for (AccountEntity account : accountlist) {
            int Count_Money = diaryService.getCountByMoney(account.getWhere_use(), account.getMonth());
            MoneyMap.put(account.getWhere_use(), Count_Money);
        }

        // 금액 사용처 Key , Value
        Map<String, Integer> countMap = new HashMap<>();
        for (AccountEntity account : accountlist) {
            int count = diaryService.getCountByWhere(account.getWhere_use(), account.getMonth());
            countMap.put(account.getWhere_use(), count);
        }
        // Map < key , value > response에 대입
        Map<String, Object> response = new HashMap<>();
        response.put("accountList", accountlist);
        response.put("countMap", countMap);
        response.put("moneyMap", MoneyMap);
        response.put("MostUse", MostUsed);
        return response;
    }
}

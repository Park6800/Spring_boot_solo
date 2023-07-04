package Annotation.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountDto {
    private int Money_use_Seq;
    private int Year;
    private int Month;
    private int Day;
    private int Money;
    private String Where_use;
}

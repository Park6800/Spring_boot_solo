package Annotation.Entity;


import Annotation.Dto.AccountDto;
import Annotation.Dto.DiaryDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Account")
public class AccountEntity {
    @Id
    @Column(name = "Money_use_Seq")
    private int Money_use_Seq;
    @Column(name = "Year")
    private int year;
    @Column(name = "Month")
    private int Month;
    @Column(name = "Day")
    private int day;
    @Column(name="Money")
    private int money;
    @Column(name="Where_use")
    private String where_use;

    public static AccountEntity toSaveEntity(AccountDto accountDto) {
        AccountEntity accountEntity = new AccountEntity();
        accountEntity.setMoney_use_Seq(accountDto.getMoney_use_Seq());
        accountEntity.setYear(accountDto.getYear());
        accountEntity.setMonth(accountDto.getMonth());
        accountEntity.setDay(accountDto.getDay());
        accountEntity.setMoney(accountDto.getMoney());
        accountEntity.setWhere_use(accountDto.getWhere_use());
        return accountEntity;
    }
}

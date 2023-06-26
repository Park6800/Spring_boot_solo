package Annotation.Repository;

import Annotation.Entity.AccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccountRepository extends JpaRepository<AccountEntity, Long> {

    @Query(value="select * from Account where Month= ?1",nativeQuery = true)
    public List<AccountEntity> findAll(int month);

    @Query(value="select count(*) from Account where Where_use = ?1", nativeQuery = true)
    public int countByWhere_use(String location);

    @Query(value="select sum(Money) from Account where Where_use = ?1", nativeQuery = true)
    public int countByMoney(String location);
}

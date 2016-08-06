/* https://social.msdn.microsoft.com/Forums/sqlserver/en-US/297d777c-efe0-4f78-ad6e-4184e9aa11bd/extract-number-from-account-number?forum=transactsql  */

create table Test (
  accountnumber varchar(100)
)

insert into Test(accountnumber) values ('1101-22-25-7')
 
 

 select
 parsename(replace(accountnumber,'-','.'),4) p4,  
 parsename(replace(accountnumber,'-','.'),3) p3,  
 parsename(replace(accountnumber,'-','.'),2) p2, 
 parsename(replace(accountnumber,'-','.'),1) p1 
 
  from test

 
 

DROP TABLE test
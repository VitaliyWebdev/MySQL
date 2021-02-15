# 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
select *
from client
where length(FirstName) < 6;

# 2. +Вибрати львівські відділення банку.+

select *
from department
where DepartmentCity = 'Lviv';


# 3. +Вибрати клієнтів з вищою освітою та посортуclientвати по прізвищу.

select *
from client
where Education = 'high'
order by LastName;


# 4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.


select *
from application
order by idApplication desc
limit 5 offset 10;
# 5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

select *
from client
where LastName like '%iv'
   or LastName like '%iva';


# 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
#????????
select *
from client
         join department d on client.Department_idDepartment = d.idDepartment
where DepartmentCity = 'Lviv';

# 7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.

select FirstName, Passport
from client
order by FirstName;
# 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.

select *
from client
         join application on client.idClient = application.Client_idClient
where sum > 5000;

# 9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.

select count(idClient)
from client;
select count(idClient)
from client
where Department_idDepartment = 2;

#
# 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
#?
select *
from client
         join application a on client.idClient = a.Client_idClient
order by sum desc;


# 11. Визначити кількість заявок на крдеит для кожного клієнта.

select count(FirstName),
       FirstName
from application
         join client c on application.Client_idClient = c.idClient
where Client_idClient = c.idClient
group by FirstName, LastName;


# 12. Визначити найбільший та найменший кредити.
select max(sum), min(sum)
from application;


# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.

select FirstName,
       Education,
       count(Education)
from application
         join client c on c.idClient = application.Client_idClient
where Education = 'high'
group by Education, FirstName;

#
# 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.

# select FirstName,avg(sum) from application join client c on c.idClient = application.Client_idClient
# group by FirstName order by application.Sum desc;

select FirstName, LastName, AVG(Sum) as Sum
from application
         join client c on c.idClient = application.Client_idClient
group by FirstName, LastName
order by Sum desc
limit 1;


# 15. Вивести відділення, яке видало в кредити найбільше грошей

select Department_idDepartment, Sum(sum) as babosiki
from client
         join application a on client.idClient = a.Client_idClient
group by Department_idDepartment
limit 1;


# 16. Вивести відділення, яке видало найбільший кредит.

select sum, city
from application
         join client c on application.Client_idClient = c.idClient
order by Sum desc
limit 1;


# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.

UPDATE application
SET Sum = 6000
WHERE Client_idClient IN (SELECT idClient FROM client WHERE Education = 'high');

# 18. Усіх клієнтів київських відділень пересилити до Києва.

update client set City = 'Kyiv' where city in (select DepartmentCity from department );


# 19. Видалити усі кредити, які є повернені.

delete from application where CreditState = 'returned';

#
# 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
#???




# Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000



#
# Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000

select * from client join application a on client.idClient = a.Client_idClient
where CreditState = 'returned' and sum > 5000


#
# /* Знайти максимальний неповернений кредит.*/


select max(sum) from application where CreditState = 'not returned';

# /*Знайти клієнта, сума кредиту якого найменша*/

select min(sum),FirstName from client join application a on client.idClient = a.Client_idClient



# /*Знайти кредити, сума яких більша за середнє значення усіх кредитів*/
#

select sum(sum) from application


# /*Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів*/
#


#
# #місто чувака який набрав найбільше кредитів
#
#
#
# set sql_safe_updates = 0;
# set sql_safe_updates = 1;

Як запустити програму?
---------------------------------------
1. Необхідно ввести параметри налаштування вашої бази даних. *flyway.url - доступ до вашої БД	  *flyway.user - ім'я юзера flyway.password - проль від БД 2. Додати файли sql у середовище, де знаходиться flyway, а саме sql. * Файли два один створює початкову таблицю та вставляє у неї тестовий рядок, другий створює нормалізовані таблиці передає дані в з попередньої таблиці у створені та видаляє стару таблицю 3. За допомогою команд flyway -configFiles="conf/PostgresSQL.conf" -target={} migrate, (1,2) можна мігрувати від початкової форми БД до нормалізованої. 3.Якщо запустити flyway -configFiles="conf/PostgresSQL.conf" clean, дані БД очистятьться і можна назад запустити migrate для відновлення БД. 4. Подивитися на міграції у БД можна  за допомогою команди flyway -configFiles="conf/PostgresSQL.conf" info.
Де отримати нормальні форми?
-------------------------------- 
*Папка diagrams включає в себе логічну та фізичну модель.
 

# factorial_system
Erlang factorial server with mnesia database
Creating Erlang system using the following video tutorial:
https://www.youtube.com/watch?v=KGcKzoaoiAE&list=PLJr0bQpUAsMjwKxwHQXEunWQaZ9q5ttuH&index=21

runner script for server:
cd C:\
C:\"Program Files"\erl-24.1.7\bin\erl -mnesia dir 'C:/Users/DDLgame-Dev-01/IdeaProjects/gen_server_release/lib/Mnesia.svr@192.168.1.10' -name svr@192.168.1.10 -setcookie 1234 -s mnesia create_schema svr@192.168.1.10 -s init stop
C:\"Program Files"\erl-24.1.7\bin\erl -mnesia dir 'C:/Users/DDLgame-Dev-01/IdeaProjects/gen_server_release/lib/Mnesia.svr@192.168.1.10' -pa C:\Users\DDLgame-Dev-01\IdeaProjects\gen_server_release\lib\factorial_system-2\ebin -boot C:\Users\DDLgame-Dev-01\IdeaProjects\gen_server_release\releases\1.0\start -name svr@192.168.1.10 -setcookie 1234

runner script for client:
cd C:\
C:\"Program Files"\erl-24.1.7\bin\erl -name foo@192.168.1.10 -setcookie 1234

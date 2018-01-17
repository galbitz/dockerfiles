docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=P@ssword1 -e ACCEPT_EULA=Y galbitz/sql2008r2

#docker run -it --rm -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=P@ssword1 -e ACCEPT_EULA=Y galbitz/sql2008r2 powershell.exe
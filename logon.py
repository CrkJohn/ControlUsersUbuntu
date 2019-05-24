import pymysql
import socket
import datetime
import getpass
import os


"""
      Donwload MySQLdb
      lines
      sudo apt install python3-dev libpython3-dev
      sudo apt install python3-mysqldb
      sudo apt-get install python3-pymysql
"""
def user():
        os.system("last -w | grep -iE '^[A-Za-z0-9]+' -o > lastW.txt")      
        os.system("who | grep -iE '^[A-Za-z0-9]+' -o > who.txt")
        fileLastW = open("lastW.txt","r")
        last = list()
        for w in fileLastW:
            last.append(w.strip())

        fileWho = open("who.txt","r")        
        who = list()
        for w in fileWho:
            who.append(w.strip())
        userLogin = ""
        for w in who:
            for l in last:
                if w == l:
                    return l                
       
        return "Nothing"


def main():
        db = pymysql.connect(host="laboratorio.is.escuelaing.edu.co",    # tu host, usualmente localhost
                     user="control",         # tu usuario
                     passwd="control20101",  # tu password
                     db="control")
        cur = db.cursor();
        hostName = socket.gethostname()
        now = datetime.datetime.now()
        ip = "10.2.67."+ (hostName.split('-')[-1])
        userLogin = user() #getpass.getuser()      
        sql = "INSERT INTO datos(estudiante,equipo,logon,logoff,ip) VALUES(%s,%s,now(),null,%s)"
        val = (userLogin,hostName,ip)
        cur.execute(sql,val)
        db.commit()   
        print(cur.rowcount, "record inserted.")

main()

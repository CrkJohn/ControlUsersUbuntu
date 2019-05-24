import pymysql
import socket
import datetime
import getpass


"""
      Donwload MySQLdb
      lines
      sudo apt install python3-dev libpython3-dev
      sudo apt install python3-mysqldb
      sudo apt-get install python3-pymysql
"""
def main():      
      db = pymysql.connect(host="laboratorio.is.escuelaing.edu.co",    # tu host, usualmente localhost
                     user="control",         # tu usuario
                     passwd="control20101",  # tu password
                     db="control")
      cur = db.cursor();
      hostName = socket.gethostname()
      #hostName = "CrkJohn-80"
      now = datetime.datetime.now()
      ip = "10.2.67."+ (hostName.split('-')[-1])
      userLogin = getpass.getuser()      
      sql = "INSERT INTO datos(estudiante,equipo,logon,logoff,ip) VALUES(%s,%s,now(),null,%s)"
      val = (userLogin,hostName,ip)
      cur.execute(sql,val)
      db.commit()      
      print(cur.rowcount, "record inserted.")

main()


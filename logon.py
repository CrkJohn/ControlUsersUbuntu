
import MySQLdb
import socket
import datetime
import getpass



"""
      Donwload MySQLdb
      lines
      sudo apt install python3-dev libpython3-dev
      sudo apt install python3-mysqldb
"""
def main():      
      db = MySQLdb.connect(host="10.2.65.37",    # tu host, usualmente localhost
                     user="control",         # tu usuario
                     passwd="control20101",  # tu password
                     db="control")
      cur = db.cursor();
      hostName = socket.gethostname()
      now = datetime.datetime.now()
      ip = "10.2.67."+ (hostName.split('-')[-1])
      userLogin = getpass.getuser()
      sql = "INSERT INTO datos(estudiante,equipo,logon,logoff,ip) VALUES(%s,%s,now(),null,%s)"
      val = (userLogin,hostName,ip)
      cur.execute(sql,val)
      db.commit()      

main()

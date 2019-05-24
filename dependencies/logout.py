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
      #hostName = socket.gethostname()
      hostName = "linux-176"
      sql = "SELECT * FROM datos where datos.equipo = %s ORDER BY logon DESC LIMIT 1;"
      #sql = " INTO datos(estudiante,equipo,logon,logoff,ip) VALUES(%s,%s,now(),null,%s)"
      val = (hostName)
      cur.execute(sql,val)
      estudiante = None ; equipo = None ;logon= None;
      for  select in cur:
          estudiante, equipo, logon , logoff,ip = select
      now = datetime.datetime.now()
      x = str(logon)
      sql = "UPDATE datos set  logoff = now() where logon = '{}' and estudiante = '{}' and equipo= '{}';".format(x,estudiante,equipo)
      #print(sql)
      val = (x,estudiante,equipo)
      cur.execute(sql)
      db.commit()      

main()

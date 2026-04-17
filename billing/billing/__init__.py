import pymysql

# Django 6 checks mysqlclient version; expose a compatible version when using PyMySQL.
pymysql.version_info = (2, 2, 1, "final", 0)
pymysql.__version__ = "2.2.1"
pymysql.install_as_MySQLdb()

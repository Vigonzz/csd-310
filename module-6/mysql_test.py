import mysql.connector
from mysql.connector import errorcode


# Database config
config = {  # Corrected from 'congif' to 'config'
    "user": "root",
    "password": "TRexhuenemeyer12!",
    "host": "localhost",
    "database": "movies",
    "raise_on_warnings": True
}

# Connection test code
try:
    db = mysql.connector.connect(**config)
    print("\n Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)
#I could not, for the life of me, get the db to bew defined unless I tweaked it to be reflected as down below 
finally:
    if 'db' in locals() and db.is_connected(): 
        db.close()
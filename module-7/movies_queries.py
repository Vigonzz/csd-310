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

try:
    db = mysql.connector.connect(**config)
    #Create four queries
    cursor = db.cursor()
    print("\n Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    #select all fields for studio table
    cursor.execute("SELECT * FROM studio")
    studio_records = cursor.fetchall()
    print("\n-- DISPLAYING Studio RECORDS --")
    for record in studio_records:
        print(f'Studio ID: {record[0]}')
        print(f'Studio Name: {record [1]}')
        print()

    #select all fields for genre table
    cursor.execute("SELECT * FROM genre")
    genre_records = cursor.fetchall()
    print("-- DISPLAYING Genre RECORDS --")
    for record in genre_records:
        print(f'Genre ID: {record[0]}')
        print(f'Genre Name: {record[1]}')
        print()

    #select the movie names for movies with a run time of less than 2 hours
    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120")
    short_films = cursor.fetchall()
    print("-- DISPLAYING Short Film RECORDS --")
    for film in short_films:
        print(f'Film Name: {film[0]}')
        print(f'Runtime: {film[1]}')
        print()

    #Get a list of film names and directors ensure it is ordered correctly
    cursor.execute("SELECT film.film_name, film.film_director FROM film ORDER BY film.film_director")
    director_records = cursor.fetchall()
    print("-- DISPLAYING Director RECORDS in Order --")
    for record in director_records:
        print(f'Film Name: {record[0]}')
        print(f'Director: {record[1]}')
        print()

        
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specfied databse does not exist")
    else:
        print(err)
finally:
    if 'db' in locals() and db.is_connected():
        cursor.close()
        db.close()


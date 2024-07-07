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

#Our function to show films
def show_films(cursor, title):
    #Required to use INNER JOIN and ensure an iteration on the data for the results

    #The Inner join query
    cursor.execute("""
        SELECT film.film_name AS Name,
                film.film_director AS Director,
                genre.genre_name AS Genre,
                studio.studio_name AS Studio
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id
    """)

    films = cursor.fetchall()
    print("\n -- {} --".format(title))

    #now iterate the film data set
    for film in films:
        print(f'Film Name: {film[0]}\nDirector: {film[1]}\nGenre Name: {film[2]}\nStudio Name: {film[3]}\n')

try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    #disply the films
    show_films(cursor, "DISPLAYING FILMS")

    #Insert a new record into film table (film of choice Nope) #In the results I put one accidently instead of the name
    insert_query = """
    INSERT INTO film (film_name, genre_id, studio_id, film_director, film_releaseDate, film_runtime)
    VALUES ('Nope', 1, 3, 'Jordan Peele', '07-22', '122' )
    """
    cursor.execute(insert_query)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    #Update the genre of "Aliens" to horror
    update_query = """
    UPDATE film
    SET genre_id = 1 
    WHERE film_name = 'ALIEN'
    """
    cursor.execute(update_query)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

    #delete 'Gladiator'
    delete_query = """
    DELETE FROM film
    WHERE film_name = 'Gladiator'
    """
    cursor.execute(delete_query)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

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
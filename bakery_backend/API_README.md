# API Readme
## Setting up the database
- Create a new MySQL user for the API, set username and password accordingly in config.py
- Import SQL file to MySQL to set up the database
- Grant all privileges on the newly-created database to the new user you created

## Running the application
- Use pip to install flask and pymysql (pip install pymysql flask)
- Run api.py using Python2 (python api.py)

## Interfacing with the API
- You can use Postman to send HTTP queries to test
- POST requests use x-www-form-urlencoded format (located under "Body" in Postman)
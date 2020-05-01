# Paul's Bakery Batter Calculator
## Running the application
- Open the provided `.xcodeproj` project file (located in the `client-app` directory of the repo) in Xcode. Xcode version 8.0 or later will be needed in order to open the project
- Once open, select one of the iPad simulator virtual devices listed next to the `start` and `stop` buttons in the top left corner of the Xcode window
- Select the `start` button to build and launch the application. The iPad simulator will be launched by Xcode, and the program will be started

An instance of the API will be running on my server (`svc.dosdude1.com`) listening on port 5000. This is specified in the application source code. If you wish to run your own instance of the API, please follow the instructions below, and make the necessary changes to the `ServerAddress` and `ServerPort` definitions in `RESTQueryController.h`.

### Other Notes

 - The API's temporary testing user is an admin, and can be logged into using the username `admin` with the password `password`
 - If using the API instance running on my server, some testing data will be in place, allowing you to test all aspects of the user interface
 - The iPhone UI is not implemented, due to lack of time. The program should be run on an iPad/iPad simulator only

## Setting up the API
 - First, import the provided SQL file `bakery.sql` into MySQL
	 - `mysql -u root -p < /path/to/bakery.sql`
- Next, install the Python runtime if not already, then install `flask` and `pymysql`, the dependencies required for our backend, using PIP
	- `pip install flask pymysql`
- Lastly, start the API
	- `python api.py`

The API by default listens on port 5000.


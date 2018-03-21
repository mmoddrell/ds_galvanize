## Docker and Postgres Install Directions

Follow these directions to install [Docker](https://www.docker.com/what-docker)
and [PostgreSQL](https://www.postgresql.org/about/) on to your laptop.  A Postgres
Docker Image will be used to install a PostgreSQL container in your machine.
You will need the files in the `./data_for_container` folder supplied with these instructions.

1) Install Docker CE (community edition) as per the instructions for your operating system.
   * [Ubuntu Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/#extra-steps-for-aufs)  
   Also use this version if you have already installed an Ubuntu Linux Virtual Machine on your system. 
   Go into your virtual machine to install docker from the terminal.  
   <br/>
   WARNING FOR VIRTUAL MACHINE SYSTEMS<br/>   
   On the forums there is some indication that your Virtual Box installation may get screwed up by
   the Docker Install.  Before installing Docker, back up all your class files to USB (and or commit
   them to Github!)  
   <br/>  
   
   In the linked Docker install guide, go the the section **Install Using the Repository**. Ignore the "production systems" directions. 
   After installation, add your current user to the Docker user group (for file permissions). 
   ```bash
   $ sudo usermod -a -G docker $USER
   ```
   * [MacOS](https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac)  
   Click on the **Stable** button to download the stable package.  After you download it,
   click on it to install, then when prompted drag it into applications.  Click on it in
   applications, and when prompted give it priviledged access.  
   * Windows  
   First determine which version of Windows you're using. Here's a [link to a guide.](https://support.microsoft.com/en-us/help/13443/windows-which-operating-system)  
   Depending on your version, use the following link:  
   [Windows 10 Pro only](https://docs.docker.com/docker-for-windows/install/)  
   Click on the **Stable** button to download the stable package and continue following the prompts.  
   [Windows 10 Home and all other versions](https://docs.docker.com/toolbox/overview/)  
   Select "Docker Toolbox for Windows" and continue following the prompts.

   **Regardless of version** you should be able to test whether your Docker installation worked by typing
   ```base
   $ sudo docker run hello-world
   or
   $ docker run hello-world
   ```  
   and seeing:
   ```
   Hello from Docker!
   ```
   and some other text in response.

2) Create the Postgres container, while creating a storage volume, a port to communicate, and setting a password.  
   General syntax:  
   ```bash
   $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
   ```
   You can search for help on the docker run command:  
   ```bash
   $ docker run --help
   ```
   to explain the arguments.  
   Specific syntax (please cut and paste the command below into terminal).
   ```bash
    $ docker run -it --name postgres_container \
                     --mount source=postgres_data,target=/data \
                     -p 5432:5432 \
                     -e POSTGRES_PASSWORD=mypostgres \
                     -d postgres
   ```
    This makes a container named `postgres container` with an attached volume named `postgres_data`
    that is accessible from your laptop at `postgres_conatiner:/data`.  It maps
    the container port 5432 to your port at 5432.  It sets an environment
    variable POSTGRES_PASSWORD to mypostgres, and then it starts a detached instance
    base on the postgres docker image.


3) Copy needed files into the volume you created.
   ```bash 
   $ docker cp ./data_for_container/. postgres_container:/data 
   ```

4) Get inside the postgres container using bash.
   ```
   $ docker exec -it postgres_container bash
   ```

5) See what databases are available (as user postgres).
   ```bash
   # psql -U postgres -l
   ```
   You should only see postgres, template0, and template1.


6) Create an (empty) database called sql_for_ds
   ```bash
   # createdb -U postgres sql_for_ds
   ```

7) See if it's created (it should be!)
   ```bash
   # psql -U postgres -l
   ```

8) Import data into it the sql_for_ds database.
   ```bash
   # psql -U postgres sql_for_ds < ./data/make_sql_for_ds.sql
   ```

9) Connect to the database using the `psql` interactive shell.
   ```bash
   # psql -U postgres -d sql_for_ds
   ```
10) Now that you are connected (prompt should be `sql_for_ds=#`), list the tables.
    ```bash
    # \d
    ```

11) Look at all the values in each table.  These outputs should match the data in the
    paper 'Introduction to SQL for Data Scientists by Ben Smith.'  Execute these lines
    one-by-one.
    ```bash
    # SELECT * FROM degrees;  
    # SELECT * FROM term_gpa;  
    # SELECT * FROM student;  
    ```

12) Send query output to a file named `query_out.csv`.
    ```bash
    # \copy (SELECT * FROM student) To '/data/query_out.csv' With CSV;
    ```

13) Copy the query output file to your localhost at your current location (.). 
    Note, this command isn't run in the bash terminal you started when running 
    postgres, but a separate terminal.
    ```bash
    $ docker cp postgres_container:/data/query_out.csv .
    ```

14) Inspect your query results
    ```bash
    $ less query_out.csv
    ```

15) Quit the psql interactive shell.
    ```bash
    # \q
    ```

16) Leave the postgres container.
    ```bash
    # exit
    ```

17) The container is still running in the background (you can check that with `$ docker ps`)  Stop the container.
    ```bash
    $ docker stop postgres_container
    ```

18) The next time you want to use the container, **don't run it**, but start it:
    ```bash
    $ docker start postgres_container
    ```

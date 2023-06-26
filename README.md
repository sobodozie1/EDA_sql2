## MySQL x Power BI

Combination of analytical tools maketh a good analyst. Here, MySQL was used for a possible wrangling and subsequent exploration, before using Power BI to create a visual summary of the insights. The combination of MySQL for data wrangling and Power BI for visualization provides a powerful end-to-end solution for data analysis. What are featured here are mainly;
- Data importation into the MySQL and database creation
- Data wrangling and preliminary exploration in the MySQL
- Exportation to Power BI, Table connection, and Visualisation

Data Dictionary:
- Emp_ID : Unique employment identification code issued by the company
- First Name : The first name of a staff
- Last Name  : The last name of a staff
- Birth Date : The birth date of the staff
- Gender : The biological gender of a staff
- Race : The geographical race of a staff
- Department : The functional department/scetion of a staff within the company
- Job Title : The title of the job role of a staff within the company
- Location : The geographical working branch of a staff within the company 
- Hire Date : Effective date an employee was hired by the company 
- Termination Date: Effective date an employee was dismissed by the company
- Location City : The geographical location of a staff by City
- Location State : The geographical location of a staff by State

The dataset concerns a hypothetical company whose aims was determine, mainly, their staff retention, location distibution, race distribution and sex distribution, possibly for balancing, optimization, and enhancement of efficiency.

MySQL is a powerful relational database management system that can be used for data cleaning and preparation tasks. With MySQL, you can import raw data into a database, allowing one to perform various cleaning operations on it. The data cleaning tasks in MySQL may include removing duplicates, handling missing values, standardizing data formats, and correcting inconsistent entries.

MySQL provides functions and tools to handle missing values, such as replacing them with appropriate values or removing rows with missing data. With these fucntions, one can run basic calculations like average, sum, subtraction, in bid to replace missing values. By leveraging MySQL's string manipulation functions, you can standardize data formats, convert text to uppercase or lowercase, and remove unnecessary characters.Then comes "Derived Table", which is a table gotten from calculations involving two or more exisitng columns, giving rise to a new kind of table featuring the results from such calculations. One common error in creating a derived table is ommitting closing brackets, and aliasing it using the AS function.

Once the data wrangling and possible preliminary exploraation must have been done in MySQL, one can export it to a format suitable for visualization tools like Power BI. Power BI is a business intelligence tool that enables you to create interactive visualizations and reports from your MySQL data, and so on. Also one can use the Power BI's intuitive drag-and-drop interface to connect the MySQL database and import the wrangled and explored data.

Power BI offers a wide range of visualization options, including charts, graphs, maps, and tables, allowing you to represent your data in a meaningful way. Power BI's data modeling capabilities allows creation of relationships between different tables in the MySQL database, enhancing data analysis capabilities.Power BI also allows for the application of various data transformation operations on the MySQL data, such as filtering, sorting, and aggregating, to further refine your visualizations. The Interactive features in Power BI enable users to drill down into the data, filter information, and perform ad-hoc analysis, making it easier to gain insights from your MySQL dataset. The Power BI offers collaboration and sharing features, for easy, and most of all, secured collaboration with colleagues.

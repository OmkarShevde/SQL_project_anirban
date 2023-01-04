You should have following packages in your system before running python script:

1.sqlalchemy
2.boto3
3.pyodbc

4. #update your SQL server details and mention your DB name, just like shown below:
conn_str = conn_str = (
    r'DRIVER={SQL Server};' 
    r'PORT=1433;'
    r'SERVER=DESKTOP-I2P6GLV\SQLEXPRESS02;' 	<-- Your SQL server details
    r'DATABASE=ABDB;' 	<--- DB name where you have your tables
    r'Trusted_Connection=yes;'
)

5.	#execute query 
	#Update your table names in SQL query:
	
        src_tables = s.execute("""select t.name as table_name from sys.tables t where t.name in ('customer_History_data','Item_History_data','order_history_data')""")

6. 	#save to s3
	#update Bucket name : upload_file_bucket = 'etl-snfk1'
	#update folder name you want to create inside the bucket: upload_file_key = 'public/'
	#Ensure region_name: ...region_name='ap-south-1')
	
		upload_file_bucket = 'etl-snfk1'
       	upload_file_key = 'public/' + str(tbl) + f"/{str(tbl)}"
        	filepath = upload_file_key + ".csv"
        	s3_client = boto3.client('s3',aws_access_key_id=access_key,aws_secret_access_key=secret_access_key,region_name='ap-south-1')
        	with io.StringIO() as csv_buffer:

7. Make sure "main.py" and "config.json" is in the same folder.
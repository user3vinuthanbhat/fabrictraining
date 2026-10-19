# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "431d5f2d-3204-44ee-bcd6-ff401ea6fb46",
# META       "default_lakehouse_name": "Sales",
# META       "default_lakehouse_workspace_id": "6557fd20-812b-49e6-abf3-5e8f4e63518c",
# META       "known_lakehouses": [
# META         {
# META           "id": "431d5f2d-3204-44ee-bcd6-ff401ea6fb46"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

# Welcome to your new notebook
# Type here in the cell editor to add code!


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import current_timestamp

sales_df = spark.read.option("header", True).option("inferSchema", True).csv("Files/bronze_sales.csv")
sales_df = sales_df.withColumn("CreatedDateTS", current_timestamp())

spark.sql("CREATE SCHEMA IF NOT EXISTS Bronze")
sales_df.write.format("delta").mode("overwrite").saveAsTable("Bronze.bronze_sales")

# CELL ********************

record_count = spark.table("Bronze.bronze_sales").count()
print(f"Record count: {record_count}")

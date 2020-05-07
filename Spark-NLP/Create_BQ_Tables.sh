
# 1. Create the Dataset
bq mk -d $Project:Dashboard_tables 
# Name is missleading, it is a Dataset
# I cant change it, because the consecutive Project has allready been set up

# Nevertheless, we now create the included tables.

# 2. Create Tables
# Table to hold the Masterdata
bq mk \
--table \
--description Masterdata \
$Project:Dashboard_tables.Article_masterdata \
ID:STRING,PublishingDate:DATE,Author:STRING,Title:STRING,Claps:NUMERIC,No_Responses:NUMERIC,Reading_time:NUMERIC

# Table to hold NLP-Processed Entities
bq mk \
--table \
--description NLP-Data \
$Project:Dashboard_tables.Entity_raw \
Word:STRING,Doc_ID:STRING

# Table to store Tags
bq mk \
--table \
--description Tags \
$Project:Dashboard_tables.Article_tags \
ID:STRING,Tag:STRING
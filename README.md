
# Motivation

We know that LLMs can generate SQL code from Natural language. The challenge in adopting this to empower all skill levels to query big data is many fold. From LLM perspective: For a correct SQL query generation from natural langugae, LLMs not only need to understad the context but also have an understanding of the database schema. Passing schema to prompts could be an approach here but this is not scalable. 

We showcase using prompt engineering approaches from chain of thought modelling we can make this approach scalable. This project shows LLMs working from natural language to query a star schema in data lake (via Synapse) without the need to know the DB schema before hand.We employ Lakehouse pattern in this showcase.

## Quick intro to the folder structure

- `app`: The app folder for the Streamlit app and logic 
- `app/helpers` Helper modules/scripts
- `app/pages` Pages for the Streamlit app (will be extended to more pages in the future)
- `scripts` Setup scrpts to install and configure drivers
- `synapse` Scripts to generate fake data for our retail star schema, store in data lake via spark and then scripts to create external tables via SQL (lakehouse pattern)

## Setting up the data in the Data lake
- Create a Synapse environment and create a Dedicated sqlpool and a Spark cluster in the environment (refer Azure docs)
- Make sure that your user has `Storage Blob Data Contributor` role in the ADLS storage created with Synapse, create a new container in there `dataset` to hold our generated data
- Navigate to the newly created container and [create a SAS token for the container](https://learn.microsoft.com/en-us/azure/cognitive-services/translator/document-translation/how-to-guides/create-sas-tokens?tabs=Containers), keep the token handy we will need it later. 
- Copy the `synapse/data/CreateSalesStarData.ipynb` into your Synapse environment and execute it using the Spark cluster (refer to comments in the notebook for additional setup)
- Copy the [Credtion cretor file](synapse/sql/CreateDBScopedCred.sql) to Synapse (use the SAS token in the file) and create a DB scope credential to access Lakehouse
- Copy the [Customer external table creation script](synapse/sql/CreateCustomerExternal.sql) to Synapse replace the ADLS account name and the container name in the file before you execute it
- Copy the [Product external table creation script](synapse/sql/CreateProductExternal.sql) to Synapse replace the ADLS account name and the container name in the file before you execute it
- Copy the [Product external table creation script](synapse/sql/CreateSalesExternal.sql) to Synapse replace the ADLS account name and the container name in the file before you execute it
- Copy the [Store external table creation script](synapse/sql/CreateStoreExternal.sql) to Synapse replace the ADLS account name and the container name in the file before you execute it
- Finally create a login using [CReate Login script](synapse/sql/CreateLogin.sql) and add the role to the dedicated SQL using the [Add role script](synapse/sql/AddRole.sql)

We setup the dedicated SQL pool of Synapse to talk to lakehouse external tables, you could also do a similar setup with the serverless SQL pool. Adjust the above accordingly. 

## Local development setup

- Prerequisite: you need docker installed and running in your system. 
- EASY STEP: The repo comes with a `.devcontainer`, so if you are using VS Code, you will be propted to build and open in container. If you do not get this pop up and you are on VS code, you can open the command pallete and look for "Dev containers:...", follow for documentation to open in devcontainers in vs code docs. 
- COMPLEX STEP: If not you need to manually setup a few things, I assume: a debian environment, azure cli installed, conda (mamba optional) installed and available. Please make sure to have these setup in your environment. 
  - switch to root and install the MS ODBC driver: from container switch to root: `sudo su` and then execute `. scripts/mssql-odbc.sh`
  - Finally install all the required dependencies using conda: `conda env update -f app/env.yaml`
- Switch over to the new environment using: `conda activate athena`

## Locally running the app

- Run the langchain server execute the following command: `langchain-server` in an activateed conda environment (athena), navigate to `http://localhost:4173/`
- Make sure you have followe the steps before, then run `streamlit run app/Azure_OpenAI_demo.py` in an activated conda environment (athena)


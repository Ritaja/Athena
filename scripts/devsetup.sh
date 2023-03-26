sudo bash scripts/mssql-odbc.sh
conda env update -f app/env.yaml
# settings for the lanchain server (local setup)
export LANGCHAIN_HANDLER=langchain
export LANGCHAIN_SESSION=default
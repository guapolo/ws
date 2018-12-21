#!/bin/bash
set -e

function load_structure {
  local db=$1
  local count_tables=$(
    psql -v ON_ERROR_STOP=1 --username $DB_USER \
    -c "SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public'" \
    -q -A -t $db
  )
  if [ "$count_tables" = "0" ]; then
    >&2 echo "Loading structure to ${db}..."
    psql -v ON_ERROR_STOP=1 --username $DB_USER -q -f $STRUCTURE_SQL $db
    >&2 echo -e "Structure loaded to ${db}\n"
  else
    >&2 echo -e "Leaving $db untouched\n"
  fi
}

load_structure $DB_NAME

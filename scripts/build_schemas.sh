#!/usr/bin/env bash

set -e

mkdir -p schemas/en

# Build Census schema for each region
for region_code in GB-WLS GB-ENG; do
    # Lowercase the region code and replace '-' with '_'
    FORMATTED_REGION_CODE=$(echo "${region_code}" | tr '[:upper:]' '[:lower:]' | tr - _)

    CENSUS_DATE="2027-03-21"
    CENSUS_MONTH_YEAR_DATE="2027-03"

    for census_type in "individual" "household" "communal_establishment"; do

        DESTINATION_FILE="schemas/en/census_${census_type}_${FORMATTED_REGION_CODE}.json"

        SOURCE_FILE="source/jsonnet/england-wales/census_${census_type}.jsonnet"
        ADDITIONAL_LIBRARY_PATH="source/jsonnet/england-wales/${census_type}/lib/"

        jsonnet --ext-str region_code=${region_code} --tla-str region_code="${region_code}" --ext-str census_date="${CENSUS_DATE}" --tla-str census_month_year_date="${CENSUS_MONTH_YEAR_DATE}" --jpath "${ADDITIONAL_LIBRARY_PATH}" "${SOURCE_FILE}" > "${DESTINATION_FILE}"
        echo "Built ${DESTINATION_FILE}"

    done
done

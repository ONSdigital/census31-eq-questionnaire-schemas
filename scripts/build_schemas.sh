#!/usr/bin/env bash

set -e

#!/usr/bin/env bash

while [[ $# -gt 0 ]]; do
    case "$1" in
    --schemas-version)
        version="$2"
        shift 2
        ;;
    --is-test-schema)
        test=true
        shift 1
        ;;
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
    esac
done

# Use version if present
if [[ -n "${version:-}" ]]; then
    echo "Using schemas version: $version"
else
    echo "No schemas version specified"
fi

# Use version if present
if [[ -n "${test:-}" ]]; then
    echo "Built schemas will be test versions"
fi

mkdir -p schemas/census/en

# Build Census schema for each region
for region_code in GB-WLS GB-ENG GB-NIR; do
    # Lowercase the region code and replace '-' with '_'
    FORMATTED_REGION_CODE=$(echo "${region_code}" | tr '[:upper:]' '[:lower:]' | tr - _)

    CENSUS_DATE="2027-03-21"
    CENSUS_MONTH_YEAR_DATE="2027-03"

    for census_type in "individual" "household" "communal_establishment"; do

        DESTINATION_FILE="schemas/census/en/census_${census_type}_${FORMATTED_REGION_CODE}.json"

        jsonnet_args=(
            --ext-str region_code="${region_code}"
            --tla-str region_code="${region_code}"
            --ext-str census_date="${CENSUS_DATE}"
        )
        [[ -n "${version:-}" ]] &&
            jsonnet_args+=(--tla-str "schemas_version=$version")
        if [[ -n "${test:-}" ]]; then
            jsonnet_args+=(--tla-code "is_test_schema=true")
        fi

        if [[ "$region_code" = "GB-NIR" ]]; then
            if [[ "$census_type" != "communal_establishment" ]]; then
                SOURCE_FILE="source/jsonnet/northern-ireland/census_${census_type}.jsonnet"
                ADDITIONAL_LIBRARY_PATH="source/jsonnet/northern-ireland/${census_type}/lib/"
                jsonnet_args+=(--jpath "${ADDITIONAL_LIBRARY_PATH}")

                jsonnet "${jsonnet_args[@]}" "${SOURCE_FILE}" >"${DESTINATION_FILE}"
                echo "Built ${DESTINATION_FILE}"
            fi
        else
            SOURCE_FILE="source/jsonnet/england-wales/census_${census_type}.jsonnet"
            ADDITIONAL_LIBRARY_PATH="source/jsonnet/england-wales/${census_type}/lib/"
            jsonnet_args+=(--tla-str census_month_year_date="${CENSUS_MONTH_YEAR_DATE}")
            jsonnet_args+=(--jpath "${ADDITIONAL_LIBRARY_PATH}")

            jsonnet "${jsonnet_args[@]}" "${SOURCE_FILE}" >"${DESTINATION_FILE}"
            echo "Built ${DESTINATION_FILE}"
        fi

    done
done

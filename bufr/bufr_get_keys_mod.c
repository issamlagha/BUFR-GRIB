#include "eccodes.h"

int main(int argc, char* argv[])
{
    FILE* in = NULL;
    codes_handle* h = NULL;
    long* descriptors = NULL;
    double* values = NULL;
    char* typicalDate = NULL;
    long longVal;
    double doubleVal;
    size_t values_len = 0, desc_len = 0, len = 0;
    int i, err = 0;
    int cnt = 0;
    const char* infile = "bufr.synop";

    in = fopen(infile, "rb");
    if (!in) {
        printf("ERROR: unable to open file %s\n", infile);
        return 1;
    }

    /* Loop over the messages in the BUFR file */
    while ((h = codes_handle_new_from_file(NULL, in, PRODUCT_BUFR, &err)) != NULL || err != CODES_SUCCESS)
    {
        if (h == NULL) {
            printf("Error: unable to create handle for message %d\n", cnt);
            cnt++;
            continue;
        }

        printf("message: %d\n", cnt);

        /* Unpack the data values */
        CODES_CHECK(codes_set_long(h, "unpack", 1), 0);

        /* Read and print some data values */

        /* Long value */
        if (codes_is_defined(h, "blockNumber")) {
            CODES_CHECK(codes_get_long(h, "blockNumber", &longVal), 0);
            printf("  blockNumber: %ld\n", longVal);
        } else {
            printf("  blockNumber: NOT FOUND\n");
        }

        /* Handle stationNumber (may be an array or missing) */
        size_t stationNumber_len = 0;
        long* stationNumbers = NULL;

        if (codes_is_defined(h, "stationNumber")) {
            CODES_CHECK(codes_get_size(h, "stationNumber", &stationNumber_len), 0);

            if (stationNumber_len > 0) {
                stationNumbers = (long*)malloc(stationNumber_len * sizeof(long));
                CODES_CHECK(codes_get_long_array(h, "stationNumber", stationNumbers, &stationNumber_len), 0);

                printf("  stationNumber:\n");
                for (i = 0; i < stationNumber_len; i++) {
                    printf("   %ld\n", stationNumbers[i]);
                }

                free(stationNumbers);
            } else {
                printf("  stationNumber: ARRAY IS EMPTY\n");
            }
        } else {
            printf("  stationNumber: NOT FOUND\n");
        }

        /* Handle airTemperature (may be an array or missing) */
        size_t airTemperature_len = 0;
        double* airTemperatures = NULL;

        if (codes_is_defined(h, "airTemperature")) {
            CODES_CHECK(codes_get_size(h, "airTemperature", &airTemperature_len), 0);

            if (airTemperature_len > 0) {
                airTemperatures = (double*)malloc(airTemperature_len * sizeof(double));
                CODES_CHECK(codes_get_double_array(h, "airTemperature", airTemperatures, &airTemperature_len), 0);

                printf("  airTemperature:\n");
                for (i = 0; i < airTemperature_len; i++) {
                    printf("   %f\n", airTemperatures[i]);
                }

                free(airTemperatures);
            } else {
                printf("  airTemperature: ARRAY IS EMPTY\n");
            }
        } else {
            printf("  airTemperature: NOT FOUND\n");
        }

        /* String value (typicalDate) */
        if (codes_is_defined(h, "typicalDate")) {
            CODES_CHECK(codes_get_length(h, "typicalDate", &len), 0);
            typicalDate = (char*)malloc(len * sizeof(char));
            codes_get_string(h, "typicalDate", typicalDate, &len);
            printf("  typicalDate: %s\n", typicalDate);
            free(typicalDate);
        } else {
            printf("  typicalDate: NOT FOUND\n");
        }

        /* Array of long (bufrdcExpandedDescriptors) */
        if (codes_is_defined(h, "bufrdcExpandedDescriptors")) {
            CODES_CHECK(codes_get_size(h, "bufrdcExpandedDescriptors", &desc_len), 0);
            descriptors = (long*)malloc(desc_len * sizeof(long));
            CODES_CHECK(codes_get_long_array(h, "bufrdcExpandedDescriptors", descriptors, &desc_len), 0);
            printf("  bufrdcExpandedDescriptors:\n");
            for (i = 0; i < desc_len; i++) {
                printf("   %ld\n", descriptors[i]);
            }
            free(descriptors);
        } else {
            printf("  bufrdcExpandedDescriptors: NOT FOUND\n");
        }

        /* Array of double (numericValues) */
        if (codes_is_defined(h, "numericValues")) {
            CODES_CHECK(codes_get_size(h, "numericValues", &values_len), 0);
            values = (double*)malloc(values_len * sizeof(double));
            CODES_CHECK(codes_get_double_array(h, "numericValues", values, &values_len), 0);
            printf("  numericValues:\n");
            for (i = 0; i < values_len; i++) {
                printf("   %.10e\n", values[i]);
            }
            free(values);
        } else {
            printf("  numericValues: NOT FOUND\n");
        }

        /* Delete handle */
        codes_handle_delete(h);

        cnt++;
    }

    fclose(in);
    return 0;
}

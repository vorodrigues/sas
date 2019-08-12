/*****************************************************************
* SAS Visual Text Analytics
* Topics Score Code
*
* Modify the following macro variables to match your needs.
* The input_astore_name variable should have already been
* set to the location of the astore binary table for the
* associated SAS Visual Text Analytics project.
****************************************************************/

/* NOTE: The text variable on the input table must match the text variable name that was used to train the astore. */

/* cas library information for cas table containing the data set you would like to score */
%let caslib_name="INVOICES";

/* the cas table you would like to score */
/* NOTE: The text variable on the input table must match the name and type of the text variable that was used when the astore was created. */
%let input_table_name = "ABT_INVOICES_ISSUED_ORIGINAL_ID";

/* the list of variables in your input table that you want to get copied over to the output table */
/* NOTE: It is recommended that you at least include the docid variable from your input table here. This would allow you to map the results back to the input data. */
%let copy_vars="DOC_ID";

/* cas library information for output cas tables to produce */
%let output_caslib_name = "INVOICES";

/* the topics output cas table to produce */
%let output_documents_table_name = "INVOICES_TOPICS";

/* the caslib for aStore table you would like to score */
%let input_astore_caslib_name = "Analytics_Project_197108ef-4a82-4e42-addc-277d4489a5a8";

/* the cas aStore table you would like to score */
%let input_astore_name = "e2195f0f-958a-430a-92e4-6ad98f5eb495_TEXT_MODEL";

/* hostname for cas server */
%let cas_server_hostname = "sasserver.demo.sas.com";

/* port for cas server */
%let cas_server_port = 5570;

/* create a session */
cas sascas1 host=&cas_server_hostname port=&cas_server_port ;
libname sascas1 cas sessref=sascas1 datalimit=all;

/* call the scoring action */

proc cas;
    session sascas1;
    loadactionset "astore";

    action astore.score;
        param
            table={ caslib=&caslib_name, name=&input_table_name}
            rstore={ caslib=&input_astore_caslib_name, name=&input_astore_name}
            out={caslib=&output_caslib_name, name=&output_documents_table_name, replace=TRUE}
            copyVars={&copy_vars};
        ;
    run;
quit;

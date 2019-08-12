/*****************************************************************
* SAS Visual Text Analytics
* Concepts Score Code
*
* Modify the following macro variables to match your needs.
* The liti_binary_caslib and liti_binary_table_name variables
* should have already been set to the location of the concepts
* binary table for the associated SAS Visual Text Analytics project.
****************************************************************/

/* cas library information for cas table containing the data set you would like to score */
%let caslib_name="INVOICES";

/* the cas table you would like to score */
%let input_table_name = "ABT_INVOICES_ISSUED_ORIGINAL_ID";

/* the column in the cas table that contains the contains a unique id */
%let key_column = "DOC_ID";

/* the column in the cas table that contains the text data to score */
%let document_column = "DESCRIPITION_INVOICES";

/* cas library information for output cas tables to produce */
%let output_caslib_name = "INVOICES";

/* the concepts output cas table to produce */
%let output_concepts_table_name = "INVOICES_CONCEPTS";

/* the facts output cas table to produce */
%let output_facts_table_name = "INVOICES_FACTS";

/* cas library information for liti binary table... should have been set to your Text Analytics project's cas library */
%let liti_binary_caslib = "Analytics_Project_197108ef-4a82-4e42-addc-277d4489a5a8";

/* cas table name for liti binary table... should have been set to your Text Analytics project's concept node's model table */
%let liti_binary_table_name = "8ae08ac16c0b4bf8016c0b60f29e0000_CONCEPT_BINARY";

/* hostname for cas server */
%let cas_server_hostname = "sasserver.demo.sas.com";

/* port for cas server */
%let cas_server_port = 5570;

/* create a session */
cas sascas1 host=&cas_server_hostname port=&cas_server_port uuidmac=sascas1_uuid  ;
caslib _all_ assign;
libname sascas1 cas sessref=sascas1 datalimit=all;

/* call the scoring action */
proc cas;
    session sascas1;
    loadactionset "textRuleScore";

    action applyConcept;
        param
            model={caslib=&liti_binary_caslib, name=&liti_binary_table_name}
            table={caslib=&caslib_name, name=&input_table_name}
            docId=&key_column
            text=&document_column
            casOut={caslib=&output_caslib_name, name=&output_concepts_table_name, replace=TRUE}
            factOut={caslib=&output_caslib_name, name=&output_facts_table_name, replace=TRUE}
        ;
    run;
quit;

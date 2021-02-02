#!/bin/bash
#Authoer:Zhou Wu(WUR)
#make spreadlist to submit data (paired fastq) to ENA
#sample_alias	instrument_model	library_name	library_source	library_selection	library_strategy	design_description	library_construction_protocol	insert_size	forward_file_name	forward_file_md5	reverse_file_name	reverse_file_md5

ls */*_R1.fastq.gz> Folders_R1 #Make a list
sed -i 's/\// /g' Folders_R1 #Split into two colums
sed -i 's/R1\.fastq\.gz/ /g' Folders_R1 #make the second column the prefix
#echo header line and make the Spreadsheet files

echo "sample_alias	instrument_model	library_name	library_source	library_selection	library_strategy	design_description	library_construction_protocol	insert_size	forward_file_name	forward_file_md5	reverse_file_name	reverse_file_md5" > Spreadsheet.txt 
#create the spreadsheet file delimited by tab

Dir="Bantam" #Replace with the directory to the fastq files
#Examples files saved in : /Bantam/fastq_files

while read -r Sample prefix; do
#[Sample] the ID of sample or the folder name of this sample
#[prefix] the prefix of each fastq file
#echo $Sample $prefix 
echo -e "${Sample}\tIllumina HiSeq 3000\tNA\tGENOMIC\tRANDOM\tWGS\tNA\tNA\t350\t/${Dir}/$Sample/${prefix}R1.fastq.gz\t`cat $Sample/${prefix}R1.fastq.gz.md5`\t/${Dir}/$Sample/${prefix}R2.fastq.gz\t`cat $Sample/${prefix}R2.fastq.gz.md5`">>Spreadsheet.txt
#Example line output: DH16-04-0W599	Illumina HiSeq 3000	NA	GENOMIC	RANDOM	WGS	NA	NA	350	/Bantam/DH16-04-0W599/DH16-04-0W599_CTCACCAA-TTGCCTAG-AHYK32BBXX_L004_R1.fastq.gz	75a80d36f4803dbb5da7f9bb2045d898	/Bantam/DH16-04-0W599/DH16-04-0W599_CTCACCAA-TTGCCTAG-AHYK32BBXX_L004_R2.fastq.gz	5dbedcb5b0f6c4132b6ade3cafe34c12
#The optional filds are ocupied by NA in this file, can be replaced to empty filed in Excel before submitting the spreadsheet.
done <Folders_R1
